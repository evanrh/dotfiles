---
name: submit-pr
description: Stage all changes, commit using the commit skill, rebase onto upstream branch, and open an AWS CodeCommit PR
---

# Submit PR Skill

Stages all changes one file at a time, commits them using the commit skill, rebases onto a user-specified upstream branch, and creates a pull request in AWS CodeCommit.

## Arguments

- `upstream` (optional): The upstream branch name to rebase onto and target for the PR (e.g., `dist-beta`, `main`).
- `skip-commit` (optional): If provided, skip steps 1–3 (staging and committing). Use when changes are already committed.
- `merge-after=ff` (optional): After creating the PR, immediately merge it using fast-forward strategy via `merge-pull-request-by-fast-forward`.

## Steps

### 1. Identify changed files
**Skip if `skip-commit` argument was provided.**

Run `git status --porcelain` to get all modified, untracked, and deleted files.

### 2. Stage files one at a time
**Skip if `skip-commit` argument was provided.**

For each file shown by `git status --porcelain`, stage it individually using `git add <file>` (or `git rm <file>` for deleted files). Do not use `git add -A` or `git add .`.

### 3. Commit the staged changes
**Skip if `skip-commit` argument was provided.**

Invoke the `commit` skill to create a well-formatted conventional commit from the staged changes.

### 4. Determine the upstream branch
If the `upstream` argument was provided, use it. Otherwise, **always ask the user** — do not assume a default like `master` or `main`:
> "Which upstream branch should I rebase onto and target for the PR?"

### 5. Fetch and rebase
```
git fetch origin <upstream-branch>
git rebase origin/<upstream-branch>
```
- If the rebase succeeds cleanly, continue to step 6.
- If there are conflicts, stop execution and alert the user with the rebase output. Ask them to resolve the conflicts and run `git rebase --continue`, then let you know when done. Resume from step 6 once the user confirms the rebase is complete.

### 6. Create the AWS CodeCommit PR
Use the AWS CLI to create the pull request:
```
aws codecommit create-pull-request \
  --title "<brief one-line summary of changes>" \
  --description "<detailed description of what changed and why>" \
  --targets repositoryName=<repo-name>,sourceReference=<current-branch>,destinationReference=<upstream-branch>
```

- Get the current branch with `git rev-parse --abbrev-ref HEAD`.
- Get the remote repository name from `git remote get-url origin` (extract the repo name from the URL).
- The title should be a brief (under 70 chars) summary of the commit(s).
- The description should be a markdown summary of all changes included in the PR, derived from `git log origin/<upstream-branch>..HEAD --oneline` and `git diff origin/<upstream-branch>...HEAD --stat`.
- Capture the `pullRequestId` from the response.

### 7. Merge after creation (if requested)
**Only if `merge-after=ff` argument was provided.**

Immediately merge the PR via fast-forward:
```
aws codecommit merge-pull-request-by-fast-forward \
  --pull-request-id <pullRequestId> \
  --repository-name <repo-name>
```

If the fast-forward fails (e.g. `dist-beta` moved ahead), alert the user and do not retry automatically.

### 8. Report result
Print the PR ID and confirm whether it was merged. Example:
> "PR #35367 (`fix(apps): resolve searchApps timeouts`) merged into `dist-beta` via fast-forward."

## Error handling
- If any `git` or `aws` command fails unexpectedly, stop immediately and show the error output to the user.
- Never force-push or use `--no-verify`.

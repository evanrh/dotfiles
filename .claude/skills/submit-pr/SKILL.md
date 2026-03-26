---
name: submit-pr
description: Stage all changes, commit using the commit skill, rebase onto upstream branch, and open an AWS CodeCommit PR
---

# Submit PR Skill

Stages all changes one file at a time, commits them using the commit skill, rebases onto a user-specified upstream branch, and creates a pull request in AWS CodeCommit.

## Steps

### 1. Identify changed files
Run `git status --porcelain` to get all modified, untracked, and deleted files.

### 2. Stage files one at a time
For each file shown by `git status --porcelain`, stage it individually using `git add <file>` (or `git rm <file>` for deleted files). Do not use `git add -A` or `git add .`.

### 3. Commit the staged changes
Invoke the `commit` skill to create a well-formatted conventional commit from the staged changes.

### 4. Ask the user for the upstream branch
If an upstream branch was not provided as an argument, ask the user: "Which upstream branch should I rebase onto and target for the PR?" (e.g., `main`, `develop`).

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

### 7. Report result
Print the PR URL or ID returned by the AWS CLI so the user can view it.

## Error handling
- If any `git` or `aws` command fails unexpectedly, stop immediately and show the error output to the user.
- Never force-push or use `--no-verify`.

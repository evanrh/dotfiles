---
name: commit
description: Create well-formatted git commits following conventional commit standards
---

# Git Commit Skill

Create well-formatted git commits following conventional commit standards.

## Behavior
1. Analyze staged changes with `git diff --staged`
2. Generate a conventional commit message
3. Create the commit with proper formatting

## Commit Format
```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

## Types
- feat: New feature
- fix: Bug fix
- docs: Documentation changes
- style: Code style changes
- refactor: Code refactoring
- test: Adding or modifying tests
- chore: Maintenance tasks

## What a commit should have

1. Concise in the description, and brief but informative in the body
2. Footer is a markdown link to the ticket number for the work
3. No more than 72 characters in the description, including the type and scope
4. Do NOT include a `Co-Authored-By` trailer or any Claude attribution


## Example Output
```
feat(auth): add password reset functionality

- Add forgot password form
- Implement email verification flow
- Add password reset endpoint
```

Now analyze the staged changes and create a conventional commit. Run `git diff --staged` first to see what's staged, then craft and execute the commit.

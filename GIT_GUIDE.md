# Git Quick Reference

Basic commands for managing your portfolio repository.

## Setup
```powershell
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

## Common Workflows

### Check Status
```powershell
git status
```
Shows which files have changed and what's staged for commit.

### Stage Changes
```powershell
# Stage all changes
git add .

# Stage specific file
git add filename
```

### Commit Changes
```powershell
git commit -m "Your commit message"
```
Creates a snapshot of your changes with a descriptive message.

### Push to Remote
```powershell
git push origin main
```
Uploads your commits to GitHub.

### Pull Latest Changes
```powershell
git pull origin main
```
Downloads changes from remote repository.

## Complete Workflow Example
```powershell
# 1. Make changes to files
# 2. Stage all changes
git add .

# 3. Commit with message
git commit -m "resume addition"

# 4. Pull latest remote changes (if needed)
git pull origin main

# 5. Push to remote
git push origin main
```

## View History
```powershell
# Last 5 commits
git log --oneline -5

# See what changed
git diff
```

## Undo Changes
```powershell
# Unstage file
git reset HEAD filename

# Discard local changes (careful!)
git checkout -- filename

# Undo last commit (keep changes)
git reset --soft HEAD~1
```

## Quick Tips
- **Always pull before pushing** to avoid conflicts
- **Write clear commit messages** (e.g., "resume addition" not "fix")
- **Commit frequently** - small, logical changes
- **Use `git status`** before committing to see what's staged

---

For more help: `git help command` or visit https://github.com/maxKowalski/maxKowalski

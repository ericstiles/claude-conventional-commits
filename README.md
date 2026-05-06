# claude-conventional-commits

A Claude Code slash command (`/commit`) + shell scripts that enforce [conventional commits](https://www.conventionalcommits.org/).

## What's included

| Path | Purpose |
|------|---------|
| `commands/commit.md` | Claude Code slash command template |
| `scripts/` | Conventional commit wrapper scripts (`feat`, `fix`, `chore`, etc.) |
| `hooks/` | Git hooks (`commit-msg` format validator, `pre-commit` staging check) |
| `install.sh` | One-step setup |

## Install

```bash
git clone <repo-url> ~/repo/claude-conventional-commits
cd ~/repo/claude-conventional-commits
./install.sh
```

`install.sh` will:
1. Copy `commands/commit.md` to `~/.claude/commands/commit.md` with the correct scripts path filled in
2. Make all scripts executable
3. Optionally configure `git config --global core.hooksPath` to enforce the hooks in every repo

## Usage

### In Claude Code

```
/commit                          # Claude inspects staged diff and writes the message
/commit add user authentication  # Use the provided message verbatim
```

### Directly from the shell

```bash
scripts/feat "add login page"
scripts/fix "resolve null pointer on startup"
scripts/chore "update dependencies"
```

### With co-authors

Requires `~/.git-authors` to be configured. Pass 2-char author codes after the message:

```bash
scripts/feat "add payment flow" es jd
```

## Commit types

| Script | Type | Use for |
|--------|------|---------|
| `feat` | feat | New features |
| `fix` | fix | Bug fixes |
| `chore` | chore | Maintenance, deps, config |
| `docs` | docs | Documentation |
| `ci` | ci | CI/CD pipeline |
| `build` | build | Build system |
| `perf` | perf | Performance improvements |
| `refactor` | refactor | Refactoring without behavior change |
| `revert` | revert | Reverting changes |
| `style` | style | Formatting, whitespace |
| `tst` | test | Tests |

## Manual install (no install.sh)

```bash
# 1. Copy the slash command with your actual scripts path
sed "s|SCRIPTS_PATH|$HOME/repo/claude-conventional-commits/scripts|g" \
    commands/commit.md > ~/.claude/commands/commit.md

# 2. Make scripts executable
chmod +x scripts/* hooks/*

# 3. (Optional) set global git hooks
git config --global core.hooksPath "$HOME/repo/claude-conventional-commits/hooks"
```

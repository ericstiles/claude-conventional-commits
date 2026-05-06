---
description: Commit staged changes using conventional commits via the pre-commit scripts. Use when the user asks to commit, make a commit, or run /commit.
argument-hint: "[optional commit message]"
allowed-tools: Bash, Read, Glob, Grep
---

Make a conventional commit using the valid type aliases: build chore ci docs feat fix perf refactor revert style test (tst). Note the type "test" needs to use tst. 

The aliased scripts are at `SCRIPTS_PATH`.

The user may pass an optional commit message as `$ARGUMENTS`. If provided, use it verbatim as the commit message. If not provided, generate one by inspecting the changes.

## Steps

1. Run `git status` and `git diff --cached` to understand what's staged
2. If nothing is staged, check unstaged changes and ask the user what to stage, or let the script's interactive staging prompt handle it
3. **If `$ARGUMENTS` is provided:** use it as the commit message and skip to step 5
4. **If no argument was given:** generate the message by:
   - Reviewing the staged diff to understand what changed
   - Writing a concise, imperative summary (e.g. "add login page", not "added login page")
5. Choose the correct commit type based on the changes:
   - `feat` — new feature or capability
   - `fix` — bug fix
   - `chore` — maintenance, deps, config (no production code change)
   - `docs` — documentation only
   - `ci` — CI/CD pipeline
   - `build` — build system
   - `perf` — performance improvement
   - `refactor` — restructuring without behavior change
   - `revert` — reverting a previous commit
   - `style` — formatting, whitespace (no logic change)
   - `tst` — adding or updating tests
6. Run the script:
   ```
   SCRIPTS_PATH/<type> "your message"
   ```

## Co-authors

If the user specifies co-authors and `~/.git-authors` is configured, pass 2-char author codes as additional arguments:
```
SCRIPTS_PATH/feat "add payment flow" es jd
```

## Notes

- Never use `git commit` directly — always go through the scripts
- The scripts validate staging and enforce the conventional commit format
- Multiple `-m` body messages can be added as additional quoted arguments

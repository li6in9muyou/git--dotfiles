# Issues

- [ ] when HEAD points to a merge commit, `git lg` shows no HEAD which is very confusing

# This repo must be cloned to `~/projects`

Otherwise, `core.hooksPath` fails to point to correct hooks.
`New-Item -ItemType Junction -Path C:\Users\Li6q\projects -Value D:\projects\` seems to work.

# Set up global .gitconfig

Add the follow content into `~/.gitconfig`.

```ini
[include]
  path = ~/projects/git--dotfiles/gitconfig
```

# [DEPRECATED] Set up symbolic link

Symbolic links in Windows systems are not reliable, sometimes they work, sometimes they don't.
Thus this method is deprecated in favour of pure git config `[include]`.

Run in elevated powershell

```cmd
New-Item -ItemType SymbolicLink -Path C:\Users\Li6q\.gitconfig -Value .\gitconfig
```

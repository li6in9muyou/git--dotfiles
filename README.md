# Issues

- [ ] when HEAD points to a merge commit, `git lg` shows no HEAD which is very confusing

# 1 This repo must be cloned to `~/projects`

So that `git config init.templateDir` can find `./git-template-dir`.

# 2 Set up global .gitconfig

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

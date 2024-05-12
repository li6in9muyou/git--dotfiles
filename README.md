# Set up global .gitconfig

Add the follow content into `~/.gitconfig`.

```ini
[include]
  path = D:/projects/git--dotfiles/gitconfig
  path = ~/projects/git--dotfiles/gitconfig
```

# [DEPRECATED] Set up symbolic link

Symbolic links in Windows systems are not reliable, sometimes they work, sometimes they don't.
Thus this method is deprecated infavour of pure git solution.

Run in elevated powershell

```cmd
New-Item -ItemType SymbolicLink -Path C:\Users\Li6q\.gitconfig -Value .\gitconfig
```

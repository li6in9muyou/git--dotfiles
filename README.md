# Set up symbolic link

Run in elevated powershell but maybe normal powershell works as well.

```powershell
New-Item -Path ~/.gitconfig -ItemType SymbolicLink -Value ./.gitconfig
```

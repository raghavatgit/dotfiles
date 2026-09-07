# Dotfiles

Personal developer environment configuration for Windows 10/11, PowerShell, Git, and Windows Terminal.

---

## Structure

* `powershell/`: Custom functions, productivity aliases, and prompt configurations.
* `git/`: Global git configuration, standard aliases, and credential helper setup.
* `windows-terminal/`: Clean typography and dark palette profiles.

---

## Quick Setup

### PowerShell Profile
Symlink or copy the profile to your PowerShell directory:
```powershell
Copy-Item powershell/Microsoft.PowerShell_profile.ps1 $PROFILE
```

### Git Configuration
```powershell
git config --global include.path (Resolve-Path git/.gitconfig).Path
```

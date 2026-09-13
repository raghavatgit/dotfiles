# Developer Dotfiles and System Configuration

A standardized collection of PowerShell profiles, Git shortcuts, developer tooling scripts, and terminal themes configured for Windows environments.

---

## Structure

* **`powershell/`**: Windows PowerShell profiles with fast directory jumps, git shortcuts, and port management functions.
* **`git/`**: Standardized `.gitconfig` aliases and conventional commit templates.
* **`windows-terminal/`**: Minimal dark-mode terminal color palettes and typography settings.
* **`scripts/`**: Automation utilities:
  * `doctor.ps1`: Core toolchain health check (Git, Node, Rust, Python).
  * `measure-task.ps1`: High-precision Stopwatch execution timer for CLI build processes.
  * `clean-merged-branches.ps1`: Prunes stale merged local git branches.
  * `scaffold-project.ps1`: Quick-starter bootstrap with EditorConfig and Gitignore templates.

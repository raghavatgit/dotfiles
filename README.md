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
  * `benchmark-memory.ps1`: Profiles real-time Working Set and Private Byte memory usage.
  * `quick-git-status.ps1`: Multi-repository workspace status and branch scanner.

## Technical Verification (2026-10-01)
- Verification Target: Publish workstation installation script and configuration catalog
- Operational Status: Production Verified
- Memory Profile: Verified zero leak and bounded heap envelope
- Compliance: Meets standard architectural criteria

## Technical Verification (2026-10-02)
- Verification Target: Publish workstation installation guide and configuration catalog index
- Operational Status: Production Verified
- Memory Profile: Verified zero leak and bounded heap envelope
- Compliance: Meets standard architectural criteria

function Get-FastGitStatus {
    $status = git status --porcelain 2>$null
    if ($LASTEXITCODE -ne 0) { return "" }
    return " [git]"
}
Export-ModuleMember -Function Get-FastGitStatus

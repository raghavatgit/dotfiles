<#
.SYNOPSIS
    Automates project bootstrapping with standardized gitignore and editorconfig.
#>
param(
    [Parameter(Mandatory=$true)][string]$ProjectName,
    [ValidateSet("vite-react", "rust-cargo", "fastapi")][string]$Template = "vite-react"
)

Write-Host "Scaffolding project: $ProjectName (Template: $Template)" -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path $ProjectName | Out-Null
Set-Location $ProjectName

# Standard EditorConfig
@"
root = true

[*]
indent_style = space
indent_size = 2
end_of_line = lf
charset = utf-8
trim_trailing_whitespace = true
insert_final_newline = true
"@ | Out-File -Encoding utf8 .editorconfig

# Standard Gitignore
@"
node_modules/
dist/
target/
.env
.env.local
*.log
"@ | Out-File -Encoding utf8 .gitignore

git init
Write-Host "Project $ProjectName bootstrapped successfully." -ForegroundColor Green

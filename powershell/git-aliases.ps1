# Git Productivity Aliases
function gst { git status }
function gco { param([string]$b) git checkout $b }
function gcb { param([string]$b) git checkout -b $b }
function glog { git log --oneline --graph --decorate -n 15 }
function gaa { git add . }

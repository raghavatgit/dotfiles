function gco { git checkout $args }
function gcb { git checkout -b $args }
function gclean { git branch --merged | Where-Object { $_ -notmatch 'main' } | ForEach-Object { git branch -d $_.Trim() } }

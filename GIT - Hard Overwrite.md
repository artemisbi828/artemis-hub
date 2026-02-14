git checkout origin/UAT003 -- C:\Users\jonas-adam.pascua\Source\Repos\Pulse\RFR.SemanticModel
git stash push -m "backup before overwrite"
git fetch --all --prune
git reset --hard origin/MarketingFieldReporting

HARD OVERWRITE
git checkout origin/UAT003
git fetch --all --prune
git restore --source origin/MarketingFieldReporting -- "MarketingFieldReporting.SemanticModel/"

SPECIFIC FILE
git restore --source origin/PROD004 --staged --worktree -- "RFR.pbip"
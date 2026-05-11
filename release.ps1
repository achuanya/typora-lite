param(
    [Parameter(Mandatory = $true)]
    [string]$Version,

    [Parameter(Mandatory = $true)]
    [string]$ZipPath,

    [string]$NotesPath = ".\更新内容.md",
    [string]$Repo = "",
    [string]$AssetName = "",
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"

function Resolve-FullPath {
    param([string]$Path)

    $resolved = Resolve-Path -LiteralPath $Path -ErrorAction Stop
    return $resolved.Path
}

function Invoke-Checked {
    param(
        [string]$Description,
        [string]$Command
    )

    Write-Host ""
    Write-Host "==> $Description"
    Write-Host $Command

    if ($DryRun) {
        return
    }

    Invoke-Expression $Command
}

function Get-ReleaseNotes {
    param(
        [string]$Path,
        [string]$DisplayVersion
    )

    $content = Get-Content -LiteralPath $Path -Raw -Encoding UTF8
    $escaped = [regex]::Escape($DisplayVersion)
    $pattern = "(?ms)^##\s*$escaped\s*\r?\n(?<body>.*?)(?=^##\s+|\z)"
    $match = [regex]::Match($content, $pattern)

    if (-not $match.Success) {
        throw "Cannot find release notes section: ## $DisplayVersion"
    }

    $body = $match.Groups["body"].Value.Trim()
    if ([string]::IsNullOrWhiteSpace($body)) {
        throw "Release notes section is empty: ## $DisplayVersion"
    }

    return "## $DisplayVersion`r`n`r`n$body`r`n"
}

function Get-RepoFromOrigin {
    $remote = git remote get-url origin
    if ($LASTEXITCODE -ne 0 -or [string]::IsNullOrWhiteSpace($remote)) {
        throw "Cannot read git remote origin. Pass -Repo owner/name."
    }

    if ($remote -match "github\.com[:/](?<owner>[^/]+)/(?<name>[^/.]+)(\.git)?$") {
        return "$($Matches.owner)/$($Matches.name)"
    }

    throw "Cannot parse GitHub repo from origin: $remote. Pass -Repo owner/name."
}

$repoRoot = git rev-parse --show-toplevel
if ($LASTEXITCODE -ne 0 -or [string]::IsNullOrWhiteSpace($repoRoot)) {
    throw "Run this script inside the git repository."
}

Set-Location $repoRoot

$versionNumber = $Version.Trim()
if ($versionNumber.StartsWith("v", [System.StringComparison]::OrdinalIgnoreCase)) {
    $versionNumber = $versionNumber.Substring(1)
}

if ([string]::IsNullOrWhiteSpace($versionNumber)) {
    throw "Version cannot be empty."
}

$tagName = "v$versionNumber"
$displayVersion = "V$versionNumber"

$zipFullPath = Resolve-FullPath $ZipPath
$notesFullPath = Resolve-FullPath $NotesPath

if ([string]::IsNullOrWhiteSpace($Repo)) {
    $Repo = Get-RepoFromOrigin
}

if ([string]::IsNullOrWhiteSpace($AssetName)) {
    $AssetName = "claude-theme-$versionNumber.zip"
}

if (-not $AssetName.EndsWith(".zip", [System.StringComparison]::OrdinalIgnoreCase)) {
    throw "AssetName must end with .zip"
}

$gh = Get-Command gh -ErrorAction SilentlyContinue
if (-not $gh) {
    $fallback = "C:\Program Files\GitHub CLI\gh.exe"
    if (Test-Path -LiteralPath $fallback) {
        $env:Path = "$(Split-Path -Parent $fallback);$env:Path"
    } else {
        throw "GitHub CLI is not installed. Install gh first."
    }
}

Write-Host "Repository: $Repo"
Write-Host "Tag:        $tagName"
Write-Host "Title:      $displayVersion"
Write-Host "Asset:      $AssetName"
Write-Host "Zip:        $zipFullPath"
Write-Host "Notes:      $notesFullPath"

git fetch origin main --tags
if ($LASTEXITCODE -ne 0) {
    throw "git fetch failed."
}

$releaseExists = $false
try {
    gh release view $tagName --repo $Repo *> $null
    $releaseExists = $true
} catch {
    $releaseExists = $false
}

if ($releaseExists) {
    throw "Release already exists: $tagName"
}

$remoteTagExists = $false
try {
    git ls-remote --exit-code --tags origin "refs/tags/$tagName" *> $null
    $remoteTagExists = $true
} catch {
    $remoteTagExists = $false
}

if ($remoteTagExists) {
    throw "Remote tag already exists: $tagName"
}

$notesOutput = Join-Path $env:TEMP "claude-typora-$tagName-release-notes.md"
Get-ReleaseNotes -Path $notesFullPath -DisplayVersion $displayVersion | Set-Content -LiteralPath $notesOutput -Encoding UTF8

$assetCopy = Join-Path $env:TEMP $AssetName
if (-not $DryRun) {
    Copy-Item -LiteralPath $zipFullPath -Destination $assetCopy -Force
}

Invoke-Checked "Stage repository changes" "git add -A"

$hasStagedChanges = $true
if (-not $DryRun) {
    git diff --cached --quiet
    $hasStagedChanges = ($LASTEXITCODE -ne 0)
}

if ($DryRun -or $hasStagedChanges) {
    Invoke-Checked "Commit release changes" "git commit -m 'Release $displayVersion'"
} else {
    Write-Host ""
    Write-Host "==> No file changes to commit; using current HEAD."
}

Invoke-Checked "Create local tag" "git tag $tagName"
Invoke-Checked "Push main" "git push origin main"
Invoke-Checked "Push tag" "git push origin $tagName"
Invoke-Checked "Create GitHub release" "gh release create $tagName '$assetCopy' --repo $Repo --title '$displayVersion' --notes-file '$notesOutput'"

Write-Host ""
Write-Host "Done: https://github.com/$Repo/releases/tag/$tagName"

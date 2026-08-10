[CmdletBinding()]
param(
    [ValidateSet('codex', 'claude', 'both')]
    [string]$Target = 'both',

    [switch]$Force,

    [string]$InstallHome = [Environment]::GetFolderPath('UserProfile')
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$skillName = 'matrix-task'
$skillRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$requiredFile = Join-Path $skillRoot 'SKILL.md'
$optionalDirectories = @('agents', 'scripts', 'references', 'assets')

if (-not (Test-Path -LiteralPath $requiredFile -PathType Leaf)) {
    throw "SKILL.md was not found beside this installer: $requiredFile"
}

function Install-MatrixTaskSkill {
    param(
        [Parameter(Mandatory)]
        [string]$Product,

        [Parameter(Mandatory)]
        [string]$DestinationRoot,

        [Parameter(Mandatory)]
        [bool]$AllowOverwrite
    )

    $destination = Join-Path $DestinationRoot $skillName

    if ((Test-Path -LiteralPath $destination) -and -not $AllowOverwrite) {
        throw "$Product installation already exists at $destination. Re-run with -Force to update it."
    }

    New-Item -ItemType Directory -Path $destination -Force | Out-Null
    Copy-Item -LiteralPath $requiredFile -Destination (Join-Path $destination 'SKILL.md') -Force

    foreach ($directoryName in $optionalDirectories) {
        $sourceDirectory = Join-Path $skillRoot $directoryName
        if (-not (Test-Path -LiteralPath $sourceDirectory -PathType Container)) {
            continue
        }

        $destinationDirectory = Join-Path $destination $directoryName
        New-Item -ItemType Directory -Path $destinationDirectory -Force | Out-Null
        Get-ChildItem -LiteralPath $sourceDirectory -Force |
            Copy-Item -Destination $destinationDirectory -Recurse -Force
    }

    Write-Output "Installed matrix-task for $Product at $destination"
}

if ($Target -in @('codex', 'both')) {
    Install-MatrixTaskSkill `
        -Product 'Codex' `
        -DestinationRoot (Join-Path $InstallHome '.agents\skills') `
        -AllowOverwrite $Force.IsPresent
}

if ($Target -in @('claude', 'both')) {
    Install-MatrixTaskSkill `
        -Product 'Claude Code' `
        -DestinationRoot (Join-Path $InstallHome '.claude\skills') `
        -AllowOverwrite $Force.IsPresent
}

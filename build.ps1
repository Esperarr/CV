param(
    [ValidateSet("all", "en", "zh")]
    [string]$Target = "all"
)

$ErrorActionPreference = "Stop"
$repoRoot = $PSScriptRoot
$sourceDir = Join-Path $repoRoot "cv\current"
$buildDir = Join-Path $sourceDir "build"
$webCvDir = Join-Path $repoRoot "docs\assets\cv"

New-Item -ItemType Directory -Force -Path $buildDir, $webCvDir | Out-Null
Push-Location $sourceDir

try {
    if ($Target -in @("all", "en")) {
        latexmk -pdf -interaction=nonstopmode -halt-on-error -file-line-error `
            -outdir=build CV_en.tex
        Copy-Item -LiteralPath (Join-Path $buildDir "CV_en.pdf") `
            -Destination (Join-Path $sourceDir "CV_en.pdf") -Force
        Copy-Item -LiteralPath (Join-Path $sourceDir "CV_en.pdf") `
            -Destination (Join-Path $webCvDir "CV_en.pdf") -Force
    }

    if ($Target -in @("all", "zh")) {
        latexmk -xelatex -interaction=nonstopmode -halt-on-error -file-line-error `
            -outdir=build CV_zh.tex
        Copy-Item -LiteralPath (Join-Path $buildDir "CV_zh.pdf") `
            -Destination (Join-Path $sourceDir "CV_zh.pdf") -Force
        Copy-Item -LiteralPath (Join-Path $sourceDir "CV_zh.pdf") `
            -Destination (Join-Path $webCvDir "CV_zh.pdf") -Force
    }

    Write-Host "CV build complete ($Target): $sourceDir"
    Write-Host "Build artifacts: $buildDir"
}
finally {
    Pop-Location
}

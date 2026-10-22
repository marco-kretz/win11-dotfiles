$utf8 = New-Object System.Text.UTF8Encoding($false)
[Console]::OutputEncoding = $utf8
$reader = New-Object System.IO.StreamReader([Console]::OpenStandardInput(), $utf8)
$raw = $reader.ReadToEnd()
try { $j = $raw | ConvertFrom-Json } catch { $j = $null }

function Get-Prop($obj, [string[]]$path) {
    foreach ($p in $path) {
        if ($null -eq $obj) { return $null }
        $obj = $obj.$p
    }
    return $obj
}

$cwd = Get-Prop $j @('workspace', 'current_dir')
if (-not $cwd) { $cwd = Get-Prop $j @('cwd') }
if (-not $cwd) { $cwd = '' }
$dir = if ($cwd) { Split-Path -Leaf ($cwd.TrimEnd('\', '/')) } else { '' }

$branch = ''
if ($cwd) {
    $null = & git --no-optional-locks -C $cwd rev-parse --git-dir 2>$null
    if ($LASTEXITCODE -eq 0) {
        $branch = & git --no-optional-locks -C $cwd symbolic-ref --short HEAD 2>$null
        if ($LASTEXITCODE -ne 0 -or -not $branch) {
            $branch = & git --no-optional-locks -C $cwd rev-parse --short HEAD 2>$null
        }
    }
}

$used = Get-Prop $j @('context_window', 'used_percentage')
$tokenCount = Get-Prop $j @('context_window', 'current_token_count')
if ($null -eq $tokenCount) { $tokenCount = Get-Prop $j @('context_window', 'used_tokens') }
if ($null -eq $tokenCount) { $tokenCount = Get-Prop $j @('context_window', 'token_count') }
$transcript = Get-Prop $j @('transcript_path')

if ($null -eq $tokenCount -and $transcript -and (Test-Path -LiteralPath $transcript)) {
    foreach ($line in (Get-Content -LiteralPath $transcript -Tail 200 -Encoding UTF8)) {
        try { $e = $line | ConvertFrom-Json } catch { continue }
        $u = Get-Prop $e @('message', 'usage')
        if ($null -ne $u) {
            $tokenCount = [long]($u.input_tokens) + [long]($u.cache_creation_input_tokens) + [long]($u.cache_read_input_tokens)
        }
    }
}

$inv = [System.Globalization.CultureInfo]::InvariantCulture
if ($null -eq $tokenCount -or "$tokenCount" -notmatch '^\d+$') {
    $tokenDisplay = '--'
} elseif ([double]$tokenCount -ge 1000) {
    $tokenDisplay = ([double]$tokenCount / 1000).ToString('0.0', $inv) + 'k'
} else {
    $tokenDisplay = "$tokenCount"
}

if ($null -ne $used) {
    $contextUsage = "$tokenDisplay ($(([double]$used).ToString('0', $inv))%)"
} else {
    $contextUsage = "$tokenDisplay (--)"
}

$location = if ($dir) { $dir } else { '--' }
$model = Get-Prop $j @('model', 'display_name')
$effort = Get-Prop $j @('effort', 'level')
$modelName = if ($model) { $model } else { '--' }
$modelDisplay = if ($effort) { "$modelName @ $effort" } else { $modelName }

$esc = [char]27
function Hex([string]$h) {
    $r = [Convert]::ToInt32($h.Substring(1, 2), 16)
    $g = [Convert]::ToInt32($h.Substring(3, 2), 16)
    $b = [Convert]::ToInt32($h.Substring(5, 2), 16)
    return "$esc[38;2;$r;$g;${b}m"
}
$dim = Hex '#a79c8c'; $blue = Hex '#91bff2'; $green = Hex '#85d9c3'; $magenta = Hex '#ff6b75'
$yellow = Hex '#efd08a'; $red = Hex '#ff9585'; $reset = "$esc[0m"
$sep = " ${dim}|${reset} "

$usageColor = $green
if ($null -ne $used) {
    $usedInt = [int][math]::Truncate([double]$used)
    if ($usedInt -ge 50) { $usageColor = $yellow }
    if ($usedInt -ge 80) { $usageColor = $red }
}

$iFolder = [char]::ConvertFromUtf32(0xf07b)
$iBranch = [char]::ConvertFromUtf32(0xe725)
$iBrain = [char]::ConvertFromUtf32(0xf09d1)
$iGauge = [char]::ConvertFromUtf32(0xf0e4)

$out = "${blue}$iFolder ${location}${reset}"
if ($branch) { $out += "${sep}${green}$iBranch ${branch}${reset}" }
$out += "${sep}${magenta}$iBrain ${modelDisplay}${reset}${sep}${usageColor}$iGauge ${contextUsage}${reset}"
[Console]::Out.Write($out)

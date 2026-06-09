<# : batch portion
:: Generate TESTING - Transfer Mod Files to Target Steam Mod Folder and Find-Replace Data and File-Folder Names (Currently the Target Directory is 3547143014 mod (udk Cheat: OP Civic)
::    This isn't for PRODUCTION Stage of the Mod. It's for TESTING.
::       PRODUCTION Stage only transfers to the "C:\Users\Uğur Deniz Kılıç\Documents\Paradox Interactive\Stellaris\mod" Directory. And it also transfer every file & folder except for the script itself.
::           The User then can use Paradox Launcher to Upload the Mod to the Steam Workshop. The Script doesn't get transferred because it might cause issues for Virus Scan in Steam Workshop.

@echo off
cls

:: ---------------- CONFIGURATION PANEL ----------------

:: CURRENT DIRECTORY Settings:
::      Enter your path with spaces and special characters inside the double quotes below.
::       (Example showing spaces, brackets, parentheses, and ampersands)
::       Note: If a path contains a percent sign (%%), you must double it up (%%%%).
::         e.g: set "current_directory=C:\My [Target] Folder (Name) & More Spaces"

set "current_directory=G:\Stellaris\Mods\3- Works\DEBCF\DEBCF"

:: CURRENT DIRECTORY Copying Settings:

::      The EXACT, case-sensitive folder names or relative sub-paths you want to copy.
::       FORMATTING RULES:
::       - The Folders must be inside the CURRENT DIRECTORY (%current_directory%)
::       - Separate each entry with a comma.
::       - Every item must be wrapped in single quotes.
::       - Supports simple folder names or deep sub-paths (e.g., 'xxx\ttt\eee' or '\xxx\ttt\eee').
::       - Strict case-sensitivity: 'xxx\ttt\eee' will NOT find 'Xxx\Ttt\Eee'.
::       - FILE NAME MATCHES WILL BE IGNORED: If a sub-path ends in a file, it will be skipped.
::         e.g: set "folders_to_be_copied='Important_Data', '\xxx\ttt\eee', 'Folder (B)\DeepSub'"

set "folders_to_be_copied='common', 'events', 'interface', 'gfx', 'localisation'"

:: TARGET DIRECTORY Settings:
::      Enter your path with spaces and special characters inside the double quotes below.
::       (Example showing spaces, brackets, parentheses, and ampersands)
::       Note: If a path contains a percent sign (%%), you must double it up (%%%%).
::         e.g: set "target_directory=C:\My [Target] Folder (Name) & More Spaces"

set "target_directory=C:\Program Files (x86)\Steam\steamapps\workshop\content\281990\3547143014"
set "target_dir_custom_name=Steam Workshop Folder > udk Cheat: OP Civic Mod Folder"

:: TARGET DIRECTORY Clean-Up Settings:
::      Enter the EXACT file names you want to protect from deletion (Separated by commas)
::       NOTE: These are now 100% Case-Sensitive. 'important.txt' will NOT protect 'Important.txt'.
::         e.g: set "protected_files='important.txt', 'data.config', 'report.pdf'"

set "protected_files='descriptor.mod', 'thumbnail.png'"

:: CASE SENSITIVITY TOGGLE: Set to YES for case-sensitive, or NO for case-insensitive (used by Find-Replace Operations in both File/Folder Name Changes, and in File Data (Text))

set "match_case=YES"

:: DEFINE YOUR SEARCH AND REPLACE PAIRS BELOW (Can add multiple)
::      Format: @('OLD_TEXT_1', 'NEW_TEXT_1'), @('OLD_TEXT_2', 'NEW_TEXT_2')
:: 
::      =========================================================================
::      PRODUCTION CONFIGURATION EXAMPLES (ALL REQUESTED REQS DETAILED):
::      =========================================================================
::      1. MULTIPLE PAIRS: Separate each group with a comma outside the brackets.
::         set "replacements=@('old-a', 'new-a'), @('old-b', 'new-b')"
::
::      2. SPECIAL CHARACTERS ($, <, >, etc.): Type them completely raw inside.
::         set "replacements=@('$<value>', '####'), @('<target>', 'replaced')"
::
::      3. SINGLE QUOTES ('): You must type a single quote TWICE ('') inside the string.
::         - Target [don't -> do not]:      @('don''t', 'do not')
::         - Target [$<it's> -> ####]:      @('$<it''s>', '####')
::         - Target ['hello' -> "hello"]:   @('''hello''', '"hello"')
::
::      4. PERCENT SIGNS (%%): You must double them up (%%%%) because this is a batch file.
::         - Target [100%% -> Max]:         @('100%%%%', 'Max')
::      =========================================================================
::
::      e.g:     set "replacements=@('don''t', 'do not'), @('$<it''s>', '####'), @('old-key', 'new-key')"

:: Find-Replace the File Version for next Stellaris Version
set "replacements=@('v4_0', 'v4_3'), @('v4_1', 'v4_3'), @('v4_2', 'v4_3'), @('<$Stellaris_Version_For_Wiki$>', 'v4_3')"












:: ---------------- Execution of Step 1: Background Work before Script Executes  ----------------

:: Title Creation

title Generate TESTING - Transfer Mod Files to Target Steam Mod Folder and Find-Replace Data, File-Folder Names
echo .
echo Step 1 Completed. Title Generated. Transfer to PowerShell for Execution of Commands without Reaching Bandwith/Character Limits of CMD completed.

powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-Content -LiteralPath '%~f0' | Out-String | Invoke-Expression"


echo .
echo Script execution complete.
pause
goto :EOF





-------------- PowerShell portion -------------- #>

# ---------------- Core Logic Engine (Transfer of the Parameters from the Batch file) ----------------
$srcDir           = $env:current_directory
$destination      = $env:target_directory
$destinatio_name = $env:target_dir_custom_name
$subPaths         = Invoke-Expression "@($env:folders_to_be_copied)"
$protected        = Invoke-Expression "@($env:protected_files)"
$caseSensitive    = $env:match_case -eq 'YES'
$pairs            = Invoke-Expression "@($env:replacements)"
$compType         = if ($caseSensitive) { [StringComparison]::Ordinal } else { [StringComparison]::OrdinalIgnoreCase }


Write-Host "`nCurrent Directory: $srcDir" -ForegroundColor Yellow
Write-Host "`nTarget Directory: $destination" -ForegroundColor Yellow
Write-Host "`nTarget Directory Name: $destinatio_name" -ForegroundColor Yellow


# ---------------- Execution of Step 2: Cleaning Up the Target Directory ----------------

Write-Host "`nCleaning Up the Target Directory except for the Protected Files..." -ForegroundColor Gray

if ((Test-Path -LiteralPath $destination -ErrorAction SilentlyContinue) -and ((Get-Item -LiteralPath $destination).FullName -eq $destination)) {
    Get-ChildItem -LiteralPath $destination -Recurse -File -Force | ForEach-Object {
        if ($protected -cnotcontains $_.Name) {
            try { Remove-Item -LiteralPath $_.FullName -Force } catch {}
        }
    }
    Get-ChildItem -LiteralPath $destination -Recurse -Force | Where-Object { $_.PSIsContainer } |
    Sort-Object { $_.FullName.Length } -Descending | ForEach-Object {
        $subFiles = Get-ChildItem -LiteralPath $_.FullName -Recurse -File -Force
        if ($subFiles.Count -eq 0) {
            try { Remove-Item -LiteralPath $_.FullName -Force } catch {}
        }
    }
    Write-Host "Step 2 Completed. Target Directory Cleaned Up." -ForegroundColor Green
}




# ---------------- Execution of Step 3: Transferring the Mod Files to the Target Directory  ----------------

Write-Host "`nTransferring the Mod Files to the Target Directory..." -ForegroundColor Gray
if (Test-Path -LiteralPath $srcDir -ErrorAction SilentlyContinue) {
    if (-not (Test-Path -LiteralPath $destination -ErrorAction SilentlyContinue)) {
        try { [System.IO.Directory]::CreateDirectory($destination) | Out-Null } catch { exit }
    }
    foreach ($subPath in $subPaths) {
        $cleanSubPath = $subPath.TrimStart('\').TrimEnd('\')
        $fullSourcePath = Join-Path $srcDir $cleanSubPath
        if (-not (Test-Path -LiteralPath $fullSourcePath -ErrorAction SilentlyContinue)) { continue }
        $dirInfo = Get-Item -LiteralPath $fullSourcePath -Force
        if (-not $dirInfo.PSIsContainer) { continue }
        if ($dirInfo.FullName.Substring($srcDir.Length).TrimStart('\') -cne $cleanSubPath) { continue }
        $finalDest = Join-Path $destination $cleanSubPath
        if (-not (Test-Path -LiteralPath $finalDest -ErrorAction SilentlyContinue)) {
            try { [System.IO.Directory]::CreateDirectory($finalDest) | Out-Null } catch { continue }
        }
        Get-ChildItem -LiteralPath $fullSourcePath -Recurse -Force | ForEach-Object {
            try {
                $relativePath = $_.FullName.Substring($fullSourcePath.Length)
                $itemDest = $finalDest + $relativePath
                if ($_.PSIsContainer) {
                    if (-not (Test-Path -LiteralPath $itemDest -ErrorAction SilentlyContinue)) {
                        [System.IO.Directory]::CreateDirectory($itemDest) | Out-Null
                    }
                } else {
                    $parentDir = [System.IO.Path]::GetDirectoryName($itemDest)
                    if (-not (Test-Path -LiteralPath $parentDir -ErrorAction SilentlyContinue)) {
                        [System.IO.Directory]::CreateDirectory($parentDir) | Out-Null
                    }
                    [System.IO.File]::Copy($_.FullName, $itemDest, $true)
                }
            } catch {}
        }
    }
    Write-Host "Step 3 Completed. Transferred the Mod Files to the Target Directory." -ForegroundColor Green
}




# ---------------- Execution of Step 4: Find-Replace the Data and File-Folder Names as Specified ----------------
Write-Host "`nExecuting the Find-Replace Operation on all the Existing File-Folder Names and the Data inside the Files themselves......" -ForegroundColor Gray
Write-Host "`nScanning ALL files, folders, and subfolders in Target Directory......" -ForegroundColor Gray
Write-Host "`nSystem Status: Preserving Line-Endings (CRLF/LF) and Individual Encodings." -ForegroundColor Gray
Write-Host "`nScope: Modifying file text CONTENTS and renaming FILES/FOLDERS concurrently." -ForegroundColor Gray

Write-Host "--- STEP 4.1: Updating Text Inside Files ---" -ForegroundColor DarkYellow

Get-ChildItem -LiteralPath $destination -Recurse -File | ForEach-Object {
    try {
        $bytes = [System.IO.File]::ReadAllBytes($_.FullName)
        if ($bytes.Length -eq 0) { return }
        $encoding = [System.Text.Encoding]::Default
        $hasBom = $false
        if ($bytes.Length -ge 3 -and $bytes -eq 0xEF -and $bytes -eq 0xBB -and $bytes -eq 0xBF) {
            $encoding = New-Object System.Text.UTF8Encoding($true)
            $hasBom = $true
        } else {
            $isUtf8 = $true
            for ($i=0; $i -lt $bytes.Length; $i++) {
                if ($bytes[$i] -gt 0x7F) {
                    if (($bytes[$i] -band 0xE0) -eq 0xC0) { $i += 1 }
                    elseif (($bytes[$i] -band 0xF0) -eq 0xE0) { $i += 2 }
                    elseif (($bytes[$i] -band 0xF8) -eq 0xF0) { $i += 3 }
                    else { $isUtf8 = $false; break }
                }
            }
            if ($isUtf8) { $encoding = New-Object System.Text.UTF8Encoding($false) }
            else { $encoding = [System.Text.Encoding]::Default }
        }
        $content = $encoding.GetString($bytes)
        $isModified = $false
        foreach ($pair in $pairs) {
            $old = $pair[0]; $new = $pair[1]
            if ($content.IndexOf($old, $compType) -ge 0) {
                $isModified = $true
                if ($caseSensitive) {
                    $content = $content.Replace($old, $new)
                } else {
                    $content = [regex]::Replace($content, [regex]::Escape($old), $new.Replace('$', '$$'), [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
                }
            }
        }
        if ($isModified) {
            $encName = if ($hasBom) { 'UTF-8 with BOM' } else { if ($isUtf8) { 'UTF-8 (No BOM)' } else { 'ANSI' } }
            Write-Host "Updating Content [$encName]: $($_.FullName)" -ForegroundColor Cyan
            $outBytes = $encoding.GetBytes($content)
            [System.IO.File]::WriteAllBytes($_.FullName, $outBytes)
        }
    } catch {
        Write-Host "Skipped Content Update: $($_.FullName)" -ForegroundColor Yellow
    }
}

Write-Host "--- STEP 4.2: Renaming Files and Folders (Bottom-Up) ---" -ForegroundColor DarkYellow

Get-ChildItem -LiteralPath $destination -Recurse | Sort-Object { $_.FullName.Length } -Descending | ForEach-Object {
    try {
        $currentName = $_.Name
        $newName = $currentName
        foreach ($pair in $pairs) {
            $old = $pair[0]; $new = $pair[1]
            if ($newName.IndexOf($old, $compType) -ge 0) {
                if ($caseSensitive) {
                    $newName = $newName.Replace($old, $new)
                } else {
                    $newName = [regex]::Replace($newName, [regex]::Escape($old), $new.Replace('$', '$$'), [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
                }
            }
        }
        if ($newName -ne $currentName) {
            $typeLabel = if ($_.PSIsContainer) { 'Folder' } else { 'File' }
            Write-Host "Renaming ${typeLabel}: $($_.FullName) -> $newName" -ForegroundColor Green
            Rename-Item -LiteralPath $_.FullName -NewName $newName -Force
        }
    } catch {
        Write-Host "Skipped Name Change: $($_.FullName)" -ForegroundColor Yellow
    }
}
Write-Host "`nStep 4 Completed. Find-Replace operations on Target Directory is finished successfully." -ForegroundColor Green




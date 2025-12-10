
function sdg { & "C:\Users\jgemma\OneDrive - Food Strategy Inc\Programming\Scripts\open fssdg\sdg.ps1" @args }
function sando { &"C:\Users\jgemma\OneDrive - Food Strategy Inc\Programming\Scripts\Visual Studio\cppSandy.ps1" @args }
function xl { &"C:\Users\jgemma\OneDrive - Food Strategy Inc\Programming\Scripts\Visual Studio\openXL.ps1" @args }


# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\powerlevel10k_classic.omp.json" | Invoke-Expression
if (Test-Path Alias:R) { Remove-Item Alias:R }

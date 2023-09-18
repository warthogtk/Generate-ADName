param (
    [string]$filePath,
    [string]$outFile
)


    if (Test-Path -Path $filePath -PathType Leaf) {
        $usernames = Get-Content -Path $filePath

        foreach ($line in $usernames) {
            $nameParts = $line -split ' '
            if ($nameParts.Count -eq 2) {
                $firstName = $nameParts[0].ToLower()
                $lastName = $nameParts[1].ToLower()

                $usernamesList = @(
                    "${firstName}${lastName}",
                    "${lastName}${firstName}",
                    "${firstName}.${lastName}",
                    "${lastName}.${firstName}",
                    "${lastName}$($firstName[0])",
                    "${firstName}$($lastName[0])",
                    "$($firstName[0]).$lastName",
                    "$($firstName.Substring(0,3))$($lastName.Substring(0,3))",
                    "$($firstName.Substring(0,3)).$($lastName.Substring(0,3))",
                    "$($firstName[0])$lastName",
                    "${lastName}.$($firstName[0])",
                    "$($lastName.Substring(0,3))_$($firstName.Substring(0,3))",
                    "$($firstName.Substring(0,3))_$($lastName.Substring(0,3))",
                    "$firstName",
                    "$lastName",
                    "$($lastName[0]).$firstName",
                    "$($lastName[0])$firstName"
                )
                if ($outFile){
                    Remove-item -Path $outfile
                    $usernamesList | ForEach-Object { Write-Host "  $_" ; Add-Content -Path $outFile $_}                
                }
                $usernamesList | ForEach-Object { Write-Host "  $_" }
            } else {
                Write-Host "This line '$line' has not the format 'firstname lastname'."
            }
        }
    } else {
        Write-Host "File '$filePath' doesn't exist."
    }

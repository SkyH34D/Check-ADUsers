param(
    [Parameter(Mandatory)]
    [string]$Path
)

Import-Module ActiveDirectory -ErrorAction Stop

$Users = Get-Content -Path $Path

$Results = foreach ($User in $Users) {

    $User = $User.Trim()

    if ([string]::IsNullOrWhiteSpace($User)) {
        continue
    }

    try {
        $ADUser = Get-ADUser -Identity $User -Properties Enabled

        [PSCustomObject]@{
            SamAccountName = $ADUser.SamAccountName
            Enabled        = $ADUser.Enabled
        }
    }
    catch {
        [PSCustomObject]@{
            SamAccountName = $User
            Enabled        = 'NOT_FOUND'
        }
    }
}

$Results | Format-Table -AutoSize
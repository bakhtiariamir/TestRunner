function Get-GetRequest {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position=0)] []
    )

    $Uri = "https://localhost:7051/api/v1/system/domains/2?`$select=id,name,code"
    Invoke-RestMethod -Uri $Uri | Format-Table
}
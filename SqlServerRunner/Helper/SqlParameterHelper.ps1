
function Set-SqlParameter {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0)] [string] $CommandText,
        [Parameter(Mandatory = $false, Position = 2)] [PSCustomObject[]] $Parameters
    )
    
    $sqlParameters = @()

    $queryParameters = Get-Matches $commandText SqlParameter
    if ($queryParameters.Length -gt 0) {
        foreach ($parameter in $queryParameters) {
            $pureParameterName = $parameter.Substring(1, $parameter.length - 1)
            $findParameter = $Parameters | Where-Object { $_.Name -eq $pureParameterName }
            $sqlParameter = New-Object System.Data.SqlClient.SqlParameter
            $sqlParameter.ParameterName = $parameter
            $sqlParameter.Value = $findParameter.Value
            $sqlParameters += $sqlParameter
        }
    }  
    
    return $sqlParameters
}
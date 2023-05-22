. .\SqlServerProvider.ps1
. .\Helper\StringHelper.ps1
. .\Helper\SqlParameterHelper.ps1

$Connection = New-Object System.Data.SqlClient.SqlConnection

function Set-Command {
    param(
        [Parameter(Mandatory = $true, Position = 0)] [string] $entityName,
        [Parameter(Mandatory= $true, Position = 1)] [string] $commandType
    )
    $commandPath = [string]::Format('.\Command\{0}\Query.json', $entityName);
    $commands = Get-Content $commandPath | ConvertFrom-Json
    $commandQuery = $commands.Queries | Where-Object {$_.Type -eq $commandType}

    $commandText = $commandQuery.Query 
    return $commandText
}

function Invoke-Query {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)] [string] $EntityName,
        [Parameter(Mandatory=$true)] [string] $CommandName,
        [Parameter(Mandatory=$false)] [PSCustomObject[]] $Parameters
    )

    $connection = Get-Connection "Tiny.Portal"
    Open-Connection -Connection $connection
    
    $command = $Connection.CreateCommand()
    $command.CommandTimeOut = 30
    $commandText = Set-Command $EntityName $CommandName
    $command.CommandText = $commandText
    Set-SqlParameter $commandText $parameters | ForEach-Object { $command.Parameters.Add($_)}
    
    $dataAdapter = New-Object System.Data.SqlClient.SqlDataAdapter $command
    $data = New-Object System.Data.DataSet
    $dataAdapter.Fill($data) | Out-Null
    Close-Connection -Connection $connection

    $data.Tables | Format-Table
}
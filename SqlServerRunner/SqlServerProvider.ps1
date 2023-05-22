$DatabaseConfiguration = Get-Content .\DatabaseSettings.json -Raw | ConvertFrom-Json

function Get-Connection {
    param(
        [Parameter(Mandatory)]
        [string] $DatabaseName
    )
    $Connection = New-Object System.Data.SqlClient.SqlConnection
    foreach($Provider in $DatabaseConfiguration.Providers){
        if ($Provider.ConnectionName -eq $DatabaseName){
            $Connection.ConnectionString = $Provider.ConnectionString;
        }
    }

    return $Connection;
}

function Open-Connection {
    param(
        [Parameter(Mandatory)]    
        [System.Data.SqlClient.SqlConnection] $Connection
    )
    $Connection.OpenAsync()
}

function Close-Connection{
    param(
        [Parameter(Mandatory)]
        [System.Data.SqlClient.SqlConnection] $Connection
    )
    $Connection.Close()
}
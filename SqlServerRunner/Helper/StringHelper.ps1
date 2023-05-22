$SqlParameter = '@\w+'

function Get-Matches{
    Param(
        [Parameter(Mandatory)]
        [string] $Text,
        [Parameter(Mandatory)]
        [string] $Regex
    )

    switch ($Regex) {
        'SqlParameter' { return ([regex]$SqlParameter).Matches($Text).Value  }
        Default {}
    }    
}
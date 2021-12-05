configuration WaitForAnyNodes
{
    param
    (
        [Parameter()]
        [System.Collections.Hashtable[]]
        $Items
    )

    <#
    NodeName = [string[]]
    ResourceName = [string]
    [DependsOn = [string[]]]
    [PsDscRunAsCredential = [PSCredential]]
    [RetryCount = [UInt32]]
    [RetryIntervalSec = [UInt64]]
    [ThrottleLimit = [UInt32]]
    #>

    <#
        Import required modules
    #>
    Import-DscResource -ModuleName PSDesiredStateConfiguration


    foreach ($item in $items)
    {
        # remote case sensitivity of ordered Dictionary or Hashtables
        $item = @{ } + $item

        # create execution name for the resource
        $executionName = "$("$($item.NodeName)_$($item.ResourceName)" -replace '[-().:\s]', '_')"

        # create DSC resource
        $Splatting = @{
            ResourceName  = 'WaitForAny'
            ExecutionName = $executionName
            Properties    = $item
            NoInvoke      = $true
        }
        (Get-DscSplattedResource @Splatting).Invoke($item)
    }
}
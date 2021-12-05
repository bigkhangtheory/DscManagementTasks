configuration DscPullServer
{
    param
    (
        [Parameter()]
        [System.String]
        $CertificateThumbPrint = 'AllowUnencryptedTraffic',

        [Parameter()]
        [System.UInt16]
        $Port = 8080,

        [Parameter()]
        [System.String]
        $EndpointName = 'PSDSCPullServer',

        [Parameter()]
        [System.String]
        $PhysicalPath = 'C:\inetpub\PSDSCPullServer',

        [Parameter()]
        [System.Boolean]
        $UseSecurityBestPractices = $false
    )

    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DSCResource -ModuleName xPSDesiredStateConfiguration

    xDscWebService PSDSCPullServer
    {
        Ensure                   = 'Present'
        EndpointName             = $EndpointName
        Port                     = $Port
        PhysicalPath             = $PhysicalPath
        CertificateThumbPrint    = $CertificateThumbPrint
        ModulePath               = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Modules"
        ConfigurationPath        = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration"
        State                    = 'Started'
        UseSecurityBestPractices = $UseSecurityBestPractices
    }
}

# Check site status- up?
# Check to see if selected cloud resources are available

# Define an array of sites to check by supplying a human-friendly name
# and the corresponding URL for testing; add additional URLs separated by
# commas as necessary (Google provided for demonstration)
$URLS = @(
    @('Google','https://www.google.com'),
    @('Bing','https://www.bing.com')
)

# Load the Windows Presentation Foundation resources for the script
[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')

# Create some visual space
Write-Output "`n"

foreach ($url in $URLS) {
    try{
        Write-Output $url[0]
        Invoke-WebRequest $url[1] -TimeoutSec 10 -UseBasicParsing | Select-Object StatusCode, StatusDescription
    }
    catch [System.Net.WebException] {
        if($_.Exception.Status -eq 'Timeout'){
        # the request timed out
        [System.Windows.Forms.MessageBox]::Show( 'Cloud Resource Warning: ' + $url[0] + ' has timed out')
    }
        # something else went wrong during the web request; note - this will run if there is an error
        # in addition to the error message; be careful not to send too many notifications
    }
}

# Pause the script before closing if indirectly executing this script
Pause

# Check https://github.com/mattfussell/ps-check-cssu for updates

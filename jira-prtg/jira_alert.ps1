param (
    [string]$device,
    [string]$linkdevice,
    [string]$sitename,
    [string]$serviceurl,
    [string]$settings,
    [string]$datetime,
    [string]$history,
    [string]$hostname,
    [string]$down,
    [string]$downtime,
    [string]$lastdown,
    [string]$nodename,
    [string]$location,
    [string]$group,
    [string]$linkgroup,
    [string]$lastmessage,
    [string]$lastup,
    [string]$uptime,
    [string]$status,
    [string]$statesince,
    [string]$sensor,
    [string]$linksensor,
    [string]$probe,
    [string]$priority,
    [string]$commentssensor,
    [string]$commentsdevice,
    [string]$commentsgroup,
    [string]$commentsprobe,
    [string]$colorofstate,
    [string]$iconofstate,
    [string]$sensorid
)
$Logfile = $PSScriptRoot + "\jira_error.log"
function WriteLog
{
    Param ([string]$LogString)
    $Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
    $LogMessage = "$Stamp $LogString"
    Add-content $LogFile -value $LogMessage
}
try {
    if ($priority.Length -gt 0 -and $priority.Length -lt 6) {
        $mappedPriority = 'P' + (6 - $priority.Length)
    } else {
        $mappedPriority = 'P5'
    }
    $postData = @{
        device = $device
        linkdevice = $linkdevice
        sitename = $sitename
        serviceurl = $serviceurl
        settings = $settings
        datetime = $datetime
        history = $history
        host = $hostname
        down = $down
        downtime = $downtime
        lastdown = $lastdown
        nodename = $nodename
        location = $location
        group = $group
        linkgroup = $linkgroup
        lastmessage = $lastmessage
        lastup = $lastup
        uptime = $uptime
        status = $status
        statesince = $statesince
        sensor = $sensor
        linksensor = $linksensor
        probe = $probe
        priority = $mappedPriority
        commentssensor = $commentssensor
        commentsdevice = $commentsdevice
        commentsgroup = $commentsgroup
        commentsprobe = $commentsprobe
        colorofstate = $colorofstate
        iconofstate = $iconofstate
        id = $sensorid
    }
    $postDataString = ($postData.GetEnumerator() | ForEach-Object { "$($_.Key)=$($_.Value)" }) -join '&'
    # remove linebreaks $postDataString = $postDataString.Replace("`r`n", " ").Replace("`n", " ")

    $headers = @{
        "Host" = "api.atlassian.com"
    }
    Invoke-WebRequest -Uri "https://api.atlassian.com/jsm/ops/integration/v1/json/prtg?apiKey=....." -Method POST -Body "$postDataString" -ContentType "application/x-www-form-urlencoded" -Headers $headers
} catch {
    WriteLog $_
}
exit 0
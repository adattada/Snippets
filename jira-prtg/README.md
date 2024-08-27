# PRTG Integration

The default Jira PRTG integration for Jira Service Management operations does not handle priority mappings.

With below custom powershell script this limitation can be resolved.

## How to install

1. Copy the script to the PRTG server _InstallDirectory_ -> Notifications\EXE
   - Amend the URL with what Jira shows.
2. Create a custom notification in PRTG:
   - Go to Setup > Account Settings > Notifications.
   - Click on Add Notification and select 'Execute Program'.
   - In the 'Program File' field, select the uploaded 'jira_alert.ps1'.
   - In the 'Parameters' field, pass PRTG placeholders variables:
```
-device "%device" -linkdevice "%linkdevice" -sitename "%sitename" -serviceurl "%serviceurl" -settings "%settings" -datetime "%datetime" -history "%history" -hostname "%host" -down "%down" -downtime "%downtime" -lastdown "%lastdown" -nodename "%nodename" -location "%location" -group "%group" -linkgroup "%linkgroup" -lastmessage "%lastmessage" -lastup "%lastup" -uptime "%uptime" -status "%status" -statesince "%statesince" -sensor "%sensor" -linksensor "%linksensor" -probe "%probe" -priority "%priority" -commentssensor "%commentssensor" -commentsdevice "%commentsdevice" -commentsgroup "%commentsgroup" -commentsprobe "%commentsprobe" -colorofstate "%colorofstate" -iconofstate "%iconofstate" -sensorid "%sensorid"
```

## Debugging
The script logs errors in the same folder as 'jira_error.log'. 

In case you need to debug, just add additional "WriteLog" statements to fetch intermediate results.

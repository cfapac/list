$GitHub_List = Invoke-WebRequest https://raw.githubusercontent.com/cfapac/list/main/tools_list
$GitHub_LatestVersion = Invoke-WebRequest https://raw.githubusercontent.com/cfapac/list/main/tools_latest

$List_Installed = Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall"
$List_Tools = $GitHub_List.Content
$List_LatestVersion = $GitHub_LatestVersion.Content

$Installed_ForensicTool = @()


$List_Installed | ForEach-Object {

    $Software_Name = $_.GetValue('DisplayName')
    $Software_Version = $_.GetValue('DisplayVersion') #-replace "\s\(.*?\)$",""
    
    If ($Software_Name -match $List_Tools){

        $Installed_ForensicTool += [pscustomobject]@{
            Name = $Software_Name
            Version = $Software_Version
            Info = $Software_Name + " - " + $Software_Version

        }
    }
}

$Installed_ForensicTool


<#




foreach ($Each_Software in $List_Installed){

    $Software_Name = $InstalledObject.GetValue('DisplayName');
    $sw_version = $InstalledObject.GetValue('DisplayVersion')
    $sw_versiononly = $InstalledObject.GetValue('DisplayVersion') -replace "\s\(.*?\)$",""

    If($sw_name -match $List_tools){
        $ForensicTool_list += [pscustomobject]@{
            Name = $sw_name
            Version = $sw_version
            ToolName = $sw_name + " - " + $sw_versiononly
        }
    }
}

foreach ($ForensicTool in $ForensicTool_list){

    if ($ForensicTool.ToolName -match "EnCase"){

#        $ForensicTool

    }
}

<#$Info_Hostname = $env:computername
$Info_CurrentTime = $(get-date)
$Info_TimeStamp = $Info_CurrentTime.tostring("yyyy/MM/dd-HH:mm:ss")

$computerSystem = Get-WmiObject Win32_ComputerSystem
$computerOS = Get-WmiObject Win32_OperatingSystem
$computerSN = Get-WmiObject Win32_bios | Select-Object SerialNumber

$Info_Model = $computerSystem.Model
$Info_OS = $computerOS.caption
$Info_SN = $computerSN.SerialNumber
$Info_User = $computerSystem.UserName

$InstalledSoftware = Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall"

$Detected_list = @()
foreach ($InstalledObject in $InstalledSoftware){
    $sw_name = $InstalledObject.GetValue('DisplayName');
    $sw_version = $InstalledObject.GetValue('DisplayVersion')
    $sw_versiononly = $InstalledObject.GetValue('DisplayVersion') -replace "\s\(.*?\)$",""

    If($sw_name -match 'EnCase|Cellebrite|Oxygen Forensic Detective|Emailchemy|Magnet AXIOM|Message Crawler'){
        $Detected_list += [pscustomobject]@{
            Name = $sw_name
            Version = $sw_version
            'Name and Version' = $sw_name + " - " + $sw_versiononly
        }
    }
}

$Detected_list


$Web = Invoke-WebRequest https://github.com/dfapac/list/raw/main/latest
$web.Content

#$Web.Content
#$Web_String = $web.tostring() -split "[`r`n]" | Select-String "rawLines"
#$LatestVersion = $Web_String | ConvertFrom-Json
#$LatestVersion

# ROOT.payload.blob.rawLines
# Web_String

#$web

$webhookaddr = "https://epiqsystems3.webhook.office.com/webhookb2/5b277128-9c71-4855-8a91-38963747cc5a@2a9f86a9-29e7-44bd-8863-849373d53db8/IncomingWebhook/8fdcbc838008448fae031564321bcf6a/e4ece5cc-3fca-4de4-b90d-9030049fb44f"
$webhookMessage = [PSCustomObject][Ordered]@{
    title = $Info_Hostname
    text  = "`n
    Date: $Info_TimeStamp
    Model: $Info_Model
    OS: $Info_OS
    Serial Number: $Info_SN
    User: $Info_User
    Detected SW:
    $Detected_list
    "
    }
$webhookJSON = convertto-json $webhookMessage -Depth 50
$webhookCall = @{
    "URI"         = $webhookaddr
    "Method"      = 'POST'
    "Body"        = $webhookJSON
    "ContentType" = 'application/json'
}

Invoke-RestMethod @webhookCall
#>
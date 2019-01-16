# [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

$Form = New-Object System.Windows.Forms.Form
$Form.text = "Form"
$Form.Size = New-Object System.Drawing.Size(600,600)
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()


function Get-MemoryUsage ($ComputerName=$ENV:ComputerName) {

    if (Test-Connection -ComputerName $ComputerName -Count 1 -Quiet) {
    $ComputerSystem = Get-WmiObject -ComputerName $ComputerName -Class Win32_operatingsystem -Property CSName, TotalVisibleMemorySize, FreePhysicalMemory
    $MachineName = $ComputerSystem.CSName
    $FreePhysicalMemory = ($ComputerSystem.FreePhysicalMemory) / (1mb)
    $TotalVisibleMemorySize = ($ComputerSystem.TotalVisibleMemorySize) / (1mb)
    $TotalVisibleMemorySizeR = “{0:N2}” -f $TotalVisibleMemorySize
    $TotalFreeMemPerc = ($FreePhysicalMemory/$TotalVisibleMemorySize)*100
    $TotalFreeMemPercR = “{0:N2}” -f $TotalFreeMemPerc
    
    # print the machine details:
    “PC Name: $MachineName”
    “RAM: $TotalVisibleMemorySizeR GB”
    “Free Memory: $TotalFreeMemPercR %”
    } }

   <# function Get-Temperature {
        $TempFormat = "#"
        $TempFile = "temperature"
    
        $Command = 'Get-WmiObject MSAcpi_ThermalZoneTemperature -Namespace "root/wmi" ' + " > $pwd\$TempFile.txt"
        $Command = 'Get-WmiObject MSAcpi_ThermalZoneTemperature -Namespace "root/wmi" ' + " | Export-Clixml $pwd\$TempFile.xml"
    
        $p = Start-Process -Verb runas -FilePath "powershell" -ArgumentList $command -WorkingDirectory $pwd -PassThru
        $p.WaitForExit()
    
        $t = Import-Clixml pippo.xml
    
        $returntemp = @()
    
        foreach ($Sensor in $t)
        {
        $Active = if($sensor.Active){"On "}else{"Off"}
        $temp = $Sensor.CurrentTemperature
        $Critical = $Sensor.CriticalTripPoint
    
        $currentTempKelvin = $temp / 10
        $currentTempCelsius = $currentTempKelvin - 273.15
        $currentTempFahrenheit = (9/5) * $currentTempCelsius + 32
    
        $StrKelvin = $currentTempKelvin.ToString($TempFormat).PadLeft(3, " ")
        $StrCelsius = $currentTempCelsius.ToString($TempFormat).PadLeft(3, " ")
        $StrFahrenheit = $currentTempFahrenheit.ToString($TempFormat).PadLeft(3, " ")
    
        $CriticalKelvin = $Critical / 10
        $CriticalCelsius = $CriticalKelvin - 273.15
        $CriticalFahrenheit = (9/5) * $CriticalCelsius + 32
    
        $StrCritKelvin = $CriticalKelvin.ToString($TempFormat).PadRight(3, " ")
        $StrCritCelsius = $CriticalCelsius.ToString($TempFormat).PadRight(3, " ")
        $StrCritFahrenheit = $CriticalFahrenheit.ToString($TempFormat).PadRight(3, " ")
    
        $PerCrit = ($currentTempCelsius/$CriticalCelsius * 100)
        $StrPerCrit = $PerCrit.ToString($TempFormat).PadLeft(3, " ")
    
        $returntemp += "$Active $StrPerCrit% $StrCelsius/$StrCritCelsius C : $StrFahrenheit/$StrCritFahrenheit  F : $StrKelvin/$StrCritKelvin K - " + $Sensor.InstanceName 
        }
        return $returntemp
    }
 #>
<#
    #Param()
Function Get-downloadSpeed($strUploadUrl)
{
    $topServerUrlSpilt = $strUploadUrl -split 'upload'
    $url = $topServerUrlSpilt[0] + 'random2000x2000.jpg'
    $col = new-object System.Collections.Specialized.NameValueCollection 
    $wc = new-object system.net.WebClient 
    $wc.QueryString = $col 
    $downloadElaspedTime = (measure-command {$webpage1 = $wc.DownloadData($url)}).totalmilliseconds
    $string = [System.Text.Encoding]::ASCII.GetString($webpage1)
    $downSize = ($webpage1.length + $webpage2.length) / 1Mb
    $downloadSize = [Math]::Round($downSize, 2)
    $downloadTimeSec = $downloadElaspedTime * 0.001
    $downSpeed = ($downloadSize / $downloadTimeSec) * 8
    $downloadSpeed = [Math]::Round($downSpeed, 2)
    return $downloadSpeed
}


$objXmlHttp = New-Object -ComObject MSXML2.ServerXMLHTTP
$objXmlHttp.Open("GET", "http://www.speedtest.net/speedtest-config.php", $False)
$objXmlHttp.Send()

#Retrieving the content of the response.
[xml]$content = $objXmlHttp.responseText


#Gives me the Latitude and Longitude so i can pick the closer server to me to actually test against. It doesnt seem to automatically do this. 
#Lat and Longitude for tampa at my house are $orilat = 27.9238 and $orilon = -82.3505 
#This is corroborated against: http://www.travelmath.com/cities/Tampa,+FL - It checks out. 

$oriLat = $content.settings.client.lat
$oriLon = $content.settings.client.lon

#Making another request. This time to get the server list from the site.
$objXmlHttp1 = New-Object -ComObject MSXML2.ServerXMLHTTP
$objXmlHttp1.Open("GET", "http://www.speedtest.net/speedtest-servers.php", $False)
$objXmlHttp1.Send()


[xml]$ServerList = $objXmlHttp1.responseText


$cons = $ServerList.settings.servers.server 

foreach($val in $cons) 
{ 
    $R = 6371;
    [float]$dlat = ([float]$oriLat - [float]$val.lat) * 3.14 / 180;
    [float]$dlon = ([float]$oriLon - [float]$val.lon) * 3.14 / 180;
    [float]$a = [math]::Sin([float]$dLat/2) * [math]::Sin([float]$dLat/2) + [math]::Cos([float]$oriLat * 3.14 / 180 ) * [math]::Cos([float]$val.lat * 3.14 / 180 ) * [math]::Sin([float]$dLon/2) * [math]::Sin([float]$dLon/2);
    [float]$c = 2 * [math]::Atan2([math]::Sqrt([float]$a ), [math]::Sqrt(1 - [float]$a));
    [float]$d = [float]$R * [float]$c;

    $ServerInformation +=
@([pscustomobject]@{Distance = $d; Country = $val.country; Sponsor = $val.sponsor; Url = $val.url })

}

$serverinformation = $serverinformation | Sort-Object -Property distance


$DLResults1 = downloadSpeed($serverinformation[0].url)
$SpeedResults += @([pscustomobject]@{Speed = $DLResults1;})

$DLResults2 = downloadSpeed($serverinformation[1].url)
$SpeedResults += @([pscustomobject]@{Speed = $DLResults2;})

$DLResults3 = downloadSpeed($serverinformation[2].url)
$SpeedResults += @([pscustomobject]@{Speed = $DLResults3;})

$DLResults4 = downloadSpeed($serverinformation[3].url)
$SpeedResults += @([pscustomobject]@{Speed = $DLResults4;})

$UnsortedResults = $SpeedResults | Sort-Object -Property speed
$WanSpeed = $UnsortedResults[3].speed
Write-Host "Wan Speed is $($Wanspeed) Mbit/Sec"
#>

#************************************************************************************

$ipv4 = ipconfig | findstr /i "ipv4" | select -last 1
$ipv6 = ipconfig | findstr /i "ipv6" | select -last 1
$subnetz = ipconfig | findstr /i "Subnetzmaske" | select -last 1
$gateway = ipconfig | findstr /i "Standardgateway" | select -last 1

#$netz = get-downloadSpeed

# $cpu = Get-Temperature
# $cpuhz = Get-WmiObject win32_processor | select LoadPercentage  |fl #Get-WmiObject MSAcpi_ThermalZoneTemperature -Namespace "root/wmi"
$pcname = Get-MemoryUsage | findstr /i "Name:"
$ramuse = Get-MemoryUsage| findstr /i "Ram:"
$ramfrei = Get-MemoryUsage| findstr /i "Memory:"


#************************************************************************************

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = '400,400'
$Form.text                       = "Form"
$Form.TopMost                    = $false

$TextBox1                        = New-Object system.Windows.Forms.TextBox
$TextBox1.multiline              = $false
$TextBox1.text                   = "$Form"
$TextBox1.width                  = 100
$TextBox1.height                 = 20
$TextBox1.location               = New-Object System.Drawing.Point(28,55)
$TextBox1.Font                   = 'Microsoft Sans Serif,10'

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = '400,400'
$Form.text                       = "Form"
$Form.TopMost                    = $false

$TextBox2                        = New-Object system.Windows.Forms.TextBox
$TextBox2.multiline              = $false
$TextBox2.text                   = "Form"
$TextBox2.width                  = 100
$TextBox2.height                 = 20
$TextBox2.location               = New-Object System.Drawing.Point(38,55)
$TextBox2.Font                   = 'Microsoft Sans Serif,10'

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = '400,400'
$Form.text                       = "Form"
$Form.TopMost                    = $false

$TextBox2                        = New-Object system.Windows.Forms.TextBox
$TextBox2.multiline              = $false
$TextBox2.text                   = "Form"
$TextBox2.width                  = 100
$TextBox2.height                 = 20
$TextBox2.location               = New-Object System.Drawing.Point(28,55)
$TextBox2.Font                   = 'Microsoft Sans Serif,10'

$Form.controls.AddRange(@($TextBox1.$TextBox2))

$Form.BackColor = "white"

#*******************************************************************************

# Start group boxes

#4er-anordnung
#oben links
$groupBox = New-Object System.Windows.Forms.GroupBox
$groupBox.Location = New-Object System.Drawing.Size(50,620)
$groupBox.size = New-Object System.Drawing.Size(350,50)
$groupBox.text = "`n`n$IPv4"
$Form.Controls.Add($groupBox)
#unten links
$groupBox = New-Object System.Windows.Forms.GroupBox
$groupBox.Location = New-Object System.Drawing.Size(50,680)
$groupBox.size = New-Object System.Drawing.Size(350,50)
$groupBox.text = "`n`n$IPv6"
$Form.Controls.Add($groupBox)
#oben rechts
$groupBox = New-Object System.Windows.Forms.GroupBox
$groupBox.Location = New-Object System.Drawing.Size(450,620)
$groupBox.size = New-Object System.Drawing.Size(350,50)
$groupBox.text = "`n`n$Subnetz"
$Form.Controls.Add($groupBox)
#unten rechts
$groupBox = New-Object System.Windows.Forms.GroupBox
$groupBox.Location = New-Object System.Drawing.Size(450,680)
$groupBox.size = New-Object System.Drawing.Size(350,50)
$groupBox.text = "`n`n$gateway"
$Form.Controls.Add($groupBox)
#ende 4er-anordnung
#**************************************************************
#rechts
$groupBox = New-Object System.Windows.Forms.GroupBox
$groupBox.Location = New-Object System.Drawing.Size(450,75)
$groupBox.size = New-Object System.Drawing.Size(350,50)
$groupBox.text = "`n`n$pcname"
$Form.Controls.Add($groupBox)

$groupBox1 = New-Object System.Windows.Forms.GroupBox
$groupBox1.Location = New-Object System.Drawing.Size(450,150)
$groupBox1.size = New-Object System.Drawing.Size(350,400)
$groupBox1.text = "`n`n$ramuse"
$Form.Controls.Add($groupBox1)

#links
$groupBox = New-Object System.Windows.Forms.GroupBox
$groupBox.Location = New-Object System.Drawing.Size(50,75)
$groupBox.size = New-Object System.Drawing.Size(350,50)
$groupBox.text = "netzgeschwindikeit geplant"
$Form.Controls.Add($groupBox)

$groupBox1 = New-Object System.Windows.Forms.GroupBox
$groupBox1.Location = New-Object System.Drawing.Size(50,150)
$groupBox1.size = New-Object System.Drawing.Size(350,400)
$groupBox1.text = "`n`n$ramfrei"
$Form.Controls.Add($groupBox1)


# ende group boxes

# Start text fields

$InputBox = New-Object System.Windows.Forms.TextBox
$InputBox.Location = New-Object System.Drawing.Size(900,100)
$InputBox.Size = New-Object System.Drawing.Size(400,80)
$Form.Controls.Add($InputBox)

$outputBox = New-Object System.Windows.Forms.TextBox
$outputBox.Location = New-Object System.Drawing.Size(900,150)
$outputBox.Size = New-Object System.Drawing.Size(870,650)
$outputBox.MultiLine = $True
$outputBox.ScrollBars = "Vertical"
$Form.Controls.Add($outputBox)

# ende text fields

# Start buttons

$Button = New-Object System.Windows.Forms.Button
$Button.Location = New-Object System.Drawing.Size(1530,850)
$Button.Size = New-Object System.Drawing.Size(100,75)
$Button.Text = "refresh"
$Button.ForeColor = "Green"
$Button.Add_Click({$Form.Refresh()})
$Form.Controls.Add($Button)

$Button = New-Object System.Windows.Forms.Button
$Button.Location = New-Object System.Drawing.Size(1650,100)
$Button.Size = New-Object System.Drawing.Size(75,25)
$Button.Text = "Process"
$Button.Add_Click({$outputBox.Text = Get-Process | Out-String})
$Form.Controls.Add($Button)

$Button = New-Object System.Windows.Forms.Button
$Button.Location = New-Object System.Drawing.Size(1550,100)
$Button.Size = New-Object System.Drawing.Size(75,25)
$Button.Text = "HitFix"
$Button.Add_Click({   $outputbox.Text = Get-HotFix | Format-Table -Property HotFixID, InstalledOn -AutoSize | Out-String})
$Form.Controls.Add($Button)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Size(1670,850)
$cancelButton.Size = New-Object System.Drawing.Size(100,75)
$cancelButton.Text = "close"
$cancelButton.ForeColor = "Red"
$cancelButton.Add_Click({ $form.Tag = $null; $form.Close() })
$Form.Controls.Add($cancelButton)

# ende buttons

<#>logo
Clear-Host
$DesktopPath = [Environment]::GetFolderPath("Desktop")
$urlimage = "https://www.lffl.org/wp-content/uploads/2016/08/powershell.png"
$pathimage = "$DesktopPath\image.png"
Invoke-WebRequest $urlimage -OutFile $pathimage
$ButtonImg = New-Object System.Windows.Forms.PictureBox 
$ButtonImg.Location = New-Object System.Drawing.Size(455,380) 
$ButtonImg.Width =  $image.Size.Width;
$ButtonImg.Height =  $image.Size.Height;
$image = [System.Drawing.Image]::FromFile("$pathimage")
$ButtonImg.Image = $image
$form.controls.add($buttonImg)
Remove-Item -Force $DesktopPath\image.png
<#>

$Form.Add_Shown({$Form.Activate()})
[void] $Form.ShowDialog()
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

$Form = New-Object System.Windows.Forms.Form
$Form.text = "Hardware Checks"
$Form.Size = New-Object System.Drawing.Size(600,600)
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = '400,400'
$Form.text                       = "Form"
$Form.TopMost                    = $false

$TextBox1                        = New-Object system.Windows.Forms.TextBox
$TextBox1.multiline              = $false
$TextBox1.text                   = "$ip"
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
$TextBox2.text                   = "$ip"
$TextBox2.width                  = 100
$TextBox2.height                 = 20
$TextBox2.location               = New-Object System.Drawing.Point(38,55)
$TextBox2.Font                   = 'Microsoft Sans Serif,10'

$Form.controls.AddRange(@($TextBox1))
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = '400,400'
$Form.text                       = "Form"
$Form.TopMost                    = $false

$TextBox2                        = New-Object system.Windows.Forms.TextBox
$TextBox2.multiline              = $false
$TextBox2.text                   = "$ip"
$TextBox2.width                  = 100
$TextBox2.height                 = 20
$TextBox2.location               = New-Object System.Drawing.Point(28,55)
$TextBox2.Font                   = 'Microsoft Sans Serif,10'

$Form.controls.AddRange(@($TextBox1.$TextBox2))

# Start functions

function checkinfo {
$HostName=$InputBox.text;


$computerSystem = get-wmiobject Win32_ComputerSystem -ComputerName $HostName
$computerBIOS = get-wmiobject Win32_BIOS -ComputerName $HostName
$computerOS = get-wmiobject Win32_OperatingSystem -ComputerName $HostName
$computerOSB = get-wmiobject Win32_OperatingSystem -ComputerName $HostName
$computerBLD = get-wmiobject Win32_OperatingSystem -ComputerName $HostName
$computerCPU = get-wmiobject Win32_Processor -ComputerName $HostName
$computerHDD = Get-WmiObject Win32_LogicalDisk -ComputerName $HostName -Filter "DeviceID='C:'"
write-host "System Information for: " $computerSystem.Name
$Man = $computerSystem.Manufacturer
$Mod = $computerSystem.
$Ser = $computerBIOS.SerialNumber
$CPUs = $ComputerSystem.NumberOfProcessors
$Cores = $ComputerSystem.NumberOfLogicalProcessors
$HDD = "{0:N2}" -f ($computerHDD.Size/1GB) + "GB"
$RAM = "{0:N2}" -f ($computerSystem.TotalPhysicalMemory/1GB) + "GB"
$OS = $computerOS.caption -replace "Microsoft Windows 7 Enterprise , Service Pack: 1", "Win 7"
$OSB = $computerOSB.ConvertToDateTime(($computerOSB).InstallDate)
$Usr = $computerSystem.UserName
$Check=$Man, $Mod, $Ser, $CPUs, $Cores, $HDD, $RAM, $OS, $OSB, $Urs
$outputBox.text=$Check
}
# ende functions

# Start group boxes

$groupBox = New-Object System.Windows.Forms.GroupBox
$groupBox.Location = New-Object System.Drawing.Size(250,20)
$groupBox.size = New-Object System.Drawing.Size(130,40)
$groupBox.text = "Hardware Info:"
$Form.Controls.Add($groupBox)

# ende group boxes

$groupBox1 = New-Object System.Windows.Forms.GroupBox
$groupBox1.Location = New-Object System.Drawing.Size(250,70)
$groupBox1.size = New-Object System.Drawing.Size(130,100)
$groupBox1.text = "Checks by OS:"
$Form.Controls.Add($groupBox1)

# Start text fields

$InputBox = New-Object System.Windows.Forms.TextBox
$InputBox.Location = New-Object System.Drawing.Size(20,50)
$InputBox.Size = New-Object System.Drawing.Size(150,20)
$Form.Controls.Add($InputBox)

$outputBox = New-Object System.Windows.Forms.TextBox
$outputBox.Location = New-Object System.Drawing.Size(10,200)
$outputBox.Size = New-Object System.Drawing.Size(565,200)
$outputBox.MultiLine = $True
$outputBox.ScrollBars = "Vertical"
$Form.Controls.Add($outputBox)

# ende text fields

# Start buttons

$Button = New-Object System.Windows.Forms.Button
$Button.Location = New-Object System.Drawing.Size(450,30)
$Button.Size = New-Object System.Drawing.Size(75,75)
$Button.Text = "Check"
$Button.Add_Click({checkinfo})
$Form.Controls.Add($Button)

# ende buttons

# Start buttons

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Size(450,520)
$cancelButton.Size = New-Object System.Drawing.Size(75,25)
$cancelButton.Text = "beenden"
$cancelButton.Add_Click({ $form.Tag = $null; $form.Close() })
$Form.Controls.Add($cancelButton)

# ende buttons

$Form.Add_Shown({$Form.Activate()})
[void] $Form.ShowDialog()



    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    #CPU Temp 1

    function Get-Temperature {
    $t = Get-WmiObject MSAcpi_ThermalZoneTemperature -Namespace "root/wmi"

    $currentTempKelvin = $t.CurrentTemperature / 10
    $currentTempCelsius = $currentTempKelvin - 273.15

    $currentTempFahrenheit = (9/5) * $currentTempCelsius + 32

    return $currentTempCelsius.ToString() + " C : " + $currentTempFahrenheit.ToString() + " F : " + $currentTempKelvin + "K"  
}

# Save in your c:\users\yourName\Documents\WindowsPowerShell\modules\ directory
# in sub directory get-temperature as get-temperature.psm1
# You **must** run as Administrator.
# It will only work if your system & BIOS support it. If it doesn't work, I can't help you.

# Just type get-temperature in PowerShell and it will spit back the temp in Celsius, Farenheit and Kelvin.

# More info on my blog: http://ammonsonline.com/is-it-hot-in-here-or-is-it-just-my-cpu/


    
     #CPU Temp 2

    function Get-Temperature {
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
 
 cons



$IP = Get-WmiObject Win32_NetworkAdapterConfiguration -filter "IPenabled=true" | % {$_.IPAddress}
Write-Output $IP
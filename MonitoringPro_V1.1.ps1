# [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

$Form = New-Object System.Windows.Forms.Form
$Form.text = "Form"
$Form.Size = New-Object System.Drawing.Size(600,600)
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()


$ip = get process sort-object ipconfig

************************************************************************************

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



*********************************************************************************

# Start group boxes

$groupBox = New-Object System.Windows.Forms.GroupBox
$groupBox.Location = New-Object System.Drawing.Size(250,50)
$groupBox.size = New-Object System.Drawing.Size(200,80)
$groupBox.text = "Ramauslastung :"
$Form.Controls.Add($groupBox)

$groupBox1 = New-Object System.Windows.Forms.GroupBox
$groupBox1.Location = New-Object System.Drawing.Size(250,150)
$groupBox1.size = New-Object System.Drawing.Size(200,160)
$groupBox1.text = "CPU Themperatur:"
$Form.Controls.Add($groupBox1)

$groupBox = New-Object System.Windows.Forms.GroupBox
$groupBox.Location = New-Object System.Drawing.Size(475,50)
$groupBox.size = New-Object System.Drawing.Size(200,80)
$groupBox.text = "Ramauslastung :"
$Form.Controls.Add($groupBox)

$groupBox1 = New-Object System.Windows.Forms.GroupBox
$groupBox1.Location = New-Object System.Drawing.Size(475,150)
$groupBox1.size = New-Object System.Drawing.Size(200,160)
$groupBox1.text = "CPU Themperatur:"
$Form.Controls.Add($groupBox1)

$groupBox = New-Object System.Windows.Forms.GroupBox
$groupBox.Location = New-Object System.Drawing.Size(30,50)
$groupBox.size = New-Object System.Drawing.Size(200,80)
$groupBox.text = "Ramauslastung :"
$Form.Controls.Add($groupBox)

$groupBox1 = New-Object System.Windows.Forms.GroupBox
$groupBox1.Location = New-Object System.Drawing.Size(30,150)
$groupBox1.size = New-Object System.Drawing.Size(200,160)
$groupBox1.text = "CPU Themperatur:"
$Form.Controls.Add($groupBox1)

$groupBox = New-Object System.Windows.Forms.GroupBox
$groupBox.Location = New-Object System.Drawing.Size(700,50)
$groupBox.size = New-Object System.Drawing.Size(200,80)
$groupBox.text = "Ramauslastung :"
$Form.Controls.Add($groupBox)

$groupBox1 = New-Object System.Windows.Forms.GroupBox
$groupBox1.Location = New-Object System.Drawing.Size(700,150)
$groupBox1.size = New-Object System.Drawing.Size(200,160)
$groupBox1.text = "CPU Themperatur:"
$Form.Controls.Add($groupBox1)

# ende group boxes

# Start text fields

$InputBox = New-Object System.Windows.Forms.TextBox
$InputBox.Location = New-Object System.Drawing.Size(1100,60)
$InputBox.Size = New-Object System.Drawing.Size(150,20)
$Form.Controls.Add($InputBox)

$outputBox = New-Object System.Windows.Forms.TextBox
$outputBox.Location = New-Object System.Drawing.Size(30,350)
$outputBox.Size = New-Object System.Drawing.Size(875,300)
$outputBox.MultiLine = $True
$outputBox.ScrollBars = "Vertical"
$Form.Controls.Add($outputBox)

# ende text fields

# Start buttons

$Button = New-Object System.Windows.Forms.Button
$Button.Location = New-Object System.Drawing.Size(675,700)
$Button.Size = New-Object System.Drawing.Size(100,75)
$Button.Text = "refresh"
$Button.Add_Click({checkinfo})
$Form.Controls.Add($Button)

# ende buttons

# Start buttons

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Size(800,700)
$cancelButton.Size = New-Object System.Drawing.Size(100,75)
$cancelButton.Text = "close"
$cancelButton.Add_Click({ $form.Tag = $null; $form.Close() })
$Form.Controls.Add($cancelButton)

# ende buttons

$Form.Add_Shown({$Form.Activate()})
[void] $Form.ShowDialog()

*************************************************************************************
 
 #cons

#$IP = Get-WmiObject Win32_NetworkAdapterConfiguration -filter "IPenabled=true" | % {$_.IPAddress}
#Write-Output $IP
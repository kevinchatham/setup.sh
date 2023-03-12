Clear-Host
$location = Get-Location
Set-Location $env:USERPROFILE

Write-Host ""
Write-Host "👾 Hello Explorer 👾"
Write-Host ""
Write-Host "This will create a Debian VM on your Hyper-V host."
Write-Host ""
Write-Host "  - If Hyper-V is not installed I will attempt to install it."
Write-Host ""
Write-Host "  - Use administrative privileges to perform these tasks."
Write-Host ""

Read-Host -P "Press any key to launch"
Clear-Host

# Check to make sure the dependencies are in place.
if (!$IsWindows) {
    Write-Host ""
    Write-Host "This script support Windows only."
    Write-Host ""
    exit
}

$hv = Get-WindowsOptionalFeature -FeatureName Microsoft-Hyper-V-All -Online

if ($hv.State -ne "Enabled") {
    Write-Host ""
    Write-Host "Hyper-V is disabled, trying to install."
    Write-Host ""

    Install-WindowsFeature -Name Hyper-V -IncludeManagementTools

    Write-Host ""
    Write-Host "If Hyper-V installed successfully please reboot before running the script again."
    Write-Host ""

    exit
}

# Configure VM properties
$Name = ''
$StartupMemory = ''
$VHDSize = ''
$ProcessorCount = ''

while ($Name -eq '') {
    Write-Host ""
    $Name = Read-Host -Prompt "Name (debian)"
    if ($Name -eq '') {
        $Name = 'debian'
    } 
}

while ($StartupMemory -eq '') {
    Write-Host ""
    $StartupMemory = Read-Host -Prompt "Startup Memory (2GB)"
    if ($StartupMemory -eq '') {
        $StartupMemory = 2GB
    } 
}

while ($VHDSize -eq '') {
    Write-Host ""
    $VHDSize = Read-Host -Prompt "HD Memory (20GB)"
    if ($VHDSize -eq '') {
        $VHDSize = 20GB
    } 
}

while ($ProcessorCount -eq '') {
    Write-Host ""
    $ProcessorCount = Read-Host -Prompt "Processor Count (2)"
    if ($ProcessorCount -eq '') {
        $ProcessorCount = 2
    } 
}

# Download Debian 11 amd64
Write-Host ""
Write-Host "Downloading Debian"
Write-Host ""

# If running amd64
$uri = 'https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.6.0-amd64-netinst.iso'

# If running arm64
# $uri = 'https://cdimage.debian.org/debian-cd/current/arm64/iso-cd/debian-11.6.0-arm64-netinst.iso'

Invoke-WebRequest -URI $uri -OutFile './debian.iso'

# Ensure directories exist
New-Item -ItemType Directory -Path './VM' -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Path './VM/Virtual Machines' -ErrorAction SilentlyContinue

# Create the VM
Write-Host ""
Write-Host "Creating VM"
Write-Host ""
New-VM -Name $Name -MemoryStartupBytes $StartupMemory -BootDevice VHD -NewVHDPath "./VM/$Name.vhdx" -Path "./VM/Virtual Machines" -NewVHDSizeBytes $VHDSize -Generation 2 -Switch External

# Set processor count
Set-VMProcessor $Name -Count $ProcessorCount -Reserve 10 -Maximum 75 -RelativeWeight 200

# Set DVD Drive to image
Write-Host ""
Write-Host "Attaching ISO"
Write-Host ""
Add-VMDvdDrive -VMName $Name -Path "debian.iso"


# Configure boot order
Write-Host ""
Write-Host "Configuring Firmware"
Write-Host ""
Set-VMFirmware -VMName $Name -BootOrder $(Get-VMDvdDrive -VMName $Name), $(Get-VMHardDiskDrive -VMName $Name), $(Get-VMNetworkAdapter -VMName $Name)

# Secure boot just makes life difficult
Set-VMFirmware -VMName $Name -EnableSecureBoot Off

Write-Host ""
Write-Host "Configuring Firmware"
Write-Host ""
Start-VM -Name $Name
Start-Sleep -Seconds 10
Get-VM -VMName $Name

Set-Location $location

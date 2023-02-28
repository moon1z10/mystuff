# Set the names of the Ethernet and Wi-Fi adapters
$adapterNameEthernet = "이더넷"
$adapterNameWiFi = "Wi-Fi"

# Get the current adapter status
$currentAdapter = Get-NetAdapter |
    Where-Object { $_.Status -eq "Up" } |
    Select-Object -First 1 |
    ForEach-Object {
        if ($_.Name -eq $adapterNameEthernet) { "Ethernet" }
        elseif ($_.Name -eq $adapterNameWiFi) { "Wi-Fi" }
    }

# Switch the adapter
if ($currentAdapter -eq "Ethernet") {
    Write-Output "Ethernet adapter is currently enabled"
    Disable-NetAdapter -Name $adapterNameEthernet -Confirm:$false
    Start-Sleep -Seconds 2
    Enable-NetAdapter -Name $adapterNameWiFi -Confirm:$false
    Write-Output "Wi-Fi adapter is now enabled"
}
elseif ($currentAdapter -eq "Wi-Fi") {
    Write-Output "Wi-Fi adapter is currently enabled"
    Disable-NetAdapter -Name $adapterNameWiFi -Confirm:$false
    Start-Sleep -Seconds 2
    Enable-NetAdapter -Name $adapterNameEthernet -Confirm:$false
    Write-Output "Ethernet adapter is now enabled"
}
else {
    Write-Output "Could not find Ethernet or Wi-Fi adapter"
    Pause
}

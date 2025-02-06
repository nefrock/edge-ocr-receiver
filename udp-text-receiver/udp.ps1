$UDPPort=8080
$endpoint = new-object System.Net.IPEndPoint( [IPAddress]::Any, $UDPPort)
$udpclient = new-object System.Net.Sockets.UdpClient $UDPPort
Write-Host ("Now listening on UDP port {0}, press Escape to stop listening" -f $UDPPort) -ForegroundColor Green
while ( $true ) {
    if ( $udpclient.Available ) {
        $content = $udpclient.Receive( [ref]$endpoint )
        $line=[Text.Encoding]::UTF8.GetString($content)
        Write-Host "$($endpoint.Address.IPAddressToString):$($endpoint.Port) $($line)"
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.Clipboard]::SetText($line)
        [System.Windows.Forms.SendKeys]::SendWait("^v")
    }
}
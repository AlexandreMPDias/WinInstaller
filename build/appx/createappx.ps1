
$LocalProjectPath = "C:\Users\tijuk\Projects"
$installer = "$LocalProjectPath\ads\build\innosetup\Output\CyberAds Setup.exe"
$destination = "$LocalProjectPath\ads\build\appx\package"
$AppDisplayName = "CyberAds"
$PackageName = "CyberAds"
$PackageDisplayName = "Cyber Ads - Descricao"
$PublisherName = "CN=Cyberlabs Ltda"
$CurrentDir = "$LocalProjetPath\ads\build\appx"
$AppPath = "$LocalProjectPath\ads\build\appx\package\$PackageName" 
$ApplicationName = "$PackageName.appx"
$CN = "Cyberlabs Ltda"
$cert = "auto-generated"

Remove-Item "package\*" -recurse

desktopappconverter.exe -installer $installer -installerArguments "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART" `
                        -destination $destination -packagename $PackageName -publisher $PublisherName -Version 0.0.0.1 `
                        -AppDisplayName $AppDisplayName `
                        -PackageDisplayName $PackageDisplayName `
                        -PackagePublisherDisplayName $AppDisplayName -makeappx -sign -verbose

Write-Host "Appx built"


    $AppCertKit = "C:\Program Files (x86)\Windows Kits\10\App Certification Kit\"
    $LocalVFSPath = "$AppPath\$PackageName\VFS"
    $WindowsKitBinaries = "C:\Program Files (x86)\Windows Kits\10\bin\10.0.16299.0\x86"
    Rename-Item "$AppPath\$PackageName.appx" "$AppPath\$PackageName.zip"
    Expand-Archive "$AppPath\$PackageName.zip" -DestinationPath "$AppPath\$PackageName"
    Copy-Item "$LocalVFSPath\$PackageName\data" "$LocalVFSPath\SystemX64\data" -recurse
    if (Test-Path("$AppPath\$PackageName.appx")){
        Remove-Item "$AppPath\$PackageName.appx"
    }

    set-location $AppCertKit
    Write-Host "Making Appx"
    .\makeappx.exe pack /d "$AppPath\$PackageName" /p "$AppPath\$PackageName.appx"  /l  
    Write-Host "Appx created"
    if (-not (Test-Path("$AppPath\$PackageName.appx"))){
        .\makeappx.exe pack /d "$AppPath\$PackageName" /p "$AppPath\$PackageName.appx"  /l
    }
    if( Test-Path("$AppPath\$cert.cer")){
        Remove-Item "$AppPath\$cert.cer"
        Remove-Item "$AppPath\$cert.pfx"
    }
    set-location $WindowsKitBinaries
    if (-not (Test-Path("$AppPath\$cert.cer")))
    {
        Write-Host "Certificates not found."
        makecert.exe -r -h 0 -n "CN=$CN" -eku 1.3.6.1.5.5.7.3.3 -pe -sv $AppPath\$cert.pvk $AppPath\$cert.cer
        pvk2pfx.exe -pvk $AppPath\$cert.pvk -spc $AppPath\$cert.cer -pfx $AppPath\$cert.pfx
        certutil.exe -addStore TrustedPeople $AppPath\$cert.cer
    }
    .\signtool.exe sign -f $AppPath\$cert.pfx -fd SHA256 -v (Join-Path $AppPath  $ApplicationName)
    Invoke-Item "$AppPath\$PackageName.appx"
    set-location $CurrentDir

#define MyAppVersion "0.0.0.1"
#define MyAppName "CyberAds"
#define MyAppPublisher "Cyberlabs"
#define MyAppURL "http://www.cyberlabs.com.br"
#define MyAppExeName "main.exe"
#define DataDir = "C:/{#MyAppName}"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{C532E133-78F4-48CE-828B-DEDA37A449EA}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName=C:\CyberAds
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
OutputBaseFilename=CyberAds Setup
Compression=lzma
SolidCompression=yes
DisableStartupPrompt=yes
Uninstallable=no

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
;Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"; Flags: skipifsilent

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 0,6.1

[Files]
Source: "C:/Users/tijuk/Projects/ads/build/pyinstaller/dist/main/main.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:/Users/tijuk/Projects/ads/build/pyinstaller/dist/main/*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
;Source: "C:\Users\tijuk\Projects\smile\dist\smile_cam\data\*"; DestDir: "{userappdata}\{#MyAppPublisher}\{#MyAppName}\data"; Flags: recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files


[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:ProgramOnTheWeb,{#MyAppName}}"; Filename: "{#MyAppURL}"
;Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}";
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: quicklaunchicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent


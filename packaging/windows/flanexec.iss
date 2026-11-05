; Inno Setup script for unsigned fLANexec Windows installer.
; Compile after: flutter build windows --release
;
; Expected env (set by CI or locally):
;   FLANEXEC_VERSION  - e.g. 1.0.0
;   FLANEXEC_ROOT     - repo root (optional; defaults relative to this script)

#ifndef FLANEXEC_VERSION
  #define FLANEXEC_VERSION "1.0.0"
#endif

#ifndef FLANEXEC_ROOT
  #define FLANEXEC_ROOT "..\.."
#endif

#define MyAppName "fLANexec"
#define MyAppExeName "flanexec.exe"
#define MyAppPublisher "r4fr13nds"
#define MyAppURL "https://github.com/r4fr13nds/fLANexec"
#define MyAppId "com.r4fr13nds.flanexec"

[Setup]
AppId={#MyAppId}
AppName={#MyAppName}
AppVersion={#FLANEXEC_VERSION}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}/issues
AppUpdatesURL={#MyAppURL}/releases
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
OutputDir={#FLANEXEC_ROOT}\dist
OutputBaseFilename=flanexec-{#FLANEXEC_VERSION}-windows-x64-setup
SetupIconFile={#FLANEXEC_ROOT}\windows\runner\resources\app_icon.ico
Compression=lzma
SolidCompression=yes
WizardStyle=modern
PrivilegesRequired=lowest
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
UninstallDisplayIcon={app}\{#MyAppExeName}

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "{#FLANEXEC_ROOT}\build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

;This program is free software: you can redistribute it and/or modify
;it under the terms of the GNU General Public License as published by
;the Free Software Foundation, either version 3 of the License, or
;(at your option) any later version.
;
;This program is distributed in the hope that it will be useful,
;but WITHOUT ANY WARRANTY; without even the implied warranty of
;MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;GNU General Public License for more details.
;
;You should have received a copy of the GNU General Public License
;along with this program.  If not, see <http://www.gnu.org/licenses/>.

;
; Sign the setup.exe properly
; Tools > Sign Tools > 
;"C:\Program Files\Microsoft SDKs\Windows\v7.1\Bin\signtool.exe" sign /f C:\Users\sunuser\Downloads\globalsign.pfx /p Password /tr http://timestamp.globalsign.com/scripts/timestamp.dll $f

#define MyAppName "Attendedbyhumans"
#define MyAppVersion "1.5"
#define MyAppPublisher "Attendedbyhumans"
#define MyAppURL "https://www.attendedbyhumans.com/"
#define MyAppExeName "nw.exe"

[Setup]
AppId={{92510DE2-D5AE-46E3-B9A8-A0B3D5C85463}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppName}
DisableDirPage=yes
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
OutputDir=C:\Users\sunuser\Desktop
OutputBaseFilename=setup
Compression=lzma
SolidCompression=yes
SignTool=signtool
#include <idp.iss>

[Components]
Name: app;  Description: "AttendedByHumans";  Types: full compact custom; Flags: fixed

[Files]
Source: "C:\Users\sunuser\Desktop\ninite.exe"; DestDir: "{app}"; Flags: ignoreversion;
Source: "{tmp}\app.exe";  DestDir: "{app}"; Flags: external;        ExternalSize: 19048576; Components: app
Source: "{tmp}\ultravnc64.exe";  DestDir: "{app}"; Flags: external; ExternalSize: 2048576; Components: app
Source: "{tmp}\gst64.exe"; DestDir: "{app}"; Flags: external;       ExternalSize: 97048576; Components: app
Source: "{tmp}\go64.exe"; DestDir: "{app}"; Flags: external;        ExternalSize: 5748576; Components: app

[Icons]
Name: "{group}\My Program"; Filename: "app.exe";  Components: app
Name: "{group}\{cm:UninstallProgram,My Program}"; Filename: "{uninstallexe}"

[Code]
procedure InitializeWizard;
begin
  idpAddFileComp('https://download.attendedbyhumans.com/ikiosk.exe',  ExpandConstant('{tmp}\app.exe'),  'app');
  idpAddFileComp('https://download.attendedbyhumans.com/ultravnc64.exe',  ExpandConstant('{tmp}\ultravnc64.exe'),  'app');
  idpAddFileComp('https://download.attendedbyhumans.com/gst64.msi',  ExpandConstant('{tmp}\gst64.exe'),  'app'); 
  idpAddFileComp('https://download.attendedbyhumans.com/go64.msi',  ExpandConstant('{tmp}\go64.exe'),  'app'); 
  idpDownloadAfter(wpReady);
end;

[Run]
Filename: "{app}\ninite.exe"
Filename: "{tmp}\app.exe"


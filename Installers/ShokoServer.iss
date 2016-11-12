; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

; Inno Download Plugin is needed to compile!
; https://mitrichsoftware.wordpress.com/inno-setup-tools/inno-download-plugin/

#include <idp.iss>
#define AppVer GetFileVersion('..\JMMServer\bin\Release\ShokoServer.exe')

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{0BA2D22B-A0B7-48F8-8AA1-BAAEFC2034CB}
AppName=Shoko Server
AppVersion=3.7.0.0
AppVerName=Shoko Server
AppPublisher=Shoko Team
AppPublisherURL=https://github.com/japanesemediamanager
AppSupportURL=https://github.com/japanesemediamanager
AppUpdatesURL=https://github.com/japanesemediamanager
DefaultDirName={pf}\Shoko\Shoko Server
DefaultGroupName=Shoko Server
AllowNoIcons=yes
OutputBaseFilename=Shoko_Server_Setup_{#AppVer}
Compression=lzma2/ultra64
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "firewall"; Description: "Firewall Exception"
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 0,6.1

[Files]
Source: "..\JMMServer\bin\Release\DeepCloner.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\DeepCloner.xml"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\FluentNHibernate.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\FluentNHibernate.pdb"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\FluentNHibernate.xml"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\ICSharpCode.SharpZipLib.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\Iesi.Collections.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\Iesi.Collections.xml"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\Infralution.Localization.Wpf.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\ShokoServer.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\ShokoServer.exe.config"; DestDir: "{app}"; Flags: ignoreversion onlyifdoesntexist
Source: "..\JMMServer\bin\Release\ShokoServer.pdb"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\Microsoft.SqlServer.ConnectionInfo.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\Microsoft.SqlServer.ConnectionInfoExtended.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\Microsoft.SqlServer.Management.Sdk.Sfc.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\Microsoft.SqlServer.Smo.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\Microsoft.SqlServer.SmoExtended.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\Microsoft.SqlServer.SqlClrProvider.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\Microsoft.SqlServer.SqlEnum.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\Microsoft.Win32.TaskScheduler.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\Microsoft.Win32.TaskScheduler.xml"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\MimeTypeMap.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\MimeTypeMap.List.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\MySql.Data.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\MySqlBackup.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\Nancy.Authentication.Stateless.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\Nancy.Authentication.Stateless.xml"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\Nancy.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\Nancy.Gzip.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\Nancy.Hosting.Self.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\Nancy.Hosting.Self.xml"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\Nancy.Serialization.JsonNet.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\Nancy.xml"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\Newtonsoft.Json.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\Newtonsoft.Json.xml"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\NHibernate.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\NHibernate.xml"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\Nito.AsyncEx.Concurrent.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\Nito.AsyncEx.Concurrent.xml"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\Nito.AsyncEx.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\Nito.AsyncEx.Enlightenment.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\Nito.AsyncEx.Enlightenment.xml"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\Nito.AsyncEx.xml"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\NLog.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\NLog.xml"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\protobuf-net.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\RestSharp.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\RestSharp.xml"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\System.Data.SQLite.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\System.Data.SQLite.xml"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\System.Net.Http.Formatting.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\System.Net.Http.Formatting.xml"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\TMDbLib.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\TMDbLib.pdb"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\JMMServer\bin\Release\de\*"; DestDir: "{app}\de"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\JMMServer\bin\Release\en-gb\*"; DestDir: "{app}\en-gb"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\JMMServer\bin\Release\es\*"; DestDir: "{app}\es"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\JMMServer\bin\Release\fr\*"; DestDir: "{app}\fr"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\JMMServer\bin\Release\it\*"; DestDir: "{app}\it"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\JMMServer\bin\Release\nl\*"; DestDir: "{app}\nl"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\JMMServer\bin\Release\pl\*"; DestDir: "{app}\pl"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\JMMServer\bin\Release\pt\*"; DestDir: "{app}\pl"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\JMMServer\bin\Release\ru\*"; DestDir: "{app}\ru"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\JMMServer\bin\Release\webui\*"; DestDir: "{app}\webui"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\JMMServer\bin\Release\x86\*"; DestDir: "{app}\x86"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\JMMServer\bin\Release\x64\*"; DestDir: "{app}\x64"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\Shoko Server"; Filename: "{app}\ShokoServer.exe"
Name: "{group}\{cm:UninstallProgram,Shoko Server}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\Shoko Server"; Filename: "{app}\ShokoServer.exe"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\Shoko Server"; Filename: "{app}\ShokoServer.exe"; Tasks: quicklaunchicon

[Run]
Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall add rule name=""Shoko Server - Client Port"" dir=in action=allow protocol=TCP localport=8111"; Flags: runhidden; StatusMsg: "Open exception on firewall..."; Tasks: Firewall
Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall add rule name=""Shoko Server - File Port"" dir=in action=allow protocol=TCP localport=8112"; Flags: runhidden; StatusMsg: "Open exception on firewall..."; Tasks: Firewall
Filename: "{app}\ShokoServer.exe"; Flags: nowait postinstall skipifsilent shellexec; Description: "{cm:LaunchProgram,Shoko Server}"Filename: "http://jmediamanager.org/version-3-6-brings-speed-and-streaming/"; Flags: shellexec runasoriginaluser postinstall; Description: "View Release Notes"

[UninstallRun]
Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall delete rule name=""Shoko Server - Client Port"" protocol=TCP localport=8111"; Flags: runhidden; StatusMsg: "Closing exception on firewall..."; Tasks: Firewall
Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall delete rule name=""Shoko Server - File Port"" protocol=TCP localport=8112"; Flags: runhidden; StatusMsg: "Closing exception on firewall..."; Tasks: Firewall
Filename: "{sys}\netsh.exe"; Parameters: "http delete urlacl url=http://+:8111/JMMServerImage"; Flags: runhidden; StatusMsg: "Unregistering WCF Service...";
Filename: "{sys}\netsh.exe"; Parameters: "http delete urlacl url=http://+:8111/JMMServerBinary"; Flags: runhidden; StatusMsg: "Unregistering WCF Service...";
Filename: "{sys}\netsh.exe"; Parameters: "http delete urlacl url=http://+:8111/JMMServerMetro"; Flags: runhidden; StatusMsg: "Unregistering WCF Service...";
Filename: "{sys}\netsh.exe"; Parameters: "http delete urlacl url=http://+:8111/JMMServerMetroImage"; Flags: runhidden; StatusMsg: "Unregistering WCF Service...";
Filename: "{sys}\netsh.exe"; Parameters: "http delete urlacl url=http://+:8111/JMMServerPlex"; Flags: runhidden; StatusMsg: "Unregistering WCF Service...";
Filename: "{sys}\netsh.exe"; Parameters: "http delete urlacl url=http://+:8111/JMMServerKodi"; Flags: runhidden; StatusMsg: "Unregistering WCF Service...";
Filename: "{sys}\netsh.exe"; Parameters: "http delete urlacl url=http://+:8111/JMMServerREST"; Flags: runhidden; StatusMsg: "Unregistering WCF Service...";
Filename: "{sys}\netsh.exe"; Parameters: "http delete urlacl url=http://+:8111/JMMServerStreaming"; Flags: runhidden; StatusMsg: "Unregistering WCF Service...";
Filename: "{sys}\netsh.exe"; Parameters: "http delete urlacl url=http://+:8112/JMMFilePort"; Flags: runhidden; StatusMsg: "Unregistering WCF Service...";

[Dirs]
Name: "{app}"; Permissions: users-full

[Types]
Name: "main"; Description: "Main"; Flags: iscustom

[Code]
function Framework46IsNotInstalled(): Boolean;
var
  bSuccess: Boolean;
  regVersion: Cardinal;
begin
  Result := True;

  bSuccess := RegQueryDWordValue(HKLM, 'Software\Microsoft\NET Framework Setup\NDP\v4\Full', 'Release', regVersion);
  if (True = bSuccess) and (regVersion >= 394254) then begin
    Result := False;
  end;
end;

procedure InitializeWizard;
begin
  if Framework46IsNotInstalled() then
  begin
    idpAddFile('http://go.microsoft.com/fwlink/?LinkId=671728', ExpandConstant('{tmp}\NetFrameworkInstaller.exe'));
    idpDownloadAfter(wpReady);
  end;
end;

procedure InstallFramework;
var
  StatusText: string;
  ResultCode: Integer;
begin
  StatusText := WizardForm.StatusLabel.Caption;
  WizardForm.StatusLabel.Caption := 'Installing .NET Framework 4.6.1. This might take a few minutes�';
  WizardForm.ProgressGauge.Style := npbstMarquee;
  try
    if not Exec(ExpandConstant('{tmp}\NetFrameworkInstaller.exe'), '/showrmui', '', SW_SHOW, ewWaitUntilTerminated, ResultCode) then
    begin
      MsgBox('.NET installation failed with code: ' + IntToStr(ResultCode) + '.', mbError, MB_OK);
    end;
  finally
    WizardForm.StatusLabel.Caption := StatusText;
    WizardForm.ProgressGauge.Style := npbstNormal;

    DeleteFile(ExpandConstant('{tmp}\NetFrameworkInstaller.exe'));
  end;
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  case CurStep of
    ssPostInstall:
      begin
        if Framework46IsNotInstalled() then
        begin
          InstallFramework();
        end;
      end;
  end;
end;

unit UI.WaitDialog;

interface

uses
  UI.Base, UI.Toast, UI.Dialog,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Forms;


function IsWaitDismiss: Boolean;
procedure HideWaitDialog;

procedure ShowWaitDialog(const AMsg: string; ACancelable: Boolean); overload;
procedure ShowWaitDialog(const AMsg: string;
  OnDismissListener: TOnDialogListener; ACancelable: Boolean); overload;
procedure ShowWaitDialog(const AMsg: string;
  OnDismissListener: TOnDialogListenerA; ACancelable: Boolean); overload;

procedure UpdateWaitDialog(const AMsg: string);

implementation

var
  FWaitDialog: TProgressDialog = nil;

function IsWaitDismiss: Boolean;
begin
  Result := Assigned(FWaitDialog) and (FWaitDialog.IsDismiss)
end;

procedure HideWaitDialog;
begin
  if Assigned(FWaitDialog) then begin
    FWaitDialog.Dismiss;
    FWaitDialog := nil;
  end;
end;

procedure ShowWaitDialog(const AMsg: string;
  OnDismissListener: TOnDialogListener; ACancelable: Boolean);
begin
  ShowWaitDialog(AMsg, ACancelable);
  if Assigned(FWaitDialog) then
    FWaitDialog.OnDismissListener := OnDismissListener;
end;

procedure ShowWaitDialog(const AMsg: string;
  OnDismissListener: TOnDialogListenerA; ACancelable: Boolean);
begin
  ShowWaitDialog(AMsg, ACancelable);
  if Assigned(FWaitDialog) then
    FWaitDialog.OnDismissListenerA := OnDismissListener;
end;

procedure ShowWaitDialog(const AMsg: string; ACancelable: Boolean);
begin
  if (not Assigned(FWaitDialog)) or (FWaitDialog.IsDismiss) then begin
    FWaitDialog := nil;
    FWaitDialog := TProgressDialog.Create(Application.MainForm);
  end;
  FWaitDialog.Cancelable := ACancelable;
  if not Assigned(FWaitDialog.RootView) then
    FWaitDialog.InitView(AMsg)
  else
    FWaitDialog.Message := AMsg;
  TDialog(FWaitDialog).Show();
end;

procedure UpdateWaitDialog(const AMsg: string);
begin
  if (not Assigned(FWaitDialog)) or (FWaitDialog.IsDismiss) then
    Exit;
  if Assigned(FWaitDialog.RootView) then begin
    FWaitDialog.Message := AMsg;
    FWaitDialog.RootView.MessageView.Text := AMsg;
  end;
end;

initialization

finalization
  FWaitDialog := nil;

end.

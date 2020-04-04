program HangMan001;

uses
  Forms,
  HangMan01 in 'HangMan01.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

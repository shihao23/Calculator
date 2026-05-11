program Project1;

uses
  Vcl.Forms,
  Calculator in 'Calculator.pas' {Form1},
  CalculatorController in 'CalculatorController.pas',
  CalculatorEngine in 'CalculatorEngine.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

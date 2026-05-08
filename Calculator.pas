unit Calculator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes,Vcl.Graphics,
  System.SysUtils, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  CalculatorController;

type
  TForm1 = class(TForm, ICalculatorView)
    btnPct: TButton;
    btnCE: TButton;
    btnC: TButton;
    btnBS: TButton;
    btnFrac: TButton;
    btnSqr: TButton;
    btnSqrt: TButton;
    btnDiv: TButton;
    btn7: TButton;
    btn8: TButton;
    btn9: TButton;
    btnMul: TButton;
    btn4: TButton;
    btn5: TButton;
    btn6: TButton;
    btnSub: TButton;
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    btnAdd: TButton;
    btnPM: TButton;
    btn0: TButton;
    btnPoint: TButton;
    btnEq: TButton;
    txtResult: TEdit;
    GridPanel1: TGridPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Memo1: TMemo;
    procedure btnNumberClick(Sender: TObject);
    procedure btnOperatorClick(Sender: TObject);
    procedure btnEqualClick(Sender: TObject);
    procedure btnCClick(Sender: TObject);
    procedure btnCEClick(Sender: TObject);
    procedure btnBSClick(Sender: TObject);
    procedure btnSqrtClick(Sender: TObject);
    procedure btnSqrClick(Sender: TObject);
    procedure btnFracClick(Sender: TObject);
    procedure btnPMClick(Sender: TObject);
    procedure btnPctClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FController: TCalculatorController;
    { ===== Utility ===== }
    function GetCaption(Sender: TObject): string;

  public
    { Public declarations }
    { ===== Display ===== }
    function GetDisplayValue: Double;
    procedure SetDisplayValue(const AValue: Double);
    { ===== History ===== }
    procedure AppendBinaryHistory(const First, Second: Double; const OpText: string; const Result: Double);
    procedure AppendUnaryHistory(const Op: string; const Num: Double; const Res: Double);

    { ===== Interface Methods ===== }
    procedure UpdateDisplayText(const AText: string);
    function GetDisplayText: string;
    function ShowMathError(const Msg: string): Double;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  FController := TCalculatorController.Create(Self);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FController.Free;
end;

function TForm1.GetDisplayValue: Double;
begin
  Result := StrToFloatDef(txtResult.Text, 0);
end;

procedure TForm1.SetDisplayValue(const AValue: Double);
begin
  txtResult.Text := FloatToStr(AValue);
end;

procedure TForm1.UpdateDisplayText(const AText: string);
begin
  // 真正改動 UI 元件的地方
  txtResult.Text := AText;
end;

function TForm1.GetDisplayText: string;
begin
  Result := txtResult.Text;
end;

function TForm1.GetCaption(Sender: TObject): string;
begin
  Result := (Sender as TButton).Caption;
end;

procedure TForm1.AppendBinaryHistory(const First, Second: Double; const OpText: string; const Result: Double);
begin
  // 輸出格式：1 + 2 = 3
  Memo1.Lines.Add(Format('%g %s %g = %g', [First, OpText, Second, Result]));
end;

procedure TForm1.AppendUnaryHistory(const Op: string; const Num: Double; const Res: Double);
begin
  // 例如：Sqrt(9) = 3
  if Op = '%' then  Memo1.Lines.Add(Format('(%g)%s = %g', [Num, Op, Res]))
  else Memo1.Lines.Add(Format('%s(%g) = %g', [Op, Num, Res]));
end;

procedure TForm1.btnNumberClick(Sender: TObject);
//根據按鈕的Caption輸出對應的值
begin
  FController.PressDigit(GetCaption(Sender));
end;

procedure TForm1.btnOperatorClick(Sender: TObject);
//檢查用戶是用加減乘除的哪個
begin
  FController.PressOperatorClick(GetCaption(Sender), GetDisplayValue)
end;

procedure TForm1.btnEqualClick(Sender: TObject);
begin
  FController.PressEqual(GetDisplayValue);
end;

procedure TForm1.btnCClick(Sender: TObject);
// C 按鈕：全部重置
begin
  FController.PressClearAll;
end;

procedure TForm1.btnCEClick(Sender: TObject);
// CE 按鈕：只清除目前的顯示數值
begin
  FController.PressClearEntry;
end;

procedure TForm1.btnBSClick(Sender: TObject);
//返回的功能
begin
  FController.PressBackspace;
end;

function TForm1.ShowMathError(const Msg: string): Double;
begin
  Application.MessageBox(PChar(Msg), '錯誤提示', MB_OK + MB_ICONERROR);
  Result := 0;
end;

procedure TForm1.btnSqrtClick(Sender: TObject);
begin
  FController.SqrtClick(GetDisplayValue);
end;

procedure TForm1.btnSqrClick(Sender: TObject);
begin
  FController.SqrClick(GetDisplayValue);
end;

procedure TForm1.btnFracClick(Sender: TObject);
begin
  FController.FracClick(GetDisplayValue);
end;

procedure TForm1.btnPctClick(Sender: TObject);
begin
  FController.PctClick(GetDisplayValue);
end;

procedure TForm1.btnPMClick(Sender: TObject);
begin
  FController.PMClick(GetDisplayValue);
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  // 假設視窗寬度大於 600 像素時，就顯示歷史紀錄
  if Self.Width > 600 then begin
    Panel2.Visible := True;
    Memo1.Visible := True;
  end else begin
    Panel2.Visible := False;
    Memo1.Visible := False;
  end;
end;

end.

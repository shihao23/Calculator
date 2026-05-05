unit Calculator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.Math,
  Vcl.Graphics,Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TBinaryOperator = (boNone, boAdd, boSub, boMul, boDiv);
  TForm1 = class(TForm)
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
    procedure ApplyUnary(OpName: string; Func: TFunc<Double, Double>);
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
    procedure UpdateMemo(Num1: Double; Op: string; Num2: Double; Res: Double);
    procedure UpdateMemoUnary(Op: string; Num: Double; Res: Double);
    function GetDisplayValue: Double;
    procedure SetDisplayValue(const AValue: Double);
    function ShowMathError(const Msg: string): Double;
    function OperatorToText(AOp: TBinaryOperator): string;
    procedure SetOperator(AOp: TBinaryOperator);
    procedure ExecutePendingOperation;
    function GetCaption(Sender: TObject): string;
  private
    { Private declarations }
    FOperator: TBinaryOperator;   // 存放運算符號 (+, -, *, /)
    FIsNewNum: Boolean;  // 標記接下來輸入的是否為新數字
    FFirstNum: Double;   // 存放第一個數字
    SecondNum: Double;   // 存放第二個數字
    ResultNum: Double;   // 存放運算好的數字
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnNumberClick(Sender: TObject);
//根據按鈕的Caption輸出對應的值
var
  ClickedText: string;
begin
  ClickedText := GetCaption(Sender);
  if ClickedText = '.' then
  begin
    if FIsNewNum then
    begin
      txtResult.Text := '0.';
      FIsNewNum := False;
      Exit;
    end;
    if Pos('.', txtResult.Text) > 0 then
      Exit;
    txtResult.Text := txtResult.Text + '.';
    Exit;
  end;
  //如果是新數字標記 (FIsNewNum) 或者是目前的文字是 '0'，就覆蓋掉
  if (txtResult.Text = '0') or (FIsNewNum) then begin
    txtResult.Text := ClickedText;
    FIsNewNum := False; // 重置標記，接下來輸入的數字要用串接的
  end else txtResult.Text := txtResult.Text + ClickedText;
end;

function TForm1.OperatorToText(AOp: TBinaryOperator): string;
begin
  case AOp of
    boAdd: Result := '+';
    boSub: Result := '-';
    boMul: Result := '×';
    boDiv: Result := '÷';
  else
    Result := '';
  end;
end;

procedure TForm1.SetOperator(AOp: TBinaryOperator);
begin
 try
   if (FOperator <> boNone) and (not FIsNewNum) then ExecutePendingOperation;
   FFirstNum := GetDisplayValue;
   FOperator := AOp;
   FIsNewNum := True;
 except
    on E: EConvertError do ShowMessage('輸入格式錯誤');
 end;
end;

procedure TForm1.btnOperatorClick(Sender: TObject);
//檢查用戶是用加減乘除的哪個
var
  BtnCaption: string;
begin
  BtnCaption := GetCaption(Sender);
  if BtnCaption = '+' then SetOperator(boAdd)
  else if BtnCaption = '-' then SetOperator(boSub)
  else if (BtnCaption = '×') or (BtnCaption = '*') then SetOperator(boMul)
  else if (BtnCaption = '÷') or (BtnCaption = '/') then SetOperator(boDiv);
end;

procedure TForm1.ExecutePendingOperation;
//加減乘除的運輸
begin
  // 防止沒按過運算符號就按等於
  if FOperator = boNone then Exit;
  SecondNum := GetDisplayValue;
  ResultNum := 0;
  case FOperator of
    boAdd:
      ResultNum := FFirstNum + SecondNum;
    boSub:
      ResultNum := FFirstNum - SecondNum;
    boMul:
      ResultNum := FFirstNum * SecondNum;
    boDiv:
      begin
        if SecondNum = 0 then begin
          ShowMessage('除數不能為 0');
          SetDisplayValue(0);
          FIsNewNum := True;
          Exit;
        end;
        ResultNum := FFirstNum / SecondNum;
      end;
  end;
  UpdateMemo(FFirstNum, OperatorToText(FOperator), SecondNum, ResultNum);
  SetDisplayValue(ResultNum);
  FOperator := boNone;  // 清除運算符號，避免重複按等於造成問題
  FIsNewNum := True;  // 計算完畢，下次輸入視為新開頭
end;

procedure TForm1.btnEqualClick(Sender: TObject);
begin
  ExecutePendingOperation;
end;

procedure TForm1.btnCClick(Sender: TObject);
// C 按鈕：全部重置
begin
  SetDisplayValue(0);
  FFirstNum := 0;
  FOperator := boNone;
  FIsNewNum := False;
end;

procedure TForm1.btnCEClick(Sender: TObject);
// CE 按鈕：只清除目前的顯示數值
begin
  SetDisplayValue(0);
end;

procedure TForm1.btnBSClick(Sender: TObject);
//返回的功能
var
  DisplayText: string;
begin
  DisplayText := txtResult.Text;
  // 如果已經是 '0' 或是空的，就不用刪了
  if (DisplayText = '0') or (DisplayText = '') then Exit;
  // 刪除最後一個字元
  Delete(DisplayText, Length(DisplayText), 1);
  // 如果刪完後變空字串，就補回 '0'
  if DisplayText = '' then DisplayText := '0';
  txtResult.Text := DisplayText;
end;

procedure TForm1.ApplyUnary(OpName: string; Func: TFunc<Double, Double>);
var
  Value, ResultValue: Double;
begin
  try
    Value := GetDisplayValue;
    ResultValue := Func(Value);
    SetDisplayValue(ResultValue);
    UpdateMemoUnary(OpName, Value, ResultValue);
    FIsNewNum := True;
  except
    on E: Exception do ShowMessage(E.Message);
  end;
end;

function TForm1.ShowMathError(const Msg: string): Double;
begin
  Application.MessageBox(PChar(Msg), '錯誤提示', MB_OK + MB_ICONERROR);
  Result := 0;
end;

procedure TForm1.btnSqrtClick(Sender: TObject);
//開根號的運算
begin
  ApplyUnary('Sqrt', function(x: Double): Double begin if x >= 0 then Result := Sqrt(x)

                                                       else Result := ShowMathError('不能對負數開根號');
                                                 end);
end;

procedure TForm1.btnSqrClick(Sender: TObject);
//做平方的運算
begin
  ApplyUnary('Sqr', function(x: Double): Double begin Result := x * x; end);
end;

procedure TForm1.btnFracClick(Sender: TObject);
//做(1/x)的運算
begin
  ApplyUnary('1 /', function(x: Double): Double begin if x <> 0 then Result := 1 / x
                                                      else Result := ShowMathError('分母不能為零');
                                                end);
end;

procedure TForm1.btnPctClick(Sender: TObject);
//做百分百的運算
begin
  ApplyUnary('%', function(x: Double): Double begin Result := x / 100; end);
end;

procedure TForm1.btnPMClick(Sender: TObject);
//做正負值的轉換
var
  Value: Double;
begin
  Value := GetDisplayValue;
  SetDisplayValue(-Value);
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

procedure TForm1.UpdateMemo(Num1: Double; Op: string; Num2: Double; Res: Double);
begin
  // 輸出格式：1 + 2 = 3
  Memo1.Lines.Add(FloatToStr(Num1) + ' ' + Op + ' ' + FloatToStr(Num2) + ' = ' + FloatToStr(Res));
end;

procedure TForm1.UpdateMemoUnary(Op: string; Num: Double; Res: Double);
begin
  // 例如：Sqrt(9) = 3
  if Op = '%' then  Memo1.Lines.Add( '(' + FloatToStr(Num) + ')' + Op + ' = ' + FloatToStr(Res))
  else Memo1.Lines.Add(Op + '(' + FloatToStr(Num) + ') = ' + FloatToStr(Res));
end;

function TForm1.GetDisplayValue: Double;
begin
  Result := StrToFloatDef(txtResult.Text, 0);
end;

procedure TForm1.SetDisplayValue(const AValue: Double);
begin
  txtResult.Text := FloatToStr(AValue);
end;

function TForm1.GetCaption(Sender: TObject): string;
begin
  Result := (Sender as TButton).Caption;
end;

end.

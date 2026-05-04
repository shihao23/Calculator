unit Calculator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
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
  private
    { Private declarations }
    FOperator: string;   // 存放運算符號 (+, -, *, /)
    FIsNewNum: Boolean;  // 標記接下來輸入的是否為新數字
    FFirstNum: Double;   // 存放第一個數字
    SecondNum: Double;   // 存放第二個數字
    ResultNum: Double;   // 存放運算好的數字
    Value: Double;       // 存放運算字符
    FCurrentProcess: string;
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
  ClickedText := (Sender as TButton).Caption;
  // 修正邏輯：如果是新數字標記 (FIsNewNum) 或者是目前的文字是 '0'，就覆蓋掉
  if (txtResult.Text = '0') or (FIsNewNum) then begin
    txtResult.Text := ClickedText;
    FIsNewNum := False; // 重置標記，接下來輸入的數字要用串接的
  end else begin
    txtResult.Text := txtResult.Text + ClickedText;
  end;
end;

procedure TForm1.btnOperatorClick(Sender: TObject);
//檢查用戶是用加減乘除的哪個
begin
  try
    // 如果已有運算子，且現在不是剛按完運算子（表示輸入了新數字），就先算中結
    if (FOperator <> '') and (not FIsNewNum) then btnEqualClick(nil); // 傳 nil 表示這是「連加中結」，不要結束算式
    FFirstNum := StrToFloat(txtResult.Text);
    FOperator := (Sender as TButton).Caption;
    //txtResult.Text := txtResult.Text + ' ' + FOperator;
    FIsNewNum := True; // 設為 True，讓下一次按數字時知道要換新的一行
  except
    on E: EConvertError do ShowMessage('輸入格式錯誤');
  end;
end;

procedure TForm1.btnEqualClick(Sender: TObject);
//加減乘除的運輸
begin
  // 防止沒按過運算符號就按等於
  if FOperator = '' then Exit;
  try
    SecondNum := StrToFloat(txtResult.Text);
  except
    Exit;
  end;
  ResultNum := 0;
  if FOperator = '+' then ResultNum := FFirstNum + SecondNum;
  if FOperator = '-' then ResultNum := FFirstNum - SecondNum;
  if FOperator = '×' then ResultNum := FFirstNum * SecondNum;
  if FOperator = '÷' then
  begin
    if SecondNum <> 0 then ResultNum := FFirstNum / SecondNum
    else begin
      ShowMessage('除數不能為 0');
      txtResult.Text := '0';
      FIsNewNum := True;
      Exit;
    end;
  end;
  UpdateMemo(FFirstNum, FOperator, SecondNum, ResultNum);
  txtResult.Text := FloatToStr(ResultNum);
  FOperator := '';   // 清除運算符號，避免重複按等於造成問題
  FIsNewNum := True; // 計算完畢，下次輸入視為新開頭
end;

procedure TForm1.btnCClick(Sender: TObject);
// C 按鈕：全部重置
begin
  txtResult.Text := '0';
  FFirstNum := 0;
  FOperator := '';
  FIsNewNum := False;
end;

procedure TForm1.btnCEClick(Sender: TObject);
// CE 按鈕：只清除目前的顯示數值
begin
  txtResult.Text := '0';
end;

procedure TForm1.btnBSClick(Sender: TObject);
//返回的功能
var
  S: string;
begin
  S := txtResult.Text;
  // 如果已經是 '0' 或是空的，就不用刪了
  if (S = '0') or (S = '') then Exit;
  // 刪除最後一個字元
  Delete(S, Length(S), 1);
  // 如果刪完後變空字串，就補回 '0'
  if S = '' then S := '0';
  txtResult.Text := S;
end;

procedure TForm1.ApplyUnary(OpName: string; Func: TFunc<Double, Double>);
var
  Value, ResultValue: Double;
begin
  Value := StrToFloat(txtResult.Text);
  ResultValue := Func(Value);
  txtResult.Text := FloatToStr(ResultValue);
  UpdateMemoUnary(OpName, Value, ResultValue);
  FIsNewNum := True;
end;

procedure TForm1.btnSqrtClick(Sender: TObject);
//開根號的運算
begin
  ApplyUnary('Sqr', function(x: Double): Double begin Result := Sqrt(x); end);
end;

procedure TForm1.btnSqrClick(Sender: TObject);
//做平方的運算
begin
  ApplyUnary('Sqr', function(x: Double): Double begin Result := x * x; end);
end;

procedure TForm1.btnFracClick(Sender: TObject);
//做(1/x)的運算
begin
  ApplyUnary('1 /', function(x: Double): Double begin Result := 1 / x; end);
end;

procedure TForm1.btnPctClick(Sender: TObject);
//做百分百的運算
begin
  ApplyUnary('%', function(x: Double): Double begin Result := x / 100; end);
end;

procedure TForm1.btnPMClick(Sender: TObject);
//做正負值的轉換
begin
  Value := StrToFloatDef(txtResult.Text, 0);
  // 如果不是 0，就取負數（0 乘以 -1 還是 0，所以不需要特別判斷 if）
  if Value <> 0 then
  begin
    Value := Value * -1;
    txtResult.Text := FloatToStr(Value);
  end;
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
  if Memo1.Lines.Count = 0 then Memo1.Lines.Add('');
  // 輸出格式：1 + 2 = 3
  Memo1.Lines.Add(FloatToStr(Num1) + ' ' + Op + ' ' + FloatToStr(Num2) + ' = ' + FloatToStr(Res));
end;

procedure TForm1.UpdateMemoUnary(Op: string; Num: Double; Res: Double);
begin
  // 例如：Sqrt(9) = 3
  Memo1.Lines.Add(Op + '(' + FloatToStr(Num) + ') = ' + FloatToStr(Res));
end;

end.

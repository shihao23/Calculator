unit CalculatorController;

interface

uses
  System.SysUtils, CalculatorEngine;

type
   ICalculatorView = interface
    ['{8F7A0D2E-9C4A-4A3B-9D45-1D3A0F3B7C21}']
    procedure SetDisplayValue(const AValue: Double);
    function GetDisplayValue: Double;
    procedure UpdateDisplayText(const AText: string);
    function GetDisplayText: string;
    procedure AppendBinaryHistory(const First, Second: Double; const OpText: string; const Result: Double);
    procedure AppendUnaryHistory(const Op: string; const Num: Double; const Res: Double);
    function ShowMathError(const Msg: string): Double;
  end;
  TCalculatorController = class
  private
    FModel: TCalculatorEngine;
    FView: ICalculatorView;

  public
    constructor Create(const AView: ICalculatorView);
    destructor Destroy; override;
    procedure PressDigit(ClickedDigit: string);
    procedure PressOperatorClick(ClickedText1: string; CurrentValue: Double);
    procedure PressEqual(CurrentValue: Double);
    procedure PressClearAll;
    procedure PressClearEntry;
    procedure PressBackspace;
    procedure Unary(const OpName: string; Func: TFunc<Double, Double>; CurrentValue: Double);
    procedure SqrtClick(CurrentValue: Double);
    procedure SqrClick(CurrentValue: Double);
    procedure FracClick(CurrentValue: Double);
    procedure PctClick(CurrentValue: Double);
    procedure PMClick(CurrentValue: Double);
  end;

implementation

constructor TCalculatorController.Create(const AView: ICalculatorView);
begin
  inherited Create;
  FView := AView;
  FModel := TCalculatorEngine.Create;
end;

destructor TCalculatorController.Destroy;
begin
  FModel.Free;
  inherited;
end;

procedure TCalculatorController.PressDigit(ClickedDigit: string);
//根據按鈕的Caption輸出對應的值
var
  ClickedText: string;
begin
  ClickedText := FView.GetDisplayText;
  if ClickedDigit = '.' then
  begin
    if FModel.IsNewNum then
    begin
      FView.UpdateDisplayText('0.');
      FModel.IsNewNum := False;
      Exit;
    end;
    if Pos('.', ClickedText) > 0 then
      Exit;
    FView.UpdateDisplayText(ClickedText + '.');
    Exit;
  end;
  //如果是新數字標記 (FIsNewNum) 或者是目前的文字是 '0'，就覆蓋掉
  if (ClickedText = '0') or (FModel.IsNewNum) then begin
    FView.UpdateDisplayText(ClickedDigit);
    FModel.IsNewNum := False; // 重置標記，接下來輸入的數字要用串接的
  end else FView.UpdateDisplayText(ClickedText + ClickedDigit);
end;

procedure TCalculatorController.PressOperatorClick(ClickedText1: string; CurrentValue: Double);
//檢查用戶是用加減乘除的哪個
var
  BtnCaption: string;
  Info: TCalcResult;
begin
  try
    BtnCaption := ClickedText1;
    if (FModel.OperatorValue <> boNone) and (not FModel.IsNewNum) then
    begin
      if FModel.ExecutePendingOperation(CurrentValue, Info) then
      begin
        FView.AppendBinaryHistory(Info.FirstNum, Info.SecondNum,FModel.OperatorToText(Info.Op), Info.ResultNum);
        FView.SetDisplayValue(Info.ResultNum);
        CurrentValue := Info.ResultNum;
      end;
    end;
    if BtnCaption = '+' then FModel.SetOperator(CurrentValue, boAdd)
    else if BtnCaption = '-' then FModel.SetOperator(CurrentValue, boSub)
    else if (BtnCaption = '×') or (BtnCaption = '*') then FModel.SetOperator(CurrentValue, boMul)
    else if (BtnCaption = '÷') or (BtnCaption = '/') then FModel.SetOperator(CurrentValue, boDiv);
  except
    on E: Exception do
       FView.ShowMathError('輸入格式錯誤');
  end;
end;

procedure TCalculatorController.PressEqual(CurrentValue: Double);
var
  Info: TCalcResult;
begin
  try
    if FModel.ExecutePendingOperation(CurrentValue, Info) then
    begin
      FView.AppendBinaryHistory(Info.FirstNum, Info.SecondNum,FModel.OperatorToText(Info.Op), Info.ResultNum);
      FView.SetDisplayValue(Info.ResultNum);
    end;
  except
    on E: Exception do
       raise Exception.Create(E.Message);
  end;
end;

procedure TCalculatorController.PressClearAll;
begin
  FView.SetDisplayValue(0);
  FModel.Clear;
end;

procedure TCalculatorController.PressClearEntry;
begin
  FView.SetDisplayValue(0);
end;

procedure TCalculatorController.PressBackspace;
//返回的功能
var
  DisplayText: string;
begin
  DisplayText := FView.GetDisplayText;
  // 如果已經是 '0' 或是空的，就不用刪了
  if (DisplayText = '0') or (DisplayText = '') then Exit;
  // 刪除最後一個字元
  Delete(DisplayText, Length(DisplayText), 1);
  // 如果刪完後變空字串，就補回 '0'
  if DisplayText = '' then DisplayText := '0';
  FView.UpdateDisplayText(DisplayText);
end;

procedure TCalculatorController.Unary(const OpName: string; Func: TFunc<Double, Double>; CurrentValue: Double);
var
  Value, ResultValue: Double;
begin
  try
    Value := CurrentValue;
    ResultValue := Func(Value);
    FView.SetDisplayValue(ResultValue);
    FView.AppendUnaryHistory(OpName, Value, ResultValue);
    FModel.IsNewNum := True;
  except
    on E: Exception do raise Exception.Create(E.Message);
  end;
end;

procedure TCalculatorController.SqrtClick(CurrentValue: Double);
//開根號的運算
begin
  Unary('Sqrt',FModel.UnarySqrt, CurrentValue);
end;

procedure TCalculatorController.SqrClick(CurrentValue: Double);
//做平方的運算
begin
  Unary('Sqr', FModel.UnarySqr, CurrentValue);
end;

procedure TCalculatorController.FracClick(CurrentValue: Double);
//做(1/x)的運算
begin
  Unary('1 /', FModel.UnaryReciprocal, CurrentValue);
end;

procedure TCalculatorController.PctClick(CurrentValue: Double);
//做百分百的運算
begin
  Unary('%', FModel.UnaryPercent, CurrentValue);
end;

procedure TCalculatorController.PMClick(CurrentValue: Double);
//做正負值的轉換
var
  Value: Double;
begin
  Value := CurrentValue;
  FView.SetDisplayValue(-Value);
end;
end.

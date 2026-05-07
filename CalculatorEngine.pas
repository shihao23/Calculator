unit CalculatorEngine;

interface

uses
  System.SysUtils, System.Math;

type
  TBinaryOperator = (boNone, boAdd, boSub, boMul, boDiv);
  TCalcResult = record
    FirstNum: Double;
    SecondNum: Double;
    Op: TBinaryOperator;
    ResultNum: Double;
  end;

  TCalculatorEngine = class
  private
    FFirstNum: Double;
    FOperator: TBinaryOperator;
    FIsNewNum: Boolean;
  public
    constructor Create;
    procedure Clear;

    function OperatorToText(AOp: TBinaryOperator): string;
    procedure SetOperator(const CurrentValue: Double; AOp: TBinaryOperator);
    function ExecutePendingOperation(const CurrentValue: Double; out Info: TCalcResult): Boolean;
    property IsNewNum: Boolean read FIsNewNum write FIsNewNum;
    property OperatorValue: TBinaryOperator read FOperator;
    function UnarySqrt(x: Double): Double;
    function UnarySqr(x: Double): Double;
    function UnaryReciprocal(x: Double): Double;
    function UnaryPercent(x: Double): Double;

  end;

implementation

constructor TCalculatorEngine.Create;
begin
  Clear;
end;

procedure TCalculatorEngine.Clear;
begin
  FFirstNum := 0;
  FOperator := boNone;
end;

function TCalculatorEngine.OperatorToText(AOp: TBinaryOperator): string;
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

procedure TCalculatorEngine.SetOperator(const CurrentValue: Double; AOp: TBinaryOperator);
var
  Info: TCalcResult;
begin
    FFirstNum := CurrentValue;
    FOperator := AOp;
    FIsNewNum := True;
end;

function TCalculatorEngine.ExecutePendingOperation(const CurrentValue: Double; out Info: TCalcResult): Boolean;
//加減乘除的運輸
begin
// 防止沒按過運算符號就按等於
  Result := FOperator <> boNone;
  if not Result then
    Exit;

  Info.FirstNum := FFirstNum;
  Info.SecondNum := CurrentValue;
  Info.Op := FOperator;

  case FOperator of
    boAdd: Info.ResultNum := Info.FirstNum + Info.SecondNum;
    boSub: Info.ResultNum := Info.FirstNum - Info.SecondNum;
    boMul: Info.ResultNum := Info.FirstNum * Info.SecondNum;
    boDiv:
      begin
        if Info.SecondNum = 0 then
          raise Exception.Create('除數不能為 0');
        Info.ResultNum := Info.FirstNum / Info.SecondNum;
      end;
  end;

  FFirstNum := Info.ResultNum;
  FOperator := boNone; // 清除運算符號，避免重複按等於造成問題
  FIsNewNum := True;   // 計算完畢，下次輸入視為新開頭
end;

function TCalculatorEngine.UnarySqrt(x: Double): Double;
begin
  if x < 0 then
    raise Exception.Create('不能對負數開根號');

  Result := Sqrt(x);
end;

function TCalculatorEngine.UnarySqr(x: Double): Double;
begin
  Result := x * x;
end;

function TCalculatorEngine.UnaryReciprocal(x: Double): Double;
begin
  if x = 0 then raise Exception.Create('分母不能為零');
  Result := 1 / x;
end;

function TCalculatorEngine.UnaryPercent(x: Double): Double;
begin
  Result := x / 100;
end;
end.

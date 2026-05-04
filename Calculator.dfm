object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 807
  ClientWidth = 534
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnResize = FormResize
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 284
    Height = 807
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 0
    object GridPanel1: TGridPanel
      Left = 0
      Top = 94
      Width = 284
      Height = 713
      Align = alClient
      Caption = 'GridPanel1'
      ColumnCollection = <
        item
          Value = 25.000625015625400000
        end
        item
          Value = 25.000625015625400000
        end
        item
          Value = 25.000625015625400000
        end
        item
          Value = 24.998124953123800000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = btnPct
          Row = 0
        end
        item
          Column = 1
          Control = btnCE
          Row = 0
        end
        item
          Column = 2
          Control = btnC
          Row = 0
        end
        item
          Column = 3
          Control = btnBS
          Row = 0
        end
        item
          Column = 0
          Control = btnFrac
          Row = 1
        end
        item
          Column = 1
          Control = btnSqr
          Row = 1
        end
        item
          Column = 2
          Control = btnSqrt
          Row = 1
        end
        item
          Column = 3
          Control = btnDiv
          Row = 1
        end
        item
          Column = 0
          Control = btn7
          Row = 2
        end
        item
          Column = 1
          Control = btn8
          Row = 2
        end
        item
          Column = 2
          Control = btn9
          Row = 2
        end
        item
          Column = 3
          Control = btnMul
          Row = 2
        end
        item
          Column = 0
          Control = btn4
          Row = 3
        end
        item
          Column = 1
          Control = btn5
          Row = 3
        end
        item
          Column = 2
          Control = btn6
          Row = 3
        end
        item
          Column = 3
          Control = btnSub
          Row = 3
        end
        item
          Column = 0
          Control = btn1
          Row = 4
        end
        item
          Column = 1
          Control = btn2
          Row = 4
        end
        item
          Column = 2
          Control = btn3
          Row = 4
        end
        item
          Column = 3
          Control = btnAdd
          Row = 4
        end
        item
          Column = 0
          Control = btnPM
          Row = 5
        end
        item
          Column = 1
          Control = btn0
          Row = 5
        end
        item
          Column = 2
          Control = btnPoint
          Row = 5
        end
        item
          Column = 3
          Control = btnEq
          Row = 5
        end>
      RowCollection = <
        item
          Value = 16.667083343750260000
        end
        item
          Value = 16.667083343750260000
        end
        item
          Value = 16.667083343750260000
        end
        item
          Value = 16.665416635415880000
        end
        item
          Value = 16.666666666666660000
        end
        item
          Value = 16.666666666666680000
        end
        item
          SizeStyle = ssAuto
        end>
      ShowCaption = False
      TabOrder = 0
      ExplicitTop = 121
      ExplicitHeight = 686
      object btnPct: TButton
        Left = 1
        Top = 1
        Width = 71
        Height = 119
        Align = alClient
        Caption = '%'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -37
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = btnPctClick
        ExplicitHeight = 114
      end
      object btnCE: TButton
        Left = 72
        Top = 1
        Width = 70
        Height = 119
        Align = alClient
        Caption = 'CE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -37
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = btnCEClick
        ExplicitHeight = 114
      end
      object btnC: TButton
        Left = 142
        Top = 1
        Width = 71
        Height = 119
        Align = alClient
        Caption = 'C'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -37
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = btnCClick
        ExplicitHeight = 114
      end
      object btnBS: TButton
        Left = 213
        Top = 1
        Width = 70
        Height = 119
        Align = alClient
        Caption = #61653
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clBlack
        Font.Height = -37
        Font.Name = 'Wingdings'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        OnClick = btnBSClick
        ExplicitHeight = 114
      end
      object btnFrac: TButton
        Left = 1
        Top = 120
        Width = 71
        Height = 118
        Align = alClient
        Caption = '1'#8260'x'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -37
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        OnClick = btnFracClick
        ExplicitTop = 115
        ExplicitHeight = 114
      end
      object btnSqr: TButton
        Left = 72
        Top = 120
        Width = 70
        Height = 118
        Align = alClient
        Caption = 'x^2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -37
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
        OnClick = btnSqrClick
        ExplicitTop = 115
        ExplicitHeight = 114
      end
      object btnSqrt: TButton
        Left = 142
        Top = 120
        Width = 71
        Height = 118
        Align = alClient
        Caption = #8730'(2&x)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -37
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 6
        OnClick = btnSqrtClick
        ExplicitTop = 115
        ExplicitHeight = 114
      end
      object btnDiv: TButton
        Left = 213
        Top = 120
        Width = 70
        Height = 118
        Align = alClient
        Caption = #247
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -37
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 7
        OnClick = btnOperatorClick
        ExplicitTop = 115
        ExplicitHeight = 114
      end
      object btn7: TButton
        Left = 1
        Top = 238
        Width = 71
        Height = 119
        Align = alClient
        Caption = '7'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -37
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 8
        OnClick = btnNumberClick
        ExplicitTop = 229
        ExplicitHeight = 114
      end
      object btn8: TButton
        Left = 72
        Top = 238
        Width = 70
        Height = 119
        Align = alClient
        Caption = '8'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -37
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 9
        OnClick = btnNumberClick
        ExplicitTop = 229
        ExplicitHeight = 114
      end
      object btn9: TButton
        Left = 142
        Top = 238
        Width = 71
        Height = 119
        Align = alClient
        Caption = '9'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -37
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 10
        OnClick = btnNumberClick
        ExplicitTop = 229
        ExplicitHeight = 114
      end
      object btnMul: TButton
        Left = 213
        Top = 238
        Width = 70
        Height = 119
        Align = alClient
        Caption = #215
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -37
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 11
        OnClick = btnOperatorClick
        ExplicitTop = 229
        ExplicitHeight = 114
      end
      object btn4: TButton
        Left = 1
        Top = 357
        Width = 71
        Height = 118
        Align = alClient
        Caption = '4'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -37
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 12
        OnClick = btnNumberClick
        ExplicitTop = 343
        ExplicitHeight = 114
      end
      object btn5: TButton
        Left = 72
        Top = 357
        Width = 70
        Height = 118
        Align = alClient
        Caption = '5'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -37
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 13
        OnClick = btnNumberClick
        ExplicitTop = 343
        ExplicitHeight = 114
      end
      object btn6: TButton
        Left = 142
        Top = 357
        Width = 71
        Height = 118
        Align = alClient
        Caption = '6'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -37
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 14
        OnClick = btnNumberClick
        ExplicitTop = 343
        ExplicitHeight = 114
      end
      object btnSub: TButton
        Left = 213
        Top = 357
        Width = 70
        Height = 118
        Align = alClient
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -37
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 15
        OnClick = btnOperatorClick
        ExplicitTop = 343
        ExplicitHeight = 114
      end
      object btn1: TButton
        Left = 1
        Top = 475
        Width = 71
        Height = 118
        Align = alClient
        Caption = '1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -37
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 16
        OnClick = btnNumberClick
        ExplicitTop = 457
        ExplicitHeight = 114
      end
      object btn2: TButton
        Left = 72
        Top = 475
        Width = 70
        Height = 118
        Align = alClient
        Caption = '2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -37
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 17
        OnClick = btnNumberClick
        ExplicitTop = 457
        ExplicitHeight = 114
      end
      object btn3: TButton
        Left = 142
        Top = 475
        Width = 71
        Height = 118
        Align = alClient
        Caption = '3'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -37
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 18
        OnClick = btnNumberClick
        ExplicitTop = 457
        ExplicitHeight = 114
      end
      object btnAdd: TButton
        Left = 213
        Top = 475
        Width = 70
        Height = 118
        Align = alClient
        Caption = '+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -37
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 19
        OnClick = btnOperatorClick
        ExplicitTop = 457
        ExplicitHeight = 114
      end
      object btnPM: TButton
        Left = 1
        Top = 593
        Width = 71
        Height = 119
        Align = alClient
        Caption = #177
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -37
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 20
        OnClick = btnPMClick
        ExplicitTop = 571
        ExplicitHeight = 114
      end
      object btn0: TButton
        Left = 72
        Top = 593
        Width = 70
        Height = 119
        Align = alClient
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -37
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 21
        OnClick = btnNumberClick
        ExplicitTop = 571
        ExplicitHeight = 114
      end
      object btnPoint: TButton
        Left = 142
        Top = 593
        Width = 71
        Height = 119
        Align = alClient
        Caption = '.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -37
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 22
        OnClick = btnNumberClick
        ExplicitTop = 571
        ExplicitHeight = 114
      end
      object btnEq: TButton
        Left = 213
        Top = 593
        Width = 70
        Height = 119
        Align = alClient
        Caption = '='
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -37
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 23
        OnClick = btnEqualClick
        ExplicitTop = 571
        ExplicitHeight = 114
      end
    end
    object txtResult: TEdit
      Left = 0
      Top = 0
      Width = 284
      Height = 94
      Align = alTop
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -64
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ImeName = 'txtResult'
      ParentFont = False
      TabOrder = 1
      Text = '0'
    end
  end
  object Panel2: TPanel
    Left = 284
    Top = 0
    Width = 250
    Height = 807
    Align = alRight
    Caption = 'Panel2'
    TabOrder = 1
    Visible = False
    object Memo1: TMemo
      Left = 1
      Top = 1
      Width = 248
      Height = 805
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = #24494#36575#27491#40657#39636
      Font.Style = [fsBold]
      Lines.Strings = (
        #27511#31243#35352#37636)
      ParentFont = False
      TabOrder = 0
    end
  end
end

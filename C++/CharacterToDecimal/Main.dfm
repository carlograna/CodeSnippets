object MainForm: TMainForm
  Left = 619
  Top = 481
  BorderStyle = bsDialog
  Caption = 'CharacterConverter'
  ClientHeight = 283
  ClientWidth = 416
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 40
    Width = 77
    Height = 13
    Caption = 'Enter Character:'
  end
  object Label2: TLabel
    Left = 24
    Top = 88
    Width = 71
    Height = 13
    Caption = 'Decimal Value:'
  end
  object decLbl: TLabel
    Left = 112
    Top = 96
    Width = 3
    Height = 13
  end
  object Label3: TLabel
    Left = 24
    Top = 136
    Width = 69
    Height = 13
    Caption = 'Enter Decimal:'
  end
  object label4: TLabel
    Left = 24
    Top = 184
    Width = 76
    Height = 13
    Caption = 'Character Value'
  end
  object charLbl: TLabel
    Left = 112
    Top = 184
    Width = 3
    Height = 13
  end
  object charEdit: TEdit
    Left = 112
    Top = 40
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object charBtn: TButton
    Left = 272
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Convert'
    TabOrder = 1
    OnClick = charBtnClick
  end
  object closeBtn: TButton
    Left = 272
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 2
    OnClick = closeBtnClick
  end
  object decEdit: TEdit
    Left = 112
    Top = 128
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object decBtn: TButton
    Left = 272
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Convert'
    TabOrder = 4
    OnClick = decBtnClick
  end
end

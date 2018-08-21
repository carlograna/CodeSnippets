//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Main.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TMainForm *MainForm;
//---------------------------------------------------------------------------
__fastcall TMainForm::TMainForm(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TMainForm::charBtnClick(TObject *Sender)
{
     if(charEdit->Text.Length() != 1)
        ShowMessage("Please enter one character");
     else
     {
        char cValue = charEdit->Text[1];
        int iValue = (int)cValue;
        decLbl->Caption = IntToStr(iValue);
     }
}
//---------------------------------------------------------------------------
void __fastcall TMainForm::closeBtnClick(TObject *Sender)
{
        Close();
}
//---------------------------------------------------------------------------
void __fastcall TMainForm::decBtnClick(TObject *Sender)
{
        if(decEdit->Text.IsEmpty() || StrToIntDef(decEdit->Text, -1) == -1)
                ShowMessage("Not a decimal");
        else
        {
        int iValue = StrToInt(decEdit->Text);
        charLbl->Caption = AnsiString((char)iValue);
        }
}

//---------------------------------------------------------------------------

//---------------------------------------------------------------------------

#ifndef MainH
#define MainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
//---------------------------------------------------------------------------
class TMainForm : public TForm
{
__published:	// IDE-managed Components
        TLabel *Label1;
        TEdit *charEdit;
        TLabel *Label2;
        TLabel *decLbl;
        TButton *charBtn;
        TButton *closeBtn;
        TLabel *Label3;
        TEdit *decEdit;
        TButton *decBtn;
        TLabel *label4;
        TLabel *charLbl;
        void __fastcall charBtnClick(TObject *Sender);
        void __fastcall closeBtnClick(TObject *Sender);
        void __fastcall decBtnClick(TObject *Sender);
private:	// User declarations
public:		// User declarations
        __fastcall TMainForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TMainForm *MainForm;
//---------------------------------------------------------------------------
#endif

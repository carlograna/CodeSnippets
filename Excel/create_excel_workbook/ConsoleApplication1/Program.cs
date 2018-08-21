using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Excel = Microsoft.Office.Interop.Excel;

namespace ConsoleApplication1
{
    class Program
    {
        static void Main(string[] args)
        {
            CreateExcelDoc excell_app = new CreateExcelDoc();
            //creates the main header
            excell_app.createHeaders(5, 2, "Total of Products", "B5", "D5", 2, "YELLOW", true, 10, "n");
            //creates subheaders
            excell_app.createHeaders(6, 2, "Sold Product", "B6", "B6", 0, "GRAY", true, 10, "");
            excell_app.createHeaders(6, 3, "", "C6", "C6", 0, "GRAY", true, 10, "");
            excell_app.createHeaders(6, 4, "Initial Total", "D6", "D6", 0, "GRAY", true, 10, "");
            //add Data to cells
            excell_app.addData(7, 2, "114287", "B7", "B7", "#,##0");
            excell_app.addData(7, 3, "", "C7", "C7", "");
            excell_app.addData(7, 4, "129121", "D7", "D7", "#,##0");
            //add percentage row
            excell_app.addData(8, 2, "", "B8", "B8", "");
            excell_app.addData(8, 3, "=B7/D7", "C8", "C8", "0.0%");
            excell_app.addData(8, 4, "", "D8", "D8", "");
            //add empty divider
            excell_app.createHeaders(9, 2, "", "B9", "D9", 2, "GAINSBORO", true, 10, "");
            excell_app.addData(20, 1, "This is carlo", "a20", "d20", "");

            excell_app.SaveAndExit(@"C:\temp\test.xls");          
        }
    }
}

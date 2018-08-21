using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.IO;

namespace FileUploadProject
{
    public partial class _Default : System.Web.UI.Page
    {
        //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack == true)
            {
                ErrLbl.ForeColor = System.Drawing.ColorTranslator.FromHtml("#FF0000");
                ErrLbl.Text = "";
            }

        }
        //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        protected void SingleFileUploadButton_Click(object sender, EventArgs e)
        {            
            ProcessUpload(SingleFileUpload);
            //UploadsView.DataBind();
        }
        //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        protected void ProcessUpload(FileUpload SingleFileUpload)
        {
            if (SingleFileUpload.HasFile)
            {
                //Valid File extensions.  You can add more extension here and it won't break.
                string[] validFileExt_array = new string[] {".hde", ".csv",".txt"};
                string fileExt = System.IO.Path.GetExtension(SingleFileUpload.FileName);
                string fileType = SingleFileUpload.PostedFile.ContentType; 


                for (int i = 0; i < validFileExt_array.Length; i++)
                {
                    if (fileExt == validFileExt_array[i])
                    {
                        UploadFile(SingleFileUpload);
                        break;
                    }
                    else if (i == (validFileExt_array.Length -1))
                    {
                        //this is the last loop. Incoming file  type not allowed.
                        InvalidFileType();
                    }                   
                }
            }
            else
            {                
                ErrLbl.Text = "Wrong file or No file specified to upload";                 
            }   
        }
        //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        protected void UploadFile(FileUpload SingleFileUpload)
        {
            //if (fileExt == ".hde" && fileType == "application/x-zip-compressed")
            //{
                    try
                    {
                        //string fileName = Path.Combine(Server.MapPath("~/Uploads"), SingleFileUpload.FileName);

                        DateTime currentDate = System.DateTime.Now;
                        string year = currentDate.Year.ToString();
                        string month = currentDate.Month.ToString();
                        string day = currentDate.Day.ToString();
                        string hour = currentDate.Hour.ToString();
                        string minute = currentDate.Minute.ToString();
                        string second = currentDate.Second.ToString();


                        string fileName = year + month + day + hour + minute + second + "-" + SingleFileUpload.FileName;
                        fileName = Path.Combine(Server.MapPath("~/Uploads"), fileName);
                        //fileName += System.DateTime.Now;


                        if (File.Exists(fileName))
                            File.Delete(fileName);
                        SingleFileUpload.SaveAs(fileName);

                        ErrLbl.Text = "File uploaded Successfully <br> " + 
                                      "File name: "    + SingleFileUpload.PostedFile.FileName      + "<br>"       +
                                      "File size: "    + SingleFileUpload.PostedFile.ContentLength + " bytes<br>" +
                                      "Content type: " + SingleFileUpload.PostedFile.ContentType;
                    }
                    catch (Exception ex)
                    {
                        ErrLbl.Text = "ERROR: " + ex.Message.ToString();
                    }
                //}
            //else
            //{


            //}
        }
        protected void InvalidFileType()
        {
            ErrLbl.Text = "File type not allowed <br/> " +
                          "File name: " + SingleFileUpload.PostedFile.FileName + "<br>" +
                          "File size: " + SingleFileUpload.PostedFile.ContentLength + " bytes<br>" +
                          "Content type: " + SingleFileUpload.PostedFile.ContentType;
        }
    }
}

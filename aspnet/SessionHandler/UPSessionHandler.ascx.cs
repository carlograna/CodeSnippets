using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class controls_UPSessionHandler : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void Page_Init(object sender, EventArgs e)
    {
        if ((Session["id"] == null) || (String.IsNullOrEmpty(Session["id"].ToString())))
        {
            Response.Redirect("/up/holder-reporting");//TODO redirecting to online1 just for test enviorement
        }
    }

    //protected void EndSessionLnkBtn_Click(object sender, EventArgs e)
    //{
    //    Session.Abandon();
    //    Response.Redirect("/up/holder-reporting/");
    //}
}
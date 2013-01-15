using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace BusReservation
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["is_loggedin"] != null && Session["is_loggedin"].ToString() == "1")
            {
                if (Session["user_level"].ToString() == "3")
                {
                    Response.Redirect("~/admin");
                }
                LoginLink.Visible = false;
                UserNameLabel.Text = Session["user_name"].ToString();
            }
            else
            {
                SalesLink.Visible = false;
                LogoutLink.Visible = false;
                UserNameDiv.Visible = false;
            }
        }

    }
}

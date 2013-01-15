using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BusReservation.admin
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["is_loggedin"] == null)
            {
                Response.Redirect("~/login.aspx?redirect_url=admin.aspx");
            }
            if (Session["user_level"] != null && Session["user_level"].ToString() == "1")
            {
                Response.Redirect("~/default.aspx");
            }
        }
    }
}
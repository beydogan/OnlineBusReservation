using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
namespace BusReservation
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["user_name"] = null;
            Session["is_loggedin"] = null;
            Session["user_id"] = null;
            Response.Redirect("~/default.aspx");
        }

       
    }
}
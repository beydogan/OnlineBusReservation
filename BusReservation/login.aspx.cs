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
//
using System.Data.SqlClient;

namespace BusReservation
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Title = "Login - " + ConfigurationSettings.AppSettings["siteName"].ToString();
            errorPanel.Visible = false;
            if (Session["error_msg"] != null)
            {
                LiteralControl objPanelText = errorPanel.Controls[0] as LiteralControl;
                errorPanel.Visible = true;
                objPanelText.Text = "<strong>Warning: </strong>" + Session["error_msg"].ToString();
                Session["error_msg"] = null;
            }
        }

        protected void Login_Click(object sender, EventArgs e)
        {
            Response.Redirect("User.aspx");
        }

        protected void Login_Authenticate(object sender, AuthenticateEventArgs e)
        {
            string connectionString;
            connectionString = ConfigurationManager.ConnectionStrings["conStr"].ToString();

            SqlConnection con = new SqlConnection(connectionString);

            try
            {
                con.Open();
            }
            catch (Exception)
            {
                con.Close();
                return;
                throw;
            }

            DataSet ds = new DataSet();
            string sqlstr;
            sqlstr = "select * from Users WHERE password = '" + Login_Form.Password +
                "' AND username='" + Login_Form.UserName + "'";
            SqlDataAdapter da = new SqlDataAdapter(sqlstr, connectionString);
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count == 1)
            {
                string user_level;
                user_level = ds.Tables[0].Rows[0]["user_level"].ToString();

                Session["user_name"] = ds.Tables[0].Rows[0]["username"].ToString();
                Session["user_id"] = ds.Tables[0].Rows[0]["user_id"].ToString();
                Session["user_level"] = user_level;
                Session["is_loggedin"] = "1";

                if (Session["do_search"] != null && Session["do_search"].ToString() == "1")
                {
                    Response.Redirect("results.aspx");
                }

                if (user_level == "3")
                {
                    Response.Redirect("~/admin/default.aspx");
                }
                else
                {
                    Response.Redirect("~/default.aspx");
                }
            }

        }
    }
}
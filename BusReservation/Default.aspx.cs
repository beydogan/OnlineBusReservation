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
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            errorPanel.Visible = false;
            if (Session["error_msg"] != null)
            {
                LiteralControl objPanelText = errorPanel.Controls[0] as LiteralControl;
                errorPanel.Visible = true;
                objPanelText.Text = "<strong>Warning: </strong>" + Session["error_msg"].ToString();
                Session["error_msg"] = null;
            }
        }
        
        protected void SearchButton_Click(object sender, EventArgs e)
        {
            Session["do_search"] = "1";
            Session["search_from_city"] = ddlFromCity.SelectedValue;
            Session["search_to_city"] = ddlToCity.SelectedValue;
            Session["search_date"] = departureDate.Text;
            Response.Redirect("results.aspx");
        }

    }
}

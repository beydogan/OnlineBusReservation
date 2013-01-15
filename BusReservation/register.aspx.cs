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
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Title = "Login - " + ConfigurationSettings.AppSettings["siteName"].ToString();
        }

        protected void Register_Click(object sender, EventArgs e)
        {

            if (password.Text != password_confirm.Text)
            {
                note.InnerHtml = "Passwords dont match!";
            }
            else
            {

                //TODO kullanıcı adı,email  yunik olmalı, form hata kontrolü
                note.InnerHtml = "";

                string connectionString;
                connectionString = ConfigurationManager.ConnectionStrings["conStr"].ToString();

                SqlConnection con = new SqlConnection(connectionString);
                SqlCommand cmd = new SqlCommand("INSERT INTO Users(username,password,email,user_level) values('" + username.Text + "','" + password.Text + "','" + email.Text + "','1')", con);
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

                if (cmd.ExecuteNonQuery() == 1)
                {
                    con.Close();
                    Response.Redirect("Login.aspx");
                }
                else
                {
                    note.InnerHtml = "Çok fena";
                }

            } 

        }
    }
}
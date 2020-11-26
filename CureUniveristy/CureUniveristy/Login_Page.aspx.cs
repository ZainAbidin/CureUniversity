using BLL;
using System;
using System.Web.Services;

namespace CureUniveristy
{
    public partial class Login_Page : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        { 
        }

        [WebMethod(EnableSession = true)]
        public static int CheckCredentials(string email, string password)
        {
            return (new Bll()).LogIn(email, password);
        }

        protected void LoginButton_Click(object sender, EventArgs e)
        {
            Bll obj = new Bll();
            if (obj.LogIn(inputEmail.Value, inputPassword.Value) == 0)
            {
                Session["value"] = 0;
                Response.Redirect("Student_Page.aspx?email=" + inputEmail.Value);
            }
            else if (obj.LogIn(inputEmail.Value, inputPassword.Value) == 1)
            {
                Session["value"] = 1;
                Response.Redirect("Teacher_Page.aspx?email="+ inputEmail.Value);
            }
            else if (obj.LogIn(inputEmail.Value, inputPassword.Value) == 2)
            {
                Session["value"] = 2;
                Response.Redirect("Admin_Page.aspx?email=" + inputEmail.Value);
            }
            else
            {
                Display.Text = "Wrong Credentials";
            }
        }
    }

}
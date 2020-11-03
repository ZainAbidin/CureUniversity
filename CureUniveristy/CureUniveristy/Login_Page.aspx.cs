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
    }
   
}
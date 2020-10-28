using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;

namespace CureUniveristy
{
    public partial class Login_Page : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static int CheckCredentials(string email, string password)
        {
            Bll BllObj = new Bll();
            return BllObj.LogIn(email, password);
        }
    }
   
}
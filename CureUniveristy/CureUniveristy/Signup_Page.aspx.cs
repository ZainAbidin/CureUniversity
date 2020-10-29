using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;

namespace CureUniveristy
{
    public partial class Signup_Page : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static int Signup(string email, string address, string firstName, string lastName, string password, int schoolId, string contactNumber, string userName)
        {
            Bll BllObj = new Bll();
            return BllObj.SignUp(email, address, firstName, lastName, password, schoolId, contactNumber, userName);
        }
    }
}
using BLL;
using System;

namespace CureUniveristy
{
    public partial class Signup_Page : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static bool Signup(string email, string address, string firstName, string lastName, string password, int schoolId, string contactNumber, string userName)
        {
            return new Bll().SignUp(email, address, firstName, lastName, password, schoolId, contactNumber, userName);
        }
    }
}
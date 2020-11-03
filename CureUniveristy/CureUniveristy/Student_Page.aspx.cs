using BLL;
using Classes;
using System;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace CureUniveristy
{
    public partial class Student_Page : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod(EnableSession = true)]

        public static string GetStudents(string email)
        {
            Students students = new Students();
            JavaScriptSerializer js = new JavaScriptSerializer();
            return js.Serialize((new Bll()).ViewStudents(email));
        }
    }
}
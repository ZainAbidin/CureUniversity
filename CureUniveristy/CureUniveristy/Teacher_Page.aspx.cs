using BLL;
using Classes;
using System;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace CureUniveristy
{
    public partial class Teacher_Page : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod(EnableSession = true)]
        public static string GetTeacherByID(string email)
        {
            JavaScriptSerializer js = new JavaScriptSerializer();
            return js.Serialize((new Bll()).GetTeacherByID(email));
        }

        [WebMethod(EnableSession = true)]
        public static bool UpdateStudentProfile(string reference, string email, string address, string firstName, string lastName, string contactNumber, string userName)
        {
            return (new Bll()).UpdateStudentProfile(reference, email, address, firstName, lastName, contactNumber, userName);
        }

        [WebMethod(EnableSession = true)]
        public static void EditCourse(string course, string courseName, string creditHours)
        {
            new Bll().EditCourse(course, courseName, Int32.Parse(creditHours));
        }
    }
}
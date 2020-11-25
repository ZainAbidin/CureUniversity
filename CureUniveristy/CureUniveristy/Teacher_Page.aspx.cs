using BLL;
using Classes;
using System;
using System.Web.Script.Serialization;
using System.Web.Services;
using Newtonsoft.Json;

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

        [WebMethod(EnableSession = true)]
        public static string ShowAssignments(string email, string course)
        {
            JavaScriptSerializer js = new JavaScriptSerializer();
            return js.Serialize((new Bll().ShowAssignments(email, course)));
        }

        [WebMethod(EnableSession = true)]
        public static void UploadAssignmentScore(string email, string course, string score)
        {
            new Bll().UploadAssignmentScore(email, course, Int32.Parse(score));
        }

        [WebMethod(EnableSession = true)]
        public static string ViewRegisteredStudentstoTeacher(string email)
        {
            JavaScriptSerializer js = new JavaScriptSerializer();
            return js.Serialize((new Bll()).ViewRegisteredStudentstoTeacher(email));
        }

        [WebMethod(EnableSession = true)]
        public static void sendMessage(string reference, string email, string message)
        {
            new Bll().sendMessage(reference, email, message);
        }

        [WebMethod(EnableSession = true)]
        public static void TeacherBlockStudent(string teacher, string student)
        {
            new Bll().TeacherBlockStudent(teacher, student);
        }
    }
}
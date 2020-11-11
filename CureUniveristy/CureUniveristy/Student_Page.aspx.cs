using BLL;
using System;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI.WebControls;

namespace CureUniveristy
{
    public partial class Student_Page : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod(EnableSession = true)]
        public static string GetStudentByID(string email)
        {
            JavaScriptSerializer js = new JavaScriptSerializer();
            return js.Serialize((new Bll()).GetStudentByID(email));
        }

        [WebMethod(EnableSession = true)]
        public static bool UpdateStudentProfile(string reference, string email, string address, string firstName, string lastName, string contactNumber, string userName)
        {
            return (new Bll()).UpdateStudentProfile(reference, email, address, firstName, lastName, contactNumber, userName);
        }


        //[WebMethod(EnableSession = true)]
        //public void PopulateCourseDropDownListForStudent(DropDownList ItemsDropDownList)
        //{
        //    new Bll().PopulateCourseDropDownListForStudent(ItemsDropDownList);  
        //}

        [WebMethod(EnableSession = true)]
        public static string DisplayCourses()
        {
            JavaScriptSerializer js = new JavaScriptSerializer();
            return js.Serialize((new Bll()).DisplayCourses()); 
        }

        [WebMethod(EnableSession = true)]
        public static bool StudentRegisterCourse(string email, string course)
        {
            return (new Bll()).StudentRegisterCourse(email, course);
        }
    }
}
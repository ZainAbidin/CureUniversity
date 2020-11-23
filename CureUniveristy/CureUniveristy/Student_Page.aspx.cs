using BLL;
using System;
using System.IO;
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

        protected void UploadButton_Click(object sender, EventArgs e)
        {
            string FN = "";
            FN = Path.GetFileName(FileUpload1.PostedFile.FileName);
            string contentType = FileUpload1.PostedFile.ContentType;
            Stream fs = FileUpload1.PostedFile.InputStream;
            BinaryReader br = new BinaryReader(fs);
            byte[] bytes = br.ReadBytes((Int32)fs.Length);
            string email = this.Request.Form.Get("test2");
            string course = this.Request.Form.Get("test");
            new Bll().AddAssignmnetToDatabase(email, course, FN, contentType, bytes);



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

        [WebMethod(EnableSession = true)]
        public static int GetStudnetCreditHours(string email)
        {
            return (new Bll().GetStudnetCreditHours(email));
        }

        [WebMethod(EnableSession = true)]
        public static string DisplayTeacherToStudent(string courseName)
        {
            JavaScriptSerializer js = new JavaScriptSerializer();
            return js.Serialize((new Bll()).DisplayTeacherToStudent(courseName));
        }

        [WebMethod(EnableSession = true)]
        public static string DisplayRegisteredCourses(string email)
        {
            JavaScriptSerializer js = new JavaScriptSerializer();
            return js.Serialize((new Bll()).DisplayRegisteredCourses(email));
        }

        [WebMethod(EnableSession = true)]

        public static void ModeOfStudy(string email, string course, string mode)
        {
            new Bll().ModeOfStudy(email, course, mode);
        }

    }
}
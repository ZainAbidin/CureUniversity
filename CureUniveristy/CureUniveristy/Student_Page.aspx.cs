using BLL;
using System;
using System.IO;
using System.Web.Script.Serialization;
using System.Web.Services;
using Newtonsoft.Json;


namespace CureUniveristy
{
    public partial class Student_Page : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
  
            try
            {
                if (Session["value"].ToString() != "0")
                {
                    Response.Redirect("Login_Page.aspx");
                }
            }
            catch (Exception)
            {
                Response.Redirect("Login_Page.aspx");
            }

        }

        public void UploadButton_Click(object sender, EventArgs e)
        {
            string FN = "";
            string email = this.Request.Form.Get("test2");
            string course = this.Request.Form.Get("test");
            string contentType = FileUpload1.PostedFile.ContentType;

            FN = Path.GetFileName(FileUpload1.PostedFile.FileName);
            Stream fs = FileUpload1.PostedFile.InputStream;

            BinaryReader br = new BinaryReader(fs);
            byte[] bytes = br.ReadBytes((Int32)fs.Length);
            string extension = Path.GetExtension(FileUpload1.PostedFile.FileName);
            if(extension == ".pdf")
            { 
                new Bll().AddAssignmnetToDatabase(email, course, FN, contentType, bytes);
              
            }
            else {
                
            }

        }

        public void UploadButton_Click1(object sender, EventArgs e)
        {
            string FN = "";
            string email = this.Request.Form.Get("test3");
            string course = this.Request.Form.Get("test1");
            string contentType = FileUpload2.PostedFile.ContentType;

            FN = Path.GetFileName(FileUpload2.PostedFile.FileName);
            Stream fs = FileUpload2.PostedFile.InputStream;
            BinaryReader br = new BinaryReader(fs);
            byte[] bytes = br.ReadBytes((Int32)fs.Length);
            string extension = Path.GetExtension(FileUpload2.PostedFile.FileName);
            if (extension == ".pdf")
                new Bll().AddQuizToDatabase(email, course, FN, contentType, bytes);
            else { }

        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Session["value"] = null;
            Response.Redirect("Login_Page.aspx");
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

        [WebMethod(EnableSession = true)]
        public static void ChooseTeacher(string email, string name)
        {
            new Bll().ChooseTeacher(email, name);
        }

        [WebMethod (EnableSession = true)]
        public static string DisplayMessages(string email)
        {
            return new Bll().DisplayMessages(email);
        }

        [WebMethod(EnableSession = true)]
        public static string DownloadVideo(string course, string teacher)
        {
            return JsonConvert.SerializeObject(new Bll().StudentDownloadVideo(course, teacher));
        }

    }
} 
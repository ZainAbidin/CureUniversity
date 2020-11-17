using BLL;
using System;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI.WebControls;
using System.IO;


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

        protected void UploadButton_Click(object sender, EventArgs e)
        {
            if (FileUploadControl.HasFile)
            {
                try
                {
                    if (FileUploadControl.PostedFile.ContentType == "image/jpeg")
                    {
                        if (FileUploadControl.PostedFile.ContentLength < 102400)
                        {
                            string filename = Path.GetFileName(FileUploadControl.FileName);
                            FileUploadControl.SaveAs(Server.MapPath("~/") + filename);
                            StatusLabel.Text = "Upload status: File uploaded!";
                        }
                        else
                            StatusLabel.Text = "Upload status: The file has to be less than 100 kb!";
                    }
                    else
                        StatusLabel.Text = "Upload status: Only JPEG files are accepted!";
                }
                catch (Exception ex)
                {
                    StatusLabel.Text = "Upload status: The file could not be uploaded. The following error occured: " + ex.Message;
                }
            }
        }
    }
}
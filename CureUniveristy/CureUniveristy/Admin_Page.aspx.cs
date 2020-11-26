using BLL;
using Newtonsoft.Json;
using System;
using System.Web.Services;

namespace CureUniveristy
{
    public partial class Admin_Page : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Session["value"].ToString() != "2")                
                    Response.Redirect("Login_Page.aspx");                
            }
            catch (Exception)
            {
                Response.Redirect("Login_Page.aspx");
            }
        }

        [WebMethod(EnableSession = true)]
        public static string ViewAllStudentstoAdmin()
        {
            return JsonConvert.SerializeObject((new Bll()).ViewAllStudentstoAdmin());
        }

        [WebMethod(EnableSession = true)]
        public static string ViewAllTeacherstoAdmin()
        {
            return JsonConvert.SerializeObject((new Bll()).ViewAllTeacherstoAdmin());
        }

        [WebMethod(EnableSession = true)]
        public static bool BlockOrSuspendEntity(int choice, int schoolId)
        {
            return (new Bll()).BlockOrSuspendEntity( choice, schoolId);
        }

        [WebMethod(EnableSession = true)]
        public static void sendMessage(string message, string schoolId)
        {
            new Bll().AdminSendMessage(message, Int32.Parse(schoolId));
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Session["value"] = null;
            Response.Redirect("Login_Page.aspx");
        }
    }
}
using System;
using System.Web.Services;
using BLL;
using Newtonsoft.Json;

namespace CureUniveristy
{
    public partial class Admin_Page : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

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
            return (new Bll()).BlockOrSuspendEntity(choice, schoolId);
        }
    }
}
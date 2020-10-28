using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL;

namespace BLL
{
    public class Bll
    {
        Dal DllObj = new Dal();
        public int LogIn(string email, string passwrod)
        {
            return DllObj.LogIn(email, passwrod);
        }

        public int SignUp(string email, string address, string firstName, string lastName, string password, int schoolId, string contactNumber)
        {
            return DllObj.SignUp(email, address, firstName, lastName, password, schoolId, contactNumber);
        }
    }
}

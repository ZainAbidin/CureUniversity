using Classes;
using DAL;
using System.Collections.Generic;
using System.Data;

namespace BLL
{
    public class Bll
    {
        public int LogIn(string email, string passwrod)
        {
            return (new Dal()).LogIn(email, passwrod);
        }

        public bool SignUp(string email, string address, string firstName, string lastName, string password, int schoolId, string contactNumber, string userName)
        {
            return (new Dal()).SignUp(email, address, firstName, lastName, password, schoolId, contactNumber, userName);
        }

        public DataTable GetEntityAgainstEmail(string email)
        {
            return (new Dal()).GetEntityAgainstEmail(email);
        }

        public List<Students> ViewStudents(string email)
        {
            return (new Dal()).GetStudents(email);
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using Classes;

namespace DAL
{
    public class Dal
    {
        string CS = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

        public int LogIn(string email, string password)
        {
            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlCommand cmnd = new SqlCommand("spCheckCredentials", con);
                cmnd.CommandType = System.Data.CommandType.StoredProcedure;
                cmnd.Parameters.AddWithValue("@Email", email);
                cmnd.Parameters.AddWithValue("@Password", password);
                con.Open();

                string role = Convert.ToString(cmnd.ExecuteScalar());
                int returnvar = 0;
                if (!string.IsNullOrEmpty(role))
                {
                    if (role.Equals("Student"))
                    {
                        returnvar = 0;
                    }
                    else if (role.Equals("Teacher"))
                    {
                        returnvar = 1;
                    }
                    else if (role.Equals("Admin"))
                    {
                        return 2;
                    }
                    return returnvar;

                }
                else
                {
                    return 3;
                }
            }


        }

        public int SignUp(string email, string address, string firstName, string lastName, string password, int schoolId, string contactNumber, string userName)
        {

            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlCommand cmnd = new SqlCommand("spstudentSignup", con);
                cmnd.CommandType = System.Data.CommandType.StoredProcedure;
                cmnd.Parameters.AddWithValue("@Email", email);
                cmnd.Parameters.AddWithValue("@Address", address);
                cmnd.Parameters.AddWithValue("@FirstName", firstName);
                cmnd.Parameters.AddWithValue("@LastName", lastName);
                cmnd.Parameters.AddWithValue("@SchoolId", schoolId);
                cmnd.Parameters.AddWithValue("@Contact_Number", contactNumber);
                cmnd.Parameters.AddWithValue("@Password", password);
                cmnd.Parameters.AddWithValue("@Username", userName);
                con.Open();

                string userExistenceCheck = Convert.ToString(cmnd.ExecuteScalar());
                if (!string.IsNullOrEmpty(userExistenceCheck))
                {
                    if (userExistenceCheck.Equals("0"))
                    {
                        return 0;
                    }
                    else
                    {
                        return 1;
                    }

                }
                return 1;

            }
            Students stdobj = new Students();
           

        }

    }
}

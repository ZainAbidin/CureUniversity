using Classes;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace DAL
{
    public class Dal
    {
        string ConnectionString = ConfigurationManager.ConnectionStrings["CureUniversityConnectionString"].ConnectionString;

        public int LogIn(string email, string password)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                SqlCommand cmnd = new SqlCommand("spCheckCredentials", connection);

                cmnd.CommandType = System.Data.CommandType.StoredProcedure;
                cmnd.Parameters.AddWithValue("@Email", email);
                cmnd.Parameters.AddWithValue("@Password", password);

                connection.Open();

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

        public bool SignUp(string email, string address, string firstName, string lastName, string password, int schoolId, string contactNumber, string userName)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                SqlCommand cmnd = new SqlCommand("spstudentSignup", connection);

                cmnd.CommandType = System.Data.CommandType.StoredProcedure;
                cmnd.Parameters.AddWithValue("@Email", email);
                cmnd.Parameters.AddWithValue("@Address", address);
                cmnd.Parameters.AddWithValue("@FirstName", firstName);
                cmnd.Parameters.AddWithValue("@LastName", lastName);
                cmnd.Parameters.AddWithValue("@SchoolId", schoolId);
                cmnd.Parameters.AddWithValue("@Contact_Number", contactNumber);
                cmnd.Parameters.AddWithValue("@Password", password);
                cmnd.Parameters.AddWithValue("@Username", userName);
                connection.Open();

                string userExistenceCheck = Convert.ToString(cmnd.ExecuteScalar());

                if (!string.IsNullOrEmpty(userExistenceCheck))
                {
                    if (userExistenceCheck.Equals("0"))
                    {
                        return false; /////////user already exists
                    }
                    else
                    {
                        return true; /////// NEW USER IS TO BE REGISTERED
                    }
                }

                return false;
            }
        }
        
        public DataTable GetEntityAgainstEmail (string email)
        {
            using(SqlConnection con = new SqlConnection (ConnectionString))
            {
                SqlCommand cmnd = new SqlCommand("spuserIdentify", con);
                cmnd.Parameters.AddWithValue("@Email", email);
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmnd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }

        public List<Students> GetStudents(string email)
        {
            List<Students> students = new List<Students>();
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                SqlCommand cmnd = new SqlCommand("spuserIdentify", connection);
                cmnd.Parameters.AddWithValue("@Email",email);
                cmnd.CommandType = System.Data.CommandType.StoredProcedure;
                connection.Open();
                SqlDataReader rdr = cmnd.ExecuteReader();
                while (rdr.Read())
                {
                    Students student = new Students();
                    student.ID = Convert.ToInt32(rdr["School_ID"]);
                    student.firstName = rdr["First_Name"].ToString();
                    student.lastName = rdr["Last_Name"].ToString();
                    student.email = rdr["Email"].ToString();
                    student.contactNumber = rdr["Contact_Number"].ToString();
                    student.address = rdr["Adress"].ToString();
                    students.Add(student);
                }
                return students;
            }
        }
    }
}

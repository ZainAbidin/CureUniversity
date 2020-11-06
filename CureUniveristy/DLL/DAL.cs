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

        public List<Students> GetStudentByID(string email)
        {
            List<Students> students = new List<Students>();
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                SqlCommand cmnd = new SqlCommand("spuserIdentify", connection);
                cmnd.Parameters.AddWithValue("@Email", email);
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

        public bool UpdateStudentProfile(string reference, string email, string address, string firstName, string lastName, string contactNumber, string userName)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                SqlCommand cmnd = new SqlCommand("spUpdateStudent", connection);

                cmnd.CommandType = CommandType.StoredProcedure;
                cmnd.Parameters.AddWithValue("@Email", email);
                cmnd.Parameters.AddWithValue("@Address", address);
                cmnd.Parameters.AddWithValue("@FirstName", firstName);
                cmnd.Parameters.AddWithValue("@LastName", lastName);
                cmnd.Parameters.AddWithValue("@reference", reference);
                cmnd.Parameters.AddWithValue("@Contact_Number", contactNumber);
                cmnd.Parameters.AddWithValue("@Username", userName);
                connection.Open();

                string checkUpdate = Convert.ToString(cmnd.ExecuteScalar());

                if (!string.IsNullOrEmpty(checkUpdate))
                {
                    if (checkUpdate.Equals("0"))
                    {
                        return false; ///////// didnt update
                    }
                    else
                    {
                        return true; /////// updated
                    }
                }

                return false;
            }
        }

        public DataTable ViewAllStudentstoAdmin()
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {

                SqlCommand cmnd = new SqlCommand("spViewAllStudents", con);
                cmnd.CommandType = System.Data.CommandType.StoredProcedure;
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmnd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }

        public DataTable ViewAllTeacherstoAdmin()
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {

                SqlCommand cmnd = new SqlCommand("spViewAllTeachers", con);
                cmnd.CommandType = CommandType.StoredProcedure;
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmnd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }

        public bool BlockOrSuspendEntity(int choice, int schoolId)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                SqlCommand cmnd = new SqlCommand("spSuspend", con);
                cmnd.CommandType = CommandType.StoredProcedure;
                con.Open();
                cmnd.Parameters.AddWithValue("@Choice", choice);
                cmnd.Parameters.AddWithValue("@SchoolID", schoolId);
                string checkUpdate = Convert.ToString(cmnd.ExecuteScalar());
                if (!string.IsNullOrEmpty(checkUpdate))
                {
                    if (checkUpdate.Equals("0"))
                    {
                        return false; ///////// updated
                    }
                    else
                    {
                        return true; /////// not updated
                    }
                }

                return true;
            }

        }

        public List<Teacher> GetTeacherByID(string email)
        {
            List<Teacher> teachers = new List<Teacher>();
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                SqlCommand cmnd = new SqlCommand("spuserIdentify", connection);
                cmnd.Parameters.AddWithValue("@Email", email);
                cmnd.CommandType = CommandType.StoredProcedure;
                connection.Open();
                SqlDataReader rdr = cmnd.ExecuteReader();
                while (rdr.Read())
                {
                    Teacher teacher = new Teacher();
                    teacher.ID = Convert.ToInt32(rdr["School_ID"]);
                    teacher.firstName = rdr["First_Name"].ToString();
                    teacher.lastName = rdr["Last_Name"].ToString();
                    teacher.email = rdr["Email"].ToString();
                    teacher.contactNumber = rdr["Contact_Number"].ToString();
                    teacher.address = rdr["Adress"].ToString();
                    teachers.Add(teacher);
                }
                return teachers;
            }
        }

        public bool CourseRegistrationByStudent(string courseName, int schoolId)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                SqlCommand cmnd = new SqlCommand("spCourseRegister", connection);

                cmnd.CommandType = CommandType.StoredProcedure;
                cmnd.Parameters.AddWithValue("@SchoolId", schoolId);
                cmnd.Parameters.AddWithValue("@CourseName", courseName);

                connection.Open();

                string registrationCheck = Convert.ToString(cmnd.ExecuteScalar());

                if (!string.IsNullOrEmpty(registrationCheck))
                {
                    if (registrationCheck.Equals("0"))
                    {
                        return false; /////////course already traken up
                    }
                    else
                    {
                        return true; /////// course registrered
                    }
                }

                return false;
            }
        }

        //public void PopulateCourseDropDownListForStudent(DropDownList ItemsDropDownList)
        //{
        //    using (SqlConnection connection = new SqlConnection(ConnectionString))
        //    {
        //        SqlCommand cmnd = new SqlCommand("spShowCourses", connection);
        //        cmnd.CommandType = CommandType.StoredProcedure;
        //        connection.Open();
        //        ItemsDropDownList.DataSource = cmnd.ExecuteReader();
        //        ItemsDropDownList.DataTextField = "ItemName";
        //        ItemsDropDownList.DataValueField = "ItemID";
        //        ItemsDropDownList.DataBind();
        //    }

        //}

        public List<Course> DisplayCourses()
        {
            List<Course> courses = new List<Course>();
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                SqlCommand cmnd = new SqlCommand("spShowCourses", connection);
                cmnd.CommandType = CommandType.StoredProcedure;
                connection.Open();
                SqlDataReader rdr = cmnd.ExecuteReader();
                while (rdr.Read())
                {
                    Course course = new Course();
                    course.creditHours = Convert.ToInt32(rdr["CreditHours"]);
                    course.name = rdr["CourseName"].ToString();
                    courses.Add(course);
                }
                return courses;
            }
        }
    }
}



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
            try
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
                            returnvar = 0;

                        else if (role.Equals("Teacher"))
                            returnvar = 1;

                        else if (role.Equals("Admin"))
                            return 2;

                        return returnvar;
                    }
                    else
                    {
                        return 3;
                    }
                }
            }
            catch (Exception e)
            {
                return 3;
            }
        }

        public bool SignUp(string email, string address, string firstName, string lastName, string password, int schoolId, string contactNumber, string userName)
        {
            try
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
                            return false; //user already exists
                        }
                        else
                        {
                            return true; //NEW USER IS TO BE REGISTERED
                        }
                    }

                    return false;
                }
            }
            catch (Exception e)
            {
                return false;
            }
        }

        public List<Students> GetStudentByID(string email)
        {
            List<Students> students = new List<Students>();
            try
            {

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
            catch (Exception e)
            {
                return students;
            }
        }

        public bool UpdateStudentProfile(string reference, string email, string address, string firstName, string lastName, string contactNumber, string userName)
        {
            try
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
                            return false; // didnt update

                        else
                            return true; // updated                        
                    }
                    return false;
                }
            }
            catch (Exception e)
            {
                return false;
            }
        }

        public DataTable ViewAllStudentstoAdmin()
        {
            DataTable dt = new DataTable();
            try
            {
                using (SqlConnection con = new SqlConnection(ConnectionString))
                {

                    SqlCommand cmnd = new SqlCommand("spViewAllStudents", con);
                    cmnd.CommandType = System.Data.CommandType.StoredProcedure;
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmnd);

                    da.Fill(dt);
                    return dt;
                }
            }
            catch (Exception e)
            {
                return dt;
            }
        }

        public DataTable ViewAllTeacherstoAdmin()
        {
            DataTable dt = new DataTable();
            try
            {

                using (SqlConnection con = new SqlConnection(ConnectionString))
                {
                    SqlCommand cmnd = new SqlCommand("spViewAllTeachers", con);
                    cmnd.CommandType = CommandType.StoredProcedure;
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmnd);
                    da.Fill(dt);
                    return dt;
                }
            }
            catch (Exception e)
            {
                return dt;
            }
        }

        public bool BlockOrSuspendEntity(int choice, int schoolId)
        {
            try
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
                            return false; // updated                        
                        else
                            return true; // not updated                        
                    }
                    return true;
                }
            }
            catch (Exception e)
            {
                return true;
            }
        }

        public List<Teacher> GetTeacherByID(string email)
        {
            List<Teacher> teachers = new List<Teacher>();
            try
            {
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
            catch (Exception e)
            {
                return teachers;
            }
        }

        public List<Course> DisplayCourses()
        {
            List<Course> courses = new List<Course>();
            try
            {
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
            catch
            {
                return courses;
            }
        }

        public bool StudentRegisterCourse(string email, string course)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    SqlCommand cmnd = new SqlCommand("spCourseRegister", connection);
                    cmnd.CommandType = CommandType.StoredProcedure;

                    cmnd.Parameters.AddWithValue("@Email", email);
                    cmnd.Parameters.AddWithValue("@CourseName", course);

                    connection.Open();
                    string checkRegistration = Convert.ToString(cmnd.ExecuteScalar());

                    if (!string.IsNullOrEmpty(checkRegistration))
                    {
                        if (checkRegistration.Equals("0"))
                            return false; // already registered                        
                        else
                            return true; // registered
                    }

                    return true;
                }
            }
            catch
            {
                return true;
            }
        }

        public int GetStudnetCreditHours(string email)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    SqlCommand cmnd = new SqlCommand("spShowCredits", connection);

                    cmnd.CommandType = CommandType.StoredProcedure;
                    cmnd.Parameters.AddWithValue("@Email", email);

                    connection.Open();

                    return Convert.ToInt32((cmnd.ExecuteScalar()));
                }
            }
            catch
            {
                return 0;
            }
        }

        public List<Teacher> DisplayTeachersToStudent(string courseName)
        {
            List<Teacher> teachers = new List<Teacher>();
            try
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    SqlCommand cmnd = new SqlCommand("spShowTeacher", connection);
                    cmnd.CommandType = CommandType.StoredProcedure;
                    cmnd.Parameters.AddWithValue("@CourseName", courseName);
                    connection.Open();
                    SqlDataReader rdr = cmnd.ExecuteReader();

                    while (rdr.Read())
                    {
                        Teacher teacher = new Teacher();
                        teacher.firstName = rdr["First_Name"].ToString();
                        teachers.Add(teacher);
                    }
                    return teachers;
                }
            }
            catch
            {
                return teachers;
            }
        }

        public List<Course> DisplayRegisteredCourses(string email)
        {
            List<Course> courses = new List<Course>();
            try
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    SqlCommand cmnd = new SqlCommand("spShowRegisteredCourse", connection);
                    cmnd.CommandType = CommandType.StoredProcedure;
                    cmnd.Parameters.AddWithValue("@Email", email);
                    connection.Open();
                    SqlDataReader rdr = cmnd.ExecuteReader();

                    while (rdr.Read())
                    {
                        Course course = new Course();
                        course.name = rdr["Course"].ToString();
                        courses.Add(course);
                    }
                    return courses;
                }
            }
            catch (Exception e)
            {
                return courses;
            }
        }

        public void AddAssignmnetToDatabase(string email, string course, string name, string type, byte[] data)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    SqlCommand cmnd = new SqlCommand("spUploadAssignment", connection);
                    cmnd.CommandType = CommandType.StoredProcedure;

                    cmnd.Parameters.AddWithValue("@Email", email);
                    cmnd.Parameters.AddWithValue("@Course", course);
                    cmnd.Parameters.AddWithValue("@Assignment_Name", name);
                    cmnd.Parameters.AddWithValue("@Assignment_Type", type);
                    cmnd.Parameters.AddWithValue("@Assignment_Data", data);

                    connection.Open();
                    cmnd.ExecuteNonQuery();
                }
            }
            catch (Exception e)
            { }
        }

        public void AddQuizToDatabase(string email, string course, string name, string type, byte[] data)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    SqlCommand cmnd = new SqlCommand("spUploadQuiz", connection);
                    cmnd.CommandType = CommandType.StoredProcedure;

                    cmnd.Parameters.AddWithValue("@Email", email);
                    cmnd.Parameters.AddWithValue("@Course", course);
                    cmnd.Parameters.AddWithValue("@Quiz_Name", name);
                    cmnd.Parameters.AddWithValue("@Quiz_Type", type);
                    cmnd.Parameters.AddWithValue("@Quiz_Data", data);

                    connection.Open();
                    cmnd.ExecuteNonQuery();
                }
            }
            catch (Exception e)
            { }
        }

        public void EditCourse(string course, string courseName, int creditHours)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    SqlCommand cmnd = new SqlCommand("spEditCourse", connection);
                    cmnd.CommandType = CommandType.StoredProcedure;

                    cmnd.Parameters.AddWithValue("@CourseRefrence", course);
                    cmnd.Parameters.AddWithValue("@CourseName", courseName);
                    cmnd.Parameters.AddWithValue("@CourseCredits", creditHours);

                    connection.Open();
                    cmnd.ExecuteNonQuery();
                }
            }
            catch (Exception e)
            { }
        }

        public void ModeOfStudy(string email, string course, string mode)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    SqlCommand cmnd = new SqlCommand("spModeOfStudy", connection);
                    cmnd.CommandType = CommandType.StoredProcedure;

                    cmnd.Parameters.AddWithValue("@Course", course);
                    cmnd.Parameters.AddWithValue("@Email", email);
                    cmnd.Parameters.AddWithValue("@Mode", mode);

                    connection.Open();
                    cmnd.ExecuteNonQuery();
                }
            }
            catch (Exception e)
            { }
        }

        public void ChooseTeacher(string email, string name)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    SqlCommand cmnd = new SqlCommand("spChooseTeacher", connection);
                    cmnd.CommandType = CommandType.StoredProcedure;

                    cmnd.Parameters.AddWithValue("@name", name);
                    cmnd.Parameters.AddWithValue("@Email", email);

                    connection.Open();
                    cmnd.ExecuteNonQuery();
                }
            }
            catch (Exception e)
            { }
        }

        public List<Assignment> ShowAssignments(string email, string course)
        {
            List<Assignment> assignments = new List<Assignment>();
            try
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    SqlCommand cmnd = new SqlCommand("spShowAssignments", connection);
                    cmnd.CommandType = CommandType.StoredProcedure;

                    cmnd.Parameters.AddWithValue("@Email", email);
                    cmnd.Parameters.AddWithValue("@Course", course);

                    connection.Open();
                    SqlDataReader rdr = cmnd.ExecuteReader();

                    while (rdr.Read())
                    {
                        Assignment assignment = new Assignment();
                        assignment.name = rdr["Assignment_Name"].ToString();
                        assignments.Add(assignment);
                    }
                    return assignments;
                }
            }
            catch (Exception e)
            {
                return assignments;
            }
        }

        //public List<Course> ShowAssignments(string email, string course)
        //{
        //    List<Course> courses = new List<Course>();
        //    try
        //    {
        //        using (SqlConnection connection = new SqlConnection(ConnectionString))
        //        {

        //            SqlCommand cmnd = new SqlCommand("spShowAssignments", connection);
        //            cmnd.CommandType = CommandType.StoredProcedure;
        //            cmnd.Parameters.AddWithValue("@Email", email);
        //            cmnd.Parameters.AddWithValue("@Course", course);
        //            connection.Open();
        //            SqlDataReader rdr = cmnd.ExecuteReader();
        //            while (rdr.Read())
        //            {

        //                Course cours = new Course();
        //                cours.assignment.name = rdr["Assignment_Name"].ToString();
        //                courses.Add(cours);

        //            }
        //            return assignments;
        //        }
        //    }
        //    catch (Exception e)
        //    {
        //        return assignments;

        //    }
        //}

        public void UploadAssignmentScore(string email, string course, int score)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    SqlCommand cmnd = new SqlCommand("spUploadAssignmentScore", connection);
                    cmnd.CommandType = CommandType.StoredProcedure;

                    cmnd.Parameters.AddWithValue("@Email", email);
                    cmnd.Parameters.AddWithValue("@Course", course);
                    cmnd.Parameters.AddWithValue("@Score", score);

                    connection.Open();
                    cmnd.ExecuteNonQuery();
                }
            }
            catch (Exception e)
            { }
        }

        public string DisplayMessages(string email)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    SqlCommand cmnd = new SqlCommand("spReadMessage", connection);
                    cmnd.CommandType = CommandType.StoredProcedure;
                    cmnd.Parameters.AddWithValue("@Email", email);
                    connection.Open();

                    Students std = new Students();
                    std.message.message = Convert.ToString(cmnd.ExecuteScalar());
                    return std.message.message;
                }
            }
            catch (Exception e)
            {
                return "";
            }
        }

        public List<Students> ViewRegisteredStudentstoTeacher(string email)
        {
            List<Students> students = new List<Students>();
            try
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    SqlCommand cmnd = new SqlCommand("spShowStudentsTaught", connection);
                    cmnd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmnd.Parameters.AddWithValue("@Email", email);
                    connection.Open();
                    SqlDataReader rdr = cmnd.ExecuteReader();
                    while (rdr.Read())
                    {
                        Students student = new Students();
                        student.ID = Convert.ToInt32(rdr["School_ID"]);
                        student.firstName = rdr["First_Name"].ToString();
                        student.email = rdr["Email"].ToString();
                        students.Add(student);
                    }
                    return students;
                }
            }
            catch (Exception e)
            {
                return students;
            }
        }

        public void sendMessage(string reference, string email, string message)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    SqlCommand cmnd = new SqlCommand("spMessage", connection);
                    cmnd.CommandType = CommandType.StoredProcedure;

                    cmnd.Parameters.AddWithValue("@Email", email);
                    cmnd.Parameters.AddWithValue("@Reference", reference);
                    cmnd.Parameters.AddWithValue("@message", message);

                    connection.Open();
                    cmnd.ExecuteNonQuery();
                }
            }
            catch (Exception e)
            {

            }
        }

        public void TeacherBlockStudent(string teacher, string student)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    SqlCommand cmnd = new SqlCommand("spTeacherBlockStudent", connection);

                    cmnd.CommandType = CommandType.StoredProcedure;
                    cmnd.Parameters.AddWithValue("@Email", student);
                    cmnd.Parameters.AddWithValue("@Reference", teacher);

                    connection.Open();
                    cmnd.ExecuteNonQuery();
                }
            }
            catch (Exception e)
            {

            }
        }

        public void AdminSendMessage(string message, int schoolId)
        {
            //try
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    SqlCommand cmnd = new SqlCommand("spAdminMessage", connection);
                    cmnd.CommandType = CommandType.StoredProcedure;
                    cmnd.Parameters.AddWithValue("@Schoolid", schoolId);
                    cmnd.Parameters.AddWithValue("@message", message);
                    connection.Open();
                    cmnd.ExecuteNonQuery();
                }
            }
            //catch
            //{

            //}
        }
    }
}
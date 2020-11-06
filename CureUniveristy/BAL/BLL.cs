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

        public List<Students> GetStudentByID(string email)
        {
            return (new Dal()).GetStudentByID(email);
        }

        public bool UpdateStudentProfile(string reference, string email, string address, string firstName, string lastName, string contactNumber, string userName)
        {
            return (new Dal()).UpdateStudentProfile(reference, email, address, firstName, lastName, contactNumber, userName);
        }

        public DataTable ViewAllStudentstoAdmin()
        {
            return (new Dal()).ViewAllStudentstoAdmin();
        }

        public DataTable ViewAllTeacherstoAdmin()
        {
            return (new Dal()).ViewAllTeacherstoAdmin();
        }

        public bool BlockOrSuspendEntity(int choice, int schoolId)
        {
            return (new Dal()).BlockOrSuspendEntity(choice, schoolId);
        }

        public List<Teacher> GetTeacherByID(string email)
        {
            return (new Dal()).GetTeacherByID(email);
        }

        public bool CourseRegistrationByStudent(string courseName, int schoolId)
        {
            return (new Dal()).CourseRegistrationByStudent(courseName, schoolId);
        }

        //public void PopulateCourseDropDownListForStudent(DropDownList ItemsDropDownList)
        //{
        //    (new Dal()).PopulateCourseDropDownListForStudent(ItemsDropDownList);
        //}

        public List<Course> DisplayCourses()
        {
            return (new Dal()).DisplayCourses();
        }
    }
}

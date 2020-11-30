using Classes;
using DAL;
using System;
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

        public List<string> DisplayCourses()
        {
            List<Course> coursesList = new List<Course>();
            List<string> compiledList = new List<string>();

            coursesList = (new Dal()).DisplayCourses();

            foreach (var course in coursesList)
                compiledList.Add(string.Format("{0} - {1}", course.name, course.creditHours));

            return compiledList;
        }

        public bool StudentRegisterCourse(string email, string course)
        {
            return (new Dal()).StudentRegisterCourse(email, course);
        }

        public object GetStudentByID(Func<string> email)
        {
            throw new NotImplementedException();
        }

        public int GetStudnetCreditHours(string email)
        {
            return (new Dal().GetStudnetCreditHours(email));
        }

        public List<string> DisplayTeacherToStudent(string courseName)
        {
            List<Teacher> teacherlist = new List<Teacher>();
            List<string> compiledList = new List<string>();

            teacherlist = (new Dal().DisplayTeachersToStudent(courseName));

            foreach (var teacher in teacherlist)
                compiledList.Add(teacher.firstName);

            return compiledList;
        }

        public List<string> DisplayRegisteredCourses(string email)
        {
            List<Course> coursesList = new List<Course>();
            List<string> compiledList = new List<string>();

            coursesList = (new Dal()).DisplayRegisteredCourses(email);

            foreach (var course in coursesList)
                compiledList.Add(course.name);

            return compiledList;
        }

        public void AddAssignmnetToDatabase(string email, string course, string name, string type, byte[] data)
        {
            new Dal().AddAssignmnetToDatabase(email, course, name, type, data);
        }

        public void AddQuizToDatabase(string email, string course, string name, string type, byte[] data)
        {
            new Dal().AddQuizToDatabase(email, course, name, type, data);
        }

        public void EditCourse(string course, string courseName, int creditHours)
        {
            new Dal().EditCourse(course, courseName, creditHours);
        }

        public void ModeOfStudy(string email, string course, string mode)
        {
            new Dal().ModeOfStudy(email, course, mode);
        }

        public void ChooseTeacher(string email, string name)
        {
            new Dal().ChooseTeacher(email, name);
        }

        public List<string> ShowAssignments(string email, string course)
        {
            List<Assignment> assignmentList = new List<Assignment>();
            List<string> compiledList = new List<string>();

            assignmentList = new Dal().ShowAssignments(email, course);

            foreach (var assignment in assignmentList)
                compiledList.Add(assignment.name);

            return compiledList;
        }


        public void UploadAssignmentScore(string email, string course, int score)
        {
            new Dal().UploadAssignmentScore(email, course, score);
        }

        public string DisplayMessages(string email)
        {
            return new Dal().DisplayMessages(email);
        }

        public List<Students> ViewRegisteredStudentstoTeacher(string email)
        {
            return new Dal().ViewRegisteredStudentstoTeacher(email);
        }

        public void sendMessage(string reference, string email, string message)
        { 
            new Dal().sendMessage(reference, email, message); 
        }
        
        public void TeacherBlockStudent(string teacher, string student)
        {
            new Dal().TeacherBlockStudent(teacher, student);
        }

        public void AdminSendMessage(string message, int schoolId)
        {
            new Dal().AdminSendMessage(message, schoolId);
        }

        public void TeacherUploadVideo(string email, string course, string link, string name)
        {
            new Dal().TeacherUploadVideo(email, course, link, name);
        }

        public DataTable StudentDownloadVideo(string course, string teacher)
        {
            return new Dal().StudentDownloadVideo(course, teacher);
        }
    }
}

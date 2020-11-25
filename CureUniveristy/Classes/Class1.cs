using System.Collections.Generic;

namespace Classes
{
    public class Course
    {
        public string name { get; set; }
        public int creditHours { get; set; }
        public string modeOfStudy { get; set; }

        public Assignment assignment;

    }
    public class Users
    {
        public int ID { get; set; }
        public string firstName { get; set; }
        public string lastName { get; set; }
        public string address { get; set; }
        public string email { get; set; }
        public string contactNumber { get; set; }

    }

    public class Students : Users
    {
        public Students()
        {
            CourseList = new List<Course>();
            message = new Messages(); 
        }

        List<Course> CourseList { get; set; }

        public Messages message;

    }

    public class Teacher : Users
    {
        public Teacher()
        {
            CourseList = new List<Course>();
            message = new Messages();
        }
        Messages message = new Messages();
        List<Course> CourseList { get; set; }

    }

    public class Admin : Users
    {
        public Admin()
        {
            message = new Messages();
        }
        Messages message = new Messages();
    }

    public class Assignment
    {
        public string name { set; get; }
    }

    public class Messages
    {
        public string message { set; get; }
    }

}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Classes
{
    public class Users
    {
        public int ID { get; set; }
        protected string firstName { get; set; }
        protected string lastName { get; set; }
        protected string address { get; set; }
        protected string email { get; set; }
        protected string contactNumber { get; set; }

    }

    public class Students : Users
    {
        public Students()
        {
            CourseList = new List<Course>();
        }

        List<Course> CourseList { get; set; }


    }

    public class Teacher : Users
    {
        public Teacher()
        {
            CourseList = new List<Course>();
        }

        List<Course> CourseList { get; set; }

    }

    public class Admin : Users
    {
        public Admin()
        {
            
        }

    }

    public class Course
    {

    }
}

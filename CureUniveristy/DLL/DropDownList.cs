using System;
using System.Data.SqlClient;

namespace DAL
{
    public class DropDownList
    {
        public SqlDataReader DataSource { get; internal set; }
        public string DataTextField { get; internal set; }
        public string DataValueField { get; internal set; }

        internal void DataBind()
        {
            throw new NotImplementedException();
        }
    }
}
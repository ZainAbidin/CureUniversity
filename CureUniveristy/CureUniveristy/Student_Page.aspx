<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Student_Page.aspx.cs" Inherits="CureUniveristy.Student_Page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="Scripts/jquery-3.3.1.js"></script>
    <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.22/css/jquery.dataTables.min.css" />
    <script type="text/javascript" src="//cdn.datatables.net/1.10.22/js/jquery.dataTables.min.js"></script>

    <script type="text/javascript">


        function getUrlVars() {

            //todo: userEmail
            var vars = [], hash;
            var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');

            for (var i = 0; i < hashes.length; i++) {

                hash = hashes[i].split('=');
                vars.push(hash[0]);
                vars[hash[0]] = hash[1];
            }

            return vars;
        }

        $(document).ready(function () {
            var EMAIL = getUrlVars()["email"];
           
            $.ajax({
                url: 'Student_Page.aspx/GetStudents',
                method: 'post',
                dataType: 'json',
                contentType: 'application/json',
                async: false,
                data: JSON.stringify({ "email": EMAIL }),
                success: function (data) {

                    $('#studentDataTable').dataTable({
                        data: JSON.parse(data.d),
                        columns: [
                            {
                                'data': 'ID',
                                'render': function (id) {
                                    return '<a href=http://localhost:6398/AddUpdateAccountant.aspx?ID=' + id + '>' + id + '</a>';
                                }
                            },

                            { 'data': 'firstName' },
                            { 'data': 'lastName' },
                            { 'data': 'address' },
                            { 'data': 'email' },
                            { 'data': 'contactNumber' }
                        ]
                    });
                }

            });
        });

        


    </script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>Welcome Student!</h1>
        </div>

        <div style="margin: auto">
            <table id="studentDataTable" >
                <thead>
                    <tr>
                        <th>School ID</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Address</th>
                        <th>Email</th>
                        <th>Contact Number</th>
                    </tr>
                </thead>
            </table>
            <br />
        </div>

    </form>
</body>
</html>

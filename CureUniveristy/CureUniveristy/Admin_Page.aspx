<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin_Page.aspx.cs" Inherits="CureUniveristy.Admin_Page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="Scripts/jquery-3.3.1.js"></script>
    <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.22/css/jquery.dataTables.min.css" />
    <script type="text/javascript" src="//cdn.datatables.net/1.10.22/js/jquery.dataTables.min.js"></script>

    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


    <script type="text/javascript">

        $(document).ready(function () {
            populateStudentDataTable();
            populateTeacherDataTable();
            $('#studentDatatableDiv').hide();
            $('#teacherDatatableDiv').hide();

        });
        function showstudentdiv() {
            $('#studentDatatableDiv').show();
            $('#teacherDatatableDiv').hide();
        }
        function showteacherdiv() {
            $('#teacherDatatableDiv').show();
            $('#studentDatatableDiv').hide();
        }

        function populateStudentDataTable() {

            $.ajax({
                url: 'Admin_Page.aspx/ViewAllStudentstoAdmin',
                method: 'post',
                dataType: 'json',
                contentType: 'application/json',
                async: true,
                success: function (data) {

                    $('#viewStudentDataTable').dataTable({
                        data: JSON.parse(data.d),
                        columns: [
                            {
                                'data': 'School_ID',
                                'render': function (id) {
                                    return '<button type = "button" data-toggle="modal" onclick="getID()" id="iDbtn" value = "'+ id +'"data-target="#myModal" style="padding:0; border : none; background: none"' + id + '>' + id + '</button>';
                                }

                            },
                            { 'data': 'First_Name' },
                            { 'data': 'Last_Name' },
                            { 'data': 'Adress' },
                            { 'data': 'Email' },
                            { 'data': 'Contact_Number' },
                            { 'data': 'Username' },
                            { 'data': 'Activity' },
                            { 'data': 'Course' }
                        ]
                    });
                }

            });

        }

        function getID() {
            $('#')
        }


        function populateTeacherDataTable() {

            $.ajax({
                url: 'Admin_Page.aspx/ViewAllTeacherstoAdmin',
                method: 'post',
                dataType: 'json',
                contentType: 'application/json',
                async: true,
                success: function (data) {

                    $('#viewTeacherDataTable').dataTable({
                        data: JSON.parse(data.d),
                        columns: [
                            {
                                'data': 'School_ID',
                                'render': function (id) {
                                    return '<button type = "button"  data-toggle="modal" data-target="#myModal" style="padding:0; border : none; background: none"' + id + '>' + id + '</button>';
                                }

                            },
                            { 'data': 'First_Name' },
                            { 'data': 'Last_Name' },
                            { 'data': 'Adress' },
                            { 'data': 'Email' },
                            { 'data': 'Contact_Number' },
                            { 'data': 'Username' },
                            { 'data': 'Activity' },
                            { 'data': 'Course' }
                        ]
                    });
                }

            });

        }


        function BlockEntity() {
            $.ajax({
                type: "post",
                url: "Admin_Page.aspx/BlockOrSuspendEntity",
                async: false,
                data: JSON.stringify({ "choice": 0, "schoolId": $('#iDbtn').val() }),
                contentType: 'application/json',
                dataType: 'json',
                success: function (data) {
                    if (data.d == false) {


                        alert("update");

                    }
                    else if (data.d == true)
                        alert("not Updated");

                },
                error: function () {
                    alert("Failure");
                }
            })

        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <button type="button" onclick="showstudentdiv()">View All Students</button>

            <button type="button" onclick="showteacherdiv()">View All Teachers</button>

            <div id="studentDatatableDiv" style="margin: auto">
                <table id="viewStudentDataTable">
                    <thead>
                        <tr>
                            <th>School ID</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Address</th>
                            <th>Email</th>
                            <th>Contact Number</th>
                            <th>Username</th>
                            <th>Activity</th>
                            <th>Course</th>
                        </tr>
                    </thead>
                </table>
                <br />
            </div>

            <div id="teacherDatatableDiv" style="margin: auto">
                <table id="viewTeacherDataTable">
                    <thead>
                        <tr>
                            <th>School ID</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Address</th>
                            <th>Email</th>
                            <th>Contact Number</th>
                            <th>Username</th>
                            <th>Activity</th>
                            <th>Course</th>
                        </tr>
                    </thead>
                </table>
                <br />
            </div>

            <div class="modal" id="myModal">
                <div class="modal-dialog">
                    <div class="modal-content">

                        <!-- Modal body -->
                        <div class="modal-body">
                            <input type="text" id="messageBox" />
                        </div>

                        <div class="modal-footer">
                            <table>
                                <tr>
                                    <td>
                                        <button type="button" class="btn btn-danger" data-dismiss="modal">Suspend</button>
                                    </td>
                                    <td>
                                        <button type="button" class="btn btn-danger" onclick="BlockEntity()" data-dismiss="modal">Block</button>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </form>
</body>
</html>

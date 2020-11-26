<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin_Page.aspx.cs" Inherits="CureUniveristy.Admin_Page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="Scripts/jquery-3.3.1.js"></script>
    <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.22/css/jquery.dataTables.min.css" />
    <script type="text/javascript" src="//cdn.datatables.net/1.10.22/js/jquery.dataTables.min.js"></script>
    <!--Bootsrap 4 CDN-->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous" />
    <!--Fontawesome CDN-->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous" />

    <!-- Bootstrap core CSS -->
    <link href="dashboard.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <style>
        html, body {
            background-image: url("images/page.jpg");
            background-size: cover;
            background-repeat: no-repeat;
            height: 100%;
            font-family: 'Numans', sans-serif;
        }
    </style>

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
                                    return '<button type = "button" data-toggle="modal"  id="iDbtn" data-target="#myModal" style="padding:0; border : none; background: none"' + id + '>' + id + '</button>';
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
                data: JSON.stringify({ "choice": 0, "schoolId": $('#schoolId').val() }),
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

        function SuspendEntity() {

            $.ajax({
                type: "post",
                url: "Admin_Page.aspx/BlockOrSuspendEntity",
                async: false,
                data: JSON.stringify({ "choice": 1, "schoolId": $('#schoolId').val() }),
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
        function sendMessage() {
            $.ajax({
                type: "post",
                url: "Admin_Page.aspx/sendMessage",
                async: false,
                data: JSON.stringify({ "schoolId": $('#schoolId').val(), "message": $('messageBox').val()}),
                contentType: 'application/json',
                dataType: 'json',
                success: function (data) {

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
        <nav class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-0 shadow">
            <h1 class="navbar-brand col-md-3 col-lg-2 mr-0 px-3">Welcome Admin!</h1>
            <button class="navbar-toggler position-absolute d-md-none collapsed" type="button" data-toggle="collapse" data-target="#sidebarMenu" aria-controls="sidebarMenu" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <ul class="navbar-nav px-3">
                <li class="nav-item text-nowrap">
<%--                    <a class="nav-link" href="Login_Page.aspx">Sign out</a>--%>
                    <asp:LinkButton ID="LinkButton1" class="nav-link" runat="server" OnClick="LinkButton1_Click">Sign out</asp:LinkButton>
                </li>
            </ul>
        </nav>
        <div class="container-fluid">
            <div class="row">
                <nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
                    <div class="sidebar-sticky pt-3">
                        <ul class="nav flex-column">
                            <li class="nav-item">
                                <a class="nav-link" href="#" onclick="showstudentdiv()">
                                    <span data-feather="file"></span>
                                    View All Students
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" onclick="showteacherdiv()">
                                    <span data-feather="shopping-cart"></span>
                                    View All Teachers
                                </a>
                            </li>
                        </ul>

                    </div>
                </nav>

                <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
                    <div class="table-responsive">
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
                        <!--------------------------------------------------------MODAL TO PERFORM ACTION ON ENTITIES-------------------------------------------->
                        <div class="modal" id="myModal">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">

                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    </div>
                                    <!-- Modal body -->
                                    <div class="modal-body">
                                        <table>
                                            <tr>
                                                <td>
                                                    <label>Enter the ID: </label>
                                                </td>
                                                <td>
                                                    <input type="text" id="schoolId" />
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <label>Type in the message you want to send: </label>
                                                </td>
                                                <td>
                                                    <input type="text" id="messageBox" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>

                                    <div class="modal-footer">
                                        <table>
                                            <tr>
                                                <td>
                                                    <button type="button" class="btn btn-danger" onclick="SuspendEntity()">Suspend</button>
                                                </td>
                                                <td>
                                                    <button type="button" class="btn btn-danger" onclick="BlockEntity()">Block</button>
                                                </td>
                                                <td>
                                                    <button type="button" class="btn btn-danger" onclick="sendMessage()">Send Message</button>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--------------------------------------------------------------------------------------------------------------------------------->

                    </div>
                </main>
            </div>
        </div>
    </form>
</body>
</html>

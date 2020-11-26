<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Teacher_Page.aspx.cs" Inherits="CureUniveristy.Teacher_Page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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
        .bd-placeholder-img {
            font-size: 1.125rem;
            text-anchor: middle;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
        }

        @media (min-width: 768px) {
            .bd-placeholder-img-lg {
                font-size: 3.5rem;
            }
        }

        html, body {
            background-image: url("images/4.jpg");
            background-size: cover;
            background-repeat: no-repeat;
            height: 100%;
            font-family: 'Numans', sans-serif;
        }

    </style>
    <script type="text/javascript">
        function Validation() {
            var errors = "";
            errors += CheckName();
            errors += CheckUsername();
            errors += CheckEmailAddress();
            if (errors != "") {
                alert(errors);
                return false;
            }
            UpdateTeacherProfile();
            return true;

        }

        function CheckName() {
            var FName = document.getElementById('firstName');
            var LName = document.getElementById('lastName');
            var exp = /^[a-zA-Z]+$/
            if ((exp.test(FName.value)) && (exp.test(LName.value))) {
                return "";
            }
            else {
                return 'Name can Only have alphabets!!\n'
            }
        }

        function CheckUsername() {
            var Username = document.getElementById('userName');
            var exp = /^[a-z.]+$/
            if (exp.test(Username.value)) {
                return "";
            }
            else {
                return 'Username should not have block letters and numbers!!\n'
            }
        }

        function CheckEmailAddress() {
            var emailAddress = document.getElementById('inputEmail');
            var exp = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            if (exp.test(emailAddress.value)) 
                return "";
            else
                return "Email address typed is not in the correct format!\n";

        }

        $(document).ready(function () {
            $('#assignmentDiv').hide();
            var EMAIL = getUrlVars()["email"];

            $.ajax({
                url: 'Teacher_Page.aspx/GetTeacherByID',
                method: 'post',
                dataType: 'json',
                contentType: 'application/json',
                async: false,
                data: JSON.stringify({ "email": EMAIL }),
                success: function (data) {

                    $('#teacherDataTable').dataTable({
                        data: JSON.parse(data.d),
                        columns: [
                            { 'data': 'ID' },
                            { 'data': 'firstName' },
                            { 'data': 'lastName' },
                            { 'data': 'address' },
                            { 'data': 'email' },
                            { 'data': 'contactNumber' }
                        ],
                        searching: false,
                        bPaginate: false,
                        bInfo: false,
                        
                    });
                }

            });

            $.ajax({
                url: 'Student_Page.aspx/DisplayRegisteredCourses',
                method: 'post',
                dataType: 'json',
                contentType: 'application/json',
                async: false,
                data: JSON.stringify({ "email": EMAIL }),
                success: function (data) {

                    var good = JSON.parse(data.d);

                    for (var course = 0; course < good.length; course++) 
                        $('#displayCoursesId').append(new Option(good[course], course));
                }
            });

            $.ajax({
                url: 'Student_Page.aspx/DisplayMessages',
                method: 'post',
                dataType: 'json',
                contentType: 'application/json',
                async: false,
                data: JSON.stringify({ "email": EMAIL }),
                success: function (data) {
                    document.getElementById("message").value = data.d;
                }
            });

            $.ajax({
                url: 'Teacher_Page.aspx/ViewRegisteredStudentstoTeacher',
                method: 'post',
                dataType: 'json',
                contentType: 'application/json',
                async: false,
                data: JSON.stringify({ "email": EMAIL }),
                success: function (data) {
                    $('#registeredStudentTable').dataTable({
                        data: JSON.parse(data.d),
                        columns: [
                            { 'data': 'ID' },
                            { 'data': 'firstName' },
                            { 'data': 'email' },
                        ],
                        bPaginate: false,
                        bInfo: false
                    });
                }
            });

            $.ajax({
                url: 'Teacher_Page.aspx/ViewRegisteredStudentstoTeacher',
                method: 'post',
                dataType: 'json',
                contentType: 'application/json',
                async: false,
                data: JSON.stringify({ "email": EMAIL }),
                success: function (data) {
                    $('#registeredStudentForBlockTable').dataTable({
                        data: JSON.parse(data.d),
                        columns: [
                            { 'data': 'ID' },
                            { 'data': 'firstName' },
                            { 'data': 'email' },
                        ],
                        bPaginate: false,
                        bInfo: false
                    });
                }
            });
        });

        function UpdateTeacherProfile() {

            var userName = $('#userName').val();
            var firstName = $('#firstName').val();
            var lastName = $('#lastName').val();
            var address = $('#address').val();
            var email = $('#inputEmail').val();
            var contactNumber = $('#contactNumber').val();
            var reference = getUrlVars()["email"];
            $.ajax({
                type: "post",
                url: "Teacher_Page.aspx/UpdateStudentProfile",
                async: false,
                data: JSON.stringify({ "reference": reference, "userName": userName, "firstName": firstName, "lastName": lastName, "address": address, "email": email, "contactNumber": contactNumber }),
                contentType: 'application/json',
                dataType: 'json',
                success: function (data) {

                    if (data.d == false) 
                        alert("Cannot update");

                    else if (data.d == true)
                        alert("Profile Updated");

                },
                error: function () {
                    alert("Failure");
                }
            })
        }

        function getUrlVars() {

            var vars = [], hash;
            var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');

            for (var i = 0; i < hashes.length; i++) {

                hash = hashes[i].split('=');
                vars.push(hash[0]);
                vars[hash[0]] = hash[1];
            }

            return vars;
        }

        function EditCourse() {
            var selection = document.getElementById('displayCoursesId');
            var selectedCourse = selection.options[selection.selectedIndex].innerHTML;

            var courseName = $('#courseName').val();
            var creditHours = $('#creditHours').val();

            $.ajax({
                url: 'Teacher_Page.aspx/EditCourse',
                method: 'post',
                dataType: 'json',
                contentType: 'application/json',
                async: false,
                data: JSON.stringify({ "course": selectedCourse, "courseName": courseName, "creditHours": creditHours }),
                success: function (data) {

                },
                error: function () {
                    alert("failure");
                }
            })
        }

        function UploadAssignmentScore() {
            var EMAIL = getUrlVars()["email"];

            $.ajax({
                url: 'Student_Page.aspx/DisplayRegisteredCourses',
                method: 'post',
                dataType: 'json',
                contentType: 'application/json',
                async: false,
                data: JSON.stringify({ "email": EMAIL }),
                success: function (data) {

                    var good = JSON.parse(data.d);

                    for (var course = 0; course < good.length; course++) 
                        $('#displayCoursesIdForScore').append(new Option(good[course], course));
                }
            });


        }

        function ShowCoursesForVideoUpload() {
            var EMAIL = getUrlVars()["email"];

            $.ajax({
                url: 'Student_Page.aspx/DisplayRegisteredCourses',
                method: 'post',
                dataType: 'json',
                contentType: 'application/json',
                async: false,
                data: JSON.stringify({ "email": EMAIL }),
                success: function (data) {

                    var good = JSON.parse(data.d);

                    for (var course = 0; course < good.length; course++)
                        $('#displayCoursesIdForVideo').append(new Option(good[course], course));
                }
            });
        }

        function UploadVideo() {
            var EMAIL = getUrlVars()["email"];

            var videoCourseSelection = document.getElementById('displayCoursesIdForVideo');
            var course = videoCourseSelection.options[videoCourseSelection.selectedIndex].innerHTML;

            var link = document.getElementById('videoLink').value;
            var videoName = document.getElementById('videoName').value;

            $.ajax({
                url: 'Teacher_Page.aspx/TeacherUploadVideo',
                method: 'post',
                dataType: 'json',
                contentType: 'application/json',
                async: false,
                data: JSON.stringify({ "email": EMAIL, "course": course, "link": link, "name": videoName }),
                success: function (data) {
                }
            });
        }

        function ShowAssignmentDiv() {
            var EMAIL = getUrlVars()["email"];

            var assignmentCourseSelection = document.getElementById('displayCoursesIdForScore');
            var course = assignmentCourseSelection.options[assignmentCourseSelection.selectedIndex].innerHTML;
            $.ajax({
                url: 'Teacher_Page.aspx/ShowAssignments',
                method: 'post',
                dataType: 'json',
                contentType: 'application/json',
                async: false,
                data: JSON.stringify({ "email": EMAIL, "course": course }),
                success: function (data) {

                    var good = JSON.parse(data.d);

                    for (var assignment = 0; assignment < good.length; assignment++) 
                        $('#assignments').append(new Option(good[assignment], assignment));
                }
            });

            $('#assignmentDiv').show();
        }

        function Upload() {
            var EMAIL = getUrlVars()["email"];

            var assignmentCourseSelection = document.getElementById('displayCoursesIdForScore');
            var course = assignmentCourseSelection.options[assignmentCourseSelection.selectedIndex].innerHTML;

            var score = document.getElementById('assignmentScore').value;

            $.ajax({
                url: 'Teacher_Page.aspx/UploadAssignmentScore',
                method: 'post',
                dataType: 'json',
                contentType: 'application/json',
                async: false,
                data: JSON.stringify({ "email": EMAIL, "score": score, "course": course }),
                success: function (data) {

                }

            });
            $('#assignmentDiv').hide();
        }

        function Send() {
            var reference = getUrlVars()["email"];
            var email = $('#emailID').val();
            var message = $('#messageID').val();
            $.ajax({
                url: 'Teacher_Page.aspx/sendMessage',
                method: 'post',
                dataType: 'json',
                contentType: 'application/json',
                async: false,
                data: JSON.stringify({ "email": email, "reference": reference, "message": message }),
                success: function (data) {

                }
            });
        }

        function Block() {
            var student = $('#blockID').val();
            var teacher = getUrlVars()["email"];
            $.ajax({
                url: 'Teacher_Page.aspx/TeacherBlockStudent',
                method: 'post',
                dataType: 'json',
                contentType: 'application/json',
                async: false,
                data: JSON.stringify({ "student": student, "teacher": teacher }),
                success: function (data) {

                }
            });
        }



    </script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-0 shadow">
            <h1 class="navbar-brand col-md-3 col-lg-2 mr-0 px-3">Welcome Teacher!</h1>
            <button class="navbar-toggler position-absolute d-md-none collapsed" type="button" data-toggle="collapse" data-target="#sidebarMenu" aria-controls="sidebarMenu" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <ul class="navbar-nav px-3">
                <li class="nav-item text-nowrap">
                    <%--<a class="nav-link" href="Login_Page.aspx">Sign out</a>--%>
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
                                <a class="nav-link active" href="#">
                                    <span data-feather="home"></span>
                                    Teacher <span class="sr-only">(current)</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" data-toggle="modal" data-target="#myModal">
                                    <span data-feather="file"></span>
                                    Update profile
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" data-toggle="modal" data-target="#editCourseModal">
                                    <span data-feather="shopping-cart"></span>
                                    Edit Course
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" data-toggle="modal" data-target="#sendMessageModal">
                                    <span data-feather="users"></span>
                                    Send Message
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" onclick="UploadAssignmentScore()" data-toggle="modal" data-target="#uploadAssignmentScoreModal">
                                    <span data-feather="bar-chart-2"></span>
                                    Upload assignment score
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" onclick="UploadAssignmentScore()" data-toggle="modal" data-target="#blockingModal">
                                    <span data-feather="bar-chart-2"></span>
                                    Block Student
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" onclick="ShowCoursesForVideoUpload()" data-toggle="modal" data-target="#uploadVideoModal">
                                    <span data-feather="bar-chart-2"></span>
                                    Upload Video Link
                                </a>
                            </li>
                        </ul>

                    </div>
                </nav>


                <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
                    <div class="table-responsive">
                        <table id="teacherDataTable">
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
                    </div>
                    <div>
                        <br />
                        <div>
                            <h3>Messages</h3>
                        </div>
                        <div>
                            <textarea rows="4" cols="50" id="message" name="message"></textarea>
                        </div>
                    </div>
                    <!----------------------------------MODAL FOR UPDATE PROFILE---------------------------------------------->
                    <div class="container">
                        <!-- The Modal -->
                        <div class="modal" id="myModal">
                            <div class="modal-dialog">
                                <div class="modal-content">

                                    <!-- Modal Header -->
                                    <div class="modal-header">
                                        <h4 class="modal-title">Profile</h4>
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    </div>
                                    <!-- Modal body -->
                                    <div class="modal-body">

                                        <table>
                                            <tr>
                                                <td>
                                                    <label>Email address</label></td>
                                                <td>
                                                    <input type="email" id="inputEmail" class="form-control" placeholder="Email address" required autofocus /></td>
                                            </tr>
                                            <tr>

                                                <td>
                                                    <label>First Name</label></td>
                                                <td>
                                                    <input type="text" id="firstName" class="form-control" placeholder="First Name" required /></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>Last Name</label>
                                                </td>
                                                <td>
                                                    <input type="text" id="lastName" class="form-control" placeholder="Last Name" required /></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>Phone Number</label></td>
                                                <td>
                                                    <input type="tel" id="contactNumber" class="form-control" placeholder=" Phone number in format: 332-4323914" pattern="[0-9]{3}-[0-9]{7}" required />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>Address</label></td>
                                                <td>
                                                    <input type="text" id="address" class="form-control" placeholder="Address" required />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>Username</label></td>
                                                <td>
                                                    <input type="text" id="userName" class="form-control" placeholder="UserName" required />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>

                                    <!-- Modal footer -->
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-danger" onclick="Validation()" data-dismiss="modal">Update</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <!-------------------------------------------------------------------------------------------------------->

                    <!-- -------------------------------MODAL FOR EDIT COURSE------------------------------------------------->
                    <div class="container">
                        <!-- The Modal -->
                        <div class="modal" id="editCourseModal">
                            <div class="modal-dialog">
                                <div class="modal-content">

                                    <!-- Modal Header -->
                                    <div class="modal-header">
                                        <h4 class="modal-title">Courses</h4>
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    </div>

                                    <!-- Modal body -->
                                    <div class="modal-body">

                                        <select name="DisplayCourses" id="displayCoursesId"></select>

                                    </div>

                                    <div>
                                        <table>
                                            <tr>

                                                <td>
                                                    <label>Course Name</label>

                                                </td>
                                                <td>
                                                    <input type="text" id="courseName" class="form-control" placeholder="Course Name" required />

                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>Credit Hours</label>
                                                </td>
                                                <td>
                                                    <input type="number" id="creditHours" class="form-control" placeholder="Credit Hours" required />
                                                </td>
                                            </tr>

                                        </table>
                                    </div>

                                    <!-- Modal footer -->
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="EditCourse()">Update</button>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                    <!-------------------------------------------------------------------------------------------------------->

                    <!-- -------------------------------MODAL FOR UPLOAD ASSIGNMENT SCORE------------------------------------->
                    <div class="container">
                        <!-- The Modal -->
                        <div class="modal" id="uploadAssignmentScoreModal">
                            <div class="modal-dialog" style="width: 500px">
                                <div class="modal-content">

                                    <!-- Modal Header -->
                                    <div class="modal-header">
                                        <h4 class="modal-title">Upload Score</h4>
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    </div>

                                    <!-- Modal body -->
                                    <div class="modal-body">
                                        <table>
                                            <tr>
                                                <td>
                                                    <label>Select Course: </label>
                                                    <select name="DisplayCourses" id="displayCoursesIdForScore"></select>
                                                </td>
                                                <td>
                                                    <button type="button" class="btn btn-primary" onclick="ShowAssignmentDiv()">Select</button>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>

                                    <div id="assignmentDiv">
                                        <table>
                                            <tr>
                                                <th>Assignments
                                                </th>
                                                <td>
                                                    <select name="assignments" id="assignments"></select>

                                                </td>
                                                <th>Score
                                                </th>
                                                <td>
                                                    <asp:TextBox ID="assignmentScore" runat="server" Style="width: 50px"></asp:TextBox>
                                                </td>
                                            </tr>

                                        </table>
                                    </div>

                                    <!-- Modal footer -->
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="Upload()">Upload</button>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                    <!-------------------------------------------------------------------------------------------------------->

                    <!-- -------------------------------MODAL FOR SENDING MESSAGE TO STUDENT---------------------------------->
                    <div class="container">
                        <!-- The Modal -->
                        <div class="modal" id="sendMessageModal">
                            <div class="modal-dialog" style="width: auto">
                                <div class="modal-content">

                                    <!-- Modal Header -->
                                    <div class="modal-header">
                                        <h4 class="modal-title">Send Message</h4>
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    </div>

                                    <!-- Modal body -->
                                    <div class="modal-body">
                                        <div class="table-responsive">
                                            <table id="registeredStudentTable">
                                                <thead>
                                                    <tr>
                                                        <th>School ID</th>
                                                        <th>First Name</th>
                                                        <th>Email</th>
                                                    </tr>
                                                </thead>
                                            </table>
                                        </div>
                                        <br />
                                        <div id="messageDiv">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <label>Email: </label>
                                                        <input type="text" id="emailID" style="width: 150px" />
                                                    </td>
                                                    <td>
                                                        <label>Message: </label>
                                                        <input type="text" id="messageID" style="width: 200px" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>

                                        <!-- Modal footer -->
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="Send()">Send</button>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-------------------------------------------------------------------------------------------------------->

                    <!-- -------------------------------MODAL FOR Blocking STUDENT-------------------------------------------->
                    <div class="container">
                        <!-- The Modal -->
                        <div class="modal" id="blockingModal">
                            <div class="modal-dialog" style="width: auto">
                                <div class="modal-content">

                                    <!-- Modal Header -->
                                    <div class="modal-header">
                                        <h4 class="modal-title">Block</h4>
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    </div>

                                    <!-- Modal body -->
                                    <div class="modal-body">
                                        <div class="table-responsive">
                                            <table id="registeredStudentForBlockTable">
                                                <thead>
                                                    <tr>
                                                        <th>School ID</th>
                                                        <th>First Name</th>
                                                        <th>Email</th>
                                                    </tr>
                                                </thead>
                                            </table>
                                        </div>
                                        <br />
                                        <div id="BlockDiv">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <label>Block Student: </label>
                                                    </td>
                                                    <td>
                                                        <input type="text" id="blockID" style="width: 150px" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>

                                        <!-- Modal footer -->
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="Block()">Block</button>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-------------------------------------------------------------------------------------------------------->

                    <!----------------------------------MODAL FOR UPLOAD VIDEOS----------------------------------------------->
                    <div class="container">
                        <!-- The Modal -->
                        <div class="modal" id="uploadVideoModal">
                            <div class="modal-dialog" style="width: 500px">
                                <div class="modal-content">

                                    <!-- Modal Header -->
                                    <div class="modal-header">
                                        <h4 class="modal-title">Upload Video Link</h4>
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    </div>

                                    <!-- Modal body -->
                                    <div class="modal-body">
                                        <table>
                                            <tr>
                                                <td>
                                                    <label>Select Course: </label>
                                                    <select name="DisplayCourses" id="displayCoursesIdForVideo"></select>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>

                                    <div>
                                        <table>
                                            <tr>
                                                <td>
                                                    <label>Paste Link: </label>
                                                    <asp:TextBox ID="videoLink" runat="server" Style="width: 300px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>Video Name: </label>
                                                    <asp:TextBox ID="videoName" runat="server" Style="width: 300px"></asp:TextBox>
                                                </td>
                                            </tr>

                                        </table>
                                    </div>

                                    <!-- Modal footer -->
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="UploadVideo()">Upload</button>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                    <!-------------------------------------------------------------------------------------------------------->
                </main>
            </div>
        </div>
    </form>
</body>
</html>

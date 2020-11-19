﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Student_Page.aspx.cs" Inherits="CureUniveristy.Student_Page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="Scripts/jquery-3.3.1.js"></script>
    <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.22/css/jquery.dataTables.min.css" />
    <script type="text/javascript" src="//cdn.datatables.net/1.10.22/js/jquery.dataTables.min.js"></script>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

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
            UpdateStudentProfile();
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
            if (exp.test(emailAddress.value)) {
                return "";
            }
            else {
                return "Email address typed is not in the correct format!\n";
            }
        }

        function UpdateStudentProfile() {

            var userName = $('#userName').val();
            var firstName = $('#firstName').val();
            var lastName = $('#lastName').val();
            var address = $('#address').val();
            var email = $('#inputEmail').val();
            var contactNumber = $('#contactNumber').val();
            var reference = getUrlVars()["email"];
            $.ajax({
                type: "post",
                url: "Student_Page.aspx/UpdateStudentProfile",
                async: false,
                data: JSON.stringify({ "reference": reference, "userName": userName, "firstName": firstName, "lastName": lastName, "address": address, "email": email, "contactNumber": contactNumber }),
                contentType: 'application/json',
                dataType: 'json',
                success: function (data) {
                    if (data.d == false) {


                        alert("Cannot update");

                    }
                    else if (data.d == true)
                        alert("Profile Updated");

                },
                error: function () {
                    alert("Failure");
                }
            })
        }

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
            PageReady(); 
        });

        function PageReady() {
            $("#displayTeachers").hide();
            $("#uploadAssignment").hide();
            
            var EMAIL = getUrlVars()["email"];
            $.ajax({
                url: 'Student_Page.aspx/GetStudentByID',
                method: 'post',
                dataType: 'json',
                contentType: 'application/json',
                async: false,
                data: JSON.stringify({ "email": EMAIL }),
                success: function (data) {

                    $('#studentDataTable').dataTable({
                        data: JSON.parse(data.d),
                        columns: [
                            { 'data': 'ID' },
                            { 'data': 'firstName' },
                            { 'data': 'lastName' },
                            { 'data': 'address' },
                            { 'data': 'email' },
                            { 'data': 'contactNumber' }
                        ]
                    });
                }

            });
            $.ajax({
                url: 'Student_Page.aspx/DisplayCourses',
                method: 'post',
                dataType: 'json',
                contentType: 'application/json',
                async: false,
                success: function (data) {

                    var good = JSON.parse(data.d);

                    for (var course = 0; course < good.length; course++) {

                        $('#displayCoursesId').append(new Option(good[course], course));

                    }
                }
            });


            $.ajax({
                url: 'Student_Page.aspx/GetStudnetCreditHours',
                method: 'post',
                dataType: 'json',
                contentType: 'application/json',
                async: false,
                data: JSON.stringify({ "email": EMAIL }),
                success: function (data) {
                    document.getElementById("noOfCreditsRegistered").value = data.d;
                }
            });
            
        }

        function displaysuccess() {
            alert("You have been Registered successfully");
        }

        function readData() {

            var selection = document.getElementById('displayCoursesId');

            var selectedCourse = selection.options[selection.selectedIndex].innerHTML;

            var credits = selectedCourse.match(/(\d+)/);

            var courseName = selectedCourse.split(" ", 1).toString();

            var EMAIL = getUrlVars()["email"];

            if (credits) {
                if (document.getElementById("noOfCreditsRegistered").value != "") {

                    document.getElementById("noOfCreditsRegistered").value = parseInt(document.getElementById("noOfCreditsRegistered").value) + parseInt(credits[0]);
                    if (parseInt(document.getElementById("noOfCreditsRegistered").value) < 6) {

                        $.ajax({
                            url: 'Student_Page.aspx/StudentRegisterCourse',
                            method: 'post',
                            dataType: 'json',
                            contentType: 'application/json',
                            async: false,
                            data: JSON.stringify({ "email": EMAIL, "course": courseName }),
                            success: function (data) {
                                if (data.d == false) {

                                    alert("Already Registered in this Course");

                                }
                                else if (data.d == true) {

                                    $("#displayTeachers").show();

                                }

                            },
                            error: function () {
                                alert("Failure");
                            }
                        })

                    }
                    else
                        alert("You cannot register another course")
                    document.getElementById("noOfCreditsRegistered").value = parseInt(document.getElementById("noOfCreditsRegistered").value) - parseInt(credits[0]);
                }

                else {
                    document.getElementById("noOfCreditsRegistered").value = 0 + parseInt(credits[0]);
                    $.ajax({
                        url: 'Student_Page.aspx/StudentRegisterCourse',
                        method: 'post',
                        dataType: 'json',
                        contentType: 'application/json',
                        async: false,
                        data: JSON.stringify({ "email": EMAIL, "course": courseName }),
                        success: function (data) {
                            if (data.d == false) {


                                alert("Already Registered in this Course");

                            }
                            else if (data.d == true) {

                                $("#displayTeachers").show();

                            }

                        },
                        error: function () {
                            alert("Failure");
                        }
                    })

                }
            }

            $.ajax({
                url: 'Student_Page.aspx/DisplayTeacherToStudent',
                method: 'post',
                dataType: 'json',
                contentType: 'application/json',
                async: false,
                data: JSON.stringify({ "courseName": courseName }),
                success: function (data) {

                    var good = JSON.parse(data.d);

                    for (var teacher = 0; teacher < good.length; teacher++) {

                        $('#displayTeachers').append(new Option(good[teacher], teacher));

                    }
                }
            });
        }

        function displayquiz() {
            alert("Hurray! No quiz uploaded yet");
        }

        function displayUploadAssignment() {
            $("#uploadAssignment").show();
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

                    for (var registeredCourse = 0; registeredCourse < good.length; registeredCourse++) {

                        $('#displayRegisteredCoursesId').append(new Option(good[registeredCourse], registeredCourse));

                    }

                }
            });
            document.getElementById("test2").value = EMAIL;
            var e = document.getElementById('displayRegisteredCoursesId');
            document.getElementById("test").value = e.options[e.selectedIndex].innerHTML;
            //document.getElementById("test").value = document.getElementById("displayRegisteredCoursesId").options.selectedItem.text;
            //document.getElementById("test").value = document.getElementById("displayRegisteredCoursesId").selectedIndex[0].value;
            
        }


    </script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">

        <div>
            <h1>Welcome Student!</h1>
        </div>

        <div style="margin: auto">
            <table id="studentDataTable">
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

            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
                Update Profile
            </button>
        </div>

        <label>Number of credits registered: </label>
        <asp:TextBox ID="noOfCreditsRegistered" runat="server">No Of credits registered</asp:TextBox>

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
                                        <input type="email" id="inputEmail" class="form-control" placeholder="Email address" /></td>
                                </tr>

                                <tr>

                                    <td>
                                        <label>First Name</label></td>
                                    <td>
                                        <input type="text" id="firstName" class="form-control" placeholder="First Name" /></td>
                                </tr>
                                <tr>
                                    <td>
                                        <label>Last Name</label>
                                    </td>
                                    <td>
                                        <input type="text" id="lastName" class="form-control" placeholder="Last Name" /></td>
                                </tr>
                                <tr>
                                    <td>
                                        <label>Phone Number</label></td>
                                    <td>
                                        <input type="tel" id="contactNumber" class="form-control" placeholder=" Phone number in format: 332-4323914" pattern="[0-9]{3}-[0-9]{7}" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label>Address</label></td>
                                    <td>
                                        <input type="text" id="address" class="form-control" placeholder="Address" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label>Username</label></td>
                                    <td>
                                        <input type="text" id="userName" class="form-control" placeholder="UserName" />
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



        <div>
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#courseModal">
                Register Course
            </button>
        </div>
        <div id="displayTeachers">
            <div>
                <br />
                <select name="displayTeachers"></select>
            </div>
            <div>
                <button type="button" class="btn btn-primary" id="chooseTeacher" onclick="displaysuccess()">Choose Teacher</button>
            </div>
        </div>
        <div>
            <br />
            <button type="button" class="btn btn-primary" id="takeQuiz" onclick="displayquiz()">Take Quiz</button>
            <br />
            <br />
            <br />
        </div>

        <div class="container">
            <!-- The Modal -->
            <div class="modal" id="courseModal">
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

                        <!-- Modal footer -->
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="readData()">Register</button>
                        </div>

                    </div>
                </div>
            </div>

        </div>
        <div>
            <button type="button" class="btn btn-primary" onclick="displayUploadAssignment()">
                Upload Assignment
            </button>
        </div>

        <div id="uploadAssignment">

            <select name="DisplayRegisteredCourses" id="displayRegisteredCoursesId"></select>
            <input type="hidden" id="test" name="Test"/>
            <input type="hidden" id="test2" name="Test2"/>
            <br />
            <asp:FileUpload ID="FileUpload1" runat="server" />
            <asp:Button runat="server" ID="UploadButton" Text="Upload" OnClick="UploadButton_Click"/>
            <br />
            <br />
            <asp:Label runat="server" ID="StatusLabel" Text="Upload status: " />
        </div>

    </form>

</body>
</html>

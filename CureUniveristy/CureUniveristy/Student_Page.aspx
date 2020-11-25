<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Student_Page.aspx.cs" Inherits="CureUniveristy.Student_Page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <link rel="canonical" href="https://getbootstrap.com/docs/4.5/examples/dashboard/" />

    <!-- Bootstrap core CSS -->
    <link href="dashboard.css" rel="stylesheet" />

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
    </style>



    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="Scripts/jquery-3.3.1.js"></script>
    <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.22/css/jquery.dataTables.min.css" />
    <script type="text/javascript" src="//cdn.datatables.net/1.10.22/js/jquery.dataTables.min.js"></script>
    <!--Bootsrap 4 CDN-->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous" />
    <!--Fontawesome CDN-->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous" />

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
            $("#displayTeacher").hide();

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
                        ],
                        searching: false,
                        bPaginate: false,
                        bInfo: false
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



        }

        function displaysuccess() {
            alert("You have been Registered successfully");

            var selection = document.getElementById('displayCoursesId');

            var selectedCourse = selection.options[selection.selectedIndex].innerHTML;

            var courseName = selectedCourse.split(" ", 1).toString();

            var EMAIL = getUrlVars()["email"];

            var modeSelection = document.getElementById('displayModeOfStudy');

            var mode = modeSelection.options[modeSelection.selectedIndex].innerHTML;

            var teacherSelection = document.getElementById('displayTeachers');

            var name = teacherSelection.options[teacherSelection.selectedIndex].innerHTML;

            $.ajax({
                url: 'Student_Page.aspx/ModeOfStudy',
                method: 'post',
                dataType: 'json',
                contentType: 'application/json',
                async: false,
                data: JSON.stringify({ "email": EMAIL, "course": courseName, "mode": mode }),
                success: function (data) {

                }

            });

            $.ajax({
                url: 'Student_Page.aspx/ChooseTeacher',
                method: 'post',
                dataType: 'json',
                contentType: 'application/json',
                async: false,
                data: JSON.stringify({ "email": EMAIL, "name": name }),
                success: function (data) {

                }

            });

            $("#displayTeacher").hide();
        }

        function readData() {

            var selection = document.getElementById('displayCoursesId');

            var selectedCourse = selection.options[selection.selectedIndex].innerHTML;

            var credits = selectedCourse.match(/(\d+)/);

            var courseName = selectedCourse.split(" ", 1).toString();

            var EMAIL = getUrlVars()["email"];

            if (credits) {
                if (document.getElementById("noOfCreditsRegistered").value != "") {

                    if (parseInt(document.getElementById("noOfCreditsRegistered").value) < 6) {
                        document.getElementById("noOfCreditsRegistered").value = parseInt(document.getElementById("noOfCreditsRegistered").value) + parseInt(credits[0]);

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
                                    document.getElementById("noOfCreditsRegistered").value = parseInt(document.getElementById("noOfCreditsRegistered").value) - parseInt(credits[0]);
                                }
                                else if (data.d == true) {

                                    $("#displayTeacher").show();

                                }

                            },
                            error: function () {
                                alert("Failure");
                            }
                        })

                    }
                    else
                        alert("You cannot register another course")

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

                                $("#displayTeacher").show();

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


        function displayUploadAssignment() {
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
            var e = document.getElementById('displayRegisteredCoursesId');

            document.getElementById("test").value = e.options[e.selectedIndex].innerHTML;

            document.getElementById("test2").value = EMAIL;


        }

        function displayUploadQuiz() {
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

                        $('#displayRegisteredCoursesQuizId').append(new Option(good[registeredCourse], registeredCourse));

                    }

                }
            });

            document.getElementById("test3").value = EMAIL;

            var e = document.getElementById('displayRegisteredCoursesQuizId');

            document.getElementById("test1").value = e.options[e.selectedIndex].innerHTML;

        }

        //var myIndex = 0;
        //carousel();

        //function carousel() {
        //    var i;
        //    var x = document.getElementsByClassName("mySlides");
        //    for (i = 0; i < x.length; i++) {
        //        x[i].style.display = "none";
        //    }
        //    myIndex++;
        //    if (myIndex > x.length) { myIndex = 1 }
        //    x[myIndex - 1].style.display = "block";
        //    setTimeout(carousel, 9000);
        //}

    </script>
    <title></title>
</head>
<body <%--class="w3-content w3-section"--%>>

<%--    <img class="mySlides w3-animate-fading" src="images/1.jpg" style="width:100%"/>
    <img class="mySlides w3-animate-fading" src="images/2.jpg"style="width:100%"/>
    <img class="mySlides w3-animate-fading" src="images/3.jpg"style="width:100%"/>
    <img class="mySlides w3-animate-fading" src="images/4.jpg"style="width:100%"/>--%>
    
    <form id="form1" runat="server">
        <nav class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-0 shadow">
            <h1 class="navbar-brand col-md-3 col-lg-2 mr-0 px-3">Welcome Student!</h1>
            <button class="navbar-toggler position-absolute d-md-none collapsed" type="button" data-toggle="collapse" data-target="#sidebarMenu" aria-controls="sidebarMenu" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <ul class="navbar-nav px-3">
                <li class="nav-item text-nowrap">
                    <a class="nav-link" href="Login_Page.aspx">Sign out</a>
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
                                    Student <span class="sr-only">(current)</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" data-toggle="modal" data-target="#myModal">
                                    <span data-feather="file"></span>
                                    Update profile
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" data-toggle="modal" data-target="#courseModal">
                                    <span data-feather="shopping-cart"></span>
                                    Register Course
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" onclick="displayUploadQuiz()" data-toggle="modal" data-target='#uploadQuizModal'>
                                    <span data-feather="users"></span>
                                    Take quiz
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" onclick="displayUploadAssignment()" data-toggle="modal" data-target="#uploadAssignmentModal">
                                    <span data-feather="bar-chart-2"></span>
                                    Submit assignment
                                </a>
                            </li>
                        </ul>

                    </div>
                </nav>


                <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
                    <div class="table-responsive">
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

                    </div>
                    <br />
                    <div>
                        <div>
                            <h3>Messages</h3>
                        </div>
                        <%--<input type="text" id="message" name="message" style="border: hidden" />--%>
                        <div>
                            <textarea rows="4" cols="50" id="message" name="message" <%--style="border: hidden"--%>></textarea>
                        </div>
                    </div>
                    <!--------------------------------------------------------MODAL TO UPDATE PROFILE------------------------------------------------->
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
                                                    <input type="tel" id="contactNumber" class="form-control" placeholder=" Phone number in format: 332-4323914" title="please enter numbers only" pattern="[0-9]{3}-[0-9]{7}" />
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
                    <!----------------------------------------------------------------------------------------------------------------------------------->
                    <!--------------------------------------------------------MODAL TO UPLOAD REGISTER COURSE-------------------------------------------->
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

                                        <label>Number of credits registered: </label>
                                        <asp:TextBox ID="noOfCreditsRegistered" runat="server">No Of credits registered</asp:TextBox>
                                        <select name="DisplayCourses" id="displayCoursesId"></select>

                                        <div id="displayTeacher">
                                            <br />
                                            <label>Choose Teacher and mode of study</label>
                                            <br />
                                            <div style="float: left">
                                                <label>Teacher: </label>
                                                <select name="teachers" id="displayTeachers"></select>
                                            </div>
                                            <div style="padding-left: 50%">
                                                <label>Mode: </label>
                                                <select name="modeOfStudy" id="displayModeOfStudy">
                                                    <option value="online">Online </option>
                                                    <option value="live">Live </option>
                                                </select>
                                            </div>

                                            <div>
                                                <button type="button" class="btn btn-primary" id="chooseTeacher" onclick="displaysuccess()" data-dismiss="modal">Choose Teacher</button>
                                            </div>
                                        </div>

                                    </div>

                                    <!-- Modal footer -->
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-danger" onclick="readData()">Register</button>
                                    </div>

                                </div>
                            </div>
                        </div>

                    </div>
                    <!----------------------------------------------------------------------------------------------------------------------------------->
                    <!--------------------------------------------------------MODAL TO UPLOAD ASSIGNMENT------------------------------------------------->
                    <div class="container">
                        <!-- The Modal -->
                        <div class="modal" id="uploadAssignmentModal">
                            <div class="modal-dialog">
                                <div class="modal-content">

                                    <!-- Modal Header -->
                                    <div class="modal-header">
                                        <h4 class="modal-title">Upload</h4>
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    </div>

                                    <!-- Modal body -->
                                    <div class="modal-body">
                                        <label>Select course: </label>
                                        <select name="DisplayRegisteredCourses" id="displayRegisteredCoursesId"></select>
                                        <input type="hidden" id="test" name="Test" />
                                        <input type="hidden" id="test2" name="Test2" />
                                        <br />
                                        <asp:FileUpload ID="FileUpload1" runat="server" />
                                    </div>

                                    <!-- Modal footer -->
                                    <div class="modal-footer">
                                        <asp:Button runat="server" ID="UploadButton" class="btn btn-danger" data-dismiss="modal" UseSubmitBehavior="false" Text="Upload" OnClick="UploadButton_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--------------------------------------------------------------------------------------------------------------------------------->
                    <!--------------------------------------------------------MODAL TO UPLOAD QUIZ----------------------------------------------------->

                    <div class="container">
                        <!-- The Modal -->
                        <div class="modal" id="uploadQuizModal">
                            <div class="modal-dialog">
                                <div class="modal-content">

                                    <!-- Modal Header -->
                                    <div class="modal-header">
                                        <h4 class="modal-title">Upload</h4>
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    </div>

                                    <!-- Modal body -->
                                    <div class="modal-body">
                                        <label>Select course: </label>
                                        <select name="DisplayRegisteredCourses" id="displayRegisteredCoursesQuizId"></select>
                                        <input type="hidden" id="test1" name="Test1" />
                                        <input type="hidden" id="test3" name="Test3" />
                                        <br />
                                        <asp:FileUpload ID="FileUpload2" runat="server" />
                                    </div>

                                    <!-- Modal footer -->
                                    <div class="modal-footer">
                                        <asp:Button runat="server" ID="Button1" class="btn btn-danger" data-dismiss="modal" UseSubmitBehavior="false" Text="Upload" OnClick="UploadButton_Click1" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--------------------------------------------------------------------------------------------------------------------------------->
                </main>
            </div>
        </div>
    </form>

</body>
</html>

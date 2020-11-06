<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Teacher_Page.aspx.cs" Inherits="CureUniveristy.Teacher_Page" %>

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
            if (exp.test(emailAddress.value)) {
                return "";
            }
            else {
                return "Email address typed is not in the correct format!\n";
            }
        }

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
            <h1>Welcome Teacher!</h1>
        </div>

        <div style="margin: auto">
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
            <br />
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
                Update Profile
            </button>
        </div>
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


    </form>
</body>
</html>

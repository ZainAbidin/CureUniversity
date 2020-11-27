<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Signup_Page.aspx.cs" Inherits="CureUniveristy.Signup_Page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SignUp Page· Cure University</title>
    <!--Bootsrap 4 CDN-->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous" />
    <!--Fontawesome CDN-->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous" />

    <link href="Signup_Page.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="Scripts/jquery-3.3.1.js"></script>
    <script src="Scripts/jquery-3.3.1.min.js"></script>

    <style>

    </style>

    <script type="text/javascript">
        function Validation() {
            var errors = "";
            errors += CheckName();
            errors += CheckCnfPassword();
            errors += CheckUsername();
            errors += CheckEmailAddress();
            if (errors != "") {
                alert(errors);
                return false;
            }
            register();
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

        function CheckCnfPassword() {
            var password = document.getElementById('inputPassword');
            var confirmpassword = document.getElementById('confirmPassword');
            if (password.value == confirmpassword.value) {
                return "";
            }
            else {
                return "Password and Confirm Password does not Match!!\n";
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

        function register() {

            var userName = $('#userName').val();
            var confirmPassword = $('#confirmPassword').val();
            var firstName = $('#firstName').val();
            var lastName = $('#lastName').val();
            var address = $('#address').val();
            var schoolId = $('#schoolId').val();
            var email = $('#inputEmail').val();
            var contactNumber = $('#contactNumber').val();
            $.ajax({
                type: "post",
                url: "SignUp_Page.aspx/SignUp",
                async: false,
                data: JSON.stringify({ "userName": userName, "password": confirmPassword, "firstName": firstName, "lastName": lastName, "address": address, "email": email, "schoolId": schoolId, "contactNumber": contactNumber }),
                contentType: 'application/json',
                dataType: 'json',
                success: function (data) {
                    if (data.d == false) {


                        alert("User Already registered");

                    }
                    else if (data.d == true)
                        alert("User Registered");

                },
                error: function () {
                    alert("Failure");
                }
            })
        }




    </script>

</head>
<body>
    <div class="container" style="float: left">
        <div class="d-flex justify-content-center h-auto">
            <div class="card h-auto">
                <div class="card-header">
                    <h3>Sign Up</h3>
                </div>
                <div class="card-body">
                    <form>

                        <label for="inputEmail" id="colour">Email address</label>
                        <input type="email" id="inputEmail" class="form-control" placeholder="Email address" required autofocus />

                        <label for="fname" id="colour">First Name</label>
                        <input type="text" id="firstName" class="form-control" placeholder="First Name" required />

                        <label for="lname" id="colour">Last Name</label>
                        <input type="text" id="lastName" class="form-control" placeholder="Last Name" required />


                        <label for="phone" id="colour">Phone Number</label>
                        <input type="tel" id="contactNumber" class="form-control" placeholder=" Phone number in format: 332-4323914" pattern="[0-9]{3}-[0-9]{7}" required />


                        <label for="quantity" id="colour">School ID</label>
                        <input type="number" id="schoolId" class="form-control" placeholder="School ID" name="quantity" min="1000" max="3999" required />


                        <label for="address" id="colour">Address</label>
                        <input type="text" id="address" class="form-control" placeholder="Address" required />


                        <label for="username" id="colour">Username</label>
                        <input type="text" id="userName" class="form-control" placeholder="UserName" required />


                        <label for="inputPassword" id="colour">Password</label>
                        <input type="password" id="inputPassword" class="form-control" placeholder="Password" required />

                        <label for="confirmPassword" id="colour">Confirm Password</label>
                        <input type="password" id="confirmPassword" class="form-control" placeholder="Confirm Password" required />
                        <br />

                        <button class="btn btn-lg btn-primary btn-block" id="btnSignUp" onclick="Validation()" type="submit">Sign UP</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>

</html>

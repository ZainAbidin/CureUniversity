<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Signup_Page.aspx.cs" Inherits="CureUniveristy.Signup_Page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors" />
    <meta name="generator" content="Jekyll v4.1.1" />
    <title>SignUp Page· Cure University</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://getbootstrap.com/docs/4.5/examples/sign-in/" />
    <link href="Signup_Page.css" rel="stylesheet" type="text/css" />


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

    <link href="Signup_Page.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="Scripts/jquery-3.3.1.js"></script>
    <script src="Scripts/jquery-3.3.1.min.js"></script>

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
                    if (data.d == 0) {


                        alert("User Already registered");

                    }
                    else if (data.d == 1)
                        alert("User Registered");

                },
                error: function () {
                    alert("Failure");
                }
            })
        }




    </script>

</head>
<body class="text-center">
    <div style="width: 50%">
        <form class="form-signin">
            <h1 class="h3 mb-9 font-weight-normal">Sign Up</h1>

            <label for="inputEmail" class="sr-only">Email address</label>
            <input type="email" id="inputEmail" class="form-control" placeholder="Email address" required autofocus />

            <label for="fname" class="sr-only">First Name</label>
            <input type="text" id="firstName" class="form-control" placeholder="First Name" required />

            <label for="lname" class="sr-only">Last Name</label>
            <input type="text" id="lastName" class="form-control" placeholder="Last Name" required />


            <label for="phone" class="sr-only">Phone Number</label>
            <input type="tel" id="contactNumber" class="form-control" placeholder=" Phone number in format: 332-4323914" pattern="[0-9]{3}-[0-9]{7}" required />

            <label for="quantity" class="sr-only">School ID</label>
            <input type="number" id="schoolId" class="form-control" placeholder="School ID" name="quantity" min="1000" max="3999" required />

            <label for="address" class="sr-only">Address</label>
            <input type="text" id="address" class="form-control" placeholder="Address" required />


            <label for="username" class="sr-only">Username</label>
            <input type="text" id="userName" class="form-control" placeholder="UserName" required />

            <label for="inputPassword" class="sr-only">Password</label>
            <input type="password" id="inputPassword" class="form-control" placeholder="Password" required />

            <label for="confirmPassword" class="sr-only">Confirm Password</label>
            <input type="password" id="confirmPassword" class="form-control" placeholder="Confirm Password" required />

            <button class="btn btn-lg btn-primary btn-block" id="btnSignUp" onclick="Validation()" type="submit">Sign UP</button>
        </form>
    </div>
</body>

</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login_Page.aspx.cs" Inherits="CureUniveristy.Login_Page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors" />
    <meta name="generator" content="Jekyll v4.1.1" />
    <title>Login Page· Cure University</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://getbootstrap.com/docs/4.5/examples/sign-in/" />
    <link href="Login_Page.css" rel="stylesheet" type="text/css" />
    <link href="Login_Page.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="Scripts/jquery-3.3.1.js"></script>
    <script src="Scripts/jquery-3.3.1.min.js"></script>

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



    <script type="text/javascript">

        $(document).ready(function () {
            $("#btnSignin").click(function () {

                var email = $('#inputEmail').val();
                var password = $('#inputPassword').val();

                $.ajax({

                    type: "post",
                    url: "Login_Page.aspx/CheckCredentials",
                    async: false,
                    data: JSON.stringify({ "email": email, "password": password }),
                    contentType: 'application/json',
                    dataType: 'json',
                    success: function (data) {

                        if (data.d == 0) {

                            window.location.href = "Student_Page.aspx?email=" + email;

                        }
                        else if (data.d == 1) {

                            window.location.href = "Teacher_Page.aspx?email=" + email;
                        }
                        else if (data.d == 2) {
                            window.location.href = "Admin_Page.aspx?email=" + email;
                        }
                        else {
                            alert("Wrong credentials or user not registered yet!")
                        }
                    },
                    error: function () {
                        alert("Failure");
                    }
                })
            });
        });

        function redirect() {
            window.location.href = "Signup_Page.aspx";
            //window.location.href = "Student_Page.aspx?email=" + "zain@gmail.com";
            //window.location.href = "Teacher_Page.aspx?email=" + "abdul.majid@lhr.edu.pk";

        }

    </script>
</head>


<body class="text-center">
    <%--    <div style="float: left; width: 50%">
        <img src="images/cover.png" />
    </div>--%>
    <div style="width: 50%">
        <form class="form-signin">
            <h1 class="h3 mb-3 font-weight-normal">Please Login</h1>
            <label for="inputEmail" class="sr-only">Email address</label>
            <input type="email" id="inputEmail" class="form-control" placeholder="Email address" required autofocus />
            <label for="inputPassword" class="sr-only">Password</label>
            <input type="password" id="inputPassword" class="form-control" placeholder="Password" required />
            <button class="btn btn-lg btn-primary btn-block" id="btnSignin" type="submit">Login</button>

            <button class="btn btn-sm" id="btnSignUp" onclick="redirect()" type="submit">Sign up</button>
        </form>
    </div>
</body>
</html>

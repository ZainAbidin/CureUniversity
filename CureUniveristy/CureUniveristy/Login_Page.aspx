<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login_Page.aspx.cs" Inherits="CureUniveristy.Login_Page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <!--Bootsrap 4 CDN-->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous"/>
    <!--Fontawesome CDN-->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous" />

    <!--Custom styles-->
    <link href="Login_Page.css" rel="stylesheet" />
    <title></title>
    <script src="Scripts/jquery-3.3.1.js"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            $("#btnSignin").click(function () {

                var email = $('#inputEmail').val();
                var password = $('#inputPassword').val();

                $.ajax({

                    type: "post",
                    url: "Login_Page.aspx/CheckCredentials",
                    async: true,
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

    </script>
</head>
<body>
    <div class="container">
        <div class="d-flex justify-content-center h-100">
            <div class="card h-auto">
                <div class="card-header">
                    <h3>Sign In</h3>
                </div>
                <div class="card-body">
                    <form>
                        <div class="input-group form-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="fas fa-user"></i></span>
                            </div>
                            <input type="email" id="inputEmail" class="form-control" placeholder="email"/>
                        </div>
                        <div class="input-group form-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="fas fa-key"></i></span>
                            </div>
                            <input type="password" id="inputPassword" class="form-control" placeholder="password">
                        </div>
                        <div class="form-group">
                            <input type="submit" id="btnSignin" value="Login" class="btn float-right login_btn"/>
                        </div>
                    </form>
                </div>
                <div class="card-footer">
                    <div class="d-flex justify-content-center links">
                        Don't have an account?<a href="Signup_Page.aspx">Sign Up</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

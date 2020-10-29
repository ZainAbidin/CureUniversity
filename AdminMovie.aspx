<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminMovie.aspx.cs" Inherits="MovieSystem.AdminMovie" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <link href="chosen.min.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.22/css/jquery.dataTables.min.css" />
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous" />
    <script src="jquery-3.5.1.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="//cdn.datatables.net/1.10.22/js/jquery.dataTables.min.js"></script>
    <script src="chosen.jquery.js"></script>
    <script src="chosen.proto.js"></script>
    <%--<script src="jquery-3.5.1.js"></script>--%>
    <title>Admin Movie Page</title>
    <script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                url: 'AdminMovie.aspx/getlist',
                method: 'post',
                dataType: 'json',
                contentType: 'application/json',
                success: function (data) {
                    $('#movieTable').DataTable({
                        searching: false,
                        order: [[3, "desc"]],
                        data: JSON.parse(data.d),
                        columns: [
                            {
                                'data': 'movieID',
                                'className': "dt-center",
                            },
                            { 'data': 'movieName' },
                            {
                                'data': 'movieRating',
                                'className': "dt-center",
                            },
                            {
                                'data': 'movieRelease',
                                'className': "dt-center",
                                'render': function (data, type, row) {

                                    var date = new Date(parseInt(data.substr(6)));
                                    var month = date.getMonth() + 1;
                                    return date.getFullYear() + "-" + month + "-" + date.getDate();
                                }
                            },
                            {
                                'data': 'movieCost',
                                'render': function (data, type, row) {
                                    return "$" + data
                                }
                            },
                            {
                                'data': 'movieSale',
                                'render': function (data, type, row) {
                                    return "$" + data
                                }
                            },
                            { 'data': 'genre' },
                            { 'data': 'description' },
                            {
                                'data': 'movieID',
                                'render': function (data, type, row) {
                                    return '<button type="button" class="btn btn-primary" id="editMovie" onclick="editRow(' + data + ')"><i class="fas fa-pencil"></i></button>&nbsp;&nbsp;<button type="button" class="btn btn-danger" id="deleteMovie" onclick="deleteRow(' + data + ')"> <i class="fas fa-minus-circle"> </i> </button>'
                                },
                                'className': "dt-center",
                            },
                        ],
                    });
                }
            });
        });

        function deleteRow(data) {
            $(document).ready(function () {
                var mID = JSON.stringify({ "movieID": data });
                $.ajax({
                    url: 'AdminMovie.aspx/deleteMovie',
                    data: mID,
                    method: 'post',
                    dataType: 'json',
                    contentType: "application/json; charset=utf-8",
                    async: true,
                    success: function (data) {
                        alert('Movie deleted successfully!');
                        location.reload();
                    }
                });
            });
        };


        function editRow(data) {
            $('#editmoviemodal').on('show.bs.modal', function () {
                $.ajax({
                    url: 'AdminMovie.aspx/genreMultiSelect',
                    method: 'post',
                    dataType: 'json',
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        $('#modalmoviegenreedit').empty();
                        $.each(data.d, function (key, value) {
                            $('#modalmoviegenreedit').append($('<option></option>').val(value.genreID).html(value.genreType));
                        });
                    }
                });
            });

            $('#editmoviemodal').modal('show');

            $('#editmoviemodal').on('shown.bs.modal', function () {
                $(document).ready(function () {
                    $('#modalmoviegenreedit', this).chosen();
                });
            });


            var mID = JSON.stringify({ "movieID": data });
            $.ajax({
                url: 'AdminMovie.aspx/getEditMovie',
                data: mID,
                method: 'post',
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                async: true,
                success: function (data) {
                    $('#modalmovienameedit').val(data.d.movieName);
                    $("#modalmovieratingedit").val(data.d.movieRating);
                    var stDate = data.d.movieRelease;
                    var date = new Date(parseInt(stDate.substr(6)));
                    var month = date.getMonth() + 1;
                    var day = date.getDate();
                    if (day < 10) {
                        day = "0" + day;
                    }
                    if (month < 10) {
                        month = "0" + month
                    }
                    var releaseDate = date.getFullYear() + "-" + month + "-" + day;
                    $("#modalmoviereleaseedit").val(releaseDate);
                    $("#modalmoviecostedit").val(data.d.movieCost);
                    $("#modalmoviesaleedit").val(data.d.movieSale);
                    $("#modalmoviedescriptionedit").val(data.d.description);
                    $('#modalmoviegenreedit').val(data.d.genreID).trigger('chosen:updated');
                }
            });
            $('#editMovieBtn').click(function () {
                var genre = String($("#modalmoviegenreedit").chosen().val());
                var name = String($("#modalmovienameedit").val().trim());
                var rating = String($("#modalmovieratingedit").val());
                var release = String($("#modalmoviereleaseedit").val().trim());
                var cost = String($("#modalmoviecostedit").val().trim());
                var sale = String($("#modalmoviesaleedit").val().trim());
                var description = String($("#modalmoviedescriptionedit").val().trim());
                var movieData = JSON.stringify({
                    "movieID": data, "movieName": name, "movieGenre": genre, "movieRating": rating, "movieRelease": release,
                    "movieCost": cost, "movieSale": sale, "movieDescription": description
                });
                //alert(genre);
                $.ajax({
                    url: 'AdminMovie.aspx/EditMovie',
                    data: movieData,
                    method: 'post',
                    dataType: 'json',
                    contentType: "application/json; charset=utf-8",
                    async: true,
                    success: function (data) {
                        alert('Movie details updated successfully!');
                        $('#editmoviemodal').modal('hide');
                        location.reload();
                    }
                });
            });
        };


    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#AddMovieBtn').click(function () {
                $('#addmoviemodal').modal('show');
            });

            $('#addmoviemodal').on('show.bs.modal', function () {
                $.ajax({
                    url: 'AdminMovie.aspx/genreMultiSelect',
                    method: 'post',
                    dataType: 'json',
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        $('#modalmoviegenre').empty();
                        $.each(data.d, function (key, value) {
                            $('#modalmoviegenre').append($('<option></option>').val(value.genreID).html(value.genreType));
                        });
                    }
                });
            });
            $('#addmoviemodal').on('shown.bs.modal', function () {
                $(document).ready(function () {
                    $('#modalmoviegenre', this).chosen();
                });
            });
            $('#addmoviemodal').on('hidden.bs.modal', function () {
                $(this).find("input").val('').end();
                $('#modalmoviegenre').val('').trigger('chosen:updated');
            });
        });



        function addMovie() {
            var genre = String($("#modalmoviegenre").chosen().val());
            var name = String($("#modalmoviename").val().trim());
            var rating = String($("#modalmovierating").val().trim());
            var release = String($("#modalmovierelease").val().trim());
            var cost = String($("#modalmoviecost").val().trim());
            var sale = String($("#modalmoviesale").val().trim());
            var description = String($("#modalmoviedescription").val().trim());
            var data = JSON.stringify({
                "movieName": name, "movieGenre": genre, "movieRating": rating, "movieRelease": release,
                "movieCost": cost, "movieSale": sale, "movieDescription": description
            });
            $.ajax({
                url: 'AdminMovie.aspx/addMovie',
                method: 'post',
                data: data,
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                async: true,
                success: function (data) {
                    alert('Movie added successfully!');
                    $('#addmoviemodal').modal('hide');
                }
            });
        };
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="input-group">
            <input type="text" class="form-control" placeholder="Search" id="moviesearch" />
            <div class="input-group-append">
                <button class="btn btn-secondary" type="submit" id="moviesearchbtn" onclick="Search()"><i class="fas fa-search"></i></button>
            </div>
        </div>
        <div style="margin: auto">
            <table id="movieTable">
                <thead>
                    <tr>
                        <th>MovieID</th>
                        <th>Name</th>
                        <th>Rating</th>
                        <th>ReleaseDate</th>
                        <th>Cost</th>
                        <th>Sale</th>
                        <th>Genre</th>
                        <th>Description</th>
                        <th>Edit/Delete</th>
                    </tr>
                </thead>
                <tfoot>
                    <tr>
                        <th>MovieID</th>
                        <th>Name</th>
                        <th>Rating</th>
                        <th>ReleaseDate</th>
                        <th>Cost</th>
                        <th>Sale</th>
                        <th>Genre</th>
                        <th>Description</th>
                        <th>Edit/Delete</th>
                    </tr>
                </tfoot>
            </table>
            <br />
            &nbsp&nbsp
        </div>
        <%--</form>--%>
        <button class="btn btn-outline-success" id="AddMovieBtn">Add Movie &nbsp<i class="fas fa-plus"></i></button>
        <div class="modal fade" id="addmoviemodal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Add New Movie</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="form-group">
                                <label for="modalmoviename">Movie Name:</label>
                                <input class="form-control" placeholder="Movie Name" type="text" id="modalmoviename" required="" />
                            </div>
                            <div class="form-group">
                                <label for="modalmoviegenre chosen-select">Movie Genre:</label>
                                <select class="form-control" id="modalmoviegenre" multiple="" required=""></select>
                            </div>
                            <div class="form-group">
                                <label for="modalmovierating">Movie Rating:</label>
                                <select class="form-control" name="modalmovierating" id="modalmovierating" required="">
                                    <option value="" disabled selected>Select Rating</option>
                                    <option value="G">G</option>
                                    <option value="PG">PG</option>
                                    <option value="PG-13">PG-13</option>
                                    <option value="R">R</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="modalmovierelease">Release Date:</label>
                                <input class="form-control" type="date" placeholder="dd-mm-yyyy" id="modalmovierelease" required="" />
                            </div>
                            <div class="form-group">
                                <label for="modalmoviecost">Cost Price:</label>
                                <input class="form-control" placeholder="Cost Price" type="number" id="modalmoviecost" required="" />
                            </div>
                            <div class="form-group">
                                <label for="modalmoviesale">Sale Price:</label>
                                <input class="form-control" placeholder="Sale Price" type="number" id="modalmoviesale" required="" />
                            </div>
                            <div class="form-group">
                                <label for="modalmoviedescription">Movie Description:</label>
                                <textarea class="form-control" placeholder="Movie Description" id="modalmoviedescription" required=""></textarea>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-primary" onclick="addMovie()">Add</button>
                        <button class="btn btn-danger" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="editmoviemodal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Edit Movie Details</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="form-group">
                                <label for="modalmoviename">Movie Name:</label>
                                <input class="form-control" placeholder="Movie Name" type="text" id="modalmovienameedit" required="" />
                            </div>
                            <div class="form-group">
                                <label for="modalmoviegenre chosen-select">Movie Genre:</label>
                                <select class="form-control" id="modalmoviegenreedit" multiple="" required=""></select>
                            </div>
                            <div class="form-group">
                                <label for="modalmovierating">Movie Rating:</label>
                                <select class="form-control" name="modalmovierating" id="modalmovieratingedit" required="">
                                    <option value="" disabled selected>Select Rating</option>
                                    <option value="G">G</option>
                                    <option value="PG">PG</option>
                                    <option value="PG-13">PG-13</option>
                                    <option value="R">R</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="modalmovierelease">Release Date:</label>
                                <input class="form-control" type="date" placeholder="dd-mm-yyyy" id="modalmoviereleaseedit" required="" />
                            </div>
                            <div class="form-group">
                                <label for="modalmoviecost">Cost Price:</label>
                                <input class="form-control" placeholder="Cost Price" type="number" id="modalmoviecostedit" required="" />
                            </div>
                            <div class="form-group">
                                <label for="modalmoviesale">Sale Price:</label>
                                <input class="form-control" placeholder="Sale Price" type="number" id="modalmoviesaleedit" required="" />
                            </div>
                            <div class="form-group">
                                <label for="modalmoviedescription">Movie Description:</label>
                                <textarea class="form-control" placeholder="Movie Description" id="modalmoviedescriptionedit" required=""></textarea>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-primary" type="submit" id="editMovieBtn" <%--onclick="updateMovie()"--%>>Edit</button>
                        <button class="btn btn-danger" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>

<%@page import="com.tech.blog.dao.LikedDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entites.Category"%>
<%@page import="com.tech.blog.entites.Post"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entites.User"%>
<%@page errorPage="error_page.jsp" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login_page.jsp");
    }

%>


<%    int postId = Integer.parseInt(request.getParameter("post_id"));
    PostDao d = new PostDao(ConnectionProvider.getConnection());
    Post p = d.getPostById(postId);

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= p.getpTitle()%>||TechBlog </title>
        <!--css-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background{
                clip-path: polygon(36% 0, 66% 0, 100% 0, 100% 92%, 55% 100%, 26% 93%, 0 100%, 0 0);
            }
            .post-title{
                font-weight: 100;
                font-size: 30px;
                
            }
            .post-content{
                font-weight: 100;
                font-size: 25px;
            }
            .post-date{
                font-style: italic;
                font-weight: bold;
                
            }
            .post-user-info{
                font-size: 20px;
                font-weight: 300px;
            }
            .row-user{
                border: 1px solid #e2e2e2;
                padding-top: 15px;
            }
            body{
                background: url(img/bg-img.png);
                background-size: cover;
                background-attachment: fixed;
            }
        </style>
    </head>
    <body >
        <!--start of nav bar-->
        <nav class="navbar navbar-expand-lg navbar-dark primary-background">
            <a class="navbar-brand" href="index.jsp"><span class="fa fa-asterisk"></span> Tech Blog</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="profile.jsp"> <span class="fa fa-bell-o"></span> Profile <span class="sr-only">(current)</span></a>
                    </li>

                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class="	fa fa-calendar-check-o"></span>Categories
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="#">Programming Language</a>
                            <a class="dropdown-item" href="#">Project Implientation</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#">Data Structure</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><span class="fa fa-address-book-o"></span> Contact</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#add-post-modal" ><span class="fa fa-square fa-spin"></span> Do Post</a>
                    </li>




                </ul>
                <ul class="navbar-nav mr-right">
                    <li class="nav-item">
                        <a class="nav-link" href="#!" data-toggle="modal" data-target="#profile-modal"><span class="fa fa-user-circle"></span> <%= user.getName()%></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="LogoutServlet"><span class="	fa fa-sign-out"></span> Logout</a>
                    </li>
                </ul>
            </div>
        </nav>

        <!--end of navbar-->

        <!--main content of body-->


        <div class="container " >
            <div class="row my-4">
                <div class="col-md-8 offset-md-2">
                    <div class="card">

                        <div class="card-header primary-background text-white ">
                            <h4 class="post-title" ><%= p.getpTitle()%></h4>
                        </div>

                        <div class="card-body">
                            <img class="img-card-top my-2" src="BlogsPic/<%= p.getpPic() %> " alt="cCard Image Cap" style="width:690px;height:500px;">
                            <div class="row my-3 row-user">
                                <div class=" col-md-8">
                                    <% UserDao userDao= new UserDao(ConnectionProvider.getConnection());%>
                                    <p class="post-user-info"><a href="#"><%= userDao.getUserByUserId(p.getUserId()).getName() %></a> has posted :</p>
                                </div>
                                
                                <div class="col-md-4">
                                    <p class="post-date"><%= DateFormat.getDateTimeInstance().format(p.getpDate()) %></p>
                                </div>
                            </div>
                            
                            <p class="post-content"><%= p.getpContent()%></p>
                            <br>
                            <br>
                            <div class="post-code">
                                <pre><%= p.getpCode()%></pre>
                            </div> 
                        </div>
                            <%
                                LikedDao lDao=new LikedDao(ConnectionProvider.getConnection());
                            %>
                        <div class="card-footer primary-background ">

                            <a href="#!" onclick="doLike(<%= p.getPid() %>,<%= user.getId() %>,this)" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up" ></i><span class="like-counter"><%= lDao.countLikeOnPost(p.getPid()) %></span></a>
                            <a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o" ></i><span>20</span></a>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <!--end of main containt of body-->


        <!--profile modal starts-->


        <!-- Button trigger modal -->

        <!-- Modal -->
        <div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header primary-background text-center text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Tech Blog</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-center">

                            <img src="pics/<%= user.getProfile()%>" style="border-radius:50%; max-width: 150px;">
                            <br>
                            <h5 class="modal-title mt-3" id="exampleModalLabel"><%= user.getName()%></h5>


                            <!--data table-->
                            <div id="profile-detail">
                                <table class="table">

                                    <tbody>
                                        <tr>
                                            <th scope="row">ID</th>
                                            <td><%=user.getId()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Email</th>
                                            <td><%=user.getEmail()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Gender</th>
                                            <td><%=user.getGender()%></td>

                                        </tr>

                                        <tr>
                                            <th scope="row">Status</th>
                                            <td><%=user.getAbout()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Registered On</th>
                                            <td><%=user.getDateTime().toString()%></td>

                                        </tr>
                                    </tbody>
                                </table>
                            </div>



                            <!--EDIT PROFILE-->
                            <div id="edit-profile" style="display:none;">
                                <h2 class="mt-2"> Please Edit Carefully </h2>
                                <form action="EditServlet" method="post" enctype="multipart/form-data">
                                    <table class="table">

                                        <tr>
                                            <td>ID :</td>
                                            <td><%= user.getId()%></td>
                                        </tr>

                                        <tr>
                                            <td>Name :</td>
                                            <td><input type="text" class="form-control" name="user_name" value="<%= user.getName()%>"></td>
                                        </tr>

                                        <tr>
                                            <td>Email :</td>
                                            <td><input type="email" class="form-control" name="user_email" value="<%= user.getEmail()%>"></td>
                                        </tr>

                                        <tr>
                                            <td>Password :</td>
                                            <td><input type="password" class="form-control" name="user_password" value="<%= user.getPassword()%>"></td>
                                        </tr>
                                        <tr>
                                            <td>Gender :</td>
                                            <td><%= user.getGender().toUpperCase()%></td>
                                        </tr>
                                        <tr>
                                            <td>About :</td>
                                            <td>
                                                <textarea rows="4" name="user_about" class="form-control">
                                                    <%= user.getAbout()%>
                                                </textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>New Profile:</td>
                                            <td>
                                                <input type="file" name="image" class="form-control">
                                            </td>
                                        </tr>


                                    </table>
                                    <button type="submit" class="btn btn-outline-primary"  >Save</button>
                                </form>
                            </div>

                            <!--EDIT PROFILE END-->              

                        </div>
                    </div>
                    <div class="modal-footer">

                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button  id="edit-profile-btn" type="button" class="btn btn-primary">Edit</button>
                    </div>
                </div>
            </div>
        </div>
        <!--profile modal ends-->




        <!--post modal-->
        <!-- Button trigger modal -->


        <!-- Modal -->
        <div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Add Post Detail</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="add-post-form" action="AddPostMethod" method="post">

                            <div class="form-group">
                                <select name="cid" class="form-control">

                                    <option selected disabled >---select category---</option>
                                    <%
                                        PostDao postD = new PostDao(ConnectionProvider.getConnection());
                                        ArrayList<Category> list = postD.getAllCategories();
                                        for (Category c : list) {
                                    %>
                                    <option value="<%= c.getCid()%>"><%= c.getName()%></option>

                                    <%
                                        }
                                    %>
                                </select>
                            </div>

                            <div class="form-group">
                                <input name="pTitle" type="text" placeholder="add post title" class="form-control" />
                            </div>

                            <div class="form-group">
                                <textarea name="pContent" class="form-control"  style="height:200px;" placeholder="enter your content" ></textarea>
                            </div>

                            <div class="form-group">
                                <textarea name="pCode" class="form-control"  style="height:150px;" placeholder="enter your program (if any)" ></textarea>
                            </div>

                            <div class="form-group">
                                <label>Select Your Picture</label>
                                <br>
                                <input type="file" name="pPic" />
                            </div>
                            <div class="container text-center">
                                <button type="submit" class="btn btn-outline-primary">Post</button>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>

        <!--end post model-->


        <!--javascript-->
        <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
        <script>
            $(document).ready(function () {
                let editStatus = false;
                $('#edit-profile-btn').click(function ()
                {
                    if (editStatus == false)
                    {
                        $("#profile-detail").hide()
                        $("#edit-profile").show();
                        $("#save-btn").show()
                        editStatus = true;
                        $(this).text("Back")

                    } else {
                        $("#profile-detail").show()
                        $("#edit-profile").hide();
                        $("#save-btn").hide()
                        editStatus = false;
                        $(this).text("Edit")
                    }


                })

            });
        </script>

        <!--add post js-->
        <script>
            $(document).ready(function (e) {
                $("#add-post-form").on("submit", function (event) {
//                   this fuction will fired ehwn form is submitted
                    event.preventDefault();

                    let form = new FormData(this);
                    console.log("you have clicked submit..")
                    $.ajax({
                        url: "AddPostServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            // if sucess  
                            console.log(data);
                            if (data.trim() == 'done') {
                                swal("Done", "Posted Succesfully", "success");
                            } else {
                                swal("opss..!", "Something went wrong", "error");
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //if error
                            swal("opss..!", "Something went wrong", "error");
                        },
                        processData: false,
                        contentType: false
                    })
                })
            })
        </script>
    </body>
</html>

<%@page import="com.tech.blog.entites.User"%>
<%@page import="com.tech.blog.dao.LikedDao"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entites.Post"%>

<div class="row">
<%
    User user=(User)session.getAttribute("currentUser");
    
    Thread.sleep(1000);
    PostDao d=new PostDao(ConnectionProvider.getConnection());
    int cid=Integer.parseInt(request.getParameter("cid"));
    List<Post> posts=null;
    if(cid==0){
      posts=d.getAllPosts();
    }
    else{
        posts=d.getPostByCatId(cid);
    }
    if(posts.size()==0){
        out.println("<h3 class='display-3 text-center'>No Post In This Category...</h3>");
        return;
    }
    for(Post p:posts){
    %>
    <div class="col-md-6 mt-3">
        <div class="card">
            <img class="card-img-top" src="BlogsPic/<%= p.getpPic() %>" alt="Card Image Cap">
            <div class="card-body">
                <b> <%= p.getpTitle() %> </b>
                <p> <%= p.getpContent() %> </p>
               
                
            </div>
                 <%
                    LikedDao lDao=new LikedDao(ConnectionProvider.getConnection());
                 %>
                <div class="card-footer primary-background text-center">
                    
                    <a href="#!" onclick="doLike(<%= p.getPid() %>,<%= user.getId() %>,this)" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up" ></i><span class="like-counter"><%= lDao.countLikeOnPost(p.getPid()) %></span></a>
                    <a href="show_blog_page.jsp?post_id=<%= p.getPid() %>" class="btn btn-outline-light btn-sm">Read More</a>
                   <a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o" ></i><span>20</span></a>
                                    </div>
        </div>
    </div>
    <%
    }
%>
</div>
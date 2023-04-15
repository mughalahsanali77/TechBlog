/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tech.blog.dao;

import com.tech.blog.entites.Category;
import java.sql.*;
import java.util.ArrayList;
import com.tech.blog.entites.Post;
import java.util.List;

public class PostDao {

    private Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }

    public ArrayList<Category> getAllCategories() {
        ArrayList<Category> list = new ArrayList<>();

        try {
            String query = "SELECT * FROM categories";
            PreparedStatement pstmt = con.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                int cid = rs.getInt("cid");
                String categoryName = rs.getString("name");
                String discription = rs.getString("discription");

                Category c = new Category(cid, categoryName, discription);
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;

    }

    public boolean savePost(Post p) {
        boolean flag = false;

        try {
            String query = " INSERT INTO post (pTitle,pContent,pCode,pPic,catId,userId) values(?,?,?,?,?,?)";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, p.getpTitle());
            pstmt.setString(2, p.getpContent());
            pstmt.setString(3, p.getpCode());
            pstmt.setString(4, p.getpPic());
            pstmt.setInt(5, p.getCid());
            pstmt.setInt(6, p.getUserId());
            pstmt.executeUpdate();

            flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return flag;
    }

    public List<Post> getAllPosts() {
        List<Post> list = new ArrayList<>();

        try {
            String query = "SELECT * FROM post ORDER BY pId";
            PreparedStatement pstmt = con.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                int pId = rs.getInt("pId");
                String pTitle = rs.getString("pTitle");
                String pContent = rs.getString("pContent");
                String pCode = rs.getString("pCode");
                String pPic = rs.getString("pPic");
                Timestamp pDate = rs.getTimestamp("pDate");
                int catId = rs.getInt("catId");
                int userId = rs.getInt("userId");
                Post p = new Post(pId, pTitle, pContent, pCode, pPic, pDate, catId, userId);
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;

    }

    public List<Post> getPostByCatId(int catId) {
        List<Post> list = new ArrayList<>();
        try {
            String query = "SELECT * FROM post WHERE catId=?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, catId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                int pId = rs.getInt("pId");
                String pTitle = rs.getString("pTitle");
                String pContent = rs.getString("pContent");
                String pCode = rs.getString("pCode");
                String pPic = rs.getString("pPic");
                Timestamp pDate = rs.getTimestamp("pDate");
                int userId = rs.getInt("userId");
                Post p=new Post(pId, pTitle, pContent, pCode, pPic, pDate, catId, userId);
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;

    }
    
    public Post getPostById(int postId) throws SQLException{
        Post post=null;
        String query="SELECT * FROM post WHERE pId=?";
        try{
            PreparedStatement pstmt=this.con.prepareStatement(query);
            pstmt.setInt(1, postId);
            ResultSet rs=pstmt.executeQuery();
            if(rs.next()){
                 int pId = rs.getInt("pId");
                String pTitle = rs.getString("pTitle");
                String pContent = rs.getString("pContent");
                String pCode = rs.getString("pCode");
                String pPic = rs.getString("pPic");
                Timestamp pDate = rs.getTimestamp("pDate");
                int catId = rs.getInt("catId");
                int userId = rs.getInt("userId");
                post = new Post(pId, pTitle, pContent, pCode, pPic, pDate, catId, userId);
            
            }
        
        }catch(SQLException sql){
            sql.printStackTrace();
        }
        
        
        return post;
        
        
    }

}

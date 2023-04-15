/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tech.blog.dao;
import java.sql.*;

/**
 *
 * @author Ahsan
 */
public class LikedDao {
    Connection con;

    public LikedDao(Connection con) {
        this.con = con;
    }
    
    
    public boolean inserLike(int pid,int uid){
        boolean f=false;
        String query="INSERT INTO liked (pid,uid)VALUES (?,?)";
        
        
        try {
            PreparedStatement pstmt=this.con.prepareStatement(query);
            pstmt.setInt(1,pid);
            pstmt.setInt(2,uid);
            pstmt.executeUpdate();
            f=true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
    
    
    
    public int countLikeOnPost(int pid){
        int count=0;
        String query="SELECT COUNT(*) FROM liked WHERE pid=?";
        try {
            PreparedStatement pstmt=this.con.prepareStatement(query);
            pstmt.setInt(1,pid);
            ResultSet rs=pstmt.executeQuery();
            if(rs.next()){
                count=rs.getInt("COUNT(*)");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }


        return count;
    }
    
    public boolean isLikedByUser(int pid,int uid){
        boolean f=false;
        try {
            String query="SELECT * FROM liked WHERE pid=? AND uid=?";
            PreparedStatement pstmt=this.con.prepareStatement(query);
            pstmt.setInt(1,pid);
            pstmt.setInt(2,uid);
            ResultSet rs=pstmt.executeQuery();
            if(rs.next()){
                
                f=true;
            }
        } catch (Exception e) {
        }
        
        return f;
                
                
    }
    
    public boolean deleteLike(int pid,int uid){
        boolean f=false;
        try {
            PreparedStatement pstmt=this.con.prepareStatement("DELETE FROM liked WHERE pid=? AND uid=?");
            pstmt.setInt(1,pid);
            pstmt.setInt(2,uid);
            pstmt.executeUpdate();
            f=true;
            
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return f;
    }
}

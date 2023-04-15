package com.tech.blog.dao;
import com.tech.blog.entites.User;
import java.sql.*;

public class UserDao {
    
    private  Connection con;
    public UserDao (Connection con){
        this.con=con;
    }
    
    public boolean saveUser(User user){
        boolean f=false;
        try{
//            user----->db
            String query="INSERT INTO user(name,email,password,gender,about) values(?,?,?,?,?)";
            PreparedStatement pstmt=this.con.prepareStatement(query);
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3,user.getPassword());
            pstmt.setString(4, user.getGender());
            pstmt.setString(5, user.getAbout());
            pstmt.executeUpdate();
            
            f=true;
        }catch(Exception e){
            e.printStackTrace();
        }
        
        return f;
    }
    
    public User getUserByEmailAndPassword(String email,String password){
        User user=null;
        
        try {
            String query="SELECT * FROM user where email=? and password=?";
            PreparedStatement pstmt=con.prepareStatement(query);
            pstmt.setString(1, email);
            pstmt.setString(2,password);
            ResultSet rs=pstmt.executeQuery();
            if(rs.next()){
               user=new User();
               
               //fetching name from db
               String name=rs.getString("name");
               
               //setting data to user
               user.setName(name);
               user.setId(rs.getInt("id"));
               user.setEmail(rs.getString("email"));
               user.setPassword(rs.getString("password"));
               user.setGender(rs.getString("gender"));
               user.setAbout(rs.getString("about"));
               user.setDateTime(rs.getTimestamp("rdate"));
               user.setProfile(rs.getString("profile"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
    
    public boolean updateUser(User user){
        boolean f=false;
        try {
            String query="UPDATE user set name=?,email=?,password=?,gender=?,about=?,profile=? WHERE id=?";
            PreparedStatement p=con.prepareStatement(query);
            p.setString(1,user.getName());
            p.setString(2,user.getEmail());
            p.setString(3, user.getPassword());
            p.setString(4,user.getGender());
            p.setString(5,user.getAbout());
            p.setString(6,user.getProfile());
            p.setInt(7,user.getId());
            
            p.executeUpdate();
            f=true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
    
    public User getUserByUserId(int userId){
        User user=null;
        try {
            String query="SELECT * FROM user WHERE id=?";
            PreparedStatement pstmt=this.con.prepareStatement(query);
            pstmt.setInt(1, userId);
            ResultSet rs=pstmt.executeQuery();
            if(rs.next()){
                 user=new User();
               
               //fetching name from db
               String name=rs.getString("name");
               
               //setting data to user
               user.setName(name);
               user.setId(rs.getInt("id"));
               user.setEmail(rs.getString("email"));
               user.setPassword(rs.getString("password"));
               user.setGender(rs.getString("gender"));
               user.setAbout(rs.getString("about"));
               user.setDateTime(rs.getTimestamp("rdate"));
               user.setProfile(rs.getString("profile"));
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        
        return user;
    }
}

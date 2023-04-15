
package com.tech.blog.helper;
import java.sql.*;

public class ConnectionProvider {
    private static Connection con;
    public static Connection getConnection(){
        if(con==null){
            try{
                //load Driver
                Class.forName("com.mysql.cj.jdbc.Driver");
                
                //create connetion
                con=DriverManager.getConnection("jdbc:mysql://localhost:3306/techblog","root","root");
            }catch(Exception e){
                e.printStackTrace();
            }
        }//if con==null
        return con;
    }
    
}

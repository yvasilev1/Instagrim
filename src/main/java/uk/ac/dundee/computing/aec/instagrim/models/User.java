/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uk.ac.dundee.computing.aec.instagrim.models;

import com.datastax.driver.core.BoundStatement;
import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.PreparedStatement;
import com.datastax.driver.core.ResultSet;
import com.datastax.driver.core.Row;
import com.datastax.driver.core.Session;
import com.datastax.driver.core.Statement;
import javax.servlet.http.HttpSession;
import com.datastax.driver.core.querybuilder.QueryBuilder;
import static com.datastax.driver.core.querybuilder.QueryBuilder.eq;
import static com.datastax.driver.core.querybuilder.QueryBuilder.set;
import static com.sun.corba.se.spi.presentation.rmi.StubAdapter.request;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.Iterator;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.http.HttpSession;
import uk.ac.dundee.computing.aec.instagrim.lib.AeSimpleSHA1;
import uk.ac.dundee.computing.aec.instagrim.stores.LoggedIn;
import uk.ac.dundee.computing.aec.instagrim.stores.Pic;
import uk.ac.dundee.computing.aec.instagrim.stores.Profile;

/**
 *
 * @author Administrator
 */
public class User {

    Cluster cluster;

    public User() {

    }

    public boolean RegisterUser(UUID userId, String RegUserName, String Password, String first_name, String last_name, String email) {
        AeSimpleSHA1 sha1handler = new AeSimpleSHA1();
        String EncodedPassword = null;
        try {
            EncodedPassword = sha1handler.SHA1(Password);
        } catch (UnsupportedEncodingException | NoSuchAlgorithmException et) {
            System.out.println("Can't check your password");
            return false;
        }

        Session session = cluster.connect("instagrim");
        PreparedStatement ps = session.prepare("insert into userprofiles (userid,login,password,first_name, last_name,email) "
                + "Values(?,?,?,?,?,?)");

        BoundStatement boundStatement = new BoundStatement(ps);
        session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        userId, RegUserName, EncodedPassword, first_name, last_name, email));
        //We are assuming this always works.  Also a transaction would be good here !

        System.out.println("You have been registered");
        return true;
    }
    public boolean isValidEmail(String email){
         Pattern p0 = Pattern.compile(".+@.+\\.[a-z]+");
         Matcher m0 = p0.matcher(email);
        
         boolean isValid = m0.matches();
         if (isValid)
         {
             return true;
         }
         
        
        return false;
    }

    public boolean IsValidUser(String logUsername, String Password) {
        AeSimpleSHA1 sha1handler = new AeSimpleSHA1();
        String EncodedPassword = null;
        try {
            EncodedPassword = sha1handler.SHA1(Password);
        } catch (UnsupportedEncodingException | NoSuchAlgorithmException et) {
            System.out.println("Can't check your password");
            return false;
        }
        Session session = cluster.connect("instagrim");
        PreparedStatement ps = session.prepare("select * from userprofiles");
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                ));
        if (rs.isExhausted()) {
            System.out.println("No Images returned");
            return false;
        } else {
            for (Row row : rs) {

                String userName = row.getString("login");

                if (userName.equals(logUsername)) {
                    String StoredPass = row.getString("password");
                    if (StoredPass.compareTo(EncodedPassword) == 0) {
                        return true;
                    }
                }

            }
        }

        return false;
    }

    public boolean updateProfile(String currUserName, String newUserName, String newFirstName, String newLastName,String newEmail) {
        

        
        UUID StoredID;
        Session session = cluster.connect("instagrim");
        Statement statement;
        statement = QueryBuilder.select()
                .all()
                .from("instagrim", "userprofiles");
        ResultSet rs = session.execute(statement);

        for (Row row : rs) {

            String user_name = row.getString("login");
            StoredID = row.getUUID("userid");
            
            if (user_name.equals(currUserName)) {

                Statement statement1;
                statement1 = QueryBuilder.update("instagrim", "userprofiles")
                        .with(set("login", newUserName))
                        .where(eq("userid", StoredID));

                Statement statement2;
                statement2 = QueryBuilder.update("instagrim", "userprofiles")
                        .with(set("first_name", newFirstName))
                        .where(eq("userid", StoredID));

                Statement statement3;
                statement3 = QueryBuilder.update("instagrim", "userprofiles")
                        .with(set("last_name", newLastName))
                        .where(eq("userid", StoredID));

                 Statement statement4;
                statement4 = QueryBuilder.update("instagrim", "userprofiles")
                        .with(set("email", newEmail))
                        .where(eq("userid", StoredID));
                
                
                session.execute(statement1);
                session.execute(statement2);
                session.execute(statement3);
                session.execute(statement4);

            }
        }

        return true;
    }

    public boolean getProfileInfo(Profile profile, User user) {

        Session session = cluster.connect("instagrim");
        Statement statement;
        statement = QueryBuilder.select()
                .all()
                .from("instagrim", "userprofiles");
        ResultSet rs = session.execute(statement);

        for (Row row : rs) {
            // String firstName;

            profile.setFirstName(row.getString("first_name"));
            profile.setLastName(row.getString("last_name"));
            profile.setEmail(row.getString("email"));

        }
        return true;
    }
    
    public String getProfilePic(String picid){
        
         
	   String storedPicID = " ";
        Session session = cluster.connect("instagrim");
        Statement statement;
        statement = QueryBuilder.select()
                .all()
                .from("instagrim", "userprofiles");
        ResultSet rs = session.execute(statement);

        for (Row row : rs) {

            //String user_name = row.getString("login");
          
            
           // if (user_name.equals(user)) {

             storedPicID = row.getString("profilePic");
                       
        
         //  }
        
        }
       
        return storedPicID;
    }
    
    
    

    public void setCluster(Cluster cluster) {
        this.cluster = cluster;
    }

}

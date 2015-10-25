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
import java.util.LinkedList;

/**
 *
 * @author Administrator
 */
public class User {

    Cluster cluster;

    public User() {

    }

    public boolean RegisterUser(UUID userId, String regUserName, String Password, String first_name, String last_name, String email, String location) {
        AeSimpleSHA1 sha1handler = new AeSimpleSHA1();
        String EncodedPassword = null;
        try {
            EncodedPassword = sha1handler.SHA1(Password);
        } catch (UnsupportedEncodingException | NoSuchAlgorithmException et) {
            System.out.println("Can't check your password");
            return false;
        }

        Session session = cluster.connect("yvinstagrim");
        PreparedStatement ps = session.prepare("insert into userprofiles (userid,login,password,first_name, last_name,email,location) "
                + "Values(?,?,?,?,?,?,?)");

        BoundStatement boundStatement = new BoundStatement(ps);
        session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        userId, regUserName, EncodedPassword, first_name, last_name, email, location));
        //We are assuming this always works.  Also a transaction would be good here !

        System.out.println("You have been registered");
        return true;
    }

    public boolean isValidLogin(String username) {
        System.out.println(username);
        Session session = cluster.connect("yvinstagrim");
        PreparedStatement ps = session.prepare("select first_name from userprofiles where login =?");
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        username));
        if (rs.isExhausted()) {
            System.out.println("No Images returned");
            return false;
        } else {
            for (Row row : rs) {
                String StoredFirstName = row.getString("first_name");

                return true;
            }
        }

        return false;
    }

    public boolean isValidEmail(String email) {
        Pattern p0 = Pattern.compile(".+@.+\\.[a-z]+");
        Matcher m0 = p0.matcher(email);

        if (m0.matches()) {
            return true;
        } else {
            return false;
        }
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
        Session session = cluster.connect("yvinstagrim");
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

    public boolean updateProfile(String currUserName, String newFirstName, String newLastName, String newEmail, String newLocation) {

        UUID StoredID;
        Session session = cluster.connect("yvinstagrim");
        Statement statement;
        statement = QueryBuilder.select()
                .all()
                .from("yvinstagrim", "userprofiles");
        ResultSet rs = session.execute(statement);

        for (Row row : rs) {

            String user_name = row.getString("login");
            StoredID = row.getUUID("userid");

            if (user_name.equals(currUserName)) {

                Statement statement1;
                statement1 = QueryBuilder.update("yvinstagrim", "userprofiles")
                        .with(set("first_name", newFirstName))
                        .where(eq("userid", StoredID));

                Statement statement2;
                statement2 = QueryBuilder.update("yvinstagrim", "userprofiles")
                        .with(set("last_name", newLastName))
                        .where(eq("userid", StoredID));

                Statement statement3;
                statement3 = QueryBuilder.update("yvinstagrim", "userprofiles")
                        .with(set("email", newEmail))
                        .where(eq("userid", StoredID));

                Statement statement4;
                statement4 = QueryBuilder.update("yvinstagrim", "userprofiles")
                        .with(set("location", newLocation))
                        .where(eq("userid", StoredID));

                session.execute(statement1);
                session.execute(statement2);
                session.execute(statement3);
                session.execute(statement4);

            }
        }

        return true;
    }

    public boolean getProfileInfo(Profile profile, User user, String logUsername) {

        Session session = cluster.connect("yvinstagrim");
        PreparedStatement ps = session.prepare("select * from userprofiles where login=?");
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        logUsername));
        if (rs.isExhausted()) {
            System.out.println("No Images returned");
        } else {
            for (Row row : rs) {
                // String firstName;

                profile.setFirstName(row.getString("first_name"));
                profile.setLastName(row.getString("last_name"));
                profile.setEmail(row.getString("email"));
                profile.setLocation(row.getString("location"));

            }
        }
        return true;
    }

    public String getProfilePic(String picid) {

        String storedPicID = " ";
        Session session = cluster.connect("yvinstagrim");
        PreparedStatement ps = session.prepare("select profilePic from userprofiles where login =?");
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        picid));
        if (rs.isExhausted()) {
            System.out.println("No Images returned");
            return "no first name stored";
        } else {
            for (Row row : rs) {

                storedPicID = row.getString("profilepic");

            }
        }

        return storedPicID;
    }

    public void followUser(String user1, String user2) {
        Session session = cluster.connect("yvinstagrim");
        PreparedStatement ps = session.prepare("insert into followers (user,user1) Values(?,?)");
        ResultSet rs = null;
        BoundStatement bs = new BoundStatement(ps);
        rs = session.execute( // this is where the query is executed
                bs.bind( // here you are binding the 'boundStatement'
                        user1, user2));

    }

    public boolean doesUserFollow(String user1, String user2) {
        if (user1.equals(user2)) {
            return true;
        }
        java.util.LinkedList<String> follows = new java.util.LinkedList<>();
        Session session = cluster.connect("yvinstagrim");
        PreparedStatement ps = session.prepare("select user1 from followers where user=?");
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        user1));
        if (rs.isExhausted()) {
            System.out.println("No Images returned");
            return false;
        } else {
            for (Row row : rs) {

                follows.add(row.getString("user1"));

            }

            for (int i = 0; i < follows.size(); i++) {
                System.out.println("looping");
                System.out.println(user1 + user2);
                if (user2.equals(follows.get(i))) {
                    System.out.println(user1 + "  " + user2);
                    return true;
                }

            }
            return false;

        }
    }

    public java.util.LinkedList<String> getUserForFollower(String logUserName) {
        java.util.LinkedList<String> usersForFollowers = new java.util.LinkedList<>();
        Session session = cluster.connect("yvinstagrim");
        PreparedStatement ps = session.prepare("select user1 from followers where user=?");
        BoundStatement boundStatement = new BoundStatement(ps);
        ResultSet rs = null;
        rs = session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        logUserName));
        if (rs.isExhausted()) {
            System.out.println("No Images returned");
            return null;
        } else {
            for (Row row : rs) {

                usersForFollowers.add(row.getString("user1"));

            }

        }

        return usersForFollowers;
    }

    public void setCluster(Cluster cluster) {
        this.cluster = cluster;
    }

}

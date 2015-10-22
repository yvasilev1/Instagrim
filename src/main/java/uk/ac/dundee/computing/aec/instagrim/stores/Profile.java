/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uk.ac.dundee.computing.aec.instagrim.stores;

/**
 *
 * @author Yulian
 */
public class Profile {

    public void Profile() {

    }

    String FirstName = null;
    String LastName = null;
    String Email = null;
    String Location = null;


    public void setFirstName(String firstName) {
        this.FirstName = firstName;
    }

    public String getFirstName() {
        return FirstName;
    }

    public void setLastName(String lastName) {
        this.LastName = lastName;
    }

    public String getLastName() {
        return LastName;
    }

    public void setEmail(String email) {
        this.Email = email;
    }
     public String getEmail() {
        return Email;

    }
     public void setLocation(String location){
         this.Location = location;
     }
     public String getLocation(){
         return Location;
     }
}
<%-- 
    Document   : UserProfile
    Created on : 15-Oct-2015, 11:05:04
    Author     : Yulian
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Instagrim</title>
        <link rel="stylesheet" type="text/css" href="Styles.css" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <%

            LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
            Profile pf = (Profile) session.getAttribute("Profile");
            if (lg != null) {
                String UserName = lg.getUsername();
                String firstName = pf.getFirstName();
                String lastName = pf.getLastName();
                String email = pf.getEmail();

                if (lg.getlogedin()) {
        %>




        <header>
            <h1>Instagrim </h1>
            <h2>Your world in Black and White</h2>
          
        </header>



      
        <table align="center" background-color="white" border="1" td ="60%"width="60%">
            <caption><h2><%=lg.getUsername()%>'s Profile</h2></caption>
            <tr>
                <td height="100px">row 1, column 1</td>
                <td height="100px"> 
                    <p>Username: <%=UserName%></p>
                    <p>First Name: <%=firstName%></p>
                    <p>Last Name: <%=lastName%></p>
                    <p>Email: <%=email%></p></td>
            </tr>
            <tr>
                <td><a href="/Instagrim/ProfilePicUpload.jsp">Upload Profile Picture</a></td><td><a href="/Instagrim/EditProfile">Edit Profile</a></td>
            </tr>
        </table>
    

        <nav>

            <li><a href="/Instagrim/Images/<%=lg.getUsername()%>"><%=lg.getUsername()%>'s Images</a></li>
            

            <%}
                } else {
                }
            %>


        </nav>

        <footer>
            <ul>
                <li class="footer"><a href="/Instagrim">Home</a></li>

            </ul>
        </footer>
    </body>
</html>


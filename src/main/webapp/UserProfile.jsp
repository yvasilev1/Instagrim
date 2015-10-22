<%-- 
    Document   : UserProfile
    Created on : 15-Oct-2015, 11:05:04
    Author     : Yulian
--%>

<%@page import="uk.ac.dundee.computing.aec.instagrim.models.User"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.lib.CassandraHosts"%>
<%@page import="com.datastax.driver.core.Cluster"%>
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
            User us = new User();
            Cluster cluster;
            cluster = CassandraHosts.getCluster();
            us.setCluster(cluster);
            lg.setProfilePic(us.getProfilePic(lg.getUsername()));

            if (lg != null) {
                String UserName = lg.getUsername();
                String firstName = pf.getFirstName();
                String lastName = pf.getLastName();
                String email = pf.getEmail();

                if (lg.getlogedin()) {
        %>

        <header>
            <div class="innertube">
                <h1>Instagrim </h1>
                <h2>Your world in Black and White</h2>
            </div>
        </header>

        <div id="wrapper">

            <main>
                <div id="content">
                    <div class="innertube">
                        <table align ="center" class="Table">
                            <caption><h2><%=lg.getUsername()%>'s Profile</h2></caption>
                            <thead>
                                <tr>
                                    <th></th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td> <a href="/Instagrim/Image/<%=lg.getProfilePic()%>" ><img src="/Instagrim/Thumb/<%=lg.getProfilePic()%>"></a> </td>                         
                                    <td> <p>Username: <%=UserName%></p>
                                        <p>First Name: <%=firstName%></p>
                                        <p>Last Name: <%=lastName%></p>
                                        <p>Email: <%=email%></p></td></td>
                                </tr>
                                <tr>
                                    <td><a href="/Instagrim/Images/<%=UserName%>">Select New Profile Picture</a></td>
                                    <td><a href="/Instagrim/EditProfile">Edit Profile</a></td>
                                </tr>
                            </tbody>
                        </table>

                    </div>
                </div>
            </main>

            <nav>

                <div class="innertube">
                    <h3></h3>
                    <ul>
                        <li><a href="/Instagrim/Images/<%=UserName%>"><%=UserName%>'s Images</a></li>
                        <li><a href="upload.jsp">Upload</a></li>
                        <li><a href="LogoutServlet">Logout</a><li>
                        <li><a href="/Instagrim">Home</a></li>
                    </ul>

                </div>
                <%}
                    } else {
                    }
                %>
            </nav>

        </div>

        <footer>
            <div class="innertube">
                <p> &COPY; Yulian V</p>
            </div>
        </footer>

    </body>
</html>

<%-- 
    Document   : index
    Created on : Sep 28, 2014, 7:01:44 PM
    Author     : Administrator
--%>


<%@page import="uk.ac.dundee.computing.aec.instagrim.lib.CassandraHosts"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.models.User"%>
<%@page import="com.datastax.driver.core.Cluster"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.models.PicModel"%>
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
                        <h1>Main page</h1>
                    </div>
                </div>
            </main>

            <nav>
                <%
                    LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
                    PicModel pm = new PicModel();

                    Cluster cluster;
                    Cluster cluster2;
                    User us = new User();
                    cluster = CassandraHosts.getCluster();
                    cluster2 = CassandraHosts.getCluster();
                    us.setCluster(cluster);
                    pm.setCluster(cluster2);

                    if (lg != null) {
                        String UserName = lg.getUsername();
                        if (lg.getlogedin()) {
                            lg.setProfilePic(us.getProfilePic(lg.getUsername()));
                %>
                <div class="innertube">
                    <h3>User Options</h3>
                    <ul>
                        <li><a href="/Instagrim/UserProfile"><%=UserName%>'s Profile</a></li>
                        <li><a href="/Instagrim/Images/<%=UserName%>"><%=UserName%>'s Images</a></li>
                        <li><a href="/Instagrim/FindNewPeople/majed">Find New People</a></li>
                        <li><a href="/Instagrim/Followers"><%=UserName%>'s followers</a></li>
                        <li><a href="/Instagrim/Upload">Upload</a></li>
                        <li><a href="/Instagrim/LogoutServlet">Logout</a><li>   
                    </ul>
                    <%}
                    } else {
                    %>
                    <h3>Register or Login</h3>
                    <ul>
                        <li><a href="register.jsp">Register</a></li>
                        <li><a href="login.jsp">Login</a></li>
                            <%
                                }%>
                    </ul>
                </div>
            </nav>

        </div>

        <footer>
            <div class="innertube">
                <p> &COPY; Yulian V</p>
            </div>
        </footer>

    </body>
</html>
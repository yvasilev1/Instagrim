<%-- 
    Document   : UsersPics
    Created on : Sep 24, 2014, 2:52:48 PM
    Author     : Yulian
--%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.lib.CassandraHosts"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.models.User"%>
<%@page import="com.datastax.driver.core.Cluster"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.models.PicModel"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Instagrim</title>
        <link rel="stylesheet" type="text/css" href="/Instagrim/Styles.css" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>

    <body>		

        <header>
            <div class="innertube">
                <h1>Instagrim </h1>
                <h2>Your world in Black and White</h2>
                <%
                    LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
                    User us = new User();

                    String username = lg.getUsername();

                    PicModel pm = new PicModel();
                    Cluster cluster;

                    cluster = CassandraHosts.getCluster();
                    pm.setCluster(cluster);
                    us.setCluster(cluster);
                    lg.setProfilePic(us.getProfilePic(lg.getUsername()));


                %>
            </div>
        </header>

        <div id="wrapper">

            <main>
                <div id="content">
                    <div class="innertube">
                        <article>

                            <%                                java.util.LinkedList<Pic> lsPics = (java.util.LinkedList<Pic>) request.getAttribute("Pics");
                                if (lsPics == null) {
                            %>
                            <p>No Pictures found</p>
                            <%
                            } else {
                                for (int i = 0; i < lsPics.size(); i++) {
                                    Pic p = lsPics.get(i);

                            %>
                            <a href="/Instagrim/Image/<%=p.getSUUID()%>" ><img src="/Instagrim/Thumb/<%=p.getSUUID()%>"></a>
                            <a href="/Instagrim/updateProfilePic/<%=p.getSUUID()%>" > Update Profile Pic </a></br>
                            </br>


                            <%
                                    }
                                }
                            %>
                        </article>
                    </div>
                </div>
            </main>

            <nav>
                <%
                    String UserName = lg.getUsername();


                %>
                <div class="innertube">
                    <h3>User options</h3>
                    <ul>
                        <li><a href="/Instagrim/UserProfile"><%=UserName%>'s Profile</a></li>
                        <li><a href="/Instagrim/Upload">Upload</a></li>
                        <li><a href="/Instagrim/">Home</a></li>
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

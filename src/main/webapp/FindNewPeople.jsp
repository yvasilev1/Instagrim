<%-- 
    Document   : Wall
    Created on : 24-Oct-2015, 11:17:33
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
                    String username = lg.getUsername();

                    PicModel pm = new PicModel();
                    Cluster cluster;

                    User us = new User();
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
                                java.util.LinkedList<String> comments = new java.util.LinkedList<>();
                                java.util.LinkedList<String> users = new java.util.LinkedList<>();
                                if (lsPics == null) {
                            %>
                            <p>No Pictures found</p>
                            <%
                            } else {
                                for (int i = 0; i < lsPics.size(); i++) {
                                    Pic p = lsPics.get(i);
                                    comments = pm.getComments(p.getSUUID());
                                    users = pm.getUsers(p.getSUUID());
                                    if (!us.doesUserFollow(lg.getUsername(), p.getUser())) {

                            %>
                            <a href="/Instagrim/Image/<%=p.getSUUID()%>" ><img src="/Instagrim/Thumb/<%=p.getSUUID()%>"></a>
                            <IMG HEIGHT=50 WIDTH=50 SRC="/Instagrim/Image/<%=us.getProfilePic(p.getUser())%>" >
                            <a href="/Instagrim/Images/<%=p.getUser()%>" > <% out.println(p.getUser());%> </a>
                            </br>

                            <form name="input" action="/Instagrim/Followers" method="POST">
                                <input type="text" name="user" value="<%=lg.getUsername()%>" hidden>
                                <input type="text" name="user1" value="<%=p.getUser()%>" hidden>



                                <input type="submit" value="Follow">
                            </form>
                          

                            <%
                                if (comments != null) {

                                    for (int j = 0; j < comments.size(); j++) {
                            %>


                                   <!--   <a href="/Instagrim/Images/<%=users.get(j)%>" style="text-decoration: none" > <% out.println(users.get(j));%>:  </a>
                                        <a > <% out.println(comments.get(j)); %> </a></br>-->
                            <%
                                }
                            %>
                            </br></br>


                            <%
                                            }
                                        }
                                    }
                                }
                            %>
                        </article>
                    </div>
                </div>
            </main>
            <nav>

                <div class="innertube">
                    <h3>User options</h3>
                    <ul>

                        <li><a href="/Instagrim/UserProfile"> Your Profile</a></li>
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

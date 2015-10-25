<%-- 
    Document   : followers
    Created on : 25-Oct-2015, 16:13:13
    Author     : Yulian
--%>

<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.Pic"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.lib.CassandraHosts"%>
<%@page import="com.datastax.driver.core.Cluster"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.models.PicModel"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.models.User"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.LoggedIn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Instagrim</title>
        <link rel="stylesheet" type="text/css" href="Styles.css" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <%

        LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
        User us = new User();

        String userName = lg.getUsername();

       
       

    %>

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
                        <article>

                            <%                                java.util.LinkedList<String> usersForFollowers = new java.util.LinkedList<>();

                                if (usersForFollowers == null) {

                            %>
                            <p>No followers found</p>

                            <%                            } else {
                                for (int i = 0; i < usersForFollowers.size(); i++) {

                                    usersForFollowers = us.getUserForFollower(lg.getUsername());
                            %>
                            <h2><%=lg.getUsername()%>'s Followers</h2>

                            <%if (usersForFollowers != null) {
                                    for (int j = 0; j < usersForFollowers.size(); j++) {%>
                            <p>Imali nqkoi tuk?</p>
                            <a href="/Instagrim/Images/<%=usersForFollowers.get(j)%>" > <% out.println(usersForFollowers.get(j));%>'s pictures  </a>
                            <p>asdsad?</p>
                            <% }
                                        }
                                    }
                                }
                            %>
                            <p>asdsad</p>
                        </article>

                    </div>
                </div>
            </main>
            <nav>

                <div class="innertube">
                    <h3></h3>
                    <ul>

                        <li><a href="/Instagrim/UserProfile">Go back to your profile</a></li>

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
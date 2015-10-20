<%-- 
    Document   : UsersPics
    Created on : Sep 24, 2014, 2:52:48 PM
    Author     : Yulian
--%>
<%@page import="java.util.*"%>
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
                        <article>
                            <h1>Your Pics</h1>
                            <%
                                java.util.LinkedList<Pic> lsPics = (java.util.LinkedList<Pic>) request.getAttribute("Pics");
                                if (lsPics == null) {
                            %>
                            <p>No Pictures found</p>
                            <%
                            } else {
                                Iterator<Pic> iterator;
                                iterator = lsPics.iterator();
                                while (iterator.hasNext()) {
                                    Pic p = (Pic) iterator.next();

                            %>
                            <a href="/Instagrim/Image/<%=p.getSUUID()%>" ><img src="/Instagrim/Thumb/<%=p.getSUUID()%>"></a><br/><%

                                    }
                                }
                                %>
                        </article>
                    </div>
                </div>
            </main>

            <nav>
                <%
                    LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
                    if (lg != null) {
                        String UserName = lg.getUsername();
                        if (lg.getlogedin()) {
                %>
                <div class="innertube">
                    <h3></h3>
                    <ul>
                        <li><a href="/Instagrim/UserProfile"><%=UserName%>'s Profile</a></li>
                        <li><a href="/Instagrim/Images/<%=UserName%>"><%=UserName%>'s Images</a></li>
                        <li><a href="upload.jsp">Upload</a></li>
                        <li><a href="LogoutServlet">Logout</a><li>   
                    </ul>
                    <%}
                        } else {
                        }
                    %>

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

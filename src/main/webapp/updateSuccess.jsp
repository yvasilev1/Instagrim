<%-- 
    Document   : updateSuccess
    Created on : 19-Oct-2015, 20:02:29
    Author     : Yulian
--%>

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
        if (lg != null) {

            if (lg.getlogedin()) {
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
                        <p>You have updated you information successfully. </p>
                        <p> The changes will apply next time you log in. </p>
                        <p> If you wish to do that please press logout. </p>

                    </div>
                </div>
            </main>
            <nav>

                <div class="innertube">
                    <h3></h3>
                    <ul>
                        <li><a href="LogoutServlet">Logout</a></li>
                        <li><a href="/Instagrim/UserProfile">Go back to your profile</a></li>
                            <%}
                                } else {

                                }
                            %>
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

s
<%-- 
    Document   : EditProfile
    Created on : 15-Oct-2015, 11:01:01
    Author     : Yulian
--%>

<%@page import="uk.ac.dundee.computing.aec.instagrim.models.User"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.Profile"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.LoggedIn"%>
<<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            <div class="innertube">
                <h1>Instagrim </h1>
                <h2>Your world in Black and White</h2>
            </div>
        </header>

        <div id="wrapper">

            <main>
                <div id="content">
                    <div class="innertube">
                        <p>${errorMessage1}</p>
                        <article>

                            <form method="POST"  action="EditProfile">
                                <ul>
                                    
                                    <li>First Name <input type="text" name="newFirstName" value="<%=firstName%>"></li>
                                    <li>Last Name <input type="text" name="newLastName" value="<%=lastName%>"></li>
                                    <li>Email <input type="text" name="newEmail" value="<%=email%>"></li>
                                </ul>
                                <br/>
                                <input type="submit" value="Edit"> 

                            </form>
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
        <%}
            } else {
            }%>

        <footer>
            <div class="innertube">
                <p> &COPY; Yulian V</p>
            </div>
        </footer>

    </body>
</html>
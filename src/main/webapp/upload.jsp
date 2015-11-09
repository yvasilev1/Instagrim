<%-- 
    Document   : upload
    Created on : Sep 22, 2014, 6:31:50 PM
    Author     : Administrator
--%>

<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.LoggedIn"%>
<!DOCTYPE html>
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
                            <p>${uploadMessage}</p>
                            <h3>Picture Upload</h3>
                            <form method="POST" enctype="multipart/form-data" action="Image">
                                File to upload: <input type="file" name="upfile"><br/>

                                <br/>
                                <input type="submit" value="Press"> to upload the file!
                            </form>

                        </article>
                    </div>
                </div>
            </main>
            <% LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
                String UserName = lg.getUsername();
            %>

            <nav>

                <div class="innertube">
                    <h3></h3>
                    <ul>
                        <li><a href="/Instagrim/UserProfile"><%=UserName%>'s Profile</a></li>
                        <li><a href="/Instagrim/Images/<%=UserName%>"><%=UserName%>'s Images</a></li>
                        <li><a href="/Instagrim">Home</a></li>  
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
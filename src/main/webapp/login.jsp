<%-- 
    Document   : login.jsp
    Created on : Sep 28, 2014, 12:04:14 PM
    Author     : Administrator
--%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                            <h3>Login</h3>
                            <form method="POST"  action="Login">
                                <ul>
                                    <li>Username <input type="text" name="logUsername"></li>
                                    <li>Password <input type="password" name="password"></li>
                                </ul>
                                <br/>
                                <input type="submit" value="Login"> 
                            </form>

                        </article>
                    </div>
                </div>
            </main>

            <nav>

                <div class="innertube">
                    <h3></h3>
                    <ul>
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
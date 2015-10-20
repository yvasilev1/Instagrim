<%-- 
    Document   : register.jsp
    Created on : Sep 28, 2014, 6:29:51 PM
    Author     : Administrator
--%>

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
                            <h3>Register as user</h3>

                            <p>${errorMessage}</p>
                            <p>${errorMessage1}</p>

                            <form method="POST"  action="Register">
                                <ul>
                                    <li>User Name <input type="text" name="RegUserName"></li>
                                    <li>Password <input type="password" name="password"></li>
                                    <li>Re-enter password <input type="password" name="password1"></li>
                                    <p></p>
                                    <li>First Name <input type="text" name="first_name"></li>
                                    <li>Last name <input type="text" name="last_name"></li>
                                    <li>E-mail <input type="text" name="email"></li>

                                </ul>
                                <br/>
                                <input type="submit" value="Register"> 

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
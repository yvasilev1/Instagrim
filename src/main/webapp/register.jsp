<%-- 
    Document   : register.jsp
    Created on : Sep 28, 2014, 6:29:51 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Instagrim</title>
        <link rel="stylesheet" type="text/css" href="Styles.css" />
    </head>
    <body>
        <header>
            <h1>InstaGrim ! </h1>
            <h2>Your world in Black and White</h2>
        </header>
        <nav>
            <ul>

                <li><a href="/Instagrim/Images/majed">Sample Image</a></li>
            </ul>
        </nav>

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

        <footer>
            <ul>
                <li class="footer"><a href="/Instagrim">Home</a></li>
            </ul>
        </footer>
    </body>
</html>

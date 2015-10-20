<%-- 
    Document   : ProfilePicUpload
    Created on : 19-Oct-2015, 11:20:31
    Author     : Yulian
--%>

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
                            <h3>Profile Picture Upload</h3>
                            <form method="POST" enctype="multipart/form-data" action="Image">
                                File to upload: <input type="file" name="upfile"><br/>

                                <br/>
                                <input type="submit" value="Press"> to upload the file!
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

        <footer>
            <div class="innertube">
                <p> &COPY; Yulian V</p>
            </div>
        </footer>

    </body>
</html>
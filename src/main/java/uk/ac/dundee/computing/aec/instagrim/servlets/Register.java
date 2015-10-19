/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uk.ac.dundee.computing.aec.instagrim.servlets;

import com.datastax.driver.core.Cluster;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import uk.ac.dundee.computing.aec.instagrim.lib.CassandraHosts;
import uk.ac.dundee.computing.aec.instagrim.models.User;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.http.HttpSession;
import uk.ac.dundee.computing.aec.instagrim.lib.Convertors;
import uk.ac.dundee.computing.aec.instagrim.stores.LoggedIn;
import uk.ac.dundee.computing.aec.instagrim.stores.Profile;

/**
 *
 * @author Administrator
 */
@WebServlet(name = "Register", urlPatterns = {"/Register"})
public class Register extends HttpServlet {

    Cluster cluster = null;

    public void init(ServletConfig config) throws ServletException {
        // TODO Auto-generated method stub
        cluster = CassandraHosts.getCluster();
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String RegUserName = request.getParameter("RegUserName");
        String password = request.getParameter("password");
        String password1 = request.getParameter("password1");
        String first_name = request.getParameter("first_name");
        String last_name = request.getParameter("last_name");
        String email = request.getParameter("email");

        Convertors convertor = new Convertors();
        java.util.UUID userId = convertor.getTimeUUID();

        
        User us = new User();
        boolean emailCheck = us.isValidEmail(email);
        

        if (password1.equals(password) & emailCheck == true) {

            us.setCluster(cluster);
            us.RegisterUser(userId, RegUserName, password, first_name, last_name, email);
            response.sendRedirect("/Instagrim/success.jsp");

        } else if (!password1.equals(password) & emailCheck == true) {
            String errorMessage = "Password doest match, please try again";
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            response.sendRedirect("/Instagrim/register.jsp");

        } else if (password1.equals(password) & emailCheck == false) {
            String errorMessage = "Non-valid email, please try again";
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            response.sendRedirect("/Instagrim/register.jsp");

        } else if (!password1.equals(password) & emailCheck == false) {
            String errorMessage = "Password doest match please try again";
            String errorMessage1 = "Non-valid email, please try again";
            request.setAttribute("errorMessage", errorMessage);
            request.setAttribute("errorMessage1", errorMessage1);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            response.sendRedirect("/Instagrim/register.jsp");
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

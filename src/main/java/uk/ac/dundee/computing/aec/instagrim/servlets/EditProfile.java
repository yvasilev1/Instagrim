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
import javax.servlet.http.HttpSession;
import uk.ac.dundee.computing.aec.instagrim.lib.CassandraHosts;
import uk.ac.dundee.computing.aec.instagrim.models.User;
import uk.ac.dundee.computing.aec.instagrim.stores.LoggedIn;

/**
 *
 * @author Yulian
 */
@WebServlet(name = "EditProfile", urlPatterns = {"/EditProfile"})
public class EditProfile extends HttpServlet {

    Cluster cluster = null;

    public void init(ServletConfig config) throws ServletException {
        // TODO Auto-generated method stub
        cluster = CassandraHosts.getCluster();
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditProfile</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditProfile at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

       RequestDispatcher rd = request.getRequestDispatcher("EditProfile.jsp");
       rd.forward(request, response);
    }

    @SuppressWarnings("null")
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        LoggedIn lg = new LoggedIn();
        HttpSession session = request.getSession();
        lg = (LoggedIn) session.getAttribute("LoggedIn");
        String currUserName = lg.getUsername();
        String newUserName = request.getParameter("newUserName");
        String newFirstName = request.getParameter("newFirstName");
        String newLastName = request.getParameter("newLastName");
        String newEmail = request.getParameter("newEmail");
        User us = new User();
        us.setCluster(cluster);

        boolean updateInfo = us.updateProfile(currUserName, newUserName, newFirstName, newLastName, newEmail);
        boolean isNewEmailValid = us.isValidEmail(newEmail);
        if (updateInfo == true & isNewEmailValid == true) {

            RequestDispatcher rd = request.getRequestDispatcher("updateSuccess.jsp");
            rd.forward(request, response);
        } else {
            String errorMessage1 = "Non-valid email, please try again";
            request.setAttribute("errorMessage1", errorMessage1);
            request.getRequestDispatcher("/EditProfile.jsp").forward(request, response);
            response.sendRedirect("/Instagrim/EditProfile.jsp");
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

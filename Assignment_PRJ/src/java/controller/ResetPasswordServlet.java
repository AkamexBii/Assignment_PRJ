package controller;

import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ResetPasswordServlet extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userName = req.getParameter("to_name");
        String email = req.getParameter("to_email");
        String pass = req.getParameter("code");
        
        UserDAO ud = new UserDAO();
        
        try {
            if (ud.isValidResetPassword(userName, email)) {
                boolean result = ud.changePasswordByUsername(userName, pass);
                
                if (result) {
                    req.setAttribute("resultSuccess", "New password sended to your email");
                } else {
                    req.setAttribute("resultFaild", "Reset password failed");
                }
            } else {
                req.setAttribute("resultFaild", "Invalid username or email");
            }
        } catch (Exception ex) {
            Logger.getLogger(ResetPasswordServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        req.getRequestDispatcher("forgotPassword.jsp").forward(req, resp);
    }
    
}
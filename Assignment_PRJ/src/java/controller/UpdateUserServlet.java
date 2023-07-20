package controller;

import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;

public class UpdateUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        int userId = Integer.parseInt(req.getParameter("userId"));

        UserDAO ud = new UserDAO();

        User u = ud.getUserById(userId);

        req.setAttribute("user", u);
        req.getRequestDispatcher("updateUser.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String username = req.getParameter("username");
        String fName = req.getParameter("fName");
        String lName = req.getParameter("lName");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        int roleId = Integer.parseInt(req.getParameter("roleId"));

        UserDAO ud = new UserDAO();

        boolean result = ud.updateUserByAdmin(username, fName, lName, email, phone, roleId);

        if (result) {
            req.setAttribute("msgSuccess", "Update info user success");
        } else {
            req.setAttribute("msgError", "Have some error");
        }
        
        req.getRequestDispatcher("managerUser.jsp").forward(req, res);
    }

}

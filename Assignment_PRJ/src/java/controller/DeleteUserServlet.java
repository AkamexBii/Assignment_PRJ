package controller;

import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class DeleteUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        int userId = Integer.parseInt(req.getParameter("userId"));

        UserDAO ud = new UserDAO();

        boolean result = ud.deleteUserById(userId);

        if (result) {
            req.setAttribute("msgSuccess", "Delete user success");
        } else {
            req.setAttribute("msgError", "Have some error");
        }
        
        req.getRequestDispatcher("managerUser.jsp").forward(req, res);
    }

}

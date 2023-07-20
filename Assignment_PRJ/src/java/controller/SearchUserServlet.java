package controller;

import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import model.User;

public class SearchUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String search = req.getParameter("search").trim().toLowerCase();

        UserDAO ud = new UserDAO();
        HttpSession session = req.getSession();
        User u = (User) session.getAttribute("user");

        List<User> data = ud.getAllUserWithoutCurrent(u.getUserId());
        req.setAttribute("search", search);
        if (!search.equalsIgnoreCase("")) {

            List<User> respData = new ArrayList<>();
            for (User user : data) {
                if (user.getUsername().toLowerCase().contains(search)
                        || (user.getLastName() + " " + user.getFirstName()).toLowerCase().contains(search)
                        || user.getEmail().toLowerCase().contains(search)
                        || user.getPhone().contains(search)) {
                    respData.add(user);
                }
            }

            req.setAttribute("data", respData);
        } else {
            req.setAttribute("data", data);
        }
        req.getRequestDispatcher("managerUser.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}

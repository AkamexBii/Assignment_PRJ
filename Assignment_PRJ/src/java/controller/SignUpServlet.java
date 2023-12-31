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

public class SignUpServlet extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String fname = request.getParameter("firstname").trim();
        String lname = request.getParameter("lastname").trim();
        String username = request.getParameter("username").trim();
        String password = request.getParameter("password");
        String re_password = request.getParameter("passwordconfirm");
        String email = request.getParameter("email").trim();
        String phone = request.getParameter("phone").trim();

        boolean isOke = true;

        //check password vs confirm password
        if (!password.equals(re_password)) {
            isOke = false;
            request.setAttribute("samePasswordMessage", "Confirm Password must same Password");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        }

        //check username
        UserDAO ud = new UserDAO();
        try {
            if (!ud.checkExistUsername(username)) {
                isOke = false;
                request.setAttribute("userExistMessage", "Username already exist");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
            }
        } catch (Exception ex) {
            Logger.getLogger(SignUpServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        //check phone
        if (!phone.matches("\\d+") || (phone.length() < 9 || phone.length() > 11)) {
            isOke = false;
            request.setAttribute("phoneMessage", "Invalid Phone Number");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        }
        
        // Check username <= 30 char
        if (username.length() > 30) {
            isOke = false;
            request.setAttribute("userExistMessage", "Username size less than 30 character");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        }
        
        // Check passowrd in [8,30] char
        if (password.length() < 8 || password.length() > 30) {
            isOke = false;
            request.setAttribute("passwordMessage", "Password must in range 8-30 character");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        }

        //Create User
        if (isOke) {
            User u = new User(username, password, fname, lname, email, phone, 2);
            try {
                boolean isCreated = ud.createUser(u);
                if (isCreated) {
                    request.setAttribute("creatUserMessage", "Created User Success, Plese login");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                } else {
                    request.setAttribute("creatUserMessage", "Have some Error, plese try again later");
                    request.getRequestDispatcher("signup.jsp").forward(request, response);
                }
            } catch (Exception ex) {
                Logger.getLogger(SignUpServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

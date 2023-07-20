package controller;

import dal.ServiceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Cart;
import model.Service;

public class BookServiceServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        HttpSession session = req.getSession();

        ServiceDAO sd = new ServiceDAO();
        Cart cart;

        if (session.getAttribute("cart") == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        } else {
            cart = (Cart) session.getAttribute("cart");
        }

        try {
            Service s = sd.getServiceById(id);
            cart.getListService().add(s);
        } catch (Exception ex) {
            Logger.getLogger(BookServiceServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        req.getRequestDispatcher("service.jsp").forward(req, res);
    }
    
}


package controller;

import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class FeedbackServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        int userId = Integer.parseInt(req.getParameter("userId").trim());
        int productId = Integer.parseInt(req.getParameter("productId").trim());
        String text = req.getParameter("text");
        int score = Integer.parseInt(req.getParameter("score").trim());
        
        ProductDAO pd = new ProductDAO();
        
        try {
            pd.addReview(userId, productId, score, text);
        } catch (Exception ex) {
            Logger.getLogger(FeedbackServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        res.sendRedirect("product?id="+productId);
    }
}

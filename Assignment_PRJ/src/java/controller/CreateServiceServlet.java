package controller;

import static controller.CreateProductServlet.DOMAIN;
import static controller.CreateProductServlet.UPLOAD_DIR;
import dal.ServiceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class CreateServiceServlet extends HttpServlet{
    
    public static final String DOMAIN = "http://localhost:8080";
    public static final String UPLOAD_DIR = "image";
    public String dbFileName = "";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        resp.sendRedirect("addService.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String sPrice = req.getParameter("price");
        Part part = req.getPart("file");
        
        double price = Double.NaN;
        boolean isOke = true;
        
        //Check empty name
        if (name.equalsIgnoreCase("") || name == null) {
            req.setAttribute("msgName", "Service Name is empty");
            isOke = false;
        }
        
        //Check empty description
        if (name.equalsIgnoreCase("") || name == null) {
            req.setAttribute("msgDescription", "Service Description is empty");
            isOke = false;
        }

        //Check valid price
        try {
            price = Double.parseDouble(sPrice);

            if (price <= 0) {
                throw new NumberFormatException();
            }
        } catch (NumberFormatException e) {
            req.setAttribute("msgPrice", "Invalid Price");
            isOke = false;
        }
        
        //Check empty image and valid type image
        if (!part.getContentType().equals("image/jpeg") && !part.getContentType().equals("image/png")) {
            req.setAttribute("msgImage", "Plese upload image file .jpg or .png only");
            isOke = false;
        }
        
        if (!isOke) {
            req.setAttribute("name", name);
            req.setAttribute("description", description);
            req.setAttribute("price", price == Double.NaN ? "" : price);
        } else {
            String url = getUrlImage(part);
            
            ServiceDAO sd = new ServiceDAO();
            
            try {
                sd.addService(name, description, price, url);
                
                    req.setAttribute("msgResultSuccess", "Creat new service successfully");
            } catch (Exception ex) {
                Logger.getLogger(CreateServiceServlet.class.getName()).log(Level.SEVERE, null, ex);
                req.setAttribute("msgResultFail", "Creat new product failed");
            }
        }
        
        req.getRequestDispatcher("addService.jsp").forward(req, resp);
    }
    
    public String getUrlImage(Part part) throws IOException {
        String fileName = extractFileName(part);

        String applicationPath = getServletContext().getRealPath("");
        String uploadPath = applicationPath + File.separator + UPLOAD_DIR;
        System.out.println("applicationPath:" + applicationPath);
        File fileUploadDirectory = new File(uploadPath);
        if (!fileUploadDirectory.exists()) {
            fileUploadDirectory.mkdirs();
        }
        String savePath = uploadPath + File.separator + fileName;
        System.out.println("savePath: " + savePath);
        String sRootPath = new File(savePath).getAbsolutePath();
        System.out.println("sRootPath: " + sRootPath);
        part.write(savePath + File.separator);
        File fileSaveDir1 = new File(savePath);

        dbFileName = UPLOAD_DIR + File.separator + fileName;
        part.write(savePath + File.separator);

        savePath = DOMAIN + savePath.substring(10);
        savePath = savePath.substring(0, 30) + savePath.substring(41);
        savePath = savePath.replace("\\", "/");
        
        return savePath;
    }

    private String extractFileName(Part part) {//This method will print the file name.
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }
}

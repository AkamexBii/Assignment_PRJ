package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Service;

public class ServiceDAO extends DBContext{
    
    public List<Service> getAll () throws Exception {
        List<Service> list = new ArrayList<>();
        String sql = "select * from [Service]";
        
        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            
            while (rs.next()) {
                list.add(new Service(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getDouble(4), rs.getString(5)));
            }
        }catch (SQLException e) {
            System.out.println("e");
        }
        
        return list;
    }
    
    public void addService(String name, String description, double price, String image) throws Exception {
        String sql = "insert into [Service] values (?,?,?,?)";
        
        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            st.setString(1, name);
            st.setString(2, description);
            st.setDouble(3, price);
            st.setString(4, image);
            st.executeUpdate();
            
        }catch(SQLException e) {
            System.out.println(e);
        }
    }
    
    public Service getServiceById(int id) throws Exception {
        String sql = "select * from [Service] where ID = ?";
        
        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            
            if (rs.next()) {
                return new Service(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getDouble(4), rs.getString(5));
            }
        }catch(SQLException e) {
            System.out.println(e);
        }
        return null;
    }
}

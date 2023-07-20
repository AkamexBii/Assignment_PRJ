package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Address;
import model.User;

public class UserDAO extends DBContext {

    //already exist => return false, else return true
    public boolean checkExistUsername(String username) throws Exception {
        String sql = "SELECT * FROM dbo.[User] WHERE Username=?";

        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();

            if (!rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    //Success => return true, else return false
    public boolean createUser(User u) throws Exception {
        String defaultImage = "data:image/png;base64,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";
        String sql = "INSERT INTO dbo.[User] VALUES(?,?,?,?,?,?,?,?)";

        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            st.setString(1, u.getUsername());
            st.setString(2, u.getPassword());
            st.setString(3, u.getFirstName());
            st.setString(4, u.getLastName());
            st.setString(5, u.getEmail());
            st.setString(6, u.getPhone());
            st.setInt(7, u.getRole());
            st.setString(8, defaultImage);

            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
        return true;
    }

    //username,password correct => return true, else return false
    public boolean checkPassword(String username, String password) throws Exception {
        String sql = "SELECT * FROM dbo.[User] WHERE Username=? AND Password=?";

        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);

            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public User getUser(String username, String password) throws Exception {
        String sql = "SELECT * FROM dbo.[User] WHERE Username=? AND Password=?";
        User u = null;

        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                u = new User();
                u.setUserId(rs.getInt(1));
                u.setUsername(rs.getString(2));
                u.setPassword(rs.getString(3));
                u.setFirstName(rs.getString(4));
                u.setLastName(rs.getString(5));
                u.setEmail(rs.getString(6));
                u.setPhone(rs.getString(7));
                u.setRole(rs.getInt(8));
                u.setImage(rs.getString(9));

                return u;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return u;
    }

    public boolean updateUser(int id, String fname, String lname, String email, String phone) throws Exception {
        String sql = "UPDATE dbo.[User] SET FirstName=?,LastName=?,Email=?,Phone=? WHERE UserID=?";

        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            st.setString(1, fname);
            st.setString(2, lname);
            st.setString(3, email);
            st.setString(4, phone);
            st.setInt(5, id);

            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }

        return true;
    }

    public boolean changePassword(int id, String newPassword) throws Exception {
        String sql = "UPDATE dbo.[User] SET Password=? WHERE UserID=?";

        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            st.setString(1, newPassword);
            st.setInt(2, id);

            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }

        return true;
    }
    
    public boolean changePasswordByUsername(String username, String newPassword) throws Exception {
        String sql = "UPDATE dbo.[User] SET Password=? WHERE Username=?";

        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            st.setString(1, newPassword);
            st.setString(2, username);

            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }

        return true;
    }

    public List<Address> getAddressByUserId(int id) throws Exception {
        List<Address> list = new ArrayList<>();
        String sql = "SELECT * FROM dbo.Address WHERE UserID=?";

        try {
            PreparedStatement st = getConnection().prepareCall(sql);
            st.setInt(1, id);

            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Address ad = new Address();
                ad.setId(rs.getInt(1));
                ad.setAddressLine(rs.getString(2));
                ad.setUserId(id);

                list.add(ad);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return list;
    }

    public boolean deleteAddressById(int id) throws Exception {
        String sql = "DELETE dbo.Address WHERE AddressID=?";

        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            st.setInt(1, id);

            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
        return true;
    }

    public boolean addNewAddress(int userId, String address) throws Exception {
        String sql = "INSERT INTO dbo.[Address] VALUES (?,?)";

        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            st.setString(1, address);
            st.setInt(2, userId);

            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
        return true;
    }

    public List<User> getTop5UserByTotalMoneyOrder() throws Exception {
        String sql = "SELECT TOP 5 dbo.[User].UserID,Username, SUM(dbo.Orders.TotalMoney) AS 'Total' FROM dbo.[User] INNER JOIN dbo.Orders\n"
                + "ON Orders.UserID = [User].UserID\n"
                + "WHERE Status = 1\n"
                + "GROUP BY dbo.[User].UserID,Username\n"
                + "ORDER BY [User].UserID";

        List<User> list = new ArrayList<>();

        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                User u = new User();

                u.setUserId(rs.getInt(1));
                u.setUsername(rs.getString(2));
                u.setTotalMoney(rs.getDouble(3));

                list.add(u);
            }
        } catch (SQLException e) {
        }

        return list;
    }

    public boolean updateAvatar(int id, String path) throws Exception {
        String sql = "UPDATE dbo.[User] SET [Image] = ?\n"
                + "WHERE UserID = ?";

        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            st.setString(1, path);
            st.setInt(2, id);
            st.executeUpdate();
            return true;
        } catch (SQLException e) {
        }
        return false;
    }

    public boolean isValidResetPassword(String username, String email) throws Exception {
        String sql = "SELECT * FROM dbo.[User] WHERE Username = ? AND Email = ?";

        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, email);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
        }

        return false;
    }
    
    public String genNewPassword(int size) {
        
        String pass = "";
        int min = 0, max = 9;
        
        for (int i = 0; i < size; ++i) {
            pass += (int)Math.floor(Math.random()*(max-min+1)+min);
        }
        
        return pass;
    }
    
    public List<User> getAllUserWithoutCurrent(int id) {
        String sql = "select * from [User] where [User].UserID != ?";
        List<User> list = new ArrayList<>();
        
        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            
            while (rs.next()) {
                User u = new User();
                u.setUserId(rs.getInt(1));
                u.setUsername(rs.getString(2));
                u.setFirstName(rs.getString(4));
                u.setLastName(rs.getString(5));
                u.setEmail(rs.getString(6));
                u.setPhone(rs.getString(7));
                u.setRole(rs.getInt(8));
                list.add(u);
            }
        }catch(SQLException e) {
            System.out.println(e);
        } catch (Exception ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return list;
    }
    
    public boolean deleteUserById(int userId) {
        String sql = "delete from [User] where [User].UserID = ?";
        
        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            st.setInt(1, userId);
            
            st.executeUpdate();
            
            return true;
        }catch(SQLException e) {
            System.out.println(e);
        } catch (Exception ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return false;
    }
    
    public User getUserById(int id) {
        String sql = "select * from [User] where [User].UserID = ?";
        
        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            
            if (rs.next()) {
                User u = new User();
                
                u.setUserId(rs.getInt(1));
                u.setUsername(rs.getString(2));
                u.setFirstName(rs.getString(4));
                u.setLastName(rs.getString(5));
                u.setEmail(rs.getString(6));
                u.setPhone(rs.getString(7));
                u.setRole(rs.getInt(8));
                
                return u;
            }
        }catch(SQLException e) {
            System.out.println(e);
        } catch (Exception ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return null;
    }
    
    public boolean updateUserByAdmin(String username, String fname, String lname, String email, String phone, int roleId) {
        String sql = "UPDATE dbo.[User] SET FirstName=?,LastName=?,Email=?,Phone=?,RoleID=? WHERE Username=?";

        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            st.setString(1, fname);
            st.setString(2, lname);
            st.setString(3, email);
            st.setString(4, phone);
            st.setInt(5, roleId);
            st.setString(6, username);

            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        } catch (Exception ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return true;
    }
}

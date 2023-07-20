package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Role;

public class RoleDAO extends DBContext {

    public List<Role> getAll() {
        List<Role> list = new ArrayList<>();
        String sql = "select * from [Role]";

        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                list.add(new Role(
                        rs.getInt(1),
                        rs.getString(2)));
            }
        } catch (SQLException e) {
            System.out.println(e);
        } catch (Exception ex) {
            Logger.getLogger(RoleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

    public Role getRoleById(int id) {
        String sql = "select * from [Role] where [Role].RoleId = ?";

        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                return new Role(
                        rs.getInt(1),
                        rs.getString(2));
            }
        } catch (SQLException e) {
            System.out.println(e);
        } catch (Exception ex) {
            Logger.getLogger(RoleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}

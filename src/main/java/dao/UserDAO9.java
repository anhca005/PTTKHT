package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

import model.Librarian9;
import model.Manager9;
import model.Reader9;
import model.User9;

/**
 * Truy xuất thông tin thành viên: dùng cho chức năng đăng nhập.
 */
public class UserDAO9 extends DAO9 {

    public UserDAO9() {
        super();
    }

    /**
     * Kiểm tra đăng nhập.
     * @return đối tượng thành viên đúng vai trò (Reader9, Manager9, Librarian9) nếu đúng tài khoản, null nếu sai.
     */
    public User9 checkLogin(String username, String password) {
        String sql = "SELECT u.*, s.position, r.readerType FROM tblUser9 u "
                + "LEFT JOIN tblStaff9 s ON s.tblUser9id = u.id "
                + "LEFT JOIN tblReader9 r ON r.tblUser9id = u.id "
                + "WHERE u.username = ? AND u.password = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (!rs.next()) {
                return null;
            }
            String role = rs.getString("role");
            User9 user;
            if ("reader".equals(role)) {
                Reader9 reader = new Reader9();
                reader.setReaderType(rs.getString("readerType"));
                user = reader;
            } else if ("manager".equals(role)) {
                Manager9 manager = new Manager9();
                manager.setPosition(rs.getString("position"));
                user = manager;
            } else {
                Librarian9 librarian = new Librarian9();
                librarian.setPosition(rs.getString("position"));
                user = librarian;
            }
            user.setId(rs.getInt("id"));
            user.setUsername(rs.getString("username"));
            user.setFullName(rs.getString("fullName"));
            user.setDateOfBirth(rs.getDate("dateOfBirth"));
            user.setAddress(rs.getString("address"));
            user.setEmail(rs.getString("email"));
            user.setTel(rs.getString("tel"));
            user.setRole(role);
            user.setNote(rs.getString("note"));
            return user;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}

package dao;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 * Lớp DAO gốc: giữ một kết nối CSDL dùng chung cho toàn hệ thống.
 * Các lớp DAO khác kế thừa lớp này để dùng chung thuộc tính con.
 */
public class DAO9 {
    protected static Connection con;

    public DAO9() {
        if (!isConnected()) {
            String url = env("DB_URL", "jdbc:mysql://localhost:3306/libman9?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Ho_Chi_Minh");
            String user = env("DB_USER", "root");
            String password = env("DB_PASSWORD", "123456");
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(url, user, password);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private static boolean isConnected() {
        try {
            return con != null && con.isValid(2);
        } catch (Exception e) {
            return false;
        }
    }

    private static String env(String key, String def) {
        String v = System.getenv(key);
        return (v == null || v.isEmpty()) ? def : v;
    }
}

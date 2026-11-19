package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;

import model.Reader9;
import model.ReaderCard9;

/**
 * Truy xuất thẻ bạn đọc: dùng cho modul "Bạn đọc đăng kí làm thẻ bạn đọc".
 */
public class ReaderCardDAO9 extends DAO9 {

    public ReaderCardDAO9() {
        super();
    }

    /**
     * Lấy thẻ còn hiệu lực của bạn đọc.
     * @param idReader id của bạn đọc
     * @return thẻ còn hiệu lực, null nếu bạn đọc chưa có thẻ còn hiệu lực
     */
    public ReaderCard9 checkValidCard(int idReader) {
        String sql = "SELECT * FROM tblReaderCard9 WHERE tblReader9id = ? "
                + "AND status = 'active' AND expiryDate >= CURDATE()";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idReader);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ReaderCard9 card = new ReaderCard9();
                card.setId(rs.getInt("id"));
                card.setCardCode(rs.getString("cardCode"));
                card.setIssueDate(rs.getDate("issueDate"));
                card.setExpiryDate(rs.getDate("expiryDate"));
                card.setStatus(rs.getString("status"));
                return card;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Cập nhật thông tin bạn đọc và thêm thẻ mới trong cùng một giao dịch.
     * Sau khi lưu, id và mã thẻ được gán lại vào đối tượng card.
     * @return true nếu lưu thành công
     */
    public boolean addReaderCard(ReaderCard9 card) {
        Reader9 reader = card.getReader();
        String sqlUser = "UPDATE tblUser9 SET fullName = ?, dateOfBirth = ?, address = ?, email = ?, tel = ? WHERE id = ?";
        String sqlReader = "UPDATE tblReader9 SET readerType = ? WHERE tblUser9id = ?";
        String sqlDelOld = "DELETE FROM tblReaderCard9 WHERE tblReader9id = ? "
                + "AND id NOT IN (SELECT tblReaderCard9id FROM tblBorrowSlip9)";
        String sqlCard = "INSERT INTO tblReaderCard9 (cardCode, issueDate, expiryDate, status, tblReader9id) VALUES (?, ?, ?, ?, ?)";
        String sqlCode = "UPDATE tblReaderCard9 SET cardCode = ? WHERE id = ?";
        try {
            con.setAutoCommit(false);
            try (PreparedStatement ps = con.prepareStatement(sqlUser)) {
                ps.setString(1, reader.getFullName());
                ps.setDate(2, new java.sql.Date(reader.getDateOfBirth().getTime()));
                ps.setString(3, reader.getAddress());
                ps.setString(4, reader.getEmail());
                ps.setString(5, reader.getTel());
                ps.setInt(6, reader.getId());
                ps.executeUpdate();
            }
            try (PreparedStatement ps = con.prepareStatement(sqlReader)) {
                ps.setString(1, reader.getReaderType());
                ps.setInt(2, reader.getId());
                ps.executeUpdate();
            }
            try (PreparedStatement ps = con.prepareStatement(sqlDelOld)) {
                // thẻ cũ đã hết hạn và chưa dùng để mượn thì xóa để cấp thẻ mới (tblReader9id là unique)
                ps.setInt(1, reader.getId());
                ps.executeUpdate();
            }
            int id;
            try (PreparedStatement ps = con.prepareStatement(sqlCard, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, "TMP" + System.nanoTime() % 100000000);
                ps.setDate(2, new java.sql.Date(card.getIssueDate().getTime()));
                ps.setDate(3, new java.sql.Date(card.getExpiryDate().getTime()));
                ps.setString(4, card.getStatus());
                ps.setInt(5, reader.getId());
                ps.executeUpdate();
                ResultSet keys = ps.getGeneratedKeys();
                keys.next();
                id = keys.getInt(1);
            }
            String code = "BD" + new SimpleDateFormat("yyyy").format(card.getIssueDate()) + String.format("%03d", id);
            try (PreparedStatement ps = con.prepareStatement(sqlCode)) {
                ps.setString(1, code);
                ps.setInt(2, id);
                ps.executeUpdate();
            }
            con.commit();
            card.setId(id);
            card.setCardCode(code);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            try {
                con.rollback();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            return false;
        } finally {
            try {
                con.setAutoCommit(true);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}

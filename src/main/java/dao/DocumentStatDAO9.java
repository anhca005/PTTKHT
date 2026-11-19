package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;

import model.DocumentStat9;

/**
 * Thống kê tài liệu theo số lần mượn.
 */
public class DocumentStatDAO9 extends DAO9 {

    public DocumentStatDAO9() {
        super();
    }

    /**
     * Thống kê các tài liệu được mượn trong khoảng thời gian, sắp xếp giảm dần theo số lần mượn.
     */
    public ArrayList<DocumentStat9> getDocumentStat(Date startDate, Date endDate) {
        ArrayList<DocumentStat9> result = new ArrayList<>();
        String sql = "SELECT d.*, COUNT(bd.id) AS borrowCount FROM tblDocument9 d "
                + "JOIN tblBorrowedDocument9 bd ON bd.tblDocument9id = d.id "
                + "JOIN tblBorrowSlip9 bs ON bs.id = bd.tblBorrowSlip9id "
                + "WHERE bs.borrowDate BETWEEN ? AND ? "
                + "GROUP BY d.id ORDER BY borrowCount DESC, d.code ASC";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, new java.sql.Date(startDate.getTime()));
            ps.setDate(2, new java.sql.Date(endDate.getTime()));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                DocumentStat9 ds = new DocumentStat9();
                ds.setId(rs.getInt("id"));
                ds.setCode(rs.getString("code"));
                ds.setTitle(rs.getString("title"));
                ds.setAuthor(rs.getString("author"));
                ds.setPublisher(rs.getString("publisher"));
                ds.setPublishYear(rs.getInt("publishYear"));
                ds.setType(rs.getString("type"));
                ds.setQuantity(rs.getInt("quantity"));
                ds.setDescription(rs.getString("description"));
                ds.setBorrowCount(rs.getInt("borrowCount"));
                result.add(ds);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}

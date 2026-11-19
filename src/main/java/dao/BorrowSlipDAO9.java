package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;

import model.BorrowSlip9;
import model.BorrowedDocument9;
import model.Document9;
import model.Librarian9;
import model.Reader9;
import model.ReaderCard9;

/**
 * Truy xuất phiếu mượn: dùng cho modul "Thống kê tài liệu theo số lần mượn".
 */
public class BorrowSlipDAO9 extends DAO9 {

    private static final String SLIP_SQL = "SELECT bs.id AS bsId, bs.borrowDate, bs.dueDate, bs.note AS bsNote, "
            + "rc.id AS rcId, rc.cardCode, rc.issueDate, rc.expiryDate, rc.status AS rcStatus, "
            + "ru.id AS readerId, ru.fullName AS readerName, ru.email AS readerEmail, ru.tel AS readerTel, r.readerType, "
            + "lu.id AS libId, lu.fullName AS libName, s.position "
            + "FROM tblBorrowSlip9 bs "
            + "JOIN tblReaderCard9 rc ON rc.id = bs.tblReaderCard9id "
            + "JOIN tblReader9 r ON r.tblUser9id = rc.tblReader9id "
            + "JOIN tblUser9 ru ON ru.id = r.tblUser9id "
            + "JOIN tblStaff9 s ON s.tblUser9id = bs.tblStaff9id "
            + "JOIN tblUser9 lu ON lu.id = s.tblUser9id ";

    public BorrowSlipDAO9() {
        super();
    }

    /**
     * Lấy các phiếu mượn có chứa tài liệu đã chọn trong khoảng thời gian.
     * Mỗi phiếu chỉ kèm dòng BorrowedDocument9 của tài liệu đó.
     */
    public ArrayList<BorrowSlip9> getBorrowSlipByDocument(int idDocument, Date startDate, Date endDate) {
        ArrayList<BorrowSlip9> result = new ArrayList<>();
        String sql = "SELECT x.*, bd.id AS bdId, bd.status AS bdStatus, bd.fine, "
                + "d.id AS dId, d.code, d.title, d.author, d.type "
                + "FROM (" + SLIP_SQL + ") x "
                + "JOIN tblBorrowedDocument9 bd ON bd.tblBorrowSlip9id = x.bsId "
                + "JOIN tblDocument9 d ON d.id = bd.tblDocument9id "
                + "WHERE d.id = ? AND x.borrowDate BETWEEN ? AND ? ORDER BY x.borrowDate";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idDocument);
            ps.setDate(2, new java.sql.Date(startDate.getTime()));
            ps.setDate(3, new java.sql.Date(endDate.getTime()));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                BorrowSlip9 slip = readSlip(rs);
                ArrayList<BorrowedDocument9> list = new ArrayList<>();
                list.add(readBorrowedDocument(rs));
                slip.setBorrowedDocuments(list);
                result.add(slip);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    /**
     * Lấy chi tiết một phiếu mượn: thẻ, bạn đọc, nhân viên lập và toàn bộ tài liệu trong phiếu.
     */
    public BorrowSlip9 getBorrowSlipDetail(int idBorrowSlip) {
        try (PreparedStatement ps = con.prepareStatement(SLIP_SQL + "WHERE bs.id = ?")) {
            ps.setInt(1, idBorrowSlip);
            ResultSet rs = ps.executeQuery();
            if (!rs.next()) {
                return null;
            }
            BorrowSlip9 slip = readSlip(rs);
            String sql = "SELECT bd.id AS bdId, bd.status AS bdStatus, bd.fine, "
                    + "d.id AS dId, d.code, d.title, d.author, d.type "
                    + "FROM tblBorrowedDocument9 bd JOIN tblDocument9 d ON d.id = bd.tblDocument9id "
                    + "WHERE bd.tblBorrowSlip9id = ? ORDER BY d.code";
            ArrayList<BorrowedDocument9> list = new ArrayList<>();
            try (PreparedStatement ps2 = con.prepareStatement(sql)) {
                ps2.setInt(1, idBorrowSlip);
                ResultSet rs2 = ps2.executeQuery();
                while (rs2.next()) {
                    list.add(readBorrowedDocument(rs2));
                }
            }
            slip.setBorrowedDocuments(list);
            return slip;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private BorrowSlip9 readSlip(ResultSet rs) throws Exception {
        Reader9 reader = new Reader9();
        reader.setId(rs.getInt("readerId"));
        reader.setFullName(rs.getString("readerName"));
        reader.setEmail(rs.getString("readerEmail"));
        reader.setTel(rs.getString("readerTel"));
        reader.setReaderType(rs.getString("readerType"));

        ReaderCard9 card = new ReaderCard9();
        card.setId(rs.getInt("rcId"));
        card.setCardCode(rs.getString("cardCode"));
        card.setIssueDate(rs.getDate("issueDate"));
        card.setExpiryDate(rs.getDate("expiryDate"));
        card.setStatus(rs.getString("rcStatus"));
        card.setReader(reader);

        Librarian9 librarian = new Librarian9();
        librarian.setId(rs.getInt("libId"));
        librarian.setFullName(rs.getString("libName"));
        librarian.setPosition(rs.getString("position"));

        BorrowSlip9 slip = new BorrowSlip9();
        slip.setId(rs.getInt("bsId"));
        slip.setBorrowDate(rs.getDate("borrowDate"));
        slip.setDueDate(rs.getDate("dueDate"));
        slip.setNote(rs.getString("bsNote"));
        slip.setReaderCard(card);
        slip.setLibrarian(librarian);
        return slip;
    }

    private BorrowedDocument9 readBorrowedDocument(ResultSet rs) throws Exception {
        Document9 d = new Document9();
        d.setId(rs.getInt("dId"));
        d.setCode(rs.getString("code"));
        d.setTitle(rs.getString("title"));
        d.setAuthor(rs.getString("author"));
        d.setType(rs.getString("type"));
        BorrowedDocument9 bd = new BorrowedDocument9();
        bd.setId(rs.getInt("bdId"));
        bd.setStatus(rs.getString("bdStatus"));
        bd.setFine(rs.getFloat("fine"));
        bd.setDocument(d);
        return bd;
    }
}

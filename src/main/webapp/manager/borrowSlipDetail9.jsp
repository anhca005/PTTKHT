<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="dao.BorrowSlipDAO9, model.*, java.text.SimpleDateFormat" %>
<%
    Object u = session.getAttribute("user");
    if (!(u instanceof Manager9)) {
        response.sendRedirect("../user/login9.jsp");
        return;
    }
    Manager9 manager = (Manager9) u;
    BorrowSlip9 borrowSlip = null;
    try {
        borrowSlip = new BorrowSlipDAO9().getBorrowSlipDetail(Integer.parseInt(request.getParameter("id")));
    } catch (Exception e) {
        // id không hợp lệ
    }
    String docId = request.getParameter("documentId");
    String start = request.getParameter("startDate");
    String end = request.getParameter("endDate");
    String back = "documentStat9.jsp";
    if (docId != null && docId.matches("\\d+") && start != null && start.matches("\\d{4}-\\d{2}-\\d{2}")
            && end != null && end.matches("\\d{4}-\\d{2}-\\d{2}")) {
        back = "borrowHistory9.jsp?documentId=" + docId + "&startDate=" + start + "&endDate=" + end;
    }
    SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chi tiết phiếu mượn - LibMan</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body>
<div class="top">LibMan <span>Quản lí: <%= manager.getFullName() %> | <a href="../user/logout9.jsp">Đăng xuất</a></span></div>
<div class="box">
  <h2>Chi tiết phiếu mượn</h2>
  <% if (borrowSlip == null) { %>
    <div class="msg err">Không tìm thấy phiếu mượn.</div>
  <% } else { ReaderCard9 card = borrowSlip.getReaderCard(); %>
  <table class="info">
    <tr><td>Mã phiếu</td><td><b><%= String.format("PM%04d", borrowSlip.getId()) %></b></td>
        <td>Nhân viên lập</td><td><%= borrowSlip.getLibrarian().getFullName() %></td></tr>
    <tr><td>Ngày mượn</td><td><%= df.format(borrowSlip.getBorrowDate()) %></td>
        <td>Hạn trả</td><td><%= df.format(borrowSlip.getDueDate()) %></td></tr>
    <tr><td>Bạn đọc</td><td><%= card.getReader().getFullName() %></td>
        <td>Mã thẻ</td><td><%= card.getCardCode() %></td></tr>
  </table>
  <table class="list">
    <tr><th>STT</th><th>Mã TL</th><th>Tên tài liệu</th><th>Loại</th><th>Trạng thái</th><th>Tiền phạt</th></tr>
    <% int i = 0; for (BorrowedDocument9 bd : borrowSlip.getBorrowedDocuments()) { i++; %>
    <tr>
      <td><%= i %></td>
      <td><%= bd.getDocument().getCode() %></td>
      <td><%= bd.getDocument().getTitle() %></td>
      <td><%= bd.getDocument().getType() %></td>
      <td><%= bd.getStatus() %></td>
      <td><%= String.format("%,.0f đ", bd.getFine()) %></td>
    </tr>
    <% } %>
  </table>
  <% } %>
  <p><a class="btn grey" href="<%= back %>">Quay lại</a></p>
</div>
</body>
</html>

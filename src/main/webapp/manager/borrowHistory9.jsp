<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="dao.BorrowSlipDAO9, model.*, java.util.ArrayList, java.util.Date, java.text.SimpleDateFormat" %>
<%
    Object u = session.getAttribute("user");
    if (!(u instanceof Manager9)) {
        response.sendRedirect("../user/login9.jsp");
        return;
    }
    Manager9 manager = (Manager9) u;
    String start = request.getParameter("startDate");
    String end = request.getParameter("endDate");
    int documentId;
    Date startDate, endDate;
    try {
        documentId = Integer.parseInt(request.getParameter("documentId"));
        SimpleDateFormat in = new SimpleDateFormat("yyyy-MM-dd");
        startDate = in.parse(start);
        endDate = in.parse(end);
    } catch (Exception e) {
        response.sendRedirect("documentStat9.jsp");
        return;
    }
    // lấy thông tin tài liệu đã chọn từ kết quả thống kê lưu trong session
    Document9 document = null;
    Object ls = session.getAttribute("listStat");
    if (ls instanceof ArrayList) {
        for (Object o : (ArrayList<?>) ls) {
            if (((DocumentStat9) o).getId() == documentId) {
                document = (Document9) o;
            }
        }
    }
    ArrayList<BorrowSlip9> listBorrowSlip = new BorrowSlipDAO9().getBorrowSlipByDocument(documentId, startDate, endDate);
    SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chi tiết các lần mượn tài liệu - LibMan</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body>
<div class="top">LibMan <span>Quản lí: <%= manager.getFullName() %> | <a href="../user/logout9.jsp">Đăng xuất</a></span></div>
<div class="box">
  <h2>Chi tiết các lần mượn tài liệu</h2>
  <% if (document != null) { %>
  <p>Tài liệu: <b><%= document.getCode() %> - <%= document.getTitle() %></b><br>
  <% } else { %><p><% } %>
  Thời gian: <%= df.format(startDate) %> - <%= df.format(endDate) %></p>
  <table class="list">
    <tr><th>STT</th><th>Mã phiếu</th><th>Bạn đọc</th><th>Mã thẻ</th><th>Ngày mượn</th><th>Hạn trả</th><th>Trạng thái</th><th>Chi tiết</th></tr>
    <% int i = 0; for (BorrowSlip9 bs : listBorrowSlip) { i++; %>
    <tr>
      <td><%= i %></td>
      <td><%= String.format("PM%04d", bs.getId()) %></td>
      <td><%= bs.getReaderCard().getReader().getFullName() %></td>
      <td><%= bs.getReaderCard().getCardCode() %></td>
      <td><%= df.format(bs.getBorrowDate()) %></td>
      <td><%= df.format(bs.getDueDate()) %></td>
      <td><%= bs.getBorrowedDocuments().get(0).getStatus() %></td>
      <td><a href="borrowSlipDetail9.jsp?id=<%= bs.getId() %>&documentId=<%= documentId %>&startDate=<%= start %>&endDate=<%= end %>">xem</a></td>
    </tr>
    <% } %>
  </table>
  <p><a class="btn grey" href="documentStat9.jsp?startDate=<%= start %>&endDate=<%= end %>">Quay lại</a></p>
</div>
</body>
</html>

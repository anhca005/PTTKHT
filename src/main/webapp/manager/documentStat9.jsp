<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="dao.DocumentStatDAO9, model.Manager9, model.DocumentStat9, java.util.ArrayList, java.util.Date, java.text.SimpleDateFormat" %>
<%
    Object u = session.getAttribute("user");
    if (!(u instanceof Manager9)) {
        response.sendRedirect("../user/login9.jsp");
        return;
    }
    Manager9 manager = (Manager9) u;
    String start = request.getParameter("startDate");
    String end = request.getParameter("endDate");
    String error = null;
    if (start != null && !start.matches("\\d{4}-\\d{2}-\\d{2}")) start = "";
    if (end != null && !end.matches("\\d{4}-\\d{2}-\\d{2}")) end = "";
    ArrayList<DocumentStat9> listStat = null;
    if (start != null && end != null) {
        // trang submit vào chính nó: kiểm tra ngày rồi gọi DAO lấy thống kê
        try {
            SimpleDateFormat in = new SimpleDateFormat("yyyy-MM-dd");
            Date startDate = in.parse(start);
            Date endDate = in.parse(end);
            if (startDate.after(endDate)) {
                error = "Ngày bắt đầu phải nhỏ hơn hoặc bằng ngày kết thúc!";
            } else {
                listStat = new DocumentStatDAO9().getDocumentStat(startDate, endDate);
                session.setAttribute("listStat", listStat);
            }
        } catch (Exception e) {
            error = "Vui lòng chọn đầy đủ ngày bắt đầu và ngày kết thúc!";
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Thống kê tài liệu theo số lần mượn - LibMan</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body>
<div class="top">LibMan <span>Quản lí: <%= manager.getFullName() %> | <a href="../user/logout9.jsp">Đăng xuất</a></span></div>
<div class="box">
  <h2>Thống kê tài liệu theo số lần mượn</h2>
  <form action="documentStat9.jsp" method="get">
    Từ ngày <input type="date" name="startDate" value="<%= start == null ? "" : start %>" required>
    &nbsp; Đến ngày <input type="date" name="endDate" value="<%= end == null ? "" : end %>" required>
    &nbsp; <button type="submit">Thống kê</button>
  </form>
  <% if (error != null) { %><div class="msg err" style="margin-top:14px"><%= error %></div><% } %>
  <% if (listStat != null && listStat.isEmpty()) { %>
    <div class="msg err" style="margin-top:14px">Không có tài liệu nào được mượn trong khoảng thời gian này.</div>
  <% } else if (listStat != null) { %>
  <table class="list">
    <tr><th>STT</th><th>Mã TL</th><th>Tên tài liệu</th><th>Loại</th><th>Số lần mượn</th><th>Chi tiết</th></tr>
    <% int i = 0; for (DocumentStat9 ds : listStat) { i++; %>
    <tr>
      <td><%= i %></td>
      <td><%= ds.getCode() %></td>
      <td><%= ds.getTitle() %></td>
      <td><%= ds.getType() %></td>
      <td><%= ds.getBorrowCount() %></td>
      <td><a href="borrowHistory9.jsp?documentId=<%= ds.getId() %>&startDate=<%= start %>&endDate=<%= end %>">xem</a></td>
    </tr>
    <% } %>
  </table>
  <% } %>
  <p><a class="btn grey" href="selectReport9.jsp">Quay lại</a></p>
</div>
</body>
</html>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.Reader9, java.text.SimpleDateFormat" %>
<%
    Object u = session.getAttribute("user");
    if (!(u instanceof Reader9)) {
        response.sendRedirect("../user/login9.jsp");
        return;
    }
    Reader9 reader = (Reader9) u;
    String dob = reader.getDateOfBirth() == null ? "" : new SimpleDateFormat("yyyy-MM-dd").format(reader.getDateOfBirth());
    String type = reader.getReaderType() == null ? "" : reader.getReaderType();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng kí làm thẻ bạn đọc - LibMan</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body>
<div class="top">LibMan <span>Bạn đọc: <%= reader.getFullName() %> | <a href="../user/logout9.jsp">Đăng xuất</a></span></div>
<div class="box small">
  <h2>Đăng kí làm thẻ bạn đọc</h2>
  <form action="doRegisterCard9.jsp" method="post">
    <h3>Thông tin bạn đọc</h3>
    <table class="form">
      <tr><td>Họ tên</td><td><input type="text" name="fullName" value="<%= reader.getFullName() == null ? "" : reader.getFullName() %>" required></td></tr>
      <tr><td>Ngày sinh</td><td><input type="date" name="dateOfBirth" value="<%= dob %>" required></td></tr>
      <tr><td>Địa chỉ</td><td><input type="text" name="address" value="<%= reader.getAddress() == null ? "" : reader.getAddress() %>" required></td></tr>
      <tr><td>Email</td><td><input type="email" name="email" value="<%= reader.getEmail() == null ? "" : reader.getEmail() %>" required></td></tr>
      <tr><td>Số điện thoại</td><td><input type="text" name="tel" value="<%= reader.getTel() == null ? "" : reader.getTel() %>" pattern="0[0-9]{9}" title="10 chữ số, bắt đầu bằng 0" required></td></tr>
      <tr><td>Loại bạn đọc</td><td>
        <select name="readerType">
          <% for (String t : new String[] {"Sinh viên", "Giảng viên", "Cán bộ"}) { %>
          <option <%= t.equals(type) ? "selected" : "" %>><%= t %></option>
          <% } %>
        </select></td></tr>
    </table>
    <h3>Thông tin thẻ</h3>
    <table class="form">
      <tr><td>Thời hạn thẻ</td><td>
        <select name="duration">
          <option value="4">4 năm</option>
          <option value="1">1 năm</option>
        </select></td></tr>
      <tr><td>Ghi chú</td><td><input type="text" name="note"></td></tr>
    </table>
    <p>
      <button type="submit">Thêm</button>
      <a class="btn grey" href="readerHome9.jsp">Hủy</a>
    </p>
  </form>
</div>
</body>
</html>

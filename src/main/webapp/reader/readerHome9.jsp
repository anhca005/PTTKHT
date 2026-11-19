<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.Reader9" %>
<%
    Object u = session.getAttribute("user");
    if (!(u instanceof Reader9)) {
        response.sendRedirect("../user/login9.jsp");
        return;
    }
    Reader9 reader = (Reader9) u;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang chủ bạn đọc - LibMan</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body>
<div class="top">LibMan <span>Bạn đọc: <%= reader.getFullName() %> | <a href="../user/logout9.jsp">Đăng xuất</a></span></div>
<div class="box small">
  <h2>Trang chủ bạn đọc</h2>
  <p>Xin chào: <b><%= reader.getFullName() %></b></p>
  <div class="menu">
    <span class="off">Tìm kiếm tài liệu (chưa cài đặt)</span>
    <a href="registerCard9.jsp">Đăng kí làm thẻ bạn đọc</a>
    <a href="../user/logout9.jsp">Đăng xuất</a>
  </div>
</div>
</body>
</html>

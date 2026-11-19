<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.Manager9" %>
<%
    Object u = session.getAttribute("user");
    if (!(u instanceof Manager9)) {
        response.sendRedirect("../user/login9.jsp");
        return;
    }
    Manager9 manager = (Manager9) u;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang chủ nhân viên quản lí - LibMan</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body>
<div class="top">LibMan <span>Quản lí: <%= manager.getFullName() %> | <a href="../user/logout9.jsp">Đăng xuất</a></span></div>
<div class="box small">
  <h2>Trang chủ nhân viên quản lí</h2>
  <p>Xin chào: <b><%= manager.getFullName() %></b></p>
  <div class="menu">
    <a href="selectReport9.jsp">Xem báo cáo</a>
    <a href="../user/logout9.jsp">Đăng xuất</a>
  </div>
</div>
</body>
</html>

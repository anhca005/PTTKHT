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
<title>Chọn loại báo cáo - LibMan</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body>
<div class="top">LibMan <span>Quản lí: <%= manager.getFullName() %> | <a href="../user/logout9.jsp">Đăng xuất</a></span></div>
<div class="box small">
  <h2>Chọn loại báo cáo</h2>
  <div class="menu">
    <a href="documentStat9.jsp">Thống kê tài liệu theo lượt mượn</a>
    <span class="off">Thống kê độc giả theo lượt mượn (chưa cài đặt)</span>
    <span class="off">Thống kê nhà cung cấp theo số lượng tài liệu nhập (chưa cài đặt)</span>
  </div>
  <a class="btn grey" href="managerHome9.jsp">Quay lại</a>
</div>
</body>
</html>

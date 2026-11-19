<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng nhập - LibMan</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body>
<div class="top">Hệ thống quản lý thư viện LibMan</div>
<div class="box small">
  <h2>Đăng nhập</h2>
  <% String msg = request.getParameter("msg");
     if (msg != null) { %><div class="msg err"><%= msg.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;") %></div><% } %>
  <form action="doLogin9.jsp" method="post">
    <table class="form">
      <tr><td>Tên đăng nhập</td><td><input type="text" name="username" required></td></tr>
      <tr><td>Mật khẩu</td><td><input type="password" name="password" required></td></tr>
      <tr><td></td><td><button type="submit">Đăng nhập</button></td></tr>
    </table>
  </form>
</div>
</body>
</html>

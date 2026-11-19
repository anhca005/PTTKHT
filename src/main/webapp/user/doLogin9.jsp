<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="dao.UserDAO9, model.User9, java.net.URLEncoder" %>
<%
    request.setCharacterEncoding("UTF-8");
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    User9 user = new UserDAO9().checkLogin(username, password);
    if (user == null) {
        response.sendRedirect("login9.jsp?msg=" + URLEncoder.encode("Sai tên đăng nhập hoặc mật khẩu!", "UTF-8"));
        return;
    }
    session.setAttribute("user", user);
    if ("reader".equals(user.getRole())) {
        response.sendRedirect("../reader/readerHome9.jsp");
    } else if ("manager".equals(user.getRole())) {
        response.sendRedirect("../manager/managerHome9.jsp");
    } else {
        session.invalidate();
        response.sendRedirect("login9.jsp?msg=" + URLEncoder.encode("Chức năng của nhân viên thư viện chưa được cài đặt trong phạm vi bài.", "UTF-8"));
    }
%>

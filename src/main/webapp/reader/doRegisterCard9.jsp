<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="dao.ReaderCardDAO9, model.Reader9, model.ReaderCard9, java.util.Calendar, java.util.Date, java.text.SimpleDateFormat" %>
<%
    Object u = session.getAttribute("user");
    if (!(u instanceof Reader9)) {
        response.sendRedirect("../user/login9.jsp");
        return;
    }
    request.setCharacterEncoding("UTF-8");
    Reader9 current = (Reader9) u;
    SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");

    // Nhận thông tin từ form, đóng gói đối tượng thẻ (kèm bạn đọc)
    String fullName = request.getParameter("fullName");
    String email = request.getParameter("email");
    String tel = request.getParameter("tel");
    String error = null;
    Date dob = null;
    try {
        dob = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("dateOfBirth"));
    } catch (Exception e) {
        error = "Ngày sinh không hợp lệ!";
    }
    if (fullName == null || fullName.trim().isEmpty()) {
        error = "Họ tên không được để trống!";
    } else if (email == null || !email.matches("^[\\w.+-]+@[\\w-]+(\\.[\\w-]+)+$")) {
        error = "Email không hợp lệ!";
    } else if (tel == null || !tel.matches("0\\d{9}")) {
        error = "Số điện thoại không hợp lệ!";
    }

    String title, message, next;
    boolean ok = false;
    if (error != null) {
        title = "Thông tin không hợp lệ";
        message = error + " Vui lòng kiểm tra lại.";
        next = "registerCard9.jsp";
    } else {
        Reader9 reader = new Reader9();
        reader.setId(current.getId());
        reader.setFullName(fullName.trim());
        reader.setDateOfBirth(dob);
        reader.setAddress(request.getParameter("address"));
        reader.setEmail(email);
        reader.setTel(tel);
        reader.setReaderType(request.getParameter("readerType"));

        int years = "1".equals(request.getParameter("duration")) ? 1 : 4;
        Calendar cal = Calendar.getInstance();
        Date issue = cal.getTime();
        cal.add(Calendar.YEAR, years);

        ReaderCard9 card = new ReaderCard9();
        card.setIssueDate(issue);
        card.setExpiryDate(cal.getTime());
        card.setStatus("active");
        card.setReader(reader);

        ReaderCardDAO9 dao = new ReaderCardDAO9();
        ReaderCard9 valid = dao.checkValidCard(current.getId());
        if (valid != null) {
            title = "Không thể đăng kí";
            message = "Bạn đã có thẻ bạn đọc còn hiệu lực (mã thẻ " + valid.getCardCode()
                    + ", hết hạn " + df.format(valid.getExpiryDate()) + "), không thể đăng kí thêm!";
            next = "registerCard9.jsp";
        } else if (dao.addReaderCard(card)) {
            ok = true;
            // cập nhật lại thông tin bạn đọc trong session
            current.setFullName(reader.getFullName());
            current.setDateOfBirth(reader.getDateOfBirth());
            current.setAddress(reader.getAddress());
            current.setEmail(reader.getEmail());
            current.setTel(reader.getTel());
            current.setReaderType(reader.getReaderType());
            title = "Thông báo";
            message = "Đăng kí thẻ bạn đọc thành công!<br>Mã thẻ: <b>" + card.getCardCode() + "</b><br>Ngày cấp: "
                    + df.format(card.getIssueDate()) + "<br>Ngày hết hạn: " + df.format(card.getExpiryDate());
            next = "readerHome9.jsp";
        } else {
            title = "Lỗi";
            message = "Không lưu được thông tin, vui lòng thử lại!";
            next = "registerCard9.jsp";
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%= title %> - LibMan</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body>
<div class="top">LibMan <span>Bạn đọc: <%= current.getFullName() %> | <a href="../user/logout9.jsp">Đăng xuất</a></span></div>
<div class="box small">
  <h2><%= title %></h2>
  <div class="msg <%= ok ? "ok" : "err" %>"><%= message %></div>
  <form action="<%= next %>" method="get"><button type="submit">OK</button></form>
</div>
</body>
</html>

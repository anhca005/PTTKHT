# LibMan9 – Hệ thống quản lý thư viện

Bài tập lớn môn Phân tích và thiết kế hệ thống (PTIT) – Đề số 4 – Hoàng Đức Anh – B23DCCN019.

Cài đặt 2 modul đã phân tích, thiết kế (kèm chức năng đăng nhập):

- **Bạn đọc đăng kí làm thẻ bạn đọc**: `reader/readerHome9.jsp` → `registerCard9.jsp` → `doRegisterCard9.jsp`
- **Nhân viên quản lí thống kê tài liệu theo số lần mượn**: `manager/managerHome9.jsp` → `selectReport9.jsp` → `documentStat9.jsp` → `borrowHistory9.jsp` → `borrowSlipDetail9.jsp`

## Công nghệ

Java 17, JSP (Jakarta EE 10), JDBC, MySQL 8, Apache Tomcat 10.1 – kiến trúc 3 tầng như biểu đồ triển khai.

## Cấu trúc

```
src/main/java/model   lớp thực thể (User9, Reader9, ReaderCard9, Document9, BorrowSlip9, ...)
src/main/java/dao     lớp truy xuất dữ liệu (DAO9, UserDAO9, ReaderCardDAO9, DocumentStatDAO9, BorrowSlipDAO9)
src/main/webapp/user     trang dùng chung: đăng nhập, đăng xuất
src/main/webapp/reader   trang của bạn đọc
src/main/webapp/manager  trang của nhân viên quản lí
db/libman9.sql        tạo CSDL 11 bảng + dữ liệu mẫu
```

## Chạy thử (cần Docker)

```bash
docker run --rm -v "$PWD":/app -w /app maven:3.9-eclipse-temurin-17 mvn -q package
docker compose up -d
```

Mở http://localhost:8089/LibMan9

| Tài khoản | Mật khẩu | Vai trò |
|---|---|---|
| annv | 123456 | Bạn đọc chưa có thẻ (đăng kí thẻ thành công) |
| cuonglv | 123456 | Bạn đọc đã có thẻ còn hiệu lực (ngoại lệ) |
| binhtt | 123456 | Nhân viên quản lí (xem thống kê) |

Chạy bằng Eclipse/Tomcat cài sẵn: import Maven project, chạy `db/libman9.sql` trên MySQL, đặt biến môi trường `DB_URL`, `DB_USER`, `DB_PASSWORD` (mặc định `jdbc:mysql://localhost:3306/libman9`, `root`, `123456`).

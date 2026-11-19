-- CSDL hệ thống LibMan (đề 4) - B23DCCN019
-- Thiết kế theo biểu đồ thiết kế CSDL đã nộp (11 bảng)
SET NAMES utf8mb4;
CREATE DATABASE IF NOT EXISTS libman9 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE libman9;

CREATE TABLE tblUser9 (
  id INT(10) AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  fullName VARCHAR(255),
  dateOfBirth DATE,
  address VARCHAR(255),
  email VARCHAR(255),
  tel VARCHAR(20),
  role VARCHAR(50) NOT NULL,
  note VARCHAR(255)
);

CREATE TABLE tblStaff9 (
  tblUser9id INT(10) PRIMARY KEY,
  position VARCHAR(50),
  FOREIGN KEY (tblUser9id) REFERENCES tblUser9(id)
);

CREATE TABLE tblReader9 (
  tblUser9id INT(10) PRIMARY KEY,
  readerType VARCHAR(50),
  FOREIGN KEY (tblUser9id) REFERENCES tblUser9(id)
);

CREATE TABLE tblReaderCard9 (
  id INT(10) AUTO_INCREMENT PRIMARY KEY,
  cardCode VARCHAR(20) UNIQUE,
  issueDate DATE,
  expiryDate DATE,
  status VARCHAR(20),
  tblReader9id INT(10) NOT NULL UNIQUE,
  FOREIGN KEY (tblReader9id) REFERENCES tblReader9(tblUser9id)
);

CREATE TABLE tblSupplier9 (
  id INT(10) AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  address VARCHAR(255),
  email VARCHAR(255),
  tel VARCHAR(20),
  description VARCHAR(255)
);

CREATE TABLE tblDocument9 (
  id INT(10) AUTO_INCREMENT PRIMARY KEY,
  code VARCHAR(20) UNIQUE,
  title VARCHAR(255) NOT NULL,
  author VARCHAR(255),
  publisher VARCHAR(255),
  publishYear INT(4),
  type VARCHAR(50),
  quantity INT(10),
  description VARCHAR(255)
);

CREATE TABLE tblBorrowSlip9 (
  id INT(10) AUTO_INCREMENT PRIMARY KEY,
  borrowDate DATE NOT NULL,
  dueDate DATE NOT NULL,
  note VARCHAR(255),
  tblReaderCard9id INT(10) NOT NULL,
  tblStaff9id INT(10) NOT NULL,
  FOREIGN KEY (tblReaderCard9id) REFERENCES tblReaderCard9(id),
  FOREIGN KEY (tblStaff9id) REFERENCES tblStaff9(tblUser9id)
);

CREATE TABLE tblReturnSlip9 (
  id INT(10) AUTO_INCREMENT PRIMARY KEY,
  returnDate DATE NOT NULL,
  note VARCHAR(255),
  tblStaff9id INT(10) NOT NULL,
  FOREIGN KEY (tblStaff9id) REFERENCES tblStaff9(tblUser9id)
);

CREATE TABLE tblBorrowedDocument9 (
  id INT(10) AUTO_INCREMENT PRIMARY KEY,
  status VARCHAR(20),
  fine FLOAT DEFAULT 0,
  tblBorrowSlip9id INT(10) NOT NULL,
  tblDocument9id INT(10) NOT NULL,
  tblReturnSlip9id INT(10) NULL,
  FOREIGN KEY (tblBorrowSlip9id) REFERENCES tblBorrowSlip9(id),
  FOREIGN KEY (tblDocument9id) REFERENCES tblDocument9(id),
  FOREIGN KEY (tblReturnSlip9id) REFERENCES tblReturnSlip9(id)
);

CREATE TABLE tblImportInvoice9 (
  id INT(10) AUTO_INCREMENT PRIMARY KEY,
  importDate DATE NOT NULL,
  note VARCHAR(255),
  tblSupplier9id INT(10) NOT NULL,
  tblStaff9id INT(10) NOT NULL,
  FOREIGN KEY (tblSupplier9id) REFERENCES tblSupplier9(id),
  FOREIGN KEY (tblStaff9id) REFERENCES tblStaff9(tblUser9id)
);

CREATE TABLE tblImportedDocument9 (
  id INT(10) AUTO_INCREMENT PRIMARY KEY,
  quantity INT(10) NOT NULL,
  unitPrice FLOAT,
  tblImportInvoice9id INT(10) NOT NULL,
  tblDocument9id INT(10) NOT NULL,
  FOREIGN KEY (tblImportInvoice9id) REFERENCES tblImportInvoice9(id),
  FOREIGN KEY (tblDocument9id) REFERENCES tblDocument9(id)
);

-- ===== Dữ liệu mẫu (mật khẩu demo: 123456) =====
INSERT INTO tblUser9 (id, username, password, fullName, dateOfBirth, address, email, tel, role, note) VALUES
 (1, 'binhtt',  '123456', 'Trần Thị Bình',     '1985-03-10', 'Cầu Giấy, Hà Nội',   'binhtt@libman.vn',   '0901000001', 'manager',   NULL),
 (2, 'tuandm',  '123456', 'Đỗ Minh Tuấn',      '1992-07-21', 'Thanh Xuân, Hà Nội', 'tuandm@libman.vn',   '0901000002', 'librarian', NULL),
 (3, 'annv',    '123456', 'Nguyễn Văn An',     '2005-05-12', 'Hà Đông, Hà Nội',    'annv@gmail.com',     '0912345678', 'reader',    NULL),
 (4, 'cuonglv', '123456', 'Lê Văn Cường',      '2004-09-02', 'Đống Đa, Hà Nội',    'cuonglv@gmail.com',  '0912000004', 'reader',    NULL),
 (5, 'haptt',   '123456', 'Phạm Thu Hà',       '2005-01-15', 'Hoàng Mai, Hà Nội',  'haptt@gmail.com',    '0912000005', 'reader',    NULL),
 (6, 'longnh',  '123456', 'Nguyễn Hoàng Long', '1980-11-30', 'Ba Đình, Hà Nội',    'longnh@ptit.edu.vn', '0912000006', 'reader',    NULL);

INSERT INTO tblStaff9 VALUES (1, 'quản lí'), (2, 'thủ thư');
INSERT INTO tblReader9 VALUES (3, 'Sinh viên'), (4, 'Sinh viên'), (5, 'Sinh viên'), (6, 'Giảng viên');

INSERT INTO tblReaderCard9 (id, cardCode, issueDate, expiryDate, status, tblReader9id) VALUES
 (1, 'BD2025010', '2025-09-05', '2029-09-05', 'active', 4),
 (2, 'BD2025044', '2025-09-20', '2029-09-20', 'active', 5),
 (3, 'BD2025102', '2025-10-10', '2029-10-10', 'active', 6);

INSERT INTO tblSupplier9 (id, name, address, email, tel, description) VALUES
 (1, 'NXB Giáo dục Việt Nam', '81 Trần Hưng Đạo, Hà Nội', 'contact@nxbgd.vn', '0243822081', 'Giáo trình, sách giáo khoa'),
 (2, 'Fahasa', '60-62 Lê Lợi, TP.HCM', 'cskh@fahasa.com', '1900636467', 'Sách tham khảo, tạp chí');

INSERT INTO tblDocument9 (id, code, title, author, publisher, publishYear, type, quantity, description) VALUES
 (1, 'TL001', 'Giáo trình Phân tích và thiết kế hệ thống', 'Trần Đình Quế', 'NXB Thông tin và Truyền thông', 2020, 'Giáo trình', 30, NULL),
 (2, 'TL015', 'Lập trình Java cơ bản', 'Phạm Văn Ất', 'NXB Giáo dục', 2019, 'Sách', 20, NULL),
 (3, 'TL047', 'Cơ sở dữ liệu', 'Đỗ Trung Tuấn', 'NXB Giáo dục', 2018, 'Giáo trình', 25, NULL),
 (4, 'TL058', 'Cấu trúc dữ liệu và giải thuật', 'Đỗ Xuân Lôi', 'NXB Khoa học và Kỹ thuật', 2017, 'Giáo trình', 25, NULL),
 (5, 'TL102', 'Tạp chí Tin học và Đời sống số 05/2026', 'Nhiều tác giả', 'Hội Tin học Việt Nam', 2026, 'Tạp chí', 10, NULL),
 (6, 'TL120', 'Mạng máy tính', 'Nguyễn Gia Hiểu', 'NXB Thống kê', 2016, 'Sách', 15, NULL);

INSERT INTO tblImportInvoice9 (id, importDate, note, tblSupplier9id, tblStaff9id) VALUES
 (1, '2025-08-15', 'Nhập đầu năm học', 1, 2),
 (2, '2026-05-02', 'Nhập sách và tạp chí', 2, 2);
INSERT INTO tblImportedDocument9 (quantity, unitPrice, tblImportInvoice9id, tblDocument9id) VALUES
 (30, 85000, 1, 1), (25, 70000, 1, 3), (25, 90000, 1, 4), (20, 120000, 2, 2), (10, 35000, 2, 5);

INSERT INTO tblBorrowSlip9 (id, borrowDate, dueDate, note, tblReaderCard9id, tblStaff9id) VALUES
 (231, '2026-01-05', '2026-01-19', NULL, 1, 2),
 (305, '2026-02-12', '2026-02-26', NULL, 2, 2),
 (318, '2026-03-03', '2026-03-17', NULL, 3, 2),
 (342, '2026-04-08', '2026-04-22', NULL, 1, 2),
 (377, '2026-05-20', '2026-06-03', NULL, 2, 2),
 (390, '2026-06-15', '2026-06-29', NULL, 3, 2);
INSERT INTO tblReturnSlip9 (id, returnDate, note, tblStaff9id) VALUES
 (1, '2026-01-18', NULL, 2), (2, '2026-02-26', NULL, 2), (3, '2026-03-20', 'Trả muộn 3 ngày', 2), (4, '2026-04-21', NULL, 2);
INSERT INTO tblBorrowedDocument9 (status, fine, tblBorrowSlip9id, tblDocument9id, tblReturnSlip9id) VALUES
 ('Đã trả', 0, 231, 1, 1), ('Đã trả', 0, 231, 3, 1),
 ('Đã trả', 0, 305, 1, 2), ('Đã trả', 0, 305, 2, 2),
 ('Đã trả', 15000, 318, 1, 3), ('Đã trả', 15000, 318, 4, 3),
 ('Đã trả', 0, 342, 2, 4), ('Đã trả', 0, 342, 5, 4),
 ('Đang mượn', 0, 377, 1, NULL), ('Đang mượn', 0, 377, 2, NULL),
 ('Đang mượn', 0, 390, 1, NULL), ('Đang mượn', 0, 390, 6, NULL);

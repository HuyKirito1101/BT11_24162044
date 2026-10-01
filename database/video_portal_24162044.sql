CREATE DATABASE IF NOT EXISTS video_portal_24162044 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE video_portal_24162044;

CREATE TABLE Users (
  Username VARCHAR(50) PRIMARY KEY, Password VARCHAR(255) NOT NULL, Phone VARCHAR(15),
  Fullname VARCHAR(50), Email VARCHAR(150) UNIQUE, Admin BOOLEAN DEFAULT FALSE,
  Active BOOLEAN DEFAULT FALSE, Images VARCHAR(500), OtpCode VARCHAR(6), OtpExpiresAt DATETIME
);
CREATE TABLE Category (
  CategoryId INT AUTO_INCREMENT PRIMARY KEY, Categoryname VARCHAR(100), Categorycode VARCHAR(100),
  Images VARCHAR(500), Status BOOLEAN DEFAULT TRUE
);
CREATE TABLE Videos (
  VideoId INT AUTO_INCREMENT PRIMARY KEY, Title VARCHAR(200), Poster VARCHAR(500), Views INT DEFAULT 0,
  Description VARCHAR(500), Active BOOLEAN DEFAULT TRUE, CategoryId INT, Price DOUBLE DEFAULT 150000,
  CONSTRAINT FK_Videos_Category FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId)
);
CREATE TABLE Favorites (
  FavoriteId INT AUTO_INCREMENT PRIMARY KEY, LikedDate DATE, VideoId INT, Username VARCHAR(50),
  CONSTRAINT FK_Favorites_Video FOREIGN KEY (VideoId) REFERENCES Videos(VideoId),
  CONSTRAINT FK_Favorites_User FOREIGN KEY (Username) REFERENCES Users(Username)
);
CREATE TABLE Shares (
  ShareId INT AUTO_INCREMENT PRIMARY KEY, Emails VARCHAR(50), SharedDate DATE, Username VARCHAR(50), VideoId INT,
  CONSTRAINT FK_Shares_Video FOREIGN KEY (VideoId) REFERENCES Videos(VideoId),
  CONSTRAINT FK_Shares_User FOREIGN KEY (Username) REFERENCES Users(Username)
);
CREATE TABLE Orders (
  OrderId INT AUTO_INCREMENT PRIMARY KEY,
  OrderDate DATETIME NOT NULL,
  Username VARCHAR(50),
  CustomerName VARCHAR(100) NOT NULL,
  Phone VARCHAR(20) NOT NULL,
  Address VARCHAR(255) NOT NULL,
  Note VARCHAR(500),
  PaymentMethod VARCHAR(50) NOT NULL DEFAULT 'COD',
  Status VARCHAR(50) NOT NULL DEFAULT 'NEW',
  TotalAmount DOUBLE NOT NULL,
  CONSTRAINT FK_Orders_Users FOREIGN KEY (Username) REFERENCES Users(Username) ON DELETE SET NULL
);
CREATE TABLE Order_Details (
  OrderDetailId INT AUTO_INCREMENT PRIMARY KEY,
  OrderId INT NOT NULL,
  VideoId INT,
  Price DOUBLE NOT NULL,
  Quantity INT NOT NULL,
  Subtotal DOUBLE NOT NULL,
  CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (OrderId) REFERENCES Orders(OrderId) ON DELETE CASCADE,
  CONSTRAINT FK_OrderDetails_Videos FOREIGN KEY (VideoId) REFERENCES Videos(VideoId) ON DELETE SET NULL
);

INSERT INTO Users(Username, Password, Fullname, Email, Admin, Active) VALUES
('admin', 'admin123', 'Administrator', 'admin@video.local', TRUE, TRUE),
('huy24162044', '123456', 'Ngô Gia Huy', 'huy24162044@example.com', FALSE, TRUE);
INSERT INTO Category(Categoryname, Categorycode, Images, Status) VALUES
('Âm nhạc', 'MUSIC', 'https://placehold.co/320x180?text=Music', TRUE),
('Giải trí', 'ENTERTAINMENT', 'https://placehold.co/320x180?text=Entertainment', TRUE),
('Công nghệ', 'TECH', 'https://placehold.co/320x180?text=Technology', TRUE);
INSERT INTO Videos(Title, Poster, Views, Description, Active, CategoryId, Price) VALUES
('Lofi cho ngày mới', 'https://placehold.co/320x180?text=Lofi', 135, 'Nhạc lofi thư giãn.', TRUE, 1, 120000),
('Acoustic Việt Nam', 'https://placehold.co/320x180?text=Acoustic', 210, 'Tuyển tập acoustic.', TRUE, 1, 150000),
('Bản tin công nghệ', 'https://placehold.co/320x180?text=Tech+News', 92, 'Tin công nghệ hôm nay.', TRUE, 3, 200000),
('Khám phá AI', 'https://placehold.co/320x180?text=AI', 188, 'Nhập môn trí tuệ nhân tạo.', TRUE, 3, 250000),
('Phim ngắn cuối tuần', 'https://placehold.co/320x180?text=Film', 75, 'Một phim ngắn thú vị.', TRUE, 2, 180000),
('Trò chơi vui nhộn', 'https://placehold.co/320x180?text=Game', 166, 'Giải trí cùng trò chơi.', TRUE, 2, 99000),
('Pop Việt', 'https://placehold.co/320x180?text=Pop', 86, 'Những ca khúc pop.', TRUE, 1, 140000);

INSERT INTO Orders(OrderId, OrderDate, Username, CustomerName, Phone, Address, Note, PaymentMethod, Status, TotalAmount) VALUES
(1, NOW() - INTERVAL 10 HOUR, 'huy24162044', 'Ngô Gia Huy', '0987654321', 'Số 1 Võ Văn Ngân, TP Thủ Đức', 'Giao sáng', 'COD', 'NEW', 120000),
(2, NOW() - INTERVAL 8 HOUR, 'huy24162044', 'Ngô Gia Huy', '0987654321', 'Số 1 Võ Văn Ngân, TP Thủ Đức', 'Giao trưa', 'COD', 'CONFIRMED', 150000),
(3, NOW() - INTERVAL 6 HOUR, 'huy24162044', 'Ngô Gia Huy', '0987654321', 'Số 1 Võ Văn Ngân, TP Thủ Đức', 'Gói cẩn thận', 'COD', 'PREPARING', 200000),
(4, NOW() - INTERVAL 1 DAY, 'huy24162044', 'Ngô Gia Huy', '0987654321', 'Số 1 Võ Văn Ngân, TP Thủ Đức', 'Giao chiều', 'COD', 'SHIPPING', 250000),
(5, NOW() - INTERVAL 2 DAY, 'huy24162044', 'Ngô Gia Huy', '0987654321', 'Số 1 Võ Văn Ngân, TP Thủ Đức', 'Gọi trước khi đến', 'COD', 'DELIVERING', 180000),
(6, NOW() - INTERVAL 3 DAY, 'huy24162044', 'Ngô Gia Huy', '0987654321', 'Số 1 Võ Văn Ngân, TP Thủ Đức', 'Đã nhận đủ', 'COD', 'DELIVERED', 99000),
(7, NOW() - INTERVAL 4 DAY, 'huy24162044', 'Ngô Gia Huy', '0987654321', 'Số 1 Võ Văn Ngân, TP Thủ Đức', 'Khách đổi ý', 'COD', 'CANCELLED', 140000),
(8, NOW() - INTERVAL 5 DAY, 'huy24162044', 'Ngô Gia Huy', '0987654321', 'Số 1 Võ Văn Ngân, TP Thủ Đức', 'Hàng lỗi cần hoàn', 'COD', 'RETURNED', 120000);

INSERT INTO Order_Details(OrderDetailId, OrderId, VideoId, Price, Quantity, Subtotal) VALUES
(1, 1, 1, 120000, 1, 120000),
(2, 2, 2, 150000, 1, 150000),
(3, 3, 3, 200000, 1, 200000),
(4, 4, 4, 250000, 1, 250000),
(5, 5, 5, 180000, 1, 180000),
(6, 6, 6, 99000, 1, 99000),
(7, 7, 7, 140000, 1, 140000),
(8, 8, 1, 120000, 1, 120000);


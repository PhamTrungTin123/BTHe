﻿/*21130606_Lê Vũ Ánh Tuyết*/
--Insert data part--
-- Thêm dữ liệu vào các bảng
INSERT INTO KhachHang (MaKH, TenKH, DiaChi, SoDT, NgaySinh)
VALUES
  ('KH001', 'Nguyễn Văn A', '123 Đường ABC, Quận 1, TP.HCM', '0123456789', '1990-01-01'),
  ('KH002', 'Trần Thị B', '456 Đường XYZ, Quận 2, TP.HCM', '0987654321', '1985-05-10'),
  ('KH003', 'Nguyễn Thị P', 'Sài Gòn', '0912345678', '1990-01-01'),
  ('KH004', 'Trần Văn K', 'Hà Nội', '0923456789', '1991-02-02'),
  ('KH005', 'Lê Quang C', 'Đà Nẵng', '0934567890', '1992-03-03'),
  ('KH006', 'Hồ Thị D', 'Cần Thơ', '0945678901', '1993-04-04'),
  ('KH007', 'Đỗ Văn E', 'Bình Dương', '0956789012', '1994-05-05'),
  ('KH008', 'Phan Thị F', 'Long An', '0967890123', '1995-06-06'),
  ('KH009', 'Nguyễn Thị G', 'Tiền Giang', '0978901234', '1996-07-07'),
  ('KH0010', 'Trương Thị H', 'Bến Tre', '0989012345', '1997-08-08'),
  ('KH0011', 'Lâm Thị I', 'Vĩnh Long', '0990123456', '1998-09-09'),
  ('KH0012', 'Phạm Thị J', 'Kiên Giang', '0912345678', '1999-10-10');

INSERT INTO NhaCungCap (MaNCC, TenNCC, DiaChiNCC, SoDTNCC)
VALUES
	('NCC001', 'Công ty TNHH A', 'Sài Gòn', '0912345678'),
	('NCC002', 'Công ty cổ phần B', 'Hà Nội', '0923456789'),
	('NCC003', 'Công ty tư nhân C', 'Đà Nẵng', '0934567890'),
	('NCC004', 'Công ty hợp danh D', 'Cần Thơ', '0945678901'),
	('NCC005', 'Công ty liên doanh E', 'Bình Dương', '0956789012'),
	('NCC006', 'Công ty liên kết F', 'Long An', '0967890123'),
	('NCC007', 'Công ty cổ phần G', 'Tiền Giang', '0978901234'),
	('NCC008', 'Công ty TNHH H', 'Bến Tre', '0989012345'),
	('NCC009', 'Công ty tư nhân I', 'Vĩnh Long', '0990123456'),
	('NCC0010', 'Công ty hợp danh J', 'Kiên Giang', '0912345678'),
	('NCC0011', 'Công ty K', '789 Đường DEF, Quận 3, TP.HCM', '0123456789'),
	('NCC0012', 'Công ty L', '101 Đường HIJ, Quận 4, TP.HCM', '0987654321');

INSERT INTO SanPham (MaSP, TenSP, DonViTinh, GiaBan)
VALUES
	('SP001', 'Máy tính xách tay Dell XPS 13', 'Chiếc', 20000000),
	('SP002', 'Điện thoại Samsung Galaxy S22 Ultra', 'Chiếc', 30000000),
	('SP003', 'Laptop MacBook Pro M2 14 inch', 'Chiếc', 40000000),
	('SP004', 'Điều hòa Daikin 1.5 HP FTKA25VAVMV', 'Chiếc', 50000000),
	('SP005', 'Tủ lạnh Samsung Inverter 253 lít RT22FRES4B1/SV', 'Chiếc', 60000000),
	('SP006', 'Máy giặt Electrolux Inverter 9 KG EWF9025BQWA', 'Chiếc', 70000000),
	('SP007', 'Tivi Sony OLED 4K 55 inch XR-55A80J', 'Chiếc', 80000000),
	('SP008', 'Loa soundbar Samsung HW-Q990B', 'Chiếc', 90000000),
	('SP009', 'Đồng hồ thông minh Apple Watch Series 7', 'Chiếc', 10000000),
	('SP0010', 'Laptop Dell XPS', 'Cái', 20000000),
	('SP0011', 'Laptop HP Probook 440', 'Cái', 18000000),
	('SP0012', 'Smartphone iPhone 13', 'Chiếc', 25000000);

  --Insert dữ liệu cho bảng CT_SanPham--
INSERT INTO CT_SanPham (MaSP, NuocSX, MaNCC)
VALUES
	('SP001', 'Việt Nam', null),
	('SP002', 'Trung Quốc', null),
	('SP003', 'Hàn Quốc', null),
	('SP004', 'Nhật Bản', null),
	('SP005', 'Mỹ', null),
	('SP006', 'Đức', null),
	('SP007', 'Pháp', null),
	('SP008', 'Ý', null),
	('SP009', 'Tây Ban Nha', null),
	('SP0010', 'Canada', null),
	('SP0011', 'Brazil', null),
	('SP0012', 'Ấn Độ', null);
INSERT INTO DonDatHang (MaDDH, NgayDH, MaNCC, HinhThucTT)
VALUES
	('DDH001', '2023-11-21', null, 1),
	('DDH002', '2023-11-22', null, 2),
	('DDH003', '2023-11-23', null, 1),
	('DDH004', '2023-11-24', null, 1),
	('DDH005', '2023-11-25', null, 2),
	('DDH006', '2023-11-26', null, 2),
	('DDH007', '2023-11-27', null, 2),
	('DDH008', '2023-11-28', null, 1),
	('DDH009', '2023-11-29', null, 1),
	('DDH0010', '2023-11-30', null, 1),
	('DDH0011', '2023-01-15', null, 1),
	('DDH0012', '2023-02-20', null, 2);

INSERT INTO CT_DDH (MaDDH, MaSP, SLDat)
VALUES
	('DDH001', 'SP001', 1),
	('DDH002', 'SP002', 2),
	('DDH003', 'SP003', 3),
	('DDH004', 'SP004', 4),
	('DDH005', 'SP005', 5),
	('DDH006', 'SP006', 6),
	('DDH007', 'SP007', 7),
	('DDH008', 'SP008', 8),
	('DDH009', 'SP009', 9),
	('DDH0010', 'SP0010', 10),
	('DDH0011', 'SP0011', 5),
	('DDH0012', 'SP0012', 3);
	-- Thêm Hóa Đơn
INSERT INTO HoaDon (MaHD, NgayLapHD, MaKH)
VALUES
	('HD001', '2023-03-01', null),
	('HD002', '2023-11-24', null),
	('HD003', '2023-11-25', null),
	('HD004', '2023-11-26', null),
	('HD005', '2023-11-27', null),
	('HD006', '2023-11-28', null),
	('HD007', '2023-11-29', null),
	('HD008', '2023-11-30', null),
	('HD009', '2023-11-29', null),
	('HD0010', '2023-11-10', null),
	('HD0011', '2023-11-12', null),
	('HD0012', '2023-03-02', null);
  -- Thêm Chi Tiết Hóa Đơn
INSERT INTO CT_HoaDon (MaHD, MaSP, SoLuongMua, DonGiaBan)
VALUES
	('HD001', 'SP001', 2, 21000000),
	('HD002', 'SP002', 1, 26000000),
	('HD003', 'SP003', 3, 22000000),
	('HD004', 'SP004', 2, 27000000),
	('HD005', 'SP005', 1, 23000000),
	('HD006', 'SP006', 4, 28000000),
	('HD007', 'SP007', 2, 24000000),
	('HD008', 'SP008', 1, 29000000),
	('HD009', 'SP009', 3, 25000000),
	('HD0010', 'SP0010', 2, 30000000),
	('HD0011', 'SP0011', 2, 21000000),
	('HD0012', 'SP0012', 1, 26000000);
  -- Thêm Phiếu Trả Nợ
INSERT INTO PhieuTraNo (MaPTN, NgayTra, SoTienTra, MaHD)
VALUES
  ('PTN001', '2023-03-03', 5000000, null),
  ('PTN002', '2023-03-04', 7000000, null),
  ('PTN003', '2023-03-05', 8000000, null),
  ('PTN004', '2023-03-06', 6000000, null),
  ('PTN005', '2023-03-07', 9000000, null),
  ('PTN006', '2023-03-08', 7500000, null),
  ('PTN007', '2023-03-09', 5500000, null),
  ('PTN008', '2023-03-10', 9500000, null),
  ('PTN009', '2023-03-11', 7200000, null),
  ('PTN0010', '2023-03-10', 9500000, null),
  ('PTN0011', '2023-03-11', 7200000, null),
  ('PTN0012', '2023-03-12', 8800000, null);

-- Cập nhật dữ liệu trong các bảng CT_SanPham
UPDATE CT_SanPham
	SET MaNCC = 'NCC001'
	WHERE MaSP = 'SP001'
UPDATE CT_SanPham
	SET MaNCC = 'NCC002'
	WHERE MaSP = 'SP002'
UPDATE CT_SanPham
	SET MaNCC = 'NCC003'
	WHERE MaSP = 'SP003'
UPDATE CT_SanPham
	SET MaNCC = 'NCC004'
	WHERE MaSP = 'SP004'
UPDATE CT_SanPham
	SET MaNCC = 'NCC005'
	WHERE MaSP = 'SP005'
UPDATE CT_SanPham
	SET MaNCC = 'NCC006'
	WHERE MaSP = 'SP006'
UPDATE CT_SanPham
	SET MaNCC = 'NCC007'
	WHERE MaSP = 'SP007'
UPDATE CT_SanPham
	SET MaNCC = 'NCC008'
	WHERE MaSP = 'SP008'
UPDATE CT_SanPham
	SET MaNCC = 'NCC009'
	WHERE MaSP = 'SP009'
UPDATE CT_SanPham
	SET MaNCC = 'NCC0010'
	WHERE MaSP = 'SP0010'
UPDATE CT_SanPham
	SET MaNCC = 'NCC0011'
	WHERE MaSP = 'SP0011'
UPDATE CT_SanPham
	SET MaNCC = 'NCC0012'
	WHERE MaSP = 'SP0012'
-- Cập nhật dữ liệu trong các bảng DonDatHang
UPDATE DonDatHang
	SET MaNCC = 'NCC001'
	WHERE MaDDH = 'DDH001'
UPDATE DonDatHang
	SET MaNCC = 'NCC002'
	WHERE MaDDH = 'DDH002'
UPDATE DonDatHang
	SET MaNCC = 'NCC003'
	WHERE MaDDH = 'DDH003'
UPDATE DonDatHang
	SET MaNCC = 'NCC004'
	WHERE MaDDH = 'DDH004'
UPDATE DonDatHang
	SET MaNCC = 'NCC005'
	WHERE MaDDH = 'DDH005'
UPDATE DonDatHang
	SET MaNCC = 'NCC006'
	WHERE MaDDH = 'DDH006'
UPDATE DonDatHang
	SET MaNCC = 'NCC007'
	WHERE MaDDH = 'DDH007'
UPDATE DonDatHang
	SET MaNCC = 'NCC008'
	WHERE MaDDH = 'DDH008'
UPDATE DonDatHang
	SET MaNCC = 'NCC009'
	WHERE MaDDH = 'DDH009'
UPDATE DonDatHang
	SET MaNCC = 'NCC0010'
	WHERE MaDDH = 'DDH0010'
UPDATE DonDatHang
	SET MaNCC = 'NCC0011'
	WHERE MaDDH = 'DDH0011'
UPDATE DonDatHang
	SET MaNCC = 'NCC0012'
	WHERE MaDDH = 'DDH0012'
-- Cập nhật dữ liệu trong các bảng HoaDon
UPDATE HoaDon
	SET MaKH = 'KH001'
	WHERE MaHD = 'HD001'
UPDATE HoaDon
	SET MaKH = 'KH002'
	WHERE MaHD = 'HD002'
UPDATE HoaDon
	SET MaKH = 'KH003'
	WHERE MaHD = 'HD003'
UPDATE HoaDon
	SET MaKH = 'KH004'
	WHERE MaHD = 'HD004'
UPDATE HoaDon
	SET MaKH = 'KH005'
	WHERE MaHD = 'HD005'
UPDATE HoaDon
	SET MaKH = 'KH006'
	WHERE MaHD = 'HD006'
UPDATE HoaDon
	SET MaKH = 'KH007'
	WHERE MaHD = 'HD007'
UPDATE HoaDon
	SET MaKH = 'KH008'
	WHERE MaHD = 'HD008'
UPDATE HoaDon
	SET MaKH = 'KH009'
	WHERE MaHD = 'HD009'
UPDATE HoaDon
	SET MaKH = 'KH0010'
	WHERE MaHD = 'HD0010'
UPDATE HoaDon
	SET MaKH = 'KH0011'
	WHERE MaHD = 'HD0011'
UPDATE HoaDon
	SET MaKH = 'KH0012'
	WHERE MaHD = 'HD0012'
-- Cập nhật dữ liệu trong các bảng PhieuTraNo
UPDATE PhieuTraNo
	SET MaHD = 'HD001'
	WHERE MaPTN = 'PTN001'
UPDATE PhieuTraNo
	SET MaHD = 'HD001'
	WHERE MaPTN = 'PTN002'
UPDATE PhieuTraNo
	SET MaHD = 'HD003'
	WHERE MaPTN = 'PTN003'
UPDATE PhieuTraNo
	SET MaHD = 'HD004'
	WHERE MaPTN = 'PTN004'
UPDATE PhieuTraNo
	SET MaHD = 'HD005'
	WHERE MaPTN = 'PTN005'
UPDATE PhieuTraNo
	SET MaHD = 'HD006'
	WHERE MaPTN = 'PTN006'
UPDATE PhieuTraNo
	SET MaHD = 'HD007'
	WHERE MaPTN = 'PTN007'
UPDATE PhieuTraNo
	SET MaHD = 'HD008'
	WHERE MaPTN = 'PTN008'
UPDATE PhieuTraNo
	SET MaHD = 'HD009'
	WHERE MaPTN = 'PTN009'
UPDATE PhieuTraNo
	SET MaHD = 'HD0010'
	WHERE MaPTN = 'PTN0010'
UPDATE PhieuTraNo
	SET MaHD = 'HD0011'
	WHERE MaPTN = 'PTN0011'
UPDATE PhieuTraNo
	SET MaHD = 'HD0012'
	WHERE MaPTN = 'PTN0012'
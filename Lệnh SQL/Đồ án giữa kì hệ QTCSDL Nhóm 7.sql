/*21130582_NguyenThiThanhTruc*/
CREATE DATABASE QuanLyCuaHang;
GO
USE QuanLyCuaHang;
GO
--Create table part--
create table KhachHang(
MaKH nvarchar(20) NOT NULL,
TenKH nvarchar(50) NOT NULL,
DiaChi nvarchar(50) NOT NULL,
SoDT varchar(10) NOT NULL,
NgaySinh datetime
);

create table NhaCungCap(
MaNCC nvarchar(30) NOT NULL,
TenNCC nvarchar(50) NOT NULL,
DiaChiNCC nvarchar(50),
SoDTNCC varchar(10)
);

create table SanPham(
MaSP nvarchar(20) NOT NULL,
TenSP nvarchar(50) NOT NULL,
DonViTinh nvarchar(20),
GiaBan money
);

create table CT_SanPham(
MaSP nvarchar(20) NOT NULL,
NuocSX varchar(20),
MaNCC nvarchar(30)
);

create table DonDatHang(
MaDDH nvarchar(20) NOT NULL,
NgayDH datetime,
MaNCC nvarchar(30),
HinhThucTT int check (HinhThucTT in (1, 2))
);

create table CT_DDH(
MaDDH nvarchar(20) NOT NULL,
MaSP nvarchar(20) NOT NULL,
SLDat int NOT NULL check (SLDat > 0)
);

create table HoaDon(
MaHD nvarchar(20) NOT NULL,
NgayLapHD datetime,
MaKH nvarchar(20)
);

create table CT_HoaDon(
MaHD nvarchar(20) NOT NULL,
MaSP nvarchar(20) NOT NULL,
SoLuongMua int NOT NULL check (SoLuongMua > 0),
DonGiaBan int NOT NULL
);

create table PhieuTraNo(
MaPTN nvarchar(20) NOT NULL,
NgayTra datetime,
SoTienTra money,
MaHD nvarchar(20) 
);

--Alter table part--
--Tạo primary key--
alter table KhachHang
	add constraint kh_pk primary key (MaKH)
alter table NhaCungCap
	add constraint ncc_pk primary key (MaNCC)
alter table SanPham
	add constraint sp_pk primary key (MaSP)
alter table CT_SanPham
	add constraint ctsp_pk primary key (MaSP)
alter table DonDatHang
	add constraint ddh_pk primary key (MaDDH)
alter table CT_DDH
	add constraint ddh_pk2 primary key (MaDDH, MaSP)
alter table HoaDon
	add constraint hd_pk primary key (MaHD)
alter table CT_HoaDon
	add constraint cthd_pk primary key (MaHD, MaSP)
alter table PhieuTraNo
	add constraint ptn_pk primary key (MaPTN)

--Tạo foreign key--
alter table CT_SanPham
	add constraint ctsp_fk foreign key (MaNCC) references NhaCungCap(MaNCC)
alter table DonDatHang
	add constraint ddh_fk foreign key (MaNCC) references NhaCungCap(MaNCC)
alter table HoaDon
	add constraint hd_fk foreign key (MaKH) references KhachHang(MaKH)
alter table PhieuTraNo
	add constraint ptn_fk foreign key (MaHD) references HoaDon(MaHD)

--Ràng buộc miền giá trị--
alter table DonDatHang
	add constraint chk_NgayDH_NotNull check (NgayDH is not null)
alter table HoaDon
	add constraint chk_NgayLapHD_NotNull check (NgayLapHD is not null)
alter table PhieuTraNo
	add constraint chk_NgayTra_NotNull check (NgayTra is not null)
/*21130606_Lê Vũ Ánh Tuyết*/
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
/*NGUYEN MINH THONG - 21130551 */
/* Câu 1 : Sp nhỏ hơn 20tr*/
GO
	CREATE VIEW v_SpNhoHon20tr
	AS SELECT MaSP , TenSP , GiaBan
	FROM SanPham
	WHERE GiaBan <20000000 ;
	
	GO 
	SELECT * 
	FROM v_SpNhoHon20tr
	ORDER BY MaSP DESC;
	Go

	
/* Câu 2 : Sp là laptop*/
GO
	CREATE VIEW v_SpLaLaptop
	AS SELECT MaSP , TenSP , GiaBan
	FROM SanPham ;
	GO
	SELECT *
	FROM v_SpLaLaptop
	WHERE TenSP LIKE 'Laptop%'
	ORDER BY MaSP DESC;
	GO
	

	/* Câu 3 : những khách hàng sinh dưới năm 1995*/
	GO
	CREATE VIEW v_KhDuoiNam1995
	AS SELECT MaKH , TenKH , NgaySinh
	FROM KhachHang
	WHERE YEAR(NgaySinh)<=1995;
	Go
	SELECT *
	FROM v_KhDuoiNam1995;
	GO

	/* Câu 4 : những hóa đơn trước tháng 6*/
	GO
	CREATE VIEW v_HDtrcThang6
	AS SELECT MaHD , NgayLapHD , MaKH
	FROM HoaDon
	WHERE YEAR(NgayLapHD) <=2023 AND MONTH(NgayLapHD) <=6;
	GO
	SELECT hd.MaHD , hd.MaKH , kh.TenKH ,kh.DiaChi ,hd.NgayLapHD
	FROM v_HDtrcThang6 hd join KhachHang kh ON hd.MaKH=kh.MaKH
	GO
	
	/* Câu 5 : những đơn đặt hàng có hình thức tt là 2 và tên ncc của nó*/
	GO
	CREATE VIEW v_DDHhinhThucTT2
	AS SELECT MaDDH , HinhThucTT ,MaNCC
	FROM DonDatHang
	WHERE HinhThucTT ='2';
	GO
	SELECT dh.MaDDH , dh.MaNCC , ncc.TenNCC,dh.HinhThucTT
	FROM v_DDHhinhThucTT2 dh join NhaCungCap ncc ON dh.MaNCC=ncc.MaNCC

	GO

	/* Câu 6 : những khách hàng nợ tiền */
	GO
	CREATE VIEW v_khNoTien
	AS SELECT MaPTN,MaHD,NgayTra,SoTienTra
	FROM PhieuTraNo
	GO
	SELECT ptn.MaPTN,ptn.MaHD,hd.MaKH,kh.TenKH,kh.SoDT,ptn.NgayTra,ptn.SoTienTra
	FROM v_khNoTien ptn join HoaDon hd ON ptn.MaHD=hd.MaHD
						join KhachHang kh ON hd.MaKH=kh.MaKH
	GO
	/* Câu 7:Danh sách các khách hàng đã mua sản phẩm và thông tin sản phẩm tương ứng*/
	GO
	CREATE VIEW v_TonKho_SanPham AS
	SELECT SP.MaSP, SP.TenSP, SP.DonViTinh, SP.GiaBan, COALESCE(SUM(CTHD.SoLuongMua), 0) - COALESCE(SUM(PTN.SoTienTra), 0) AS TonKho
	FROM SanPham SP
	LEFT JOIN CT_HoaDon CTHD ON SP.MaSP = CTHD.MaSP
	LEFT JOIN PhieuTraNo PTN ON SP.MaSP = PTN.MaHD
	GROUP BY SP.MaSP, SP.TenSP, SP.DonViTinh, SP.GiaBan;

	GO
	SELECT *
	FROM v_TonKho_SanPham;

	GO
	/* Câu 8 : Danh sách các sản phẩm được sản xuất trong nước:*/
	GO
	CREATE VIEW v_SanPham_Noibo AS
	SELECT MaSP, TenSP, DonViTinh, GiaBan 
	FROM SanPham
	WHERE MaSP IN (SELECT MaSP FROM CT_SanPham WHERE NuocSX = 'Việt Nam');
	GO
	SELECT *
	FROM v_SanPham_Noibo;
	DROP VIEW v_SanPham_Noibo;

	GO
	/* Câu 9 : Danh sách các đơn đặt hàng và số lượng sản phẩm đã đặt hàng (theo tháng)*/
	GO
	CREATE VIEW v_DDH_TongSLDatHang_Thang AS
SELECT DDH.MaDDH, DDH.NgayDH, DDH.MaNCC, DDH.HinhThucTT,
    COALESCE(SUM(CTDDH.SLDat), 0) AS TongSLDatHang
FROM DonDatHang DDH
LEFT JOIN CT_DDH CTDDH ON DDH.MaDDH = CTDDH.MaDDH
WHERE MONTH(DDH.NgayDH) = MONTH(GETDATE()) AND YEAR(DDH.NgayDH) = YEAR(GETDATE())
GROUP BY DDH.MaDDH, DDH.NgayDH, DDH.MaNCC, DDH.HinhThucTT;
 GO 
 SELECT *
 FROM v_DDH_TongSLDatHang_Thang;
 GO
 /* Câu 10 : Danh sách khách hàng và số lượng hóa đơn đã mua:*/
 GO
CREATE VIEW v_KhachHang_TongHoaDon AS
SELECT KH.MaKH, KH.TenKH, KH.DiaChi, KH.SoDT, COUNT(HD.MaHD) AS TongHoaDon
FROM KhachHang KH
LEFT JOIN HoaDon HD ON KH.MaKH = HD.MaKH
GROUP BY KH.MaKH, KH.TenKH, KH.DiaChi, KH.SoDT;
GO
SELECT *
FROM v_KhachHang_TongHoaDon;

/*21130573_Mai Thị Thu Trang*/
-- mai trang
--1.Danh sách sản phẩm bán được trong tháng bất kì của năm bất kì, với tháng và năm là tham số đầu vào
go
create proc proc_dsSanPham(@thang int,@nam int)
as
begin
   select  *
   from SanPham
   where MaSP in(select c.MaSP 
				 from CT_HoaDon c , HoaDon h
				 where c.MaHD=h.MaHD and MONTH(h.NgayLapHD)=@thang and YEAR(h.NgayLapHD)=@nam)
end
go
exec proc_dsSanPham 11,2023
--drop proc proc_dsDDH
--2.Viết một stored procedure để truy vấn và hiển thị danh sách các sản phẩm không bán được trong tháng, với tháng là tham số đầu vào
go
create proc proc_dsSanPhamTonKho(@thang int)
as
begin
   select  *
   from SanPham
   where MaSP not in(select c.MaSP 
				 from CT_HoaDon c , HoaDon h
				 where c.MaHD=h.MaHD and MONTH(h.NgayLapHD)=@thang)
end
go
exec proc_dsSanPhamTonKho 11
  --3. Proc để cập nhật giá bán của tất cả sản phẩm theo một tỷ lệ tăng:
 go
create proc proc_UpdateGia(@tyle DECIMAL(5,2))
as
begin
   Update SanPham
   SET GiaBan = GiaBan * (1 + @tyle / 100);
   PRINT 'Giá bán của tất cả sản phẩm đã được cập nhật thành công.';
end
go
exec proc_UpdateGia 5
go
print 'giá sau khi tăng'
select GiaBan
from SanPham 


 --4. Danh sách các đơn đặt hàng được thanh toán qua hình thức chuyển khoản với hình thức thanh toán n:
 go
 create proc proc_dsDDHVoiHTTT(@n int)
  as
begin
   select *
   from DonDatHang 
   where   HinhThucTT=@n
end
go
exec proc_dsDDHVoiHTTT 2
 --5. Cho biết danh sách các hóa đơn gồm MaHD, NgaylapHD, MaKH, TenKH và tổng trị giá của từng 
--HoaDon. Danh sách sắp xếp tăng dần theo ngày và giảm dần theo tổng trị giá của hóa đơn.
go
 create proc proc_dsHoaDonvaTongGia
  as
begin
   select h.MaHD, h.NgayLapHD, k.MaKH, k.TenKH, SUM(c.SoLuongMua*sp.GiaBan) TongGia
   from HoaDon h, KhachHang k, SanPham sp, CT_HoaDon c
   where  h.MaKH=k.MaKH and c.MaSP=sp.MaSP and c.MaHD=h.MaHD
   group by   h.MaHD, h.NgayLapHD, k.MaKH, k.TenKH
   order by   h.NgayLapHD,TongGia desc 

end
go
exec proc_dsHoaDonvaTongGia
/*NGO THUY TRANG-21130574*/
/*6.tao sp_ncc cho biet thong tin ve nha cung cap voi ma nha cung cap la tham so dau vao*/
GO
CREATE PROC sp_ncc @ma_ncc nvarchar(30)
AS SELECT *
FROM NhaCungCap
WHERE NhaCungCap.MaNCC=@ma_ncc
GO

EXEC sp_ncc 'NCC001'
go

/*7. Tao sp_SanPham cho biet nhung san pham da ban duoc*/
GO
CREATE PROC sp_SanPham 
AS SELECT *
FROM SanPham
WHERE SanPham.MaSP IN(SELECT CT_HoaDon.MaSP
                      FROM CT_HoaDon);
GO

EXEC sp_SanPham
go

/*8. tao thu tuc sp_doanhThu cua nam voi nam la tham so dau vao va tong doanh thu la tham so dau ra*/
GO
CREATE PROC sp_doanhThu @nam INT, @Tong INT OUT
AS SELECT @Tong = SUM(SoLuongMua*DonGiaBan)
FROM CT_HoaDon JOIN HoaDon ON CT_HoaDon.MaHD = HoaDon.MaHD
WHERE YEAR(HoaDon.NgayLapHD)=@nam
GO

DECLARE @tong int, @nam int = 2023;
EXEC sp_doanhThu @nam, @tong OUT
PRINT N'Tổng doanh thu nam' + STR(@nam)+  ' là: ' + STR(@tong)
GO

/*9. Tao thu tuc sp_danhSach liet ke n loai san pham ban chay nhat trong thang voi n va thang la tham so dau vao*/
GO
CREATE PROC sp_danhSach @n int, @month int
AS SELECT TOP(@n) a.MaSP, a.TenSP, SUM(SoLuongMua*DonGiaBan)as tongDoanhThu
FROM SanPham a JOIN CT_HoaDon b on a.MaSP = b.MaSP
     JOIN HoaDon c on b.MaHD = c.MaHD
WHERE MONTH(c.NgayLapHD)=@month
GROUP BY a.MaSP, a.TenSP
ORDER BY tongDoanhThu
go

EXEC sp_danhSach 2, 11
go

/* 10. tao thu tuc sp_sp dua ra tat ca san pham va loai san pham tuong ung*/
GO
CREATE PROC sp_sp
AS SELECT *
FROM SanPham
GO

EXEC sp_sp 
go
/* Cao Thành Tân-5 lệnh function đầu */

/*1.Lấy danh sách khách hàng và số lượng hóa đơn đã mua trong năm nay: */
GO
CREATE FUNCTION dbo.GetCustomerInvoiceCountThisYear()
RETURNS TABLE
AS
RETURN
(
    SELECT KhachHang.MaKH, TenKH, COUNT(HoaDon.MaHD) AS SoLuongHoaDon
    FROM KhachHang
    LEFT JOIN HoaDon ON KhachHang.MaKH = HoaDon.MaKH AND YEAR(NgayLapHD) = YEAR(GETDATE())
    GROUP BY KhachHang.MaKH, TenKH
);
GO
SELECT * FROM dbo.GetCustomerInvoiceCountThisYear();

/*2. Lấy danh sách đơn đặt hàng đã được thanh toán và chưa được thanh toán:
*/
GO
CREATE FUNCTION dbo.GetPaidAndUnpaidOrders()
RETURNS TABLE
AS
RETURN
(
    SELECT MaDDH, HinhThucTT, CASE WHEN MaHD IS NOT NULL THEN 'Đã thanh toán' ELSE 'Chưa thanh toán' END AS TinhTrang
    FROM DonDatHang
    LEFT JOIN HoaDon ON DonDatHang.MaDDH = HoaDon.MaHD
);
GO
SELECT * FROM dbo.GetPaidAndUnpaidOrders();

/*3.Lấy tổng doanh thu từ bán hàng của mỗi khách hàng:
 */
GO
CREATE FUNCTION dbo.GetTotalRevenueByCustomer()
RETURNS TABLE
AS
RETURN
(
    SELECT KhachHang.MaKH, TenKH, SUM(GiaBan * SoLuongMua) AS DoanhThu
    FROM KhachHang
    JOIN HoaDon ON KhachHang.MaKH = HoaDon.MaKH
    JOIN CT_HoaDon ON HoaDon.MaHD = CT_HoaDon.MaHD
    JOIN SanPham ON CT_HoaDon.MaSP = SanPham.MaSP
    GROUP BY KhachHang.MaKH, TenKH
);
GO
SELECT * FROM dbo.GetTotalRevenueByCustomer();

/*4.Lấy danh sách sản phẩm của một nhà cung cấp cụ thể:
 */
GO
CREATE FUNCTION dbo.GetProductsBySupplier(@MaNCC nvarchar(30))
RETURNS TABLE
AS
RETURN
(
    SELECT SanPham.MaSP, TenSP, DonViTinh, GiaBan
    FROM SanPham
    JOIN CT_SanPham ON SanPham.MaSP = CT_SanPham.MaSP
    WHERE CT_SanPham.MaNCC = @MaNCC
);
GO
SELECT * FROM dbo.GetProductsBySupplier('NCC001');

/*5. Lấy tổng số lượng sản phẩm đã bán theo từng tháng:
*/
GO
CREATE FUNCTION dbo.GetTotalSoldProductsByMonth()
RETURNS TABLE
AS
RETURN
(
    SELECT MONTH(NgayLapHD) AS Thang, SUM(SoLuongMua) AS TongSoLuongBan
    FROM HoaDon
    JOIN CT_HoaDon ON HoaDon.MaHD = CT_HoaDon.MaHD
    GROUP BY MONTH(NgayLapHD)
);
GO
SELECT * FROM dbo.GetTotalSoldProductsByMonth();
/*21130516_Mai Thị Sương */
/* 6  danh sách khách hàng có số lượng đơn hàng nhiều nhất:*/
GO
CREATE FUNCTION dbo.GetCustomersWithMostOrders()
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 1 KH.*
    FROM KhachHang KH
    JOIN HoaDon HD ON KH.MaKH = HD.MaKH
    GROUP BY KH.MaKH, KH.TenKH, KH.DiaChi, KH.SoDT, KH.NgaySinh
    ORDER BY COUNT(HD.MaHD) DESC
);
GO
-- Sử dụng hàm
SELECT * FROM dbo.GetCustomersWithMostOrders();
/*7 Tổng giá trị các đơn hàng của một nhà cung cấp:*/
GO
CREATE FUNCTION dbo.GetTotalOrderValueBySupplier(@SupplierID NVARCHAR(30))
RETURNS MONEY
AS
BEGIN
    DECLARE @TotalOrderValue MONEY;

    SELECT @TotalOrderValue = SUM(CTHD.SoLuongMua * CTHD.DonGiaBan)
    FROM HoaDon HD
    JOIN CT_HoaDon CTHD ON HD.MaHD = CTHD.MaHD
    JOIN CT_SanPham CTSP ON CTHD.MaSP = CTSP.MaSP
    WHERE CTSP.MaNCC = @SupplierID;

    RETURN @TotalOrderValue;
END;
GO
-- Sử dụng hàm
DECLARE @SupplierID NVARCHAR(30) = 'NCC001';
SELECT dbo.GetTotalOrderValueBySupplier(@SupplierID) AS TotalOrderValue;
/*8 Danh sách sản phẩm có giá bán cao nhất:*/
GO
CREATE FUNCTION dbo.GetProductsHighestPrice()
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 1 *
    FROM SanPham
    ORDER BY GiaBan DESC
);
GO
-- Sử dụng hàm
SELECT * FROM dbo.GetProductsHighestPrice();
/*9  Tổng số tiền phải trả của một khách hàng:*/
GO
CREATE FUNCTION dbo.GetTotalAmountToPayByCustomer(@CustomerID NVARCHAR(20))
RETURNS MONEY
AS
BEGIN
    DECLARE @TotalAmount MONEY;

    SELECT @TotalAmount = SUM(PTN.SoTienTra)
    FROM PhieuTraNo PTN
    JOIN HoaDon HD ON PTN.MaHD = HD.MaHD
    WHERE HD.MaKH = @CustomerID;

    RETURN @TotalAmount;
END;
GO
-- Sử dụng hàm
DECLARE @CustomerID NVARCHAR(20) = 'KH001';
SELECT dbo.GetTotalAmountToPayByCustomer(@CustomerID) AS TotalAmountToPay;
/*10 Danh sách sản phẩm được đặt hàng nhiều nhất:*/
GO
CREATE FUNCTION dbo.GetMostOrderedProducts()
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 1 SP.*, SUM(CTDDH.SLDat) AS TotalQuantityOrdered
    FROM SanPham SP
    JOIN CT_DDH CTDDH ON SP.MaSP = CTDDH.MaSP
    GROUP BY SP.MaSP, SP.TenSP, SP.DonViTinh, SP.GiaBan
    ORDER BY TotalQuantityOrdered DESC
);
GO
-- Sử dụng hàm
SELECT * FROM dbo.GetMostOrderedProducts();
/*21130565_Phạm Trung Tín Tạo 10 câu trigger*/
/*1 Tạo trigger PTN_insertNgayTra kiểm tra ràng buộc toàn vẹn sau đây mỗi khi cập nhập một 
dòng vào bảng PhieuTraNo: "Ngày Trả phải sau ngày lập hóa đơn"*/
GO
CREATE TRIGGER PTN_updateNgayTra ON PhieuTrano FOR UPDATE
AS
IF EXISTS (SELECT 1 FROM PhieuTraNo
JOIN HoaDon on PhieuTraNo.MaHD = HoaDon.MaHD
where DATEDIFF(DAY,HoaDon.NgayLapHD,PhieuTraNo.NgayTra) < 0)
BEGIN
RAISERROR ('Ngày Trả phải sau ngày lập hóa đơn',16,1)
ROLLBACK TRANSACTION
RETURN
END
GO
UPDATE PhieuTraNo SET NgayTra = '2023-02-01' WHERE MaHD LIKE 'HD001'
/*2 Tạo trigger NCC_insertSDT kiểm tra ràng buộc toàn vẹn sau đây mỗi khi thêm một 
dòng vào bảng NhaCungCap: "Số điện thoại không được có chữ cái"*/
GO
CREATE TRIGGER NCC_insertSDT ON NhaCungCap FOR INSERT
AS
  IF EXISTS (SELECT 1 FROM inserted WHERE ISNUMERIC(SoDTNCC) = 0)
    BEGIN
        RAISERROR('Số điện thoại không được có chữ cái', 16, 1)
        ROLLBACK TRANSACTION
    END
GO
INSERT INTO NhaCungCap(MaNCC,TenNCC,DiaChiNCC,SoDTNCC) VALUES ('NCC0013', 'Công ty TNHH A', 'Sài Gòn', '091234567a')
/*3 Tạo trigger KH_insertNgaySinh kiểm tra ràng buộc toàn vẹn sau đây mỗi khi thêm một 
dòng vào bảng KhachHang: "Ngày sinh phải nhỏ hơn ngày hiện tại"*/
GO
CREATE TRIGGER KH_insertNgaySinh ON KhachHang FOR INSERT
AS
IF EXISTS (SELECT *
        FROM inserted
        WHERE NgaySinh > GETDATE())
BEGIN
RAISERROR ('Ngày sinh phải nhỏ hơn ngày hiện tại', 16,1)
ROLLBACK TRANSACTION
RETURN 
END
GO
INSERT INTO KhachHang(MaKH,TenKH,DiaChi,SoDT,NgaySinh) VALUES ('KH0013', 'Nguyễn Văn A', '123 Đường ABC, Quận 1, TP.HCM', '0123456789', '2024-01-01')
/*4 Tạo trigger SP_insertDonViTinh kiểm tra ràng buộc toàn vẹn sau đây mỗi khi thêm một 
dòng vào bảng SanPham: "DonViTinh chỉ có thể là cái hoặc chiếc"*/
GO
CREATE TRIGGER SP_insertDonViTinh ON SanPham FOR INSERT
AS
IF EXISTS (SELECT DonViTinh FROM inserted WHERE DonViTinh NOT IN ('Cái','Chiếc'))
BEGIN
RAISERROR ('DonViTinh chỉ có thể là cái hoặc chiếc',16,1)
ROLLBACK TRANSACTION
RETURN 
END
GO
INSERT INTO SanPham(MaSP, TenSP, DonViTinh, GiaBan) VALUES ('SP0013', 'Máy tính xách tay Dell XPS 13', 'Vật', 20000000)
/*5 Tạo trigger CT_SP_updateNuocSX kiểm tra ràng buộc toàn vẹn sau đây mỗi khi cập nhập một 
dòng vào bảng CT_SanPham: "Không được cập nhập giá trị Việt Nam thêm nữa"  */
GO
CREATE TRIGGER CT_SP_updateNuocSX
ON CT_SanPham
FOR UPDATE
AS
BEGIN
  IF (SELECT NuocSX FROM inserted) = 'Việt Nam'
  BEGIN
    RAISERROR ('Không được cập nhập giá trị Việt Nam thêm nữa.', 16, 1);
    ROLLBACK TRANSACTION;
    RETURN;
  END
END
GO
UPDATE CT_SanPham
SET NuocSX = 'Việt Nam'
WHERE MaSP = 'SP002';
/*6 Tạo trigger PTN_insertPTN trên bảng PHIEUTRANO kiểm tra ràng buộc toàn vẹn sau đây mỗi khi thêm một 
dòng vào bảng PhieuTraNo:“ Khách hàng chỉ được trả tối đa 2 lần cho mỗi hóa đơn”*/
GO
CREATE TRIGGER PTN_insertPTN ON PhieuTraNo FOR INSERT
AS
 IF EXISTS (
        SELECT MaHD
        FROM (
            SELECT MaHD
            FROM PhieuTraNo
            UNION ALL
            SELECT MaHD
            FROM inserted
        ) AS combined
        GROUP BY MaHD
        HAVING COUNT(MaHD) >= 3
    )
BEGIN
        RAISERROR('Khách hàng chỉ được trả tối đa 2 lần cho mỗi hóa đơn',16,1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
	GO
INSERT INTO PhieuTraNo (MaPTN, NgayTra, SoTienTra, MaHD) VALUES ('PTN0013', '2023-03-03', 5000000, 'HD001')
 
/*7 Tạo trigger CT_HD_insertSlMua trên bảng CT_HOADON kiểm tra ràng buộc toàn vẹn sau đây mỗi khi thêm một 
dòng vào bảng CT_HoaDon :“Số lượng mua không được quá 10 ”*/
GO
CREATE TRIGGER CT_HD_insertSlMua ON CT_HoaDon FOR INSERT
AS
IF EXISTS (SELECT SoLuongMua FROM inserted where SoLuongMua > 10)
BEGIN
RAISERROR ('Số lượng mua không được quá 10',16,1)
ROLLBACK TRANSACTION
RETURN 
END
GO
INSERT INTO CT_HoaDon(MaHD, MaSP, SoLuongMua, DonGiaBan) VALUES ('HD0013', 'SP0013', 20, 21000000)
/*8 Tạo trigger HD_update trên bảng HOADON kiểm tra ràng buộc toàn vẹn sau đây mỗi khi cập nhật một 
dòng trên bảng HOADON:
 Không được cập nhật SoHD
 MaKH phải tồn tại trong bảng KH
 NgaylapHD <= Ngày hiện tại*/
GO
CREATE TRIGGER HD_update ON HOADON FOR UPDATE
AS
BEGIN
    IF UPDATE(MaHD)
    BEGIN
        RAISERROR('Không được cập nhật SoHD',16,1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;

    IF EXISTS (
        SELECT HD.MaKH
        FROM HOADON AS HD
        LEFT JOIN KhachHang AS K ON HD.MaKH = K.MaKH
        WHERE K.MaKH IS NULL
    )
    BEGIN
        RAISERROR('MaKH phải tồn tại trong bảng KH',16,1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;

    IF EXISTS (
        SELECT *
        FROM HOADON
        WHERE NgaylapHD > GETDATE()
    )
    BEGIN
        RAISERROR('NgaylapHD <= Ngày hiện tại',16,1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
END;
GO
UPDATE HOADON
SET MaHD = 'HD0013', NgayLapHD = '2024-01-01'
WHERE MaHD = 'HD0013';
/*9 Tạo trigger CT_DDH_insert trên bảng CT_DDH kiểm tra ràng buộc toàn vẹn sau đây mỗi khi cập nhật một 
dòng trên bảng CT_DDH: "Hai số đuôi của MaDDH và MaSP phải giống nhau"*/
GO
CREATE TRIGGER CT_DDH_insert ON CT_DDH FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT *
        FROM inserted AS I
        WHERE RIGHT(I.MaDDH, 2) <> RIGHT(I.MaSP, 2)
    )
    BEGIN
        RAISERROR ('Hai số đuôi của MaDDH và MaSP phải giống nhau', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END
END
GO
INSERT INTO CT_DDH(MaDDH, MaSP, SLDat) VALUES ('DDH0013', 'SP0014', 1)
/*10 Tạo trigger CT_HD_insertTong trên bảng CT_HOADON kiểm tra ràng buộc toàn vẹn sau đây mỗi khi thêm một 
dòng vào bảng CT_HOADON: "Tổng tiền của hóa đơn không được lớn hơn 200000000" */
GO
CREATE TRIGGER CT_HD_insertTong ON CT_HoaDon FOR INSERT
AS 
IF EXISTS (SELECT SoLuongMua,DonGiaBan FROM inserted where SoLuongMua*DonGiaBan > 200000000 )
BEGIN
RAISERROR ('Tổng tiền của hóa đơn không được lớn hơn 200000000',16,1)
ROLLBACK TRANSACTION;
        RETURN;
    END;
	GO
INSERT INTO CT_HoaDon(MaHD, MaSP, SoLuongMua, DonGiaBan) VALUES('HD0013', 'SP001', 10, 21000000)
/*Tạo xóa thay đổi user gồm username và password*/
/*21130565_Phạm Trung Tín*/
/*Tạo login*/
Use [master]
CREATE LOGIN Nhom7 with PASSWORD = '123456789'
/*Tạo user*/
USE [QuanLyCuaHang]
CREATE USER Nhom7 FOR LOGIN Nhom7
/*Xóa login*/
DROP LOGIN Nhom7
/*Cao thành Tân*/
/*Xóa user*/
DROP USER IF EXISTS Nhom7
/*Thay đổi login*/
Use [master]
CREATE LOGIN Nhom7 with PASSWORD = '123456789'
USE [QuanLyCuaHang]
CREATE USER Nhom7 FOR LOGIN Nhom7
USE [QuanLyCuaHang]
ALTER LOGIN Nhom7 WITH NAME = Nhom7Moi;
ALTER LOGIN Nhom7Moi WITH PASSWORD = '12345678910' MUST_CHANGE,
CHECK_EXPIRATION = ON;
DROP LOGIN Nhom7
/*Thay đổi user*/
ALTER USER Nhom7 WITH NAME = Nhom7Moi;
DROP USER IF EXISTS Nhom7

/*21130574 Ngo Thuy Trang*/


-- Tạo role
CREATE ROLE QuanLyKhachHang;
--gán quyền select cho quyền quản lý khách hàng trên bảng KhachHang
GRANT SELECT ON KhachHang TO QuanLyKhachHang;
GRANT INSERT ON KhachHang TO QuanLyKhachHang;

/*Thay đổi role*/
-- Thu hồi quyền SELECT cho quyền QuanLyKhachHang trên bảng KhachHang
REVOKE SELECT ON KhachHang FROM QuanLyKhachHang;
-- Cấp lại quyền SELECT cho quyền QuanLyKhachHang trên bảng KhachHang
GRANT SELECT,UPDATE ON KhachHang TO QuanLyKhachHang;
/*xóa role*/
-- Thu hồi tất cả các quyền từ role QuanLySanPham trên bảng KhachHang
REVOKE ALL PRIVILEGES ON KhachHang FROM QuanLyKhachHang;
-- Xóa role QuanLySanPham
DROP ROLE QuanLyKhachHang;


/*21130573 - Mai Thi Thu Trang*/


-- Tạo quyền (role)
CREATE ROLE QuanLySanPham;
--gán quyền select cho quyền quản lý sản phẩm trên bảng SanPham
GRANT SELECT ON SanPham TO QuanLySanPham;
/*Thay đổi role*/
-- Thu hồi quyền SELECT cho quyền QuanLySanPham trên bảng SanPham
REVOKE SELECT ON SanPham FROM QuanLySanPham;
-- Cấp lại quyền SELECT cho quyền QuanLySanPham trên bảng SanPham
GRANT SELECT,INSERT,UPDATE ON SanPham TO QuanLySanPham;
/*xóa role*/
-- Thu hồi tất cả các quyền từ role QuanLySanPham trên bảng SanPham
REVOKE ALL PRIVILEGES ON SanPham FROM QuanLySanPham;
-- Xóa role QuanLySanPham
DROP ROLE QuanLySanPham;

/*Nguyễn Minh Thông -21130551*/
/*Tạo role*/
USE [QuanLyCuaHang]
CREATE ROLE Nhom7Role;
USE [QuanLyCuaHang]
CREATE ROLE Nhom7Role2;
/*Gán quyền cho role*/
USE [QuanLyCuaHang]
/*TH1 : gán quyền để sử dụng 1 bảng nào đó : ở đây ví dụ là bảng SanPham*/
GRANT SELECT, INSERT, UPDATE, DELETE ON SanPham TO Nhom7Role;
/*TH2 : gán quyền để sử dụng toàn bộ tất cả các bảng :*/
USE [QuanLyCuaHang]

DECLARE @TableName NVARCHAR(128)
DECLARE table_cursor CURSOR FOR
SELECT name
FROM sys.tables

OPEN table_cursor
FETCH NEXT FROM table_cursor INTO @TableName

WHILE @@FETCH_STATUS = 0
BEGIN
    GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[@TableName] TO Nhom7Role
    FETCH NEXT FROM table_cursor INTO @TableName
END

CLOSE table_cursor
DEALLOCATE table_cursor
/*Gán quyền cho user*/
/*TH1 : gán quyền để sử dụng 1 bảng nào đó : ở đây ví dụ là bảng SanPham*/
USE [QuanLyCuaHang]
GRANT SELECT, INSERT, UPDATE, DELETE ON SanPham TO Nhom7Moi
/*TH2 : gán quyền để sử dụng toàn bộ tất cả các bảng :*/
USE [QuanLyCuaHang]

DECLARE @TableName2 NVARCHAR(128)
DECLARE table_cursor2 CURSOR FOR
SELECT name
FROM sys.tables

OPEN table_cursor2
FETCH NEXT FROM table_cursor2 INTO @TableName2

WHILE @@FETCH_STATUS = 0
BEGIN
    GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[@TableName2] TO Nhom7Moi
    FETCH NEXT FROM table_cursor2 INTO @TableName2
END

CLOSE table_cursor2
DEALLOCATE table_cursor2
/*Gán người dùng vào role*/

USE [QuanLyCuaHang]
GO

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = 'Nhom7Role')
BEGIN
    ALTER ROLE Nhom7Role ADD MEMBER Nhom7Moi;
END

/*Mai Thị Sương -21130516*/
/* Thu hồi người dùng khỏi 1 role*/
USE [QuanLyCuaHang]
IF EXISTS (SELECT * FROM sys.database_principals WHERE name = 'Nhom7Moi')
BEGIN
    ALTER ROLE Nhom7Role DROP MEMBER Nhom7Moi;
END

/*Thu hồi role từ cơ sở dữ liệu:*/
--USE [QuanLyCuaHang]
--DROP ROLE Nhom7Role;
/*Thu hồi quyền trên user*/
/*TH1 : Thu hồi quyền để sử dụng 1 bảng nào đó : ở đây ví dụ là bảng SanPham*/
USE [QuanLyCuaHang]
IF EXISTS (SELECT * FROM sys.database_principals WHERE name = 'Nhom7Moi')
BEGIN
    ALTER ROLE Nhom7Role ADD MEMBER Nhom7Moi;
END


/*TH2 : Thu hồi tất cả các quyền từ user Nhom7Moi trên bảng SanPham :*/
USE [QuanLyCuaHang]
GO

DECLARE @TableName3 NVARCHAR(128)

DECLARE table_cursor3 CURSOR FOR
SELECT name
FROM sys.tables

OPEN table_cursor3

FETCH NEXT FROM table_cursor3 INTO @TableName3

WHILE @@FETCH_STATUS = 0
BEGIN
    IF OBJECT_ID('[dbo].[@TableName3]') IS NOT NULL
    BEGIN
        REVOKE SELECT, INSERT, UPDATE, DELETE ON [dbo].[@TableName3] TO Nhom7Moi
    END

    FETCH NEXT FROM table_cursor3 INTO @TableName3
END

CLOSE table_cursor3
DEALLOCATE table_cursor3

GO
/*Thu hồi quyền trên role*/
/*TH1 : Thu hồi quyền để sử dụng 1 bảng nào đó : ở đây ví dụ là bảng SanPham*/
IF EXISTS (SELECT * FROM sys.database_principals WHERE name = 'Nhom7Role')
BEGIN
    REVOKE SELECT, INSERT, UPDATE, DELETE ON SanPham FROM Nhom7Role;
END
/*TH2 : Thu hồi quyền để sử dụng toàn bộ tất cả các bảng */
USE [QuanLyCuaHang]
GO

DECLARE @TableName4 NVARCHAR(128)

DECLARE table_cursor4 CURSOR FOR
SELECT name
FROM sys.tables

OPEN table_cursor4

FETCH NEXT FROM table_cursor4 INTO @TableName4

WHILE @@FETCH_STATUS = 0
BEGIN
    IF OBJECT_ID('[dbo].[@TableName3]') IS NOT NULL
    BEGIN
        REVOKE SELECT, INSERT, UPDATE, DELETE ON [dbo].[@TableName4] TO Nhom7Role
    END

    FETCH NEXT FROM table_cursor4 INTO @TableName4
END

CLOSE table_cursor4
DEALLOCATE table_cursor4

GO


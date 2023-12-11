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

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
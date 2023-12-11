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
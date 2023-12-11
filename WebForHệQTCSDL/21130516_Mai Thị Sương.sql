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

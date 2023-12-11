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
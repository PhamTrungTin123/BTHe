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
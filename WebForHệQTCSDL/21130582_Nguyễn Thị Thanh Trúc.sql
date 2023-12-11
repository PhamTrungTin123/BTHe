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
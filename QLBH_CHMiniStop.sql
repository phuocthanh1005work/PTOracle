-----------------------------------------QUAN LY CUA HANG MINISTOP ----------------------------------------------------------------------
--t?o b?ng Khách Hàng

CREATE TABLE KhachHang
(
	MaKH		nchar(4) primary key ,
	TenKH		nvarchar2(30)	not null,
	DiachiKH	nvarchar2(50),
	NgaySinhKH	date,
	SoDtKH		nvarchar2(10)
);

--t?o b?ng Nhân Viên

CREATE TABLE NhanVien
(
	MaNV		nchar(4) constraint PK_NhanVien primary key ,
	HoTenNV		nvarchar2(30)		not null,
	GioiTinh	nvarchar2(20)		not null
	constraint Ck_NhanVien_Gioitinh check (GioiTinh in (N'N?', N'Nam', N'Khác')),
	DiaChiNV	nvarchar2(50)		not null,
	NgaySinhNV		date		not null,
	DienThoaiNV		nvarchar2(15),
	Email			nvarchar2(20),
	NoiSinh			nvarchar2(20)	not null,
	NgayVaolam		date,
	MaNQL			nchar (4)
	constraint FK_NhanVien_MaNQL references NhanVien (MaNV)
)

--t?o b?ng Nhà cung c?p

CREATE TABLE NhaCC
(
	MaNCC		nchar(5) constraint PK_NhaCC primary key ,
	TenNCC		nvarchar2(50)	not null,
	DiaChiNCC	nvarchar2(50)		not null,
	DienThoaiNCC		nvarchar2(15)	not null,
	EmailNCC			nvarchar2(30)  not null	
)

--t?o b?ng Lo?i S?n Ph?m

CREATE TABLE LoaiSP
(
	MaLoaiSP		nchar (4) constraint PK_LoaiSP primary key ,
	TenLoaiSP		nvarchar2(30)	not null,
	Ghichu			nvarchar2(100)		not null
	
)

--t?o b?ng S?n Ph?m

CREATE TABLE SanPham
(
	MaSP		nchar (4) constraint PK_SanPham primary key ,
	MaLoaiSP	nchar (4)	not null,
	TenSP		nchar (50)		not null,
	DonViTinh		nvarchar2(10)	not null,
	
	constraint FK_SanPham_MaLoaiSP foreign key (MaLoaiSP) references LoaiSP (MaLoaiSP)
)

--t?o b?ng Kho Hàng

create table KhoHang
(
	MaSP nchar(4)
	constraint PK_KhoHang primary key,

	SoLuongTon int
	constraint Ck_KhoHang_SoLuongTon check (SoLuongTon >=0),
	constraint FK_KhoHang_MaSP foreign key (MaSP) references SanPham (MaSP)
)

--t?o b?ng Phi?u Nh?p
CREATE TABLE PhieuNhap
(
	SoPN		nchar (5) constraint PK_PhieuNhap primary key ,
	MaNV		nchar (4)	not null,
	MaNCC		nchar (5)	not null,
	NgayNhap	date	not null,
	

	constraint FK_PhieuNhap_MaNV foreign key (MaNV) references NhanVien (MaNV),
	constraint FK_PhieuNhap_MaNCC foreign key (MaNCC) references NhaCC (MaNCC)
)

--t?o b?ng Chi tiet Phi?u Nh?p

CREATE TABLE CTPhieuNhap
(
	SoPN		nchar (5),
	MaSP		nchar (4),
	SoLuongNhap	smallint not null
	constraint Ck_CTPN_Soluongnhap check (SoLuongNhap >=0),
	GiaNhap		decimal	not null
	constraint Ck_CTPN_GiaNhap check (GiaNhap >=0),

	constraint PK_CTPhieuNhap primary key(SoPN, MaSP),
	constraint FK_CTPhieuNhap_SoPN foreign key (SoPN) references PhieuNhap (SoPN),
	constraint FK_CTPhieuNhap_MaSP foreign key (MaSP) references SanPham (MaSP)
)

--t?o b?ng Hoa don

CREATE TABLE HoaDon
(
	MaHD		nchar (5) constraint PK_Hoadon primary key ,
	MaNV		nchar (4)	not null,
	MaKH		nchar (4)		not null,
	NgayBan		date	not null,
	

	constraint FK_Hoadon_MaNV foreign key (MaNV) references NhanVien (MaNV),
	constraint FK_PhieuNhap_MaKH foreign key (MaKH) references KhachHang (MaKH)
)

--t?o b?ng Chi tiet Phi?u Xuat

CREATE TABLE CTHoaDon
(
	MaHD		nchar (5),
	MaSP		nchar (4),
	SoLuongBan	smallint not null
	constraint Ck_CTHoaDon_SoLuongBan check (SoLuongBan >=0),
	GiaBan		decimal	not null
	constraint Ck_CTHoaDon_Giaban check (GiaBan >=0),
	constraint PK_CTHoaDon primary key (MaHD, MaSP),
	constraint FK_CTHoaDon_MaHD foreign key (MaHD) references HoaDon (MaHD),
	constraint FK_CTHoaDon_MaSP foreign key (MaSP) references SanPham (MaSP)
)


--1 Thêm d? li?u vào b?ng Nhân Viên

INSERT INTO NhanVien
VALUES ('V001', N'Tr?n Thành', 'Nam', N'Qu?n 1', (TO_DATE('10/10/1988','DD/MM/YYYY')), '0915007523', 'thanh@gmail.com', N'Qu?n 7', (TO_DATE('10/11/2010','DD/MM/YYYY')), Null);
INSERT INTO NhanVien
VALUES ('V002', N'Tr?n Thành Giang', 'Nam', N'Qu?n 12', (TO_DATE('21/06/1988','DD/MM/YYYY')), '0915007593', 'thanhgiang@gmail.com', N'Qu?n 8', (TO_DATE('21/02/2010','DD/MM/YYYY')), 'V001');
INSERT INTO NhanVien
VALUES ('V003', N'Tr?n H??ng Giang', N'N?', N'Qu?n 10', (TO_DATE('21/06/1998','DD/MM/YYYY')), '0915097593', 'giang@gmail.com', N'Qu?n 9', (TO_DATE('21/06/2016','DD/MM/YYYY')), 'V001'); 
INSERT INTO NhanVien
VALUES ('V004', N'Ngô H??ng Hòa', N'N?', N'Qu?n 10', (TO_DATE('29/07/1987','DD/MM/YYYY')), '0915091593', 'hoa@gmail.com', N'Qu?n 10', (TO_DATE('21/02/2014','DD/MM/YYYY')), 'V001');
INSERT INTO NhanVien
VALUES ('V005', N'Ngô Thành Hòa', N'N?', N'Qu?n Bình Th?nh', (TO_DATE('29/06/1986','DD/MM/YYYY')), '0935091593', 'thanhhoa@gmail.com', N'Qu?n 10', (TO_DATE('21/02/2017','DD/MM/YYYY')), Null);
INSERT INTO NhanVien
VALUES ('V006', N'Nguy?n Thành Giang', 'Nam', N'Qu?n 12', (TO_DATE('25/06/1960','DD/MM/YYYY')), '0915007599', 'ntgiang@gmail.com', N'Qu?n 12', (TO_DATE('21/02/2000','DD/MM/YYYY')), null);
INSERT INTO NhanVien
VALUES ('V007', N'Tr?n Nh? Ý', N'N?', N'Qu?n 2', (TO_DATE('21/06/1965','DD/MM/YYYY')), '0915807593', 'nhuy@gmail.com', N'Qu?n 8', null, null);

--2 Thêm d? li?u vào b?ng Khách Hàng

INSERT INTO KhachHang
VALUES ('KH01', N'Khách hàng vãng lai', null, null, null);
INSERT INTO KhachHang
VALUES ('KH02', N'Nguy?n H?ng', N'Qu?n 11', (TO_DATE('29/07/1986','DD/MM/YYYY')), '0978111333');
INSERT INTO KhachHang
VALUES ('KH03', N'Nguy?n Minh Tu?n', N'Qu?n 12', (TO_DATE('29/11/1981','DD/MM/YYYY')), '0988111333');
INSERT INTO KhachHang
VALUES ('KH04', N'Nguy?n Minh Anh', N'Qu?n 2', (TO_DATE('21/11/1982','DD/MM/YYYY')), '0988111332');
INSERT INTO KhachHang
VALUES ('KH05', N'Tr?n Minh Tu?n', N'Qu?n 6', (TO_DATE('21/10/1980','DD/MM/YYYY')), '0988111336');
INSERT INTO KhachHang
VALUES ('KH06', N'Nguy?n H?i', N'Qu?n Tân Bình', (TO_DATE('20/10/1986','DD/MM/YYYY')), '0978333333');
INSERT INTO KhachHang
VALUES ('KH07', N'Nguy?n Tu?n Tú', N'Qu?n 1', (TO_DATE('26/05/1988','DD/MM/YYYY')), '0988111222');
INSERT INTO KhachHang
VALUES ('KH08', N'Nguy?n Anh D?ng', N'Qu?n 4', (TO_DATE('24/08/1998','DD/MM/YYYY')), '0977211332');
INSERT INTO KhachHang
VALUES ('KH09', N'Tr?n Qu?c', N'Qu?n 6', (TO_DATE('06/08/1995','DD/MM/YYYY')), '0988111156');

--3 Thêm d? li?u vào b?ng Nhà Cung C?p

INSERT INTO NhaCC
VALUES ('CC001', N'Công ty XMN', N'Qu?n 11', '0928111333', 'xmn@xmn.com');
INSERT INTO NhaCC
VALUES ('CC002', N'Công ty VVMN', N'Qu?n Bình Tân', '0928111223', 'vnn@nn.com');
INSERT INTO NhaCC
VALUES ('CC003', N'Công ty XLUK', N'Qu?n 12', '0928111443', 'xluk@xluk.com');
INSERT INTO NhaCC
VALUES ('CC004', N'Công ty LGMN', N'Qu?n 8', '0988111444', 'xLG@xln.com');
INSERT INTO NhaCC
VALUES ('CC005', N'Công ty PGU', N'Qu?n 9', '0988111111', 'PLn@pln.com');

--4 Thêm d? li?u vào b?ng Lo?i S?n Ph?m

INSERT INTO LoaiSP
VALUES ('L001', N'B?t gi?t, n??c x?', N'Hàng tiêu dùng');
INSERT INTO LoaiSP
VALUES ('L002', N'Qu?n áo', N'Hàng th?i trang');
INSERT INTO LoaiSP
VALUES ('L003', N'Ch?m sóc da', N'Hóa m? ph?m');
INSERT INTO LoaiSP
VALUES ('L004', N'Ch?m sóc tóc', N'Hóa m? ph?m');
INSERT INTO LoaiSP
VALUES ('L005', N'Giày dép', N'Hàng th?i trang');
INSERT INTO LoaiSP
VALUES ('L006', N'Gia v?', N'Hàng tiêu dùng');
INSERT INTO LoaiSP
VALUES ('L007', N'Th?c ph?m', N'Hàng tiêu dùng');

--5 Thêm d? li?u vào b?ng S?n Ph?m

INSERT INTO SanPham
VALUES ('SP01', 'L001', N'N??c x? v?i comfort', N'Chai');
INSERT INTO SanPham
VALUES  ('SP02', 'L001', N'N??c r?a chén sunlight', N'Chai');
INSERT INTO SanPham
VALUES ('SP03', 'L003', N'S?a r?a m?t some by mi', N'Chai'); 
INSERT INTO SanPham
VALUES ('SP04', 'L003', N'Kem ng?n ng?a lão hóa', N'H?p'); 
INSERT INTO SanPham
VALUES ('SP05', 'L003', N'D??ng ch?t ph?c h?i da', N'Chai'); 
INSERT INTO SanPham
VALUES ('SP06', 'L002', N'Váy tr?ng công s?', N'Cái'); 
INSERT INTO SanPham
VALUES ('SP07', 'L002', N'S? mi công s?', N'Cái'); 
INSERT INTO SanPham
VALUES ('SP08', 'L006', N'Tiêu', N'Gói');
INSERT INTO SanPham
VALUES	('SP09', 'L005', N'Sandal n?', N'?ôi');
INSERT INTO SanPham
VALUES	('SP10', 'L004', N'D?u g?i th?o d??c', N'Chai');

INSERT INTO SanPham
VALUES ('SP11', 'L007', N'Bánh Oreo', N'Cái');
INSERT INTO SanPham
VALUES ('SP12', 'L004', N'Wax vu?t tóc', N'Chai');
INSERT INTO SanPham
VALUES ('SP13', 'L005', N'Giày bitis', N'?ôi');
INSERT INTO SanPham
VALUES ('SP14', 'L006', N'B?t ng?t', N'Gói');
INSERT INTO SanPham
VALUES ('SP15', 'L006', N'???ng', N'Gói');
INSERT INTO SanPham
VALUES ('SP16', 'L007', N'Bánh giò', N'Cái');
INSERT INTO SanPham
VALUES ('SP17', 'L004', N'Thu?c nhu?m tóc', N'H?p');
INSERT INTO SanPham
VALUES ('SP18', 'L006', N'N??c t??ng', N'Chai');
INSERT INTO SanPham
VALUES ('SP19', 'L005', N'Dép k?p', N'?ôi');
INSERT INTO SanPham
VALUES ('SP20', 'L004', N'Keo x?t tóc', N'Chai');

--6 Them du lieu vao bang KhoHang
insert into KhoHang
values ('SP01',0);
insert into KhoHang
values ('SP02',1000);
insert into KhoHang
values ('SP03',500);
insert into KhoHang
values ('SP04',700);
insert into KhoHang
values ('SP05',100);
insert into KhoHang
values ('SP06',100);
insert into KhoHang
values ('SP07',200);
insert into KhoHang
values ('SP08',400);
insert into KhoHang
values ('SP09',800);
insert into KhoHang
values ('SP10',100);
insert into KhoHang
values ('SP11',300);
insert into KhoHang
values ('SP12',400);
insert into KhoHang
values ('SP13',900);
insert into KhoHang
values ('SP14',400);
insert into KhoHang
values ('SP15',500);
insert into KhoHang
values ('SP16',200);
insert into KhoHang
values ('SP17',400);
insert into KhoHang
values ('SP18',100);
insert into KhoHang
values ('SP19',600);
insert into KhoHang
values ('SP20',90);
 
-------------------------------------------------------------------------------------------------------
--7 Thêm d? li?u vào b?ng Phi?u Nh?p ()

INSERT INTO PhieuNhap
VALUES ('PN01', 'V001', 'CC001', (TO_DATE('06/08/2019','DD/MM/YYYY')));
INSERT INTO PhieuNhap
VALUES ('PN02', 'V002', 'CC001',(TO_DATE('30/08/2019','DD/MM/YYYY')));
INSERT INTO PhieuNhap
VALUES ('PN03', 'V002', 'CC003',(TO_DATE('29/05/2020','DD/MM/YYYY')));
INSERT INTO PhieuNhap
VALUES ('PN04', 'V003', 'CC002', (TO_DATE('16/03/2021','DD/MM/YYYY')));
INSERT INTO PhieuNhap
VALUES ('PN05', 'V004', 'CC004', (TO_DATE('23/04/2019','DD/MM/YYYY')));
INSERT INTO PhieuNhap
VALUES ('PN06', 'V004', 'CC005', (TO_DATE('15/05/2020','DD/MM/YYYY')));
INSERT INTO PhieuNhap
VALUES ('PN07', 'V004', 'CC005', (TO_DATE('12/02/2019','DD/MM/YYYY')));

INSERT INTO PhieuNhap
VALUES ('PN08', 'V005', 'CC001', (TO_DATE('29/06/2019','DD/MM/YYYY')));
INSERT INTO PhieuNhap
VALUES	('PN09', 'V006', 'CC001', (TO_DATE('20/08/2020','DD/MM/YYYY')));
INSERT INTO PhieuNhap
VALUES ('PN10', 'V006', 'CC003', (TO_DATE('18/08/2021','DD/MM/YYYY')));
INSERT INTO PhieuNhap
VALUES ('PN11', 'V007', 'CC002', (TO_DATE('21/02/2019','DD/MM/YYYY')));
INSERT INTO PhieuNhap
VALUES ('PN12', 'V007', 'CC004', (TO_DATE('30/07/2020','DD/MM/YYYY')));
INSERT INTO PhieuNhap
VALUES ('PN13', 'V005', 'CC005', (TO_DATE('06/08/2020','DD/MM/YYYY')));
INSERT INTO PhieuNhap
VALUES ('PN14', 'V005', 'CC005', (TO_DATE('08/06/2021','DD/MM/YYYY')));


--8 Thêm d? li?u vào b?ng Chi ti?t Phi?u Nh?p

INSERT INTO CTPhieuNhap
VALUES 	('PN01', 'SP01',100, 73300);
INSERT INTO CTPhieuNhap
VALUES 	('PN01', 'SP02',200, 38300);
INSERT INTO CTPhieuNhap
VALUES ('PN02', 'SP03',100, 243000);
INSERT INTO CTPhieuNhap
VALUES ('PN02', 'SP04',50, 380000);
INSERT INTO CTPhieuNhap
VALUES ('PN02', 'SP05',50, 900000);
INSERT INTO CTPhieuNhap
VALUES ('PN03', 'SP06',300, 543000); 
INSERT INTO CTPhieuNhap
VALUES ('PN04', 'SP02',100, 38300);
INSERT INTO CTPhieuNhap
VALUES ('PN05', 'SP03',100, 243000);
INSERT INTO CTPhieuNhap
VALUES ('PN05', 'SP07',50, 250000);
INSERT INTO CTPhieuNhap
VALUES ('PN05', 'SP15',100, 603000); 
INSERT INTO CTPhieuNhap
VALUES ('PN06', 'SP03',100, 243000);
INSERT INTO CTPhieuNhap
VALUES ('PN06', 'SP07',50, 250000);
INSERT INTO CTPhieuNhap
VALUES ('PN06', 'SP06',400, 543000);
INSERT INTO CTPhieuNhap
VALUES ('PN06','SP16',50,520000);
INSERT INTO CTPhieuNhap
VALUES ('PN07','SP02',100, 38300);
INSERT INTO CTPhieuNhap
VALUES ('PN07','SP17',100, 423000); 
INSERT INTO CTPhieuNhap
VALUES ('PN07','SP20',100, 83300);
INSERT INTO CTPhieuNhap
VALUES ('PN08','SP08',100, 75000); 
INSERT INTO CTPhieuNhap
VALUES ('PN08','SP18',50, 520000);
INSERT INTO CTPhieuNhap
VALUES ('PN09', 'SP09',200, 40300);
INSERT INTO CTPhieuNhap
VALUES ('PN10', 'SP10',100, 250000);
INSERT INTO CTPhieuNhap
VALUES ('PN11', 'SP11',50, 390000); 
INSERT INTO CTPhieuNhap
VALUES ('PN12','SP12',50, 800000); 
INSERT INTO CTPhieuNhap
VALUES ('PN13','SP13',300, 603000);
INSERT INTO CTPhieuNhap
VALUES ('PN14','SP14',100, 50300);


--9 Thêm d? li?u vào b?ng Phi?u Xu?t

INSERT INTO HoaDon
VALUES ('HD01', 'V001', 'KH01', (TO_DATE('12/03/2021','DD/MM/YYYY')));
INSERT INTO HoaDon
VALUES ('HD02', 'V002', 'KH03', (TO_DATE('15/06/2020','DD/MM/YYYY')));
INSERT INTO HoaDon
VALUES ('HD03', 'V002', 'KH03', (TO_DATE('08/06/2021','DD/MM/YYYY')));
INSERT INTO HoaDon
VALUES ('HD04', 'V003', 'KH02', (TO_DATE('04/04/2020','DD/MM/YYYY')));
INSERT INTO HoaDon
VALUES ('HD05', 'V004', 'KH04', (TO_DATE('11/05/2020','DD/MM/YYYY')));
INSERT INTO HoaDon
VALUES ('HD06', 'V004', 'KH01', (TO_DATE('19/09/2021','DD/MM/YYYY')));
INSERT INTO HoaDon
VALUES ('HD07', 'V004', 'KH03', (TO_DATE('24/05/2020','DD/MM/YYYY')));
INSERT INTO HoaDon
VALUES ('HD08', 'V001', 'KH04', (TO_DATE('27/03/2021','DD/MM/YYYY')));


--10 Thêm d? li?u vào b?ng Chi ti?t Phi?u Xu?t

INSERT INTO CTHoaDon
VALUES ('HD01', 'SP01', 5, 85000);
INSERT INTO CTHoaDon
VALUES ('HD01', 'SP02',50, 45000);
INSERT INTO CTHoaDon
VALUES ('HD02', 'SP03', 5, 300000); 
INSERT INTO CTHoaDon
VALUES ('HD02', 'SP01',3, 85000);
INSERT INTO CTHoaDon
VALUES ('HD02', 'SP05', 1, 900000);
INSERT INTO CTHoaDon
VALUES ('HD03', 'SP01', 3, 85000); 
INSERT INTO CTHoaDon
VALUES ('HD04', 'SP02', 30,45000);
INSERT INTO CTHoaDon
VALUES ('HD05', 'SP04', 10, 450000); 
INSERT INTO CTHoaDon
VALUES ('HD05', 'SP07',2, 300000);
INSERT INTO CTHoaDon
VALUES ('HD06', 'SP03', 1, 300000); 
INSERT INTO CTHoaDon
VALUES ('HD06', 'SP07',1, 300000);  
INSERT INTO CTHoaDon
VALUES ('HD06', 'SP06', 1, 650000); 
INSERT INTO CTHoaDon
VALUES ('HD07', 'SP05', 2, 900000);
INSERT INTO CTHoaDon
VALUES ('HD08', 'SP05', 2, 900000);

---------------------------------------------------------------------------------------------------------------------
----------------------------------- PROCEDURE ------------------------------------------------
--THU TUC 1: THAM SO VAO LA MAKHACHHANG (KHACH HANG) 
---> LIET KE DANH SACH HOA DON MA KHACH HANG MUA
CREATE OR REPLACE PROCEDURE THUTUC1 (KH_ID KHACHHANG.MAKH%TYPE)
AS
    CURSOR KH IS SELECT CTHOADON.*
                FROM HOADON JOIN CTHOADON ON HOADON.MAHD=CTHOADON.MAHD
                WHERE KH_ID=MAKH;   
    V_CT CTHOADON%ROWTYPE;
BEGIN
    DBMS_OUTPUT.put_line('DANH SACH MUA HANG CUA KHACH HANG ' || KH_ID);
    OPEN KH;
    LOOP   
    FETCH KH INTO V_CT;
        DBMS_OUTPUT.put_line(' ');
        DBMS_OUTPUT.put_line('MA HOA DON: '|| V_CT.MAHD);
        DBMS_OUTPUT.put_line('MA SANPHAM: '|| V_CT.MASP); 
        DBMS_OUTPUT.put_line('SO LUONG BAN: '|| V_CT.SOLUONGBAN);
        DBMS_OUTPUT.put_line('GIA BAN: '|| V_CT.GIABAN);
        DBMS_OUTPUT.put_line('THANH TIEN: '|| V_CT.GIABAN*V_CT.SOLUONGBAN);
    EXIT WHEN KH%NOTFOUND;
    END LOOP;
    CLOSE KH;   
END THUTUC1;

--THUC THI
set serveroutput on;
execute THUTUC1('KH05')

--THU TUC 2: THAM SO VAO LA THANG, NAM 
---> THU TUC 
--- IN TAT CA CAC DON HANG DUOC MUA TRONG THANG,NAM DO
--- IN TAT CA CAC DON HANG DUOC NHAP TU NHA CUNG CAP TRONG THANG, NAM DO
CREATE OR REPLACE PROCEDURE THUTUC2 (THANG NUMBER, NAM NUMBER)
AS
    CURSOR DONBAN IS SELECT HOADON.*
                FROM HOADON JOIN CTHOADON ON HOADON.MAHD=CTHOADON.MAHD
                WHERE TO_NUMBER(TO_CHAR(NGAYBAN,'MM'))=THANG AND TO_NUMBER(TO_CHAR(NGAYBAN, 'YYYY'))=NAM; 
    CURSOR DONNHAP IS SELECT PHIEUNHAP.*
                FROM PHIEUNHAP JOIN CTPHIEUNHAP ON PHIEUNHAP.SOPN=CTPHIEUNHAP.SOPN
                WHERE TO_NUMBER(TO_CHAR(NGAYNHAP,'MM'))=THANG AND TO_NUMBER(TO_CHAR(NGAYNHAP, 'YYYY'))=NAM; 
                
                
    V_BAN HOADON%ROWTYPE;
    V_NHAP PHIEUNHAP%ROWTYPE;
BEGIN
    DBMS_OUTPUT.put_line('--------------------------------------- ');
    DBMS_OUTPUT.put_line('DANH SACH DON BAN TRONG THANG ' || THANG || ' NAM ' || NAM);
    OPEN DONBAN;
    LOOP   
    FETCH DONBAN INTO V_BAN;
        DBMS_OUTPUT.put_line(' ');
        DBMS_OUTPUT.put_line('MA HOA DON: '|| V_BAN.MAHD);
        DBMS_OUTPUT.put_line('NGAY BAN: '|| V_BAN.NGAYBAN);
    EXIT WHEN DONBAN%NOTFOUND;
    END LOOP;
    CLOSE DONBAN;
    
    DBMS_OUTPUT.put_line('--------------------------------------- ');
    
    DBMS_OUTPUT.put_line('DANH SACH DON NHAP TRONG THANG ' || THANG || ' NAM ' || NAM);
    OPEN DONNHAP;
    LOOP   
    FETCH DONNHAP INTO V_NHAP;
        DBMS_OUTPUT.put_line(' ');
        DBMS_OUTPUT.put_line('SO PHIEU NHAP: '|| V_NHAP.SOPN);
        DBMS_OUTPUT.put_line('NGAY NHAP: '|| V_NHAP.NGAYNHAP);
    EXIT WHEN DONNHAP%NOTFOUND;
    END LOOP;
    CLOSE DONNHAP;
    
END THUTUC2;

--THUC THI
set serveroutput on;
execute THUTUC2(05,2020)

--THU TUC 3: THAM SO VAO LA MALOAISP (LOAI SAN PHAM)
-- THAM SO DAU RA LA THONG TIN VE SAN PHAM THUOC LOAI SAN PHAM DA NHAP
CREATE OR REPLACE PROCEDURE THUTUC3 (LOAISP_ID SANPHAM.MALOAISP%TYPE)
AS
    CURSOR LSP IS SELECT *
                FROM SANPHAM
                WHERE MALOAISP=LOAISP_ID;
BEGIN
    --DBMS_OUTPUT.put_line('DANH SACH MUA HANG CUA KHACH HANG ' || KH_ID);
    FOR V_SP IN LSP
    LOOP 
    EXIT WHEN LSP%NOTFOUND;
        DBMS_OUTPUT.put_line(' ');
        DBMS_OUTPUT.put_line('MA SANPHAM: '|| V_SP.MASP); 
        DBMS_OUTPUT.put_line('TEN SAN PHAM: '|| V_SP.TENSP);
        DBMS_OUTPUT.put_line('DON VI TINH: '|| V_SP.DONVITINH);
    END LOOP;   
    EXCEPTION WHEN no_data_found THEN DBMS_OUTPUT.put_line('KHONG CO LOAI SAN PHAM ');  
END THUTUC3;


--THUC THI
set serveroutput on;
execute THUTUC3('L005')

--THU TUC 4: THAM SO VAO LA MAKH (KHACHHANG)
-- THEM KHACH HANG MOI
create or replace procedure THUTUC4 (V_KH KHACHHANG.MAKH%TYPE, 
                                    V_TENKH KHACHHANG.TENKH%TYPE)
as
    V_MAKH_TAM KHACHHANG.MAKH%TYPE;
    V_LOI EXCEPTION;
begin
    --KIEM TRA MAKH CO HAY CHUA
    select MAKH into V_MAKH_TAM 
    from KHACHHANG
    where MAKH=V_MAKH_TAM;
    
    if V_MAKH_TAM is not null then
    raise V_LOI;
    end if;
    --BAOLOI
    exception when V_LOI then
    dbms_output.put_line('KHACH HANG NAY DA TON TAI TRONG HE THONG');
    --THEM VAO
    when no_data_found then
        insert into KHACHHANG (MAKH,TENKH) values (V_KH,V_TENKH);
    dbms_output.put_line('KHACH HANG ' || V_TENKH || ' DA THEM THANH CONG.');
end;

--THUC THI
set serveroutput on
execute THUTUC4('KH88','THANH');


--THU TUC 5: THAM SO TRUYEN VAO LA MA SAN PHAM
-- CAP NHAT GIAM GIA 5% CHO SAN PHAM VAO THANG 12
create or replace procedure THUTUC5 (SP_ID CTHOADON.MASP%TYPE)
as
 begin
     update CTHOADON
     set GIABAN = GIABAN-GIABAN*0.05
     where MASP=SP_ID AND MAHD IN (SELECT MAHD FROM HOADON WHERE TO_NUMBER(TO_CHAR(NGAYBAN,'MM'))=3);
     dbms_output.put_line('CAP NHAT GIA BAN SAN PHAM '|| SP_ID ||' THANH CONG!');
 end;
--THUC THI
set serveroutput on
execute THUTUC5('SP01');


--THU TUC 6: THU TUC THEM MOI NHAN VIEN VOI TAT CA THONG TIN NHAN VIEN LA THAM SO TRUYEN VAO
create or replace procedure THUTUC6 (V_MANV NHANVIEN.MANV%TYPE, 
                                    V_TENNV NVARCHAR2,
                                    V_GIOITINH NVARCHAR2,
                                    V_DCNV NVARCHAR2,
                                    V_NGAYSINH NHANVIEN.NGAYSINHNV%TYPE,
                                    V_DT NVARCHAR2,
                                    V_EMAIL NVARCHAR2,
                                    V_NOISINH NVARCHAR2,
                                    V_NGAYVAOLAM NVARCHAR2,
                                    V_MANQL NHANVIEN.MANV%TYPE)
as
    V_DEM NUMBER;

begin
    --KIEM TRA MAKH CO HAY CHUA
    select COUNT(*) into V_DEM 
    from NHANVIEN
    where MANV=V_MANV;
    
    IF V_DEM > 0 then dbms_output.put_line('NHAN VIEN NAY DA TON TAI TRONG HE THONG');
    ELSE 
        INSERT INTO NHANVIEN VALUES (V_MANV, V_TENNV,V_GIOITINH, V_DCNV, 
                                    V_NGAYSINH,V_DT, V_EMAIL, V_NOISINH, V_NGAYVAOLAM,V_MANQL);
    dbms_output.put_line('THEM THANH CONG!');                                
    END IF;

end;

--THUC THI
set serveroutput on
execute THUTUC6('V099', N'AAA', 'Nam', N'BB', (TO_DATE('10/10/1999','DD/MM/YYYY')),'0999999', 'XCA@gmail.com', N'AAA7', (TO_DATE('10/11/2010','DD/MM/YYYY')), Null);

--THU TUC 7: THAM SO TRUYEN VAO LA MA NHAN VIEN
-- SA THAI NHAN VIEN (XOA CAC THONG TIN NHAN VIEN RA KHOI HE THONG)
create or replace procedure THUTUC7(NV_ID NHANVIEN.MANV%TYPE)
as
    V_DEM NUMBER;
begin
    select COUNT(*) into V_DEM 
    from NHANVIEN
    where MANV=NV_ID;
    
    IF V_DEM > 0 then delete from NHANVIEN where MANV=NV_ID;
    ELSE dbms_output.put_line('KHONG TON TAI NHAN VIEN NAY');
    END IF;
    
    IF V_DEM >0 THEN  dbms_output.put_line('DA XOA '||NV_ID||' THANH CONG!');                         
    END IF;

END;


--THUC THI
set serveroutput on
execute THUTUC7 ('V777')

--THU TUC 8: NHAP THAM SO DAU VAO LA MA SAN PHAM
-- THU TUC TIM KIEM NHA CUNG CAP CO GIA NHAP SAN PHAM RE NHAT
CREATE OR REPLACE PROCEDURE THUTUC8 (SP_ID SANPHAM.MASP%TYPE)
AS
    CURSOR CC IS SELECT NHACC.*
                FROM NHACC 
                WHERE MANCC IN (SELECT P.MANCC
                                FROM PHIEUNHAP P JOIN CTPHIEUNHAP C ON P.SOPN=C.SOPN
                                WHERE MASP=SP_ID AND GIANHAP <= (SELECT GIANHAP 
                                                                FROM CTPHIEUNHAP
                                                                WHERE MASP=SP_ID));   
    V_NCC NHACC%ROWTYPE;
BEGIN
    OPEN CC;
    LOOP   
    FETCH CC INTO V_NCC;
        DBMS_OUTPUT.put_line(' ');
        DBMS_OUTPUT.put_line('MA NHA CUNG CAP: '|| V_NCC.MANCC);
        DBMS_OUTPUT.put_line('TEN NHA CUNG CAP: '|| V_NCC.TENNCC); 
        DBMS_OUTPUT.put_line('DIA CHI: '|| V_NCC.DIACHINCC);
       
    EXIT WHEN CC%NOTFOUND;
    END LOOP;
    CLOSE CC;   
END THUTUC8;

--THUC THI
set serveroutput on
execute THUTUC8 ('SP14')

--THU TUC 9: NHAP THAM SO DAU VAO LA MA SAN PHAM
-- THU TUC CHO BIET NHUNG KHACH HANG DA MUA SAN PHAM NAY
CREATE OR REPLACE PROCEDURE THUTUC9 (SP_ID SANPHAM.MASP%TYPE)
AS
    CURSOR KH IS SELECT KH.*
                FROM HOADON JOIN CTHOADON ON HOADON.MAHD=CTHOADON.MAHD
                            JOIN KHACHHANG KH ON HOADON.MAKH=KH.MAKH
                WHERE SP_ID=MASP;   
    V_KH KHACHHANG%ROWTYPE;
BEGIN
    DBMS_OUTPUT.put_line('DANH SACH NHUNG KHACH HANG DA MUA SAN PHAM ' || SP_ID);
    OPEN KH;
    LOOP   
    FETCH KH INTO V_KH;
        DBMS_OUTPUT.put_line(' ');
        DBMS_OUTPUT.put_line('MA KHACH HACNG: '|| V_KH.MAKH);
        DBMS_OUTPUT.put_line('TEN KHACH HANG: '|| V_KH.TENKH); 

    EXIT WHEN KH%NOTFOUND;
    END LOOP;
    CLOSE KH;   
END THUTUC9;

--THUC THI
set serveroutput on;
execute THUTUC9('SP01')

--THU TUC 10: THU TUC XOA CT HOA DON
create or replace procedure THUTUC10 (V_HD HOADON.MAHD%TYPE,V_SP CTHOADON.MASP%TYPE)
as
    V_DEM NUMBER;

begin
    --KIEM TRA CO HAY CHUA
    select COUNT(*) into V_DEM 
    from CTHOADON
    where MAHD=V_HD AND MASP=V_SP;
    
    IF V_DEM > 0 then 
    DELETE FROM CTHOADON WHERE MAHD=V_HD AND MASP=V_SP;
    dbms_output.put_line('DA XOA');
    ELSE 

    dbms_output.put_line('KHONG CO CHI TIET HOA DON NAY!');                                
    END IF;

end;

--THUC THI
set serveroutput on
execute THUTUC10('HD01','SP01');
---------------------------------------- FUNCTION -----------------------------------------
--FUNCTION 1: NHAN VAO THAM SO MAHD CUA HOADON. 
--HAM TRA VE NHAN VIEN PHU TRACH HOA DON DO
CREATE OR REPLACE FUNCTION F1(HD_ID HOADON.MAHD%TYPE)
RETURN VARCHAR2
AS
    NV NHANVIEN%ROWTYPE;

BEGIN
    SELECT NHANVIEN.* INTO NV
    FROM NHANVIEN JOIN HOADON ON NHANVIEN.MANV=HOADON.MANV
    WHERE HOADON.MAHD=HD_ID;
    RETURN NV.MANV || ' - ' || NV.HOTENNV|| ' - ' ||NV.GIOITINH|| ' - ' ||NV.DIACHINV|| ' - ' ||NV.NGAYSINHNV|| ' - ' ||NV.DIENTHOAINV|| ' - ' ||NV.EMAIL|| ' - ' ||NV.MANQL;
END F1;


-- TEST
SELECT F1('HD02') AS THONGTINNV_PHUTRACH FROM DUAL;

--FUNCTION 2: NHAP VAO THAM SO LA MANV (NHAN VIEN).
---> HAM TRA VE DANH SACH NHUNG HOA DON MA NHAN VIEN DO PHU TRACH
CREATE OR REPLACE FUNCTION F2(NV_ID in NHANVIEN.MANV%TYPE)
RETURN VARCHAR2
As 
    V_HD VARCHAR(1000);
BEGIN
    FOR ITEM IN (SELECT H.MAHD 
                    FROM NHANVIEN N JOIN HOADON H ON N.MANV=H.MANV
                                JOIN CTHOADON CT ON H.MAHD= CT.MAHD
                    WHERE H.MANV = NV_ID)
    LOOP
    V_HD:= V_HD || ITEM.MAHD ||' ; ';
    END LOOP;
    RETURN V_HD;
END;

--TEST
SELECT F2('V001') AS DANHSACH_HOADON_DONHANVIEN_PHUTRACH FROM DUAL;

--FUNCTION 3: NHAP VAO THAM SO LA MANCC. 
-- HAM TRA VE TONG SO TIEN DA NHAP HANG TU NHA CUNG CAP DO
create or replace function F3(NCC_ID NHACC.MANCC%TYPE)
return number
as
    V_TONGTIEN number;
begin
    select sum(GIANHAP) into V_TONGTIEN
    from PHIEUNHAP P JOIN CTPHIEUNHAP C ON P.SOPN=C.SOPN
    where MANCC=NCC_ID;
        return V_TONGTIEN;
    exception when no_data_found then
        return('KHONG TIM THAY NHA CUNG CAP');
    when others then
        return('LOI HAM');
end;

--TEST
SELECT F3('CC001') AS TONGSOTIEN FROM DUAL;


--FUNCTION 4: NHAP VAO THAM SO LA MAKH
-- HAM TRA VE TONG DOANH SO MUA HANG CUA KHACH HANG DO
CREATE OR REPLACE FUNCTION F4 (KH_ID HOADON.MAKH%TYPE)
RETURN NUMBER
IS
S_TONG NUMBER;
BEGIN
    SELECT SUM(GIABAN*SOLUONGBAN)
    INTO S_TONG
    FROM HOADON H JOIN CTHOADON C ON H.MAHD=C.MAHD
    WHERE MAKH = KH_ID
    GROUP BY H.MAHD;
RETURN S_TONG;
END;
-- Test
SELECT F4('KH02') AS TONGDOANHSO_MUAHANG_CUAKHACHHANG FROM DUAL;

--FUNCTION 5: NHAP VAO THAM SO LA NGAY BAN
-- HAM TRA VE SAN PHAM BAN TRONG NGAY DO
CREATE OR REPLACE FUNCTION F5(NGAY_BAN NUMBER)
RETURN VARCHAR2
As V_TEN VARCHAR(1000);
BEGIN
    FOR ITEM IN (SELECT S.TENSP FROM CTHOADON C JOIN SANPHAM S ON C.MASP=S.MASP
                            JOIN HOADON H ON C.MAHD=H.MAHD
                    WHERE TO_NUMBER(TO_CHAR(NGAYBAN,'DD')) = NGAY_BAN)
    LOOP
    V_TEN:= V_TEN || ITEM.TENSP ||';';
    END LOOP;
RETURN V_TEN;
END;
--test
SELECT F5(28) SANPHAM_BANTRONGNGAY FROM DUAL;

--FUNCTION 6: NHAP VAO THAM SO LA NAM
-- HAM TRA VE SO LUONG NHAN VIEN DUOC TUYEN DUNG TRONG NAM DO
CREATE OR REPLACE FUNCTION F6(NAM NUMBER)
RETURN NUMBER
AS
    N NUMBER;
BEGIN
    SELECT COUNT(*) INTO N
    FROM NHANVIEN
    WHERE TO_NUMBER(TO_CHAR(NGAYVAOLAM, 'yyyy')) = NAM;
    RETURN N;
END F6;
-- TEST
SELECT F6(2010) AS SOLUONG_NHANVIEN_DUOCTUYEN FROM DUAL;

--FUNCTION 7: NHAP VAO MA SAN PHAM
-- HAM KIEM TRA XEM TRONG KHO HANG SAN PHAM NAY CON HAY HET
CREATE OR REPLACE FUNCTION F7 (SP_ID IN KHOHANG.MASP%TYPE) 
    RETURN VARCHAR2
    AS
        CO VARCHAR2(100);
        KO VARCHAR2(100);
        N INT;
    BEGIN
        CO :='SAN PHAM NAY CON TRONG KHO HANG';
        KO  :='SAN PHAM NAY DA HET!!!';
        SELECT COUNT(*) 
        INTO N 
        FROM KHOHANG
        WHERE MASP = SP_ID;
        IF N>0 THEN RETURN CO;
        ELSE RETURN KO;
        END IF;
        RETURN N;
END F7;

-- TEST
SELECT F7('SP20') AS KETQUA_KIEMTRA_SANPHAM FROM DUAL;
SELECT F7('SP222')AS KETQUA_KIEMTRA_SANPHAM FROM DUAL;

-- FUNCTION 8: NHAP VAO THAM SO LA MA NHAN VIEN
-- HAM TRA VE THONG TIN VE NGUOI QUAN LY NHAN VIEN DAY
CREATE OR REPLACE FUNCTION F8(NV_ID NHANVIEN.MANV%TYPE)
RETURN VARCHAR2
AS
    V_NV NHANVIEN%ROWTYPE;
BEGIN
    SELECT * INTO V_NV
    FROM NHANVIEN
    WHERE MANV = 
    ( 
        SELECT MANQL
        FROM NHANVIEN
        WHERE MANV = NV_ID
    );
    RETURN V_NV.MANV || ' ' || V_NV.HOTENNV;
END F8;

-- TEST
SELECT F8('V002') AS THONGTIN_NGUOIQUANLY FROM DUAL;

--FUNCTION 9: NHAP VAO THAM SO LA MAncc
-- HAM TRA VE TONG DOANH SO NHAP HANG TU NHACC DO
CREATE OR REPLACE FUNCTION F9 (NHACC_ID PHIEUNHAP.SOPN%TYPE)
RETURN NUMBER
IS
S_TONG NUMBER;
BEGIN
    SELECT SUM(GIANHAP*SOLUONGNHAP)
    INTO S_TONG
    FROM PHIEUNHAP P JOIN CTPHIEUNHAP C ON P.SOPN=C.SOPN
    WHERE MANCC = NHACC_ID;
RETURN S_TONG;
END;
-- Test
SELECT F9('CC002') AS TONGTIEN_NHAPHANG_TUNHACC FROM DUAL;

-- FUNCTION 10: NHAP VAO THAM SO LA MA LOAI SP
-- HAM TRA VE THONG TIN VE SAN PHAM THUOC LOAI SP NAY
CREATE OR REPLACE FUNCTION F10(LOAISP_ID LOAISP.MALOAISP%TYPE)
RETURN VARCHAR2
AS
    V_SP VARCHAR(1000);
BEGIN
    FOR ITEM IN (SELECT SANPHAM.*
                        FROM SANPHAM
                        WHERE MALOAISP=LOAISP_ID)       
    LOOP
    V_SP:= V_SP || ITEM.TENSP ||' ; ';
    END LOOP;
    RETURN V_SP;

END F10;

-- TEST
SELECT F10('L002') AS THONGTIN_CACSANPHAM_THUOCLOAISP FROM DUAL;
---------------------------------------- PACKAGES -----------------------------
-- PACKAGES 1: 
-- THU TUC NHAN VAO 1 THAM SO LA MASP (SANPHAM), CAC THAM SO RA LA THONG TIN CUA NHA CUNG CAP SAN PHAN DO
-- HAM NHAN VAO 1 THAM SO LA MASP (SANPHAM). HAM TRA VE 1 NEU MASP TON TAI TRONG BANG, NGUOC LAI TRA VE 0
CREATE OR REPLACE PACKAGE P1
AS
    PROCEDURE P1_detail (I_SANPHAM_ID IN SANPHAM.MASP%TYPE, 
                            O_NHACC_MANCC OUT NHACC.MANCC%TYPE, 
                            O_NHACC_TENNCC OUT NHACC.TENNCC%TYPE, 
                            O_NHACC_DIACHINCC OUT NHACC.DIACHINCC%TYPE);
    FUNCTION P1_find (I_SANPHAM_ID IN SANPHAM.MASP%TYPE) 
    RETURN INT;
END P1;

-- BODY
CREATE OR REPLACE PACKAGE BODY
    P1
AS
    PROCEDURE P1_detail (I_SANPHAM_ID IN SANPHAM.MASP%TYPE, 
                            O_NHACC_MANCC OUT NHACC.MANCC%TYPE, 
                            O_NHACC_TENNCC OUT NHACC.TENNCC%TYPE, 
                            O_NHACC_DIACHINCC OUT NHACC.DIACHINCC%TYPE)
    AS
        SP_ID SANPHAM.MASP%TYPE;
    BEGIN
        SELECT N.MANCC, N.TENNCC, N.DIACHINCC
        INTO O_NHACC_MANCC, O_NHACC_TENNCC, O_NHACC_DIACHINCC
        FROM CTPHIEUNHAP CT JOIN PHIEUNHAP P ON CT.SOPN=P.SOPN
                            JOIN NHACC N ON P.MANCC=N.MANCC
        WHERE MASP = I_SANPHAM_ID;        
    END P1_detail;
    
    FUNCTION P1_find (I_SANPHAM_ID IN SANPHAM.MASP%TYPE) 
    RETURN INT
    AS
        N INT;
    BEGIN
        SELECT COUNT(*) 
        INTO N 
        FROM SANPHAM 
        WHERE MASP = I_SANPHAM_ID;
        RETURN N;
    END P1_find;
END P1;

--THUC THI
SET SERVEROUTPUT ON;
DECLARE
    SANPHAM_ID SANPHAM.MASP%TYPE; 
    NHACC_MANCC NHACC.MANCC%TYPE; 
    NHACC_TENNCC NHACC.TENNCC%TYPE; 
    NHACC_DIACHINCC NHACC.DIACHINCC%TYPE;
BEGIN
    SANPHAM_ID := '&SANPHAM_ID';
    IF P1.P1_find(SANPHAM_ID) = 1 THEN
        P1.P1_detail(SANPHAM_ID, NHACC_MANCC, NHACC_TENNCC, NHACC_DIACHINCC);
        DBMS_OUTPUT.PUT_LINE('MA NCC: ' || NHACC_MANCC || ' - TEN NCC: ' || NHACC_TENNCC || ' - DIA CHI NCC: ' || NHACC_DIACHINCC);
    else
        DBMS_OUTPUT.PUT_LINE('Khong tim thay MASP: '|| SANPHAM_ID);
    END IF;
END;


-- PACKAGES 2: 
-- HAM NHAN VAO NHUNG THAM SO LA MAHD, MASP, SOLUONGBAN, GIABAN DE KIEM TRA XEM CO TON TAI TRONG BANG HAY KHONG.
-- NEU CAU DU LIEU TREN THOA MAN DIEU KIEN THI THU TUC NHAN THEM VAO NHUNG THAM SO LA MAHD, MASP, SOLUONGBAN, GIABAN

CREATE OR REPLACE PACKAGE P2
AS
    FUNCTION F_CHECK(I_HD CTHOADON.MAHD%TYPE, I_SANPHAM SANPHAM.MASP%TYPE,I_SOLUONGBAN CTHOADON.SOLUONGBAN%TYPE,I_GIABAN CTHOADON.GIABAN%TYPE) RETURN INT;
    PROCEDURE P_ADD(I_HD CTHOADON.MAHD%TYPE, I_SANPHAM SANPHAM.MASP%TYPE,I_SOLUONGBAN CTHOADON.SOLUONGBAN%TYPE,I_GIABAN CTHOADON.GIABAN%TYPE);
END P2;
-- body
CREATE OR REPLACE PACKAGE BODY P2
AS
    FUNCTION F_CHECK(I_HD CTHOADON.MAHD%TYPE, I_SANPHAM SANPHAM.MASP%TYPE,I_SOLUONGBAN CTHOADON.SOLUONGBAN%TYPE,I_GIABAN CTHOADON.GIABAN%TYPE)
    RETURN INT AS
        KTRA_HD INT;
        KTRA_SP INT;
    BEGIN
        SELECT COUNT(*) INTO KTRA_HD FROM HOADON WHERE MAHD = I_HD;
        SELECT COUNT(*) INTO KTRA_SP FROM SANPHAM WHERE MASP = I_SANPHAM;
        
        IF KTRA_HD > 0 AND KTRA_SP > 0 AND (I_GIABAN>0) AND (I_SOLUONGBAN>=1) THEN
            RETURN 1;
        ELSE
            RETURN 0;
        END IF;
    END F_CHECK;
    
    PROCEDURE P_ADD(I_HD CTHOADON.MAHD%TYPE, I_SANPHAM SANPHAM.MASP%TYPE,I_SOLUONGBAN CTHOADON.SOLUONGBAN%TYPE,I_GIABAN CTHOADON.GIABAN%TYPE)
    AS
    BEGIN
       IF F_CHECK(I_HD, I_SANPHAM,I_GIABAN, I_SOLUONGBAN)=1 THEN
            INSERT INTO CTHOADON VALUES (I_HD, I_SANPHAM,I_SOLUONGBAN,I_GIABAN);
       END IF;
    END P_ADD;
END P2;

--THUC THI
SET SERVEROUTPUT ON;
DECLARE
    V_MaHD		CTHOADON.MAHD%TYPE;
	V_MaSP		CTHOADON.MASP%TYPE;
    V_SoLuongBan	CTHOADON.SOLUONGBAN%TYPE;
    V_GiaBan		CTHOADON.GIABAN%TYPE;
BEGIN
    V_MAHD := '&V_MAHD';
    --MAHD LAY TU NHUNG HOA DON CO SAN. DO ANH HUONG CUA KHOA NGOAI
    V_MaSP := '&V_MaSP';
    --MASP LAY TU NHUNG SAN PHAM CO SAN. DO ANH HUONG CUA KHOA NGOAI
    V_SoLuongBan := '&V_SoLuongBan';
    V_GiaBan := '&V_GiaBan';

    IF P2.F_CHECK(V_MaHD,V_MaSP,V_SoLuongBan,V_GiaBan)=1 THEN
        P2.P_ADD(V_MaHD,V_MaSP,V_SoLuongBan,V_GiaBan);
        DBMS_OUTPUT.PUT_LINE('DA THEM!!');
    ELSE DBMS_OUTPUT.PUT_LINE('CO LOI!! KHONG THEM DUOC');
        END IF;

END;

-- PACKAGES 3: 
-- HAM NHAN VAO NHUNG THAM SO LA  MASP, SOLUONGTON DE KIEM TRA XEM CO TON TAI TRONG BANG HAY KHONG.
-- NEU CAU DU LIEU TREN THOA MAN DIEU KIEN THI THU TUC CAP NHAT LAI SO LUONG TON
CREATE OR REPLACE PACKAGE P3
AS
    FUNCTION F_CHECK(I_SANPHAM KHOHANG.MASP%TYPE) RETURN INT;
    PROCEDURE P_THUCHANH(I_SANPHAM KHOHANG.MASP%TYPE, I_SOLUONG KHOHANG.SOLUONGTON%TYPE);
END P3;
-- body
CREATE OR REPLACE PACKAGE BODY P3
AS
    FUNCTION F_CHECK(I_SANPHAM KHOHANG.MASP%TYPE)
    RETURN INT AS
        KTRA_SP INT;
    BEGIN
        SELECT COUNT(*) INTO KTRA_SP FROM SANPHAM WHERE MASP = I_SANPHAM;
        
        IF KTRA_SP > 0 THEN
            RETURN 1;
        ELSE
            RETURN 0;
        END IF;
    END F_CHECK;
    
    PROCEDURE P_THUCHANH(I_SANPHAM KHOHANG.MASP%TYPE, I_SOLUONG KHOHANG.SOLUONGTON%TYPE)
    AS
    BEGIN
       IF F_CHECK(I_SANPHAM)=1 THEN
            UPDATE KHOHANG 
            SET SOLUONGTON=SOLUONGTON+I_SOLUONG
            WHERE MASP=I_SANPHAM;
            DBMS_OUTPUT.PUT_LINE('DA THEM SO LUONG TON!!');

        END IF;
    END P_THUCHANH;
END P3;

--THUC THI
SET SERVEROUTPUT ON;
DECLARE
    V_MASP		KHOHANG.MASP%TYPE;
	V_SOLUONGTON		KHOHANG.SOLUONGTON%TYPE;

BEGIN
    V_MASP := '&V_MASP';
    V_SOLUONGTON := '&V_SOLUONGTON';

    IF P3.F_CHECK(V_MASP)=1 THEN
        P3.P_THUCHANH(V_MASP,V_SOLUONGTON);
    ELSE DBMS_OUTPUT.PUT_LINE('CO LOI!!');
    END IF;
END;

-- PACKAGES 4: 
-- HAM NHAN VAO NHUNG THAM SO LA  MANV DE KIEM TRA XEM CO TON TAI TRONG BANG HAY KHONG.
-- NEU CAU DU LIEU TREN THOA MAN DIEU KIEN THI THU TUC XOA THONG TIN NHAN VIEN DO
CREATE OR REPLACE PACKAGE P4
AS
    FUNCTION F_CHECK(I_NV NHANVIEN.MANV%TYPE) RETURN INT;
    PROCEDURE P_THUCHANH(I_NV NHANVIEN.MANV%TYPE);
END P4;
-- body
CREATE OR REPLACE PACKAGE BODY P4
AS
    FUNCTION F_CHECK(I_NV NHANVIEN.MANV%TYPE)
    RETURN INT AS
        KTRA_NV INT;
    BEGIN
        SELECT COUNT(*) INTO KTRA_NV FROM NHANVIEN WHERE MANV = I_NV;
        
        IF KTRA_NV > 0 THEN
            RETURN 1;
        ELSE
            RETURN 0;
        END IF;
    END F_CHECK;
    
    PROCEDURE P_THUCHANH(I_NV NHANVIEN.MANV%TYPE)
    AS
    BEGIN
       IF F_CHECK(I_NV)=1 THEN
            DELETE FROM NHANVIEN 
            WHERE MANV=I_NV;
            DBMS_OUTPUT.PUT_LINE('DA XOA THONG TIN NHAN VIEN!!');

        END IF;
    END P_THUCHANH;
END P4;

--THUC THI
SET SERVEROUTPUT ON;
DECLARE
    V_MANV		NHANVIEN.MANV%TYPE;
BEGIN
    V_MANV := '&V_MANV';

    IF P4.F_CHECK(V_MANV)=1 THEN
        P4.P_THUCHANH(V_MANV);
    ELSE DBMS_OUTPUT.PUT_LINE('CO LOI!!');
    END IF;
END;

-- PACKAGES 5: 
-- THU TUC NHAN VAO 1 THAM SO LA MAKH (KHACH HANG), CAC THAM SO RA LA TONG SO TIEN MA KHACH HANG DO MUA
-- HAM NHAN VAO 1 THAM SO LA MAKH (KHACH HANG). HAM TRA VE 1 NEU MAKH TON TAI TRONG BANG, NGUOC LAI TRA VE 0
CREATE OR REPLACE PACKAGE P5
AS
    PROCEDURE P5_detail (I_KH_ID IN KHACHHANG.MAKH%TYPE, 
                            O_TONGTIEN OUT FLOAT);
    FUNCTION P5_find (I_KH_ID IN KHACHHANG.MAKH%TYPE) 
    RETURN INT;
END P5;

-- BODY
CREATE OR REPLACE PACKAGE BODY
    P5
AS
    PROCEDURE P5_detail (I_KH_ID IN KHACHHANG.MAKH%TYPE, 
                            O_TONGTIEN OUT FLOAT)
    AS
        KH_ID KHACHHANG.MAKH%TYPE;
    BEGIN
        SELECT SUM(GIABAN*SOLUONGBAN)
        INTO O_TONGTIEN
        FROM HOADON H JOIN  CTHOADON CT  ON H.MAHD=CT.MAHD
        WHERE MAKH = I_KH_ID;        
    END P5_detail;
    
    FUNCTION P5_find (I_KH_ID IN KHACHHANG.MAKH%TYPE) 
    RETURN INT
    AS
        N INT;
    BEGIN
        SELECT COUNT(*) 
        INTO N 
        FROM KHACHHANG 
        WHERE MAKH = I_KH_ID;
        RETURN N;
    END P5_find;
END P5;

--THUC THI
SET SERVEROUTPUT ON;
DECLARE
    I_KH_ID  KHACHHANG.MAKH%TYPE ;
    O_TONGTIEN FLOAT;
BEGIN
    I_KH_ID := '&I_KH_ID';
    IF P5.P5_find(I_KH_ID) = 1 THEN
        P5.P5_detail(I_KH_ID, O_TONGTIEN);
        DBMS_OUTPUT.PUT_LINE('TONG SO TIEN MA KHACH HANG DA MUA: ' || O_TONGTIEN);
    else
        DBMS_OUTPUT.PUT_LINE('KHONG TIM THAY KH: '|| I_KH_ID);
    END IF;
END;

-- PACKAGES 6: 
-- THU TUC NHAN VAO 1 THAM SO LA MANCC (NHA CUNG CAP), CAC THAM SO RA LA SO LUONG SAN PHAM DA NHAP TU NHA CUNG CAP NAY
-- HAM NHAN VAO 1 THAM SO LA MANCC (NHA CUNG CAP). HAM TRA VE 1 NEU MANCC TON TAI TRONG BANG, NGUOC LAI TRA VE 0
CREATE OR REPLACE PACKAGE P6
AS
    PROCEDURE P6_detail (I_NHACC_ID IN NHACC.MANCC%TYPE, 
                            O_SOLUONGNHAP OUT NUMBER);
    FUNCTION P6_find (I_NHACC_ID IN NHACC.MANCC%TYPE) 
    RETURN INT;
END P6;

-- BODY
CREATE OR REPLACE PACKAGE BODY
    P6
AS
    PROCEDURE P6_detail (I_NHACC_ID IN NHACC.MANCC%TYPE, 
                            O_SOLUONGNHAP OUT NUMBER)
    AS
    BEGIN
        SELECT SUM(SOLUONGNHAP)
        INTO O_SOLUONGNHAP
        FROM PHIEUNHAP P JOIN  CTPHIEUNHAP CT  ON P.SOPN=CT.SOPN
        WHERE MANCC = I_NHACC_ID;        
    END P6_detail;
    
    FUNCTION P6_find (I_NHACC_ID IN NHACC.MANCC%TYPE) 
    RETURN INT
    AS
        N INT;
    BEGIN
        SELECT COUNT(*) 
        INTO N 
        FROM NHACC 
        WHERE MANCC = I_NHACC_ID;
        RETURN N;
    END P6_find;
END P6;

--THUC THI
SET SERVEROUTPUT ON;
DECLARE
    I_NHACC_ID  NHACC.MANCC%TYPE ;
    O_SOLUONGNHAP NUMBER;
BEGIN
    I_NHACC_ID := '&I_NHACC_ID';
    IF P6.P6_find(I_NHACC_ID) = 1 THEN
        P6.P6_detail(I_NHACC_ID, O_SOLUONGNHAP);
        DBMS_OUTPUT.PUT_LINE('SO LUONG SAN PHAM NHAP TU NHA CUNG CAP '||I_NHACC_ID||' LA: ' || O_SOLUONGNHAP ||' SAN PHAM ');
    else
        DBMS_OUTPUT.PUT_LINE('KHONG TIM THAY NHA CUNG CAP: '|| I_NHACC_ID);
    END IF;
END;

-- PACKAGES 7: 
-- THU TUC NHAN VAO 1 THAM SO LA MASP (SANPHAM), CAC THAM SO RA LA THONG TIN SAN PHAM THUOC LOAI NAO
-- HAM NHAN VAO 1 THAM SO LA MASP (SANPHAM). HAM TRA VE 1 NEU MASP TON TAI TRONG BANG, NGUOC LAI TRA VE 0
CREATE OR REPLACE PACKAGE P7
AS
    PROCEDURE P7_detail (I_SP_ID IN SANPHAM.MASP%TYPE, 
                            O_LOAISP_MALOAISP OUT LOAISP.MALOAISP%TYPE,
                            O_LOAISP_TENLOAISP OUT LOAISP.TENLOAISP%TYPE);
    FUNCTION P7_find (I_SP_ID IN SANPHAM.MASP%TYPE) 
    RETURN INT;
END P7;

-- BODY
CREATE OR REPLACE PACKAGE BODY
    P7
AS
    PROCEDURE P7_detail (I_SP_ID IN SANPHAM.MASP%TYPE, 
                            O_LOAISP_MALOAISP OUT LOAISP.MALOAISP%TYPE,
                            O_LOAISP_TENLOAISP OUT LOAISP.TENLOAISP%TYPE)
    AS
    BEGIN
        SELECT L.MALOAISP, L.TENLOAISP
        INTO O_LOAISP_MALOAISP, O_LOAISP_TENLOAISP
        FROM LOAISP L JOIN SANPHAM S ON L.MALOAISP=S.MALOAISP 
        WHERE MASP = I_SP_ID;        
    END P7_detail;
    
    FUNCTION P7_find (I_SP_ID IN SANPHAM.MASP%TYPE) 
    RETURN INT
    AS
        N INT;
    BEGIN
        SELECT COUNT(*) 
        INTO N 
        FROM SANPHAM 
        WHERE MASP = I_SP_ID;
        RETURN N;
    END P7_find;
END P7;

--THUC THI
SET SERVEROUTPUT ON;
DECLARE
    SANPHAM_ID SANPHAM.MASP%TYPE; 
    LOAISP_MALOAISP LOAISP.MALOAISP%TYPE; 
    LOAISP_TENLOAISP LOAISP.TENLOAISP%TYPE; 
BEGIN
    SANPHAM_ID := '&SANPHAM_ID';
    IF P7.P7_find(SANPHAM_ID) = 1 THEN
        P7.P7_detail(SANPHAM_ID, LOAISP_MALOAISP, LOAISP_TENLOAISP);
        DBMS_OUTPUT.PUT_LINE('SAN PHAM ' || SANPHAM_ID || ' THUOC LOAI SAN PHAM: ' || LOAISP_MALOAISP || ' - ' || LOAISP_TENLOAISP);
    else
        DBMS_OUTPUT.PUT_LINE('KHONG TIM THAY MASP: '|| SANPHAM_ID);
    END IF;
END;

-- PACKAGES 8: 
-- THU TUC NHAN VAO NHUNG THAM SO LA THANG, NAM. THU TUC TRA VE DOANH THU TRONG THANG NAM DO
-- HAM NHAN VAO THAM SO LA THANG VA NAM. HAM TRA VE 1 TRONG THANG VA NAM DO CO BAN DUOC SAN PHAM, NGUOC LAI TRA VE 0
CREATE OR REPLACE PACKAGE P8
AS
    PROCEDURE P8_detail (I_THANG NUMBER, I_NAM NUMBER, O_DOANHTHU OUT FLOAT);
    FUNCTION P8_find (I_THANG NUMBER, I_NAM NUMBER) 
    RETURN INT;
END P8;

-- BODY
CREATE OR REPLACE PACKAGE BODY
    P8
AS
    PROCEDURE P8_detail (I_THANG NUMBER, I_NAM NUMBER, O_DOANHTHU OUT FLOAT)
    AS
    BEGIN
        SELECT SUM(GIABAN*SOLUONGBAN)
        INTO O_DOANHTHU
        FROM HOADON H JOIN  CTHOADON CT  ON H.MAHD=CT.MAHD
        WHERE TO_NUMBER(TO_CHAR(NGAYBAN,'MM')) = I_THANG AND TO_NUMBER(TO_CHAR(NGAYBAN,'YYYY')) = I_NAM;        
    END P8_detail;
    
    FUNCTION P8_find (I_THANG NUMBER, I_NAM NUMBER) 
    RETURN INT
    AS
        N INT;
    BEGIN
        SELECT COUNT(*) 
        INTO N 
        FROM  HOADON H
        WHERE TO_NUMBER(TO_CHAR(NGAYBAN,'MM')) = I_THANG AND TO_NUMBER(TO_CHAR(NGAYBAN,'YYYY')) = I_NAM;
        RETURN N;
    END P8_find;
END P8;

--THUC THI
SET SERVEROUTPUT ON;
DECLARE
    THANG NUMBER;
    NAM NUMBER;
    DOANHTHU NUMBER;
BEGIN
    THANG := &THANG;
    NAM := &NAM;
  
    IF P8.P8_find(THANG,NAM) = 0 THEN
        DBMS_OUTPUT.PUT_LINE('THANG '|| THANG|| ' NAM ' || NAM || ' KHONG CO DOANH THU ');
    ELSE P8.P8_detail(THANG,NAM,DOANHTHU);
        DBMS_OUTPUT.PUT_LINE('DOANH THU TRONG THANG ' || THANG || ' NAM ' || NAM || ' LA: ' || DOANHTHU);
    END IF;
END;

-- PACKAGES 9: 
-- THU TUC NHAN VAO 1 THAM SO LA MA SP (SANPHAM) THANG, NAM, THAM SO RA LA SO LUONG SAN PHAM DA BAN TRONG THANG NAM DO
-- HAM NHAN VAO 1 THAM SO LA MASP (SANPHAM) THANG, NAM. HAM TRA VE 1 NEU SAN PHAM BAN DUOC TRONG THANG NAM DO, NGUOC LAI TRA VE 0
CREATE OR REPLACE PACKAGE P9
AS
    PROCEDURE P9_detail (I_SANPHAM_ID IN SANPHAM.MASP%TYPE,
                            I_THANG NUMBER, I_NAM NUMBER,
                            O_SOLUONGBAN OUT NUMBER);
    FUNCTION P9_find (I_SANPHAM_ID IN SANPHAM.MASP%TYPE,I_THANG NUMBER, I_NAM NUMBER) 
    RETURN INT;
END P9;

-- BODY
CREATE OR REPLACE PACKAGE BODY
    P9
AS
    PROCEDURE P9_detail (I_SANPHAM_ID IN SANPHAM.MASP%TYPE,
                            I_THANG NUMBER, I_NAM NUMBER,
                            O_SOLUONGBAN OUT NUMBER)
    AS
        --NHACC_ID NHACC.NHACC%TYPE;
    BEGIN
        SELECT SUM(SOLUONGBAN)
        INTO O_SOLUONGBAN
        FROM HOADON H JOIN  CTHOADON CT  ON H.MAHD=CT.MAHD
        WHERE MASP = I_SANPHAM_ID AND TO_NUMBER(TO_CHAR(NGAYBAN,'MM')) = I_THANG AND TO_NUMBER(TO_CHAR(NGAYBAN,'YYYY')) = I_NAM;        
    END P9_detail;
    
    FUNCTION P9_find (I_SANPHAM_ID IN SANPHAM.MASP%TYPE,I_THANG NUMBER, I_NAM NUMBER) 
    RETURN INT
    AS
        N INT;
    BEGIN
        SELECT COUNT(*) 
        INTO N 
        FROM HOADON H JOIN  CTHOADON CT  ON H.MAHD=CT.MAHD
        WHERE MASP = I_SANPHAM_ID AND TO_NUMBER(TO_CHAR(NGAYBAN,'MM')) = I_THANG AND TO_NUMBER(TO_CHAR(NGAYBAN,'YYYY')) = I_NAM;
        RETURN N;
    END P9_find;
END P9;


--THUC THI
SET SERVEROUTPUT ON;
DECLARE
    SANPHAM_ID SANPHAM.MASP%TYPE; 
    SL NUMBER; 
    TH NUMBER;
    NM NUMBER;
BEGIN
    SANPHAM_ID := '&SANPHAM_ID';
    TH:=&TH;
    NM:=&NM;
    IF P9.P9_find(SANPHAM_ID,TH,NM) = 1 THEN
        P9.P9_detail(SANPHAM_ID, TH,NM,SL);
        DBMS_OUTPUT.PUT_LINE('SO LUONG SAN PHAM ' || SANPHAM_ID ||' DUOC BAN TRONG THANG '||TH||' NAM '||NM|| ' LA ' ||SL);
    else
        DBMS_OUTPUT.PUT_LINE('SAN PHAM '|| SANPHAM_ID||' KHONG BAN DUOC TRONG THANG '||TH||' NAM '||NM);
    END IF;
END;

-- PACKAGES 10: 
-- THU TUC NHAN VAO 1 THAM SO LA SOPN (PHIEU NHAP), CAC THAM SO RA LA THONG TIN NHAN VIEN PHU TRACH NHAP 
-- HAM NHAN VAO 1 THAM SO LA SOPN (PHIEU NHAP). HAM TRA VE 1 NEU SOPN TON TAI TRONG BANG, NGUOC LAI TRA VE 0
CREATE OR REPLACE PACKAGE P10
AS
    PROCEDURE P10_detail (I_PHIEUNHAP_ID IN PHIEUNHAP.SOPN%TYPE, 
                            O_NV_MANV OUT NHANVIEN.MANV%TYPE, 
                            O_NV_HOTENNV OUT NHANVIEN.HOTENNV%TYPE);
    FUNCTION P10_find (I_PHIEUNHAP_ID IN PHIEUNHAP.SOPN%TYPE) 
    RETURN INT;
END P10;

-- BODY
CREATE OR REPLACE PACKAGE BODY
    P10
AS
    PROCEDURE P10_detail (I_PHIEUNHAP_ID IN PHIEUNHAP.SOPN%TYPE, 
                            O_NV_MANV OUT NHANVIEN.MANV%TYPE, 
                            O_NV_HOTENNV OUT NHANVIEN.HOTENNV%TYPE)
    AS
 
    BEGIN
        SELECT N.MANV, N.HOTENNV
        INTO O_NV_MANV, O_NV_HOTENNV
        FROM NHANVIEN N JOIN PHIEUNHAP P ON N.MANV=P.MANV
        WHERE SOPN = I_PHIEUNHAP_ID;        
    END P10_detail;
    
    FUNCTION P10_find (I_PHIEUNHAP_ID IN PHIEUNHAP.SOPN%TYPE) 
    RETURN INT
    AS
        N INT;
    BEGIN
        SELECT COUNT(*) 
        INTO N 
        FROM PHIEUNHAP
        WHERE SOPN = I_PHIEUNHAP_ID;
        RETURN N;
    END P10_find;
END P10;

--THUC THI
SET SERVEROUTPUT ON;
DECLARE
    PN_ID PHIEUNHAP.SOPN%TYPE; 
    NV_ID NHANVIEN.MANV%TYPE; 
    NV_TEN NHANVIEN.HOTENNV%TYPE; 
BEGIN
    PN_ID := '&PN_ID';
    IF P10.P10_find(PN_ID) = 1 THEN
        P10.P10_detail(PN_ID, NV_ID, NV_TEN);
        DBMS_OUTPUT.PUT_LINE('PHIEU NHAP ' || PN_ID || ' DUOC NHAN VIEN ' || NV_ID || ' - ' || NV_TEN ||' PHU TRACH');
    elsE
        DBMS_OUTPUT.PUT_LINE('KHONG TIM THAY PHIEU NHAP: '|| PN_ID);
    END IF;
END;

---------------------------------- TRIGGER -----------------------------
--TRIGGER: NGAY VAO LAM CUA NHAN VIEN PHAI NHO HON HOAC BANG NGAY HIEN HANH KHI THEM MOI HOAC CAP NHAT THONG TIN NHAN VIEN
create or replace trigger TR_NGAYVAOLAM
after insert or update
on NHANVIEN
for each row
    declare V_NGAYLAM NHANVIEN.NGAYVAOLAM%TYPE;
    begin
        if(V_NGAYLAM>SYSDATE) then
        raise_application_error(-20020,'NGAY VAO LAM KHONG HOP LE');
        end if;
    end;


--TRIGGER:KHONG NHAP HANG VAO THU 7, CHU NHAT, THU 2
CREATE OR REPLACE TRIGGER TR_NHAPHANG
BEFORE INSERT OR UPDATE ON PHIEUNHAP
DECLARE
    v_day VARCHAR2(10);
BEGIN
    v_day := RTRIM(TO_CHAR(SYSDATE, 'DAY'));
    IF v_day LIKE ('%S') OR v_day LIKE ('%M') THEN
    RAISE_APPLICATION_ERROR(-20000, 'KHONG NHAP HANG VAO THU 2 HOAC CHU NHAT');
END IF;
END;

--TRIGGER:NHAN VIEN KHONG QUA 20 NGUOI
CREATE OR REPLACE TRIGGER TR_NV
BEFORE INSERT ON NHANVIEN
FOR EACH ROW
DECLARE
    NV_NUMBER INT;
BEGIN
    SELECT COUNT(*) INTO NV_NUMBER
    FROM NHANVIEN WHERE MANV = :NEW.MANV;
    
    IF NV_NUMBER >= 20 THEN
        raise_application_error(-20112, 'DA DU NHAN VIEN');
    END IF;
END;

--TRIGGER: NGAY VAO LAM PHAI LON HON NGAY SINH
create or replace trigger TR_NV2
before insert or update
on NHANVIEN
for each row
     begin
    if(:new.NGAYSINHNV>:new.NGAYVAOLAM) then
    raise_application_error(-20021,'NGAY VAO LAM PHAI LON HON NGAY SINH');
 end if;
 end;


--VIEW
CREATE OR REPLACE VIEW HOADON_VIEW
AS
    SELECT MAKH,H.MAHD,SUM(GIABAN*SOLUONGBAN) AS DOANHTHUBAN
    FROM HOADON H JOIN CTHOADON C ON H.MAHD = C.MAHD
    GROUP BY H.MAHD , MAKH;

-- Test cau 7 hop le
SELECT * FROM HOADON_VIEW;

-- TRIGGER
CREATE OR REPLACE TRIGGER HOADON_VIEW_DELETE
INSTEAD OF DELETE ON HOADON_VIEW
FOR EACH ROW
BEGIN
    DELETE FROM CTHOADON WHERE MAHD = :OLD.MAHD;
    DELETE FROM HOADON WHERE MAHD = :OLD.MAHD;
END;















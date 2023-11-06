
-- 1. Liệt kê danh sách sinh viên, gồm các thông tin sau: Mã sinh viên, Họ sinh 
-- viên, Tên sinh viên, Học bổng. Danh sách sẽ được sắp xếp theo thứ tự Mã 
-- sinh viên tăng dần
select masv,hosv,tensv,hocbong 
from dmsv order by masv;

-- 2. Danh sách các sinh viên gồm thông tin sau: Mã sinh viên, họ tên sinh viên, 
-- Phái, Ngày sinh. Danh sách sẽ được sắp xếp theo thứ tự Nam/Nữ.
select masv,concat(hosv ,' ', tensv)  as `Họ tên`,phai, ngaysinh
from dmsv order by phai;

-- 3. Thông tin các sinh viên gồm: Họ tên sinh viên, Ngày sinh, Học bổng. Thông 
-- tin sẽ được sắp xếp theo thứ tự Ngày sinh tăng dần và Học bổng giảm dần.
select concat(hosv ,' ', tensv)  as `Họ tên`,ngaysinh,hocbong
from dmsv order by ngaysinh and hocbong desc;

-- 4. Danh sách các môn học có tên bắt đầu bằng chữ T, gồm các thông tin: Mã 
-- môn, Tên môn, Số tiết.
select mamh,tenmh,sotiet
from dmmh where tenmh like 't%';

-- 5. Liệt kê danh sách những sinh viên có chữ cái cuối cùng trong tên là I, gồm 
-- các thông tin: Họ tên sinh viên, Ngày sinh, Phái.
select concat(hosv ,' ', tensv)  as `Họ tên`,ngaysinh,phai
from dmsv where tensv like '%i';

-- 6. Danh sách những khoa có ký tự thứ hai của tên khoa có chứa chữ N, gồm 
-- các thông tin: Mã khoa, Tên khoa.
select makhoa,tenkhoa
from dmkhoa where tenkhoa like '_n%';

-- 7. Liệt kê những sinh viên mà họ có chứa chữ Thị.
select * from dmsv where hosv like '%thi%';

-- 8. Cho biết danh sách các sinh viên có học bổng lớn hơn 100,000, gồm các 
-- thông tin: Mã sinh viên, Họ tên sinh viên, Mã khoa, Học bổng. Danh sách sẽ
-- được sắp xếp theo thứ tự Mã khoa giảm dần
select * 
from dmsv where hocbong > 100000;

-- 9. Liệt kê các sinh viên có học bổng từ 150,000 trở lên và sinh ở Hà Nội, gồm 
-- các thông tin: Họ tên sinh viên, Mã khoa, Nơi sinh, Học bổng.
select * 
from dmsv where hocbong > 150000 and noisinh like 'Ha Noi';

-- 10.Danh sách các sinh viên của khoa Anh văn và khoa Vật lý, gồm các thông 
-- tin: Mã sinh viên, Mã khoa, Phái.
select * 
from dmsv where makhoa in (select makhoa from dmkhoa where tenkhoa like 'Anh van'  or tenkhoa like 'vat ly') ;

-- 11.Cho biết những sinh viên có ngày sinh từ ngày 01/01/1991 đến ngày 
-- 05/06/1992 gồm các thông tin: Mã sinh viên, Ngày sinh, Nơi sinh, Học 
-- bổng.
select * 
from dmsv where date(ngaysinh) between date('01/01/1991') and date('05/06/1992');

-- 12.Danh sách những sinh viên có học bổng từ 80.000 đến 150.000, gồm các 
-- thông tin: Mã sinh viên, Ngày sinh, Phái, Mã khoa.
select * 
from dmsv where hocbong > 80.000 and hocbong<150000;

-- 13.Cho biết những môn học có số tiết lớn hơn 30 và nhỏ hơn 45, gồm các thông 
-- tin: Mã môn học, Tên môn học, Số tiết.
select * 
from dmmh where sotiet >30 and sotiet < 45;

-- 14.Liệt kê những sinh viên nam của khoa Anh văn và khoa tin học, gồm các 
-- thông tin: Mã sinh viên, Họ tên sinh viên, tên khoa, Phái.
-- select * from dmsv where (select makhoa from dmkhoa where tenkhoa like 'anh van' or tenkhoa like 'tin hoc')
-- group by phai,masv,concat(hosv ,' ', tensv)
-- having phai = 'nam';
select  *
from dmsv sv 
join dmkhoa k on k.MaKhoa = sv.MaKhoa 
where (k.TenKhoa like 'anh van' or k.TenKhoa like 'tin hoc') and sv.Phai like 'nam'
;

-- 15.Liệt kê những sinh viên nữ, tên có chứa chữ N
select * 
from dmsv where phai like 'nu' and tensv like '%n%';

-- 16.Danh sách sinh viên có nơi sinh ở Hà Nội và sinh vào tháng 02, gồm các 
-- thông tin: Họ sinh viên, Tên sinh viên, Nơi sinh, Ngày sinh.
select * from dmsv where noisinh like 'ha noi' and month(ngaysinh) = 2; 

-- 17.Cho biết những sinh viên có tuổi lớn hơn 20, thông tin gồm: Họ tên sinh 
-- viên, Tuổi,Học bổng.
select * from dmsv where (year(now()) - year(ngaysinh)) >=20;

-- 18.Danh sách những sinh viên có tuổi từ 20 đến 25, thông tin gồm: Họ tên sinh 
-- viên, Tuổi, Tên khoa.
select concat(hosv ,' ', tensv) as `Họ tên`, year(now()) - year(ngaysinh) as `Tuổi`,dmkhoa.TenKhoa
 from dmsv 
 join dmkhoa on dmkhoa.MaKhoa = dmsv.MaKhoa
 where (year(now()) - year(ngaysinh)) between 20 and 50 ;
 
-- 19.Danh sách sinh viên sinh vào mùa xuân năm 1990, gồm các thông tin: Họ
-- tên sinh viên,Phái, Ngày sinh.
select  concat(hosv ,' ', tensv) as `Họ tên`, phai, day(ngaysinh) as `Ngày sinh`
from dmsv where year(ngaysinh) = 1990 and month(ngaysinh) between 1 and 4;

-- 20.Cho biết thông tin về mức học bổng của các sinh viên, gồm: Mã sinh viên, 
-- Phái, Mã khoa, Mức học bổng. Trong đó, mức học bổng sẽ hiển thị là “Học 
-- bổng cao” nếu giá trị của field học bổng lớn hơn 500,000 và ngược lại hiển 
-- thị là “Mức trung bình”
select masv,makhoa,
case 
when 
 hocbong > 500000 then 'Học bổng cao'
 else 'Mức trung bình'
 end 
 as `Mức học bổng`
from dmsv ;

-- 21.Cho biết tổng số sinh viên của toàn trường
select count(masv) as `tổng` from dmsv ;

-- 22.Cho biết tổng sinh viên và tổng sinh viên nữ.
select a.phai as `Phái` , count(a.phai)  as `số lượng` 
from dmsv a
-- join dmsv b on a.MaSV = b.MaSV
group by a.phai 
; 

-- 23.Cho biết tổng số sinh viên của từng khoa.
select  dmkhoa.TenKhoa  ,count(dmsv.MaKhoa)  
from dmsv join dmkhoa on dmkhoa.MaKhoa = dmsv.MaKhoa
group by dmkhoa.MaKhoa;

-- 24.Cho biết số lượng sinh viên học từng môn.
select  dmmh.TenMH ,count(masv) from ketqua
join dmmh on dmmh.MaMH = ketqua.MaMH
 group by ketqua.mamh;

-- 25.Cho biết số lượng môn học mà sinh viên đã học(tức tổng số môn học có 
-- trong bảng kq)
select dmsv.TenSV ,count(ketqua.MaMH)  from ketqua join dmsv on ketqua.MaSV = dmsv.MaSV
group by dmsv.MaSV ,ketqua.MaMH; 

-- 26.Cho biết tổng số học bổng của mỗi khoa.
select makhoa ,count(hocbong) from dmsv  where not hocbong = 0 group by makhoa;

-- 27.Cho biết học bổng cao nhất của mỗi khoa.
select makhoa,max(hocbong)  from dmsv group by makhoa;

-- 28.Cho biết tổng số sinh viên nam và tổng số sinh viên nữ của mỗi khoa.
select makhoa, phai ,count(phai) as `số lượng`
from dmsv group by makhoa,phai; 

-- 29.Cho biết số lượng sinh viên theo từng độ tuổi.
select year(ngaysinh) as `Năm` , count(masv) as `số lượng ` from dmsv group by year(ngaysinh);

-- 30.Cho biết những năm sinh nào có 2 sinh viên đang theo học tại trường.
select year(ngaysinh) as `Năm` from dmsv group by year(ngaysinh) having count(masv)=2;

-- 31.Cho biết những nơi nào có hơn 2 sinh viên đang theo học tại trường.
select noisinh ,count(masv) as `tổng` from dmsv group by noisinh having count(masv) >= 2  ;

-- 32.Cho biết những môn nào có trên 3 sinh viên dự thi.
select ketqua.mamh,dmmh.TenMH from ketqua join dmmh on dmmh.MaMH=ketqua.MaMH group by mamh having  count(masv) >3 ;

-- 33.Cho biết những sinh viên thi lại 2 lần.
select masv,mamh,lanthi from ketqua group by masv , mamh , lanthi having LanThi >=2;

-- 34.Cho biết những sinh viên nam có điểm trung bình lần 1 trên 7.0

select  dmsv.TenSV, avg(ketqua.Diem) 
from ketqua 
join dmsv on dmsv.MaSV = ketqua.MaSV
where ketqua.LanThi = 1 and dmsv.Phai like 'nam'
group by ketqua.MaSV ;

-- 35.Cho biết danh sách các sinh viên rớt trên 2 môn ở lần thi 1.
select masv from ketqua where lanthi = 1 and diem <5 group by masv having count(mamh)>=2; 

-- 36.Cho biết danh sách những khoa có nhiều hơn 2 sinh viên nam
select dmsv.makhoa , dmkhoa.TenKhoa from dmsv join dmkhoa on dmkhoa.MaKhoa = dmsv.MaKhoa where phai like 'nam' group by makhoa having count(masv);  

-- 37.Cho biết những khoa có 2 sinh đạt học bổng từ 200.000 đến 300.000.
select dmsv.makhoa, dmkhoa.TenKhoa from dmsv join dmkhoa on dmkhoa.MaKhoa = dmsv.MaKhoa where hocbong between 100000 and 300000 group by makhoa having count(masv) >=2; 

-- 38.Cho biết số lượng sinh viên đậu và số lượng sinh viên rớt của từng môn 
-- trong lần thi 1.
select mamh, count(masv) as `Tổng` from ketqua where lanthi=1 and diem <5 group by mamh   ;

-- 39.Cho biết sinh viên nào có học bổng cao nhất.
select * from dmsv where hocbong = (select max(hocbong) from dmsv);

-- 40.Cho biết sinh viên nào có điểm thi lần 1 môn cơ sở dữ liệu cao nhất.
use quanlydiemsv;
 select * from dmsv where masv like (select MaSV
from ketqua join dmmh on dmmh.MaMH = ketqua.MaMH
where TenMH like 'co so du lieu' and lanthi = 1 );
-- 41.Cho biết sinh viên khoa anh văn có tuổi lớn nhất.
select * from dmsv where year(ngaysinh)=(select max(year(now())-year(ngaysinh)) from dmsv where makhoa like 'av');

-- 42.Cho biết khoa nào có đông sinh viên nhất.
select  dmsv.MaKhoa , count(dmsv.MaSV) as `Số lượng`
from dmsv 
join dmkhoa dmk on dmk.MaKhoa = dmsv.MaKhoa
group by dmsv.MaKhoa 
 ;
use quanlydiemsv;
-- 43.Cho biết khoa nào có đông nữ nhất.
SELECT makhoa, COUNT(masv) AS soLuongNu
FROM dmsv
WHERE phai = 'nu'
GROUP BY makhoa
HAVING soLuongNu = (
    SELECT COUNT(masv) AS maxSoLuongNu
    FROM dmsv
    WHERE phai = 'nu'
    GROUP BY makhoa
    ORDER BY maxSoLuongNu DESC
    LIMIT 1
);

-- 44.Cho biết môn nào có nhiều sinh viên rớt lần 1 nhiều nhất.
-- select *,count(lanthi ) from ketqua where mahm = 
SELECT mamh, COUNT(masv) AS soLuong
FROM ketqua
WHERE lanthi = 1 AND diem < 5
GROUP BY mamh
HAVING soLuong = (
    SELECT COUNT(masv)
    FROM ketqua
    WHERE lanthi = 1 AND diem < 5
    GROUP BY mamh
    ORDER BY COUNT(masv) DESC
    LIMIT 1
);
-- select count(masv) from ketqua where lanthi =1 and diem < 5 group by mamh order by count(masv) desc limit 1 ;

-- 45.Cho biết sinh viên không học khoa anh văn có điểm thi môn phạm lớn hơn 
-- điểm thi văn của sinh viên học khoa anh văn.


-- 46.Cho biết sinh viên có nơi sinh cùng với Hải.
SELECT masv
FROM dmsv
WHERE noisinh = (
    SELECT noisinh
    FROM dmsv
    WHERE tensv LIKE 'hai%'
) and tensv  not like 'hai';

-- 47.Cho biết những sinh viên nào có học bổng lớn hơn tất cả học bổng của
-- sinh viên thuộc khoa anh văn
select * from dmsv where hocbong > (select count(hocbong) from dmsv group by makhoa having makhoa like 'av') ;

-- 48.Cho biết những sinh viên có học bổng lớn hơn bất kỳ học bổng của sinh viên 
-- học khóa anh văn
WITH MaxHocBong AS (
    SELECT MAX(hocbong) AS maxHocBong
    FROM dmsv
    WHERE makhoa like  'av' 
)
SELECT *
FROM dmsv
WHERE hocbong > (SELECT maxHocBong FROM MaxHocBong)
  AND makhoa not like 'av'; 

-- 49. ho biết sinh viên nào có điểm thi môn cơ sở dữ liệu lần 2 lớn hơn tất cả điểm 
-- thi lần 1 môn cơ sở dữ liệu của những sinh viên khác.
select * from ketqua where diem = (
select max(diem)
from ketqua
where lanthi = 2 and mamh like '01'
 )
 ;
-- 50.Cho biết những sinh viên đạt điểm cao nhất trong từng môn.


-- 51.Cho biết những khoa không có sinh viên học.
select * from dmkhoa where makhoa not in (select makhoa from dmsv );

-- 52.Cho biết sinh viên chưa thi môn cơ sở dữ liệu.
select masv from ketqua where masv not in (select masv from ketqua where mamh like '01');

-- 53.Cho biết sinh viên nào không thi lần 1 mà có dự thi lần 2.
select * from ketqua where lanthi = 1 and  masv not in  (select masv from ketqua where lanthi =2 );

-- 54.Cho biết môn nào không có sinh viên khoa anh văn học.
select  mamh from ketqua group by mamh having masv not in (select masv from dmsv where makhoa like 'av'); 
select masv from dmsv where makhoa like 'av';

-- 55.Cho biết những sinh viên khoa anh văn chưa học môn văn phạm.
-- 56.Cho biết những sinh viên không rớt môn nào.
-- 57.Cho biết những sinh viên học khoa anh văn có học bổng và những sinh viên 
-- chưa bao giờ rớt.
-- 58.Cho biết khoa nào có đông sinh viên nhận học bổng nhất và khoa nào khoa 
-- nào có ít sinh viên nhận học bổng nhất.
-- 59.Cho biết 3 sinh viên có học nhiều môn nhất.
-- 60.Cho biết những môn được tất cả các sinh viên theo học.
-- 61.Cho biết những sinh viên học những môn giống sinh viên có mã số A02 học.
-- 62.Cho biết những sinh viên học những môn bằng đúng những môn mà sinh 
-- viên A02 học.
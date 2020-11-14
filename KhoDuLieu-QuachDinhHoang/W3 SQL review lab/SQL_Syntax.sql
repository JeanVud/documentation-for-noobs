--Định nghĩa dữ liệu (DDL)
--Kiểu dữ liệu
--Số (numeric)
INT
SMALLINT
BIGINT
NUMERIC[(p[,s])]
DECIMAL[(p[,s])]
REAL
FLOAT

--Chuỗi ký tự (character string)
--Non Unicode
CHAR[(n)], VARCHAR[(n|max)]
--Unicode
NCHAR[(n)], NVARCHAR[(n|max)]

--Ngày giờ (datetime)
DATE --gồm ngày, tháng và năm (YYYY-MM-DD)
TIME --gồm giờ, phút và giây (HH:MM:SS)
DATETIME --gồm ngày và giờ ((YYYY-MM-DD HH:MM:SS)

--Tạo bảng
CREATE TABLE <Tên_bảng> (
	<Tên_cột> <Kiểu_dữ_liệu> [<RBTV>],
	<Tên_cột> <Kiểu_dữ_liệu> [<RBTV>],
	…
	
	[<RBTV>]
)

--Tạo khung nhìn (view)
CREATE VIEW <tên khung nhìn>  AS 
	<câu truy vấn>

--Xóa khung nhìn
DROP VIEW <tên khung nhìn>

--Tạo chỉ mục (index)
CREATE INDEX <tên chỉ mục> ON <tên bảng>(<tên cột>)

--Xóa chỉ mục
DROP INDEX <tên chỉ mục>

--Ràng buộc toàn vẹn (RBTV) 
NOT NULL
CHECK <tên cột> IN (<giá trị 1>, ..., <giá trị N>)
DEFAULT <giá trị>
UNIQUE (<tên cột 1>, ..., <tên cột k>)
PRIMARY KEY (<tên cột 1>, ..., <tên cột k>)
FOREIGN KEY (<tên cột 1>, ..., <tên cột k>) REFERENCES <tên bảng>(<tên cột 1>, ..., <tên cột k>)


--Đặt tên cho RBTV
CONSTRAINT <Ten_RBTV> <RBTV>

CONSTRAINT <tên khóa chính> PRIMARY KEY (<tên cột 1>, ..., <tên cột k>)
CONSTRAINT <tên khóa ngoại> FOREIGN KEY (<tên cột 1>, ..., <tên cột k>) 
							REFERENCES <tên bảng>(<tên cột 1>, ..., <tên cột k>)

--Sửa bảng
--Thêm cột
ALTER TABLE <Tên_bảng> ADD <Tên_cột> <Kiểu_dữ_liệu> [<RBTV>]

--Xóa cột
ALTER TABLE <Tên_bảng> DROP COLUMN <Tên_cột> 

--Sửa(thay đổi) cột
ALTER TABLE <Tên_bảng> ALTER COLUMN <Tên_cột> <Kiểu_dữ_liệu_mới>

--Thêm RBTV
ALTER TABLE <Tên_bảng> ADD 
	CONSTRAINT <Ten_RBTV> <RBTV>,
	CONSTRAINT <Ten_RBTV> <RBTV>,
	…

--Xóa RBTV
ALTER TABLE <Tên_bảng> DROP <Tên_RBTV> 

--Xóa bảng
DROP TABLE <Tên_bảng>

--Tạo miền giá trị
CREATE DOMAIN <Tên_kdl_mới> AS <Kiểu_dữ_liệu>


--Thao tác dữ liệu (DML)
--Lệnh SELECT 
SELECT [DISTINCT | ALL] <danh sách các cột (biểu thức)>
FROM <danh sách các bảng>
[WHERE <điều kiện>]
[GROUP BY <danh sách các cột gom nhóm> [HAVING <điều kiện trên nhóm>]]
[ORDER BY <danh sách các cột (biểu thức)>]

--Thứ tự thực hiện
FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
FROM		Xác định các bảng cần dùng.
WHERE		Điều kiện trên dòng.
GROUP BY	Tạo các nhóm có giá trị trên các cột cần nhóm giống nhau.
HAVING		Điều kiện trên nhóm.
SELECT		Xác định các cột trả về
ORDER BY 	Xác định thứ tự của kết quả

--Các từ khóa thường sử dụng
Đổi tên: AS 
Biểu thức logic: AND, OR
So sánh: LIKE (%, _), BETWEEN ... AND ..., IN, NOT IN, EXISTS, NOT EXISTS, ANY, ALL
Loại các giá trị trùng nhau: DISTINCT
Hàm nhóm: COUNT, MIN, MAX, SUM, AVG
Tập hợp: UNION, INTERSECT, EXCEPT
Phép kết: [INNER] JOIN, LEFT|RIGHT|FULL [OUTER] JOIN.
Sắp xếp: ASC, DESC

--Một câu lệnh SELECT này có thể được lồng trong một câu lệnh SELECT khác (subselect, nested select, subquery, nested query).
--Subselect có thể nằm ở mệnh để SELECT, FORM, WHERE, HAVING.
--Subselect chỉ chứa một cột, trừ trường hợp nó được dùng với từ khóa EXISTS.
--Khi subselect là một toán hạng trong phép so sánh, nó phải nằm ở vế phải.

--Đổi (đặt) Tên
AS

--Loại bỏ các dòng trùng nhau
DISTINCT, COUNT (DISTINCT (<danh sách cột>) )

--Xác định giá trị trong (ngoài) khoảng
(NOT) BETWEEN gt1 AND gt2

--Xác định giá trị giống(không giống) một mẫu
(NOT) LIKE
--Ký tự đặc tả cho LIKE:
--	%: chuỗi bất kỳ
--	_: ký tự bất kỳ

--Giá trị ngày giờ
--YYYY-MM-DD	‘1955-12-08’
--MM/DD/YYYY	’12/08/1955’
--HH:MM:SS		’17:30:00’

--Giá trị đặt biệt
IS (NOT) NULL

--Các phép toán tập hợp
--Loại bỏ các bộ trùng nhau trong kết quả
UNION (Hội)
INTERSECT (Giao)
EXCEPT (Trừ)

--Giữ lại các bộ trùng nhau
UNION ALL
INTERSECT ALL
EXCEPT ALL

--Cú pháp
SELECT <ds cột> FROM <ds bảng> WHERE <điều kiện>
UNION [ALL]
SELECT <ds cột> FROM <ds bảng> WHERE <điều kiện>

SELECT <ds cột> FROM <ds bảng> WHERE <điều kiện>
INTERSECT [ALL]
SELECT <ds cột> FROM <ds bảng> WHERE <điều kiện>

SELECT <ds cột> FROM <ds bảng> WHERE <điều kiện>
EXCEPT [ALL]
SELECT <ds cột> FROM <ds bảng> WHERE <điều kiện>

--Truy vấn lồng
SELECT <danh sách các cột>
FROM <danh sách các bảng>
WHERE [<biểu thức>] <so sánh tập hợp> (
	SELECT <danh sách các cột>
	FROM <danh sách các bảng>
	WHERE <điều kiện>)

<so sánh tập hợp>: >, >=, <, <=, =, IN, NOT IN, EXISTS, NOT EXISTS, ALL, ANY
<biểu thức>: không có khi <so sánh tập hợp> là EXISTS, NOT EXISTS

--Lồng phân cấp 
--Mệnh đề WHERE của truy vấn con không tham chiếu đến thuộc tính của các quan hệ trong mệnh đề FROM ở truy vấn cha. Khi thực hiện, câu truy vấn con sẽ được thực hiện trước.

--Lồng tương quan
--Mệnh đề WHERE của truy vấn con tham chiếu ít nhất một thuộc tính của các quan hệ trong mệnh đề FROM ở truy vấn cha. Khi thực hiện, câu truy vấn con sẽ được thực hiện nhiều lần, mỗi lần tương ứng với một bộ của truy vấn cha.

--Truy vấn dùng EXISTS
select *
from T1
where exists
	(select *
	from T2
	where T1.A = T2.A)
--tương ứng với mã giả
for each tuple t1 in table T1
	for each tuple t2 in table T2
		if (t1.A = t2.A) then
			print t1.*
--viết lại dùng IN
select *
from T1
where T1.A in
	(select T2.A
	from T2)
	
--Truy vấn dùng NOT EXISTS
select *
from T1
where not exists
	(select *
	from T2
	where t1.A = t2.A AND ...)
--tương ứng với mã giả
for each tuple t1 in table T1
	check = true
	for each tuple t2 in table T2
		if (t1.A = t2.A AND ...) then
			check =  false
			break
	if (check) then 
		print t1.*
--tương đương với
select * from T1
EXCEPT
select *
from T1
where exists
	(select *
	from T2
	where T1.A = T2.A AND ...)
	
--Hàm tập hợp
COUNT(*)  --đếm số dòng
COUNT(<tên thuộc tính>) --đếm số giá trị khác NULL của thuộc tính
COUNT(DISTINCT <tên thuộc tính>) --đếm số giá trị khác nhau và khác NULL của thuộc tính
MIN
MAX
SUM
AVG

--Truy vấn con ở mệnh đề FROM
SELECT <danh sách các cột>
FROM R1, R2, (<truy vấn con>) AS <tên bảng>
WHERE <điều kiện>

--Điều kiện kết ở mệnh đề FROM
--Kết bằng
SELECT <danh sách các cột>
FROM R1 [INNER] JOIN R2 ON  <biểu thức>
WHERE <điều kiện>

--Kết ngoại
SELECT <danh sách các cột>
FROM R1 LEFT|RIGHT|FULL [OUTER] JOIN R2 ON  <biểu thức>
WHERE <điều kiện>

--Mệnh đề WITH
WITH <tên quan hệ>(<tên cột 1>, ... <tên cột n>) AS
	<câu truy vấn để định nghĩa quan hệ>
	
--Cấu trúc CASE
CASE <tên cột>
	WHEN <giá trị> THEN <biểu thức>
	WHEN <giá trị> THEN <biểu thức>
	…
	[ELSE <biểu thức>]
END

--Lệnh INSERT
INSERT INTO <tên bảng>(<danh sách các thuộc tính>)
VALUES (<danh sách các giá trị>)

INSERT INTO <tên bảng>(<danh sách các thuộc tính>)
	<câu truy vấn con>

--Lệnh DELETE 
DELETE FROM <tên bảng>
[WHERE <điều kiện>]

--Lệnh UPDATE 
UPDATE <tên bảng>
SET <tên thuộc tính 1> = <giá trị mới 1>,
    <tên thuộc tính 2> = <giá trị mới 2>, 
	…
[WHERE <điều kiện>]

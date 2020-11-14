CREATE TABLE SUPPLIER (
	SCODE char(2) NOT NULL 
	SNAME varchar(16) NOT NULL,
	STATUS int NOT NULL,
	CITY varchar(20) NOT NULL,
	UNIQUE(SNAME),
	PRIMARY KEY(SCODE)
);

CREATE TABLE PRODUCT (
	PCODE char(2) NOT NULL
	PNAME varchar(18) NOT NULL,
	COLOR varchar(10) NOT NULL,
	WEIGHT decimal(4,1) NOT NULL,
	CITY varchar(20) NOT NULL,
	PRIMARY KEY(PCODE),
	UNIQUE (PNAME, COLOR, CITY)
);

CREATE TABLE PROJECT (
	JCODE char(2) NOT NULL,
	PNAME varchar(20) NOT NULL,
	CITY varchar(20) NOT NULL,
	PRIMARY KEY (JCODE)
);
  
CREATE TABLE SUPPLY (
	SCODE char(2) NOT NULL,
	PCODE char(2) NOT NULL,
	JCODE char(2) NOT NULL,
	QTY int NOT NULL,
	PRIMARY KEY (SCODE, PCODE, JCODE),
	FOREIGN KEY (SCODE) REFERENCES SUPPLIER(SCODE),
	FOREIGN KEY (PCODE) REFERENCES PRODUCT(PCODE),
	FOREIGN KEY (JCODE) REFERENCES PROJECT(JCODE)
);
  
INSERT INTO SUPPLIER VALUES ('S1', 'Smith', 20, 'London');
INSERT INTO SUPPLIER VALUES ('S2', 'Jones', 10, 'Paris');
INSERT INTO SUPPLIER VALUES ('S3', 'Blake', 30, 'Paris');
INSERT INTO SUPPLIER VALUES ('S4', 'Clark', 20, 'London');
INSERT INTO SUPPLIER VALUES ('S5', 'Adams', 30, 'Athens');
INSERT INTO SUPPLIER VALUES ('S6', 'Kuhn', NULL, 'Berlin');
INSERT INTO SUPPLIER VALUES ('S7', 'Thomas', 0, 'London');
INSERT INTO SUPPLIER VALUES ('S8', 'Mill', 5, NULL);

INSERT INTO PRODUCT VALUES ('P1', 'Nut', 'Red', 12, 'London');
INSERT INTO PRODUCT VALUES ('P2', 'Bolt', 'Green', 17, 'Paris');
INSERT INTO PRODUCT VALUES ('P3', 'Screw', 'Blue', 17, 'Oslo');
INSERT INTO PRODUCT VALUES ('P4', 'Screw', 'Red', 14, 'London');
INSERT INTO PRODUCT VALUES ('P5', 'Cam', 'Blue', 12, 'Paris');
INSERT INTO PRODUCT VALUES ('P6', 'Cog', 'Red', 19, 'London');
INSERT INTO PRODUCT VALUES ('P7', 'Shaft', NULL, 40, 'Paris');
INSERT INTO PRODUCT VALUES ('P8', 'Chain', 'Black', 55, NULL);

INSERT INTO PROJECT VALUES ('J1', 'Sorter', 'Paris');
INSERT INTO PROJECT VALUES ('J2', 'Display', 'Rome');
INSERT INTO PROJECT VALUES ('J3', 'OCR', 'Athens');
INSERT INTO PROJECT VALUES ('J4', 'Console', 'Athens');
INSERT INTO PROJECT VALUES ('J5', 'RAID', 'London');
INSERT INTO PROJECT VALUES ('J6', 'EDS', 'Oslo');
INSERT INTO PROJECT VALUES ('J7', 'Tape', 'London');
INSERT INTO PROJECT VALUES ('J8', 'Display', NULL);

INSERT INTO SUPPLY VALUES ('S1', 'P1', 'J1', 200);
INSERT INTO SUPPLY VALUES ('S1', 'P1', 'J4', 700);
INSERT INTO SUPPLY VALUES ('S2', 'P3', 'J1', 400);
INSERT INTO SUPPLY VALUES ('S2', 'P3', 'J2', 200);
INSERT INTO SUPPLY VALUES ('S2', 'P3', 'J3', 200);
INSERT INTO SUPPLY VALUES ('S2', 'P3', 'J4', 500);
INSERT INTO SUPPLY VALUES ('S2', 'P3', 'J5', 600);
INSERT INTO SUPPLY VALUES ('S2', 'P3', 'J6', 400);
INSERT INTO SUPPLY VALUES ('S2', 'P3', 'J7', 800);
INSERT INTO SUPPLY VALUES ('S2', 'P5', 'J2', 600);
INSERT INTO SUPPLY VALUES ('S3', 'P3', 'J1', 200);
INSERT INTO SUPPLY VALUES ('S3', 'P4', 'J2', 500);
INSERT INTO SUPPLY VALUES ('S4', 'P6', 'J3', 300);
INSERT INTO SUPPLY VALUES ('S4', 'P6', 'J7', 300);
INSERT INTO SUPPLY VALUES ('S5', 'P2', 'J2', 200);
INSERT INTO SUPPLY VALUES ('S5', 'P2', 'J4', 600);
INSERT INTO SUPPLY VALUES ('S5', 'P5', 'J5', 500);
INSERT INTO SUPPLY VALUES ('S5', 'P5', 'J7', 600);
INSERT INTO SUPPLY VALUES ('S5', 'P6', 'J2', 200);
INSERT INTO SUPPLY VALUES ('S5', 'P1', 'J4', 600);
INSERT INTO SUPPLY VALUES ('S5', 'P3', 'J4', 200);
INSERT INTO SUPPLY VALUES ('S5', 'P4', 'J4', 800);
INSERT INTO SUPPLY VALUES ('S5', 'P5', 'J4', 400);
INSERT INTO SUPPLY VALUES ('S5', 'P6', 'J4', 500);
INSERT INTO SUPPLY VALUES ('S8', 'P8', 'J8', 200);




/**************************************************************
  BASIC SELECT STATEMENTS
  Works for SQL Server
**************************************************************/

-- select *
select * from supplier
select * from product
select * from supply
select * from project

-- Cho biết những ncc có trụ sở ở London
select scode, sname
from supplier
where city = 'London'

-- Cho biết những ncc và những sản phẩm họ cung cấp
select supplier.scode, sname, product.pcode, pname
from supplier, supply, product
where supplier.scode = supply.scode
	and product.pcode = supply.pcode

-- Cho biết những ncc và những sản phẩm họ cung cấp (loại dòng trùng nhau),
-- SQL có sự khác biệt với đại số quan hệ ở chỗ cho phép dòng trùng nhau.
-- SQL dựa trên bag, đại số quan hệ dựa trên set
select distinct supplier.scode, sname, product.pcode, pname
from supplier, supply, product
where supplier.scode = supply.scode
	and product.pcode = supply.pcode

-- Cho biết những ncc ở 'London' cung cấp sản phẩm có tên 'Nut'
-- cho dự án có tên 'Console' với số lượng > 500. 
-- (nhập nhằng do không biết các thuộc tính ở mệnh đề select là của bảng nào )
select scode, sname, pcode, pname, jcode, jname, qty
from supplier, supply, product, project
where supplier.scode = supply.scode
	and product.pcode = supply.pcode
	and project.jcode = supply.jcode
	and supplier.city = 'London'
	and product.pname = 'Nut'
	and project.jname = 'Console'
	and supply.qty > 500

-- Cho biết những ncc ở 'London' cung cấp sản phẩm có tên 'Nut'
-- cho dự án có tên 'Console' với số lượng > 500. 
-- (chỉ định rõ các thuộc tính ở mệnh đề select là của bảng nào)
select supplier.scode, sname, 
		product.pcode, pname, 
		project.jcode, jname, qty
from supplier, supply, product, project
where supplier.scode = supply.scode
	and product.pcode = supply.pcode
	and project.jcode = supply.jcode
	and supplier.city = 'London'
	and product.pname = 'Nut'
	and project.jname = 'Console'
	and supply.qty > 500

-- Cho biết thông tin về ncc, sản phẩm và dự án,
-- sắp xếp theo số lượng sản phẩm được cung cấp giảm dần
select supplier.scode, sname, 
		product.pcode, pname, 
		project.jcode, jname, qty
from supplier, supply, product, project
where supplier.scode = supply.scode
	and product.pcode = supply.pcode
	and project.jcode = supply.jcode
order by qty desc

-- Cho biết thông tin về ncc, sản phẩm và dự án,
-- sắp xếp theo mã ncc tăng dần và số lượng sản phẩm được cung cấp giảm dần
select supplier.scode, sname, 
		product.pcode, pname, 
		project.jcode, jname, qty
from supplier, supply, product, project
where supplier.scode = supply.scode
	and product.pcode = supply.pcode
	and project.jcode = supply.jcode
order by supplier.scode asc, qty desc

-- so sánh chuỗi dùng like
select *
from supplier
where sname like 'S%'

-- cross product
select *
from supplier, product

-- rename
select pcode, weight*454 AS 'Weight in grams'
FROM product;

/**************************************************************
  TABLE VARIABLES AND SET OPERATORS
  Works for SQL Server
**************************************************************/

-- Cho biết thông tin về ncc, sản phẩm và dự án.
select s.scode, sname, p.pcode, pname, j.jcode, jname, qty
from supplier s, supply spj, product p, project j
where s.scode = spj.scode
	and p.pcode = spj.pcode
	and j.jcode = spj.jcode

-- Cho biết cặp mã nhà cung cấp ở cùng thành phố
select s1.scode, s2.scode 
from supplier s1, supplier s2
where s1.city = s2.city 

-- Cho biết cặp mã nhà cung cấp ở cùng thành phố
-- (loại những cặp có cùng ncc)
select s1.scode, s2.scode 
from supplier s1, supplier s2
where s1.city = s2.city 
	and s1.scode <> s2.scode 

-- Cho biết cặp mã nhà cung cấp ở cùng thành phố
-- (loại những cặp hoán vị nhau)
select s1.scode, s2.scode 
from supplier s1, supplier s2
where s1.city = s2.city 
	and s1.scode < s2.scode 

-- Tạo một danh sách gồm tên các sản phẩm và tên các dự án
select pname from product
union
select jname from project

-- Tạo một danh sách gồm tên các sản phẩm và tên các dự án
-- (đặt tên lại)
select pname as name from product
union
select jname as name from project

-- Tạo một danh sách gồm tên các sản phẩm và tên các dự án
-- (union all)
select pname as name from product
union all
select jname as name from project

-- Cho biết những nhà cung cấp đã cung cấp cả sản phẩm 'P3' và 'P4'
select scode from supply where pcode = 'P3'
intersect
select scode from supply where pcode = 'P4'

-- Cho biết những nhà cung cấp đã cung cấp cả sản phẩm 'P3' và 'P4'
select distinct s1.scode
from supply s1, supply s2 
where s1.scode = s2.scode
	and s1.pcode = 'P3'
	and s2.pcode = 'P4'

-- Cho biết những nhà cung cấp đã cung cấp sản phẩm 'P3'
-- nhưng không cung cấp sản phẩm 'P4'
select scode from supply where pcode = 'P3'
except
select scode from supply where pcode = 'P4'

-- Cho biết những nhà cung cấp đã cung cấp sản phẩm 'P3'
-- nhưng không cung cấp sản phẩm 'P4' (sai)
select distinct s1.scode
from supply s1, supply s2 
where s1.scode = s2.scode
	and s1.pcode = 'P3'
	and s2.pcode <> 'P4'


/**************************************************************
  SUBQUERIES IN THE WHERE CLAUSE
  Works for SQL Server
**************************************************************/

-- Cho biết những nhà cung cấp đã cung cấp sản phẩm 'P1'
-- dùng subquery và in
select scode, sname
from supplier
where scode in 
	(select scode
	from supply
	where pcode = 'P1')
-- đây là loại truy vấn lồng phân cấp (subquery được thực hiện độc lập với outer query) 
-- đầu tiên subquery được thực hiện trước, mã giả như bên dưới
for each tuple t in supply
	if (t.pcode = 'P1') then
		print t.scode
-- kết quả thu được, giả sử là quan hệ T(scode), sẽ được dùng cho outer query như sau
for each tuple s in supplier
	if (s.scode in T.scode)
		print s.scode, s.sname
		
-- không dùng subquery
select s.scode, sname
from supplier s, supply spj
where s.scode = spj.scode
	and spj.pcode = 'P1'

-- không dùng subquery (loại những dòng trùng nhau)
select distinct s.scode, sname
from supplier s, supply spj
where s.scode = spj.scode
	and spj.pcode = 'P1'

-- Những dòng trùng nhau có thể đóng vai trọng trong một số trường hợp
-- Ví dụ: Cho biết trọng lượng của các sản phẩm được cung cấp bởi nhà cung cấp 'S5'
-- dùng subquery và in
select weight
from product
where pcode in
	(select pcode
	from supply
	where scode = 'S5')
-- Đây là loại truy vấn lồng phân cấp. Mệnh đề WHERE của subquery không tham chiếu đến thuộc tính của các quan hệ trong mệnh đề FROM ở outer query. Khi thực hiện, subquery sẽ được thực hiện trước như mã giả bên dưới
--	for each tuple t in supply
--		if (t.pcode = 'P1') then
--			print t.scode
-- kết quả thu được, giả sử là quan hệ T(scode), sẽ được dùng cho outer query như sau
--	for each tuple s in supplier
--		if (s.scode in T.scode) then
--			print s.scode, s.sname

-- dùng subquery và exists
-- Đây là loại truy vấn lồng tương quan. Mệnh đề WHERE của subquery tham chiếu ít nhất một thuộc tính của các quan hệ trong mệnh đề FROM ở outer query. Khi thực hiện, subquery sẽ được thực hiện nhiều lần, mỗi lần tương ứng với một bộ của outer query. Mã giả được mô tả như bên dưới:
--	for each tuple s in supplier
--		for each tuple t in supply
--			if (s.scode = t.scode and t.pcode = 'P1') then
--				print s.scode, s.sname
--				break

-- không dùng subquery (sai)
select weight
from product p, supply spj
where p.pcode = spj.pcode
	and spj.scode = 'S5'

select distinct weight
from product p, supply spj
where p.pcode = spj.pcode
	and spj.scode = 'S5'

-- Cho biết những nhà cung cấp đã cung cấp sản phẩm 'P3' nhưng không cung cấp sản phẩm 'P4'
-- dùng subquery và not in
select scode
from supplier
where scode in (select scode from supply where pcode = 'P3')
	and scode not in (select scode from supply where pcode = 'P4')

select scode
from supplier
where scode in (select scode from supply where pcode = 'P3')
	and not scode in (select scode from supply where pcode = 'P4')

-- Cho biết những sản phẩm mà có ít nhất một sản phẩm khác có cùng xuất xứ (cùng thành phố) - Sai
select pcode, pname, city
from product p1
where exists 
	(select * 
	from product p2
	where p1.city = p2.city)

-- Cho biết những sản phẩm mà có ít nhất một sản phẩm khác có cùng xuất xứ (cùng thành phố) - Sửa lại
select pcode, pname, city
from product p1
where exists 
	(select * 
	from product p2
	where p1.city = p2.city
		and p1.pcode <> p2.pcode)

-- Cho biết những sản phẩm có trọng lượng lớn nhất
-- dùng subquery và not exists
select pcode, pname, weight
from product p1
where not exists
	(select *
	from product p2
	where p2.weight > p1.weight)

-- không dùng subquery (sai)
select p1.pcode, p1.pname, p1.weight
from product p1, product p2
where p2.weight > p1.weight

select distinct p1.pcode, p1.pname, p1.weight
from product p1, product p2
where p2.weight > p1.weight

-- dùng subquery và all
select pcode, pname, weight
from product
where weight >= all
	(select weight
	from product)

-- dùng subquery và any
select pcode, pname, weight
from product
where not weight < any
	(select weight
	from product)

-- Cho biết những sản phẩm có trọng lượng lớn hơn một sản phẩm khác
-- dùng any
select pcode, pname, weight
from product
where weight > any
	(select weight
	from product)

-- dùng exists 
select pcode, pname, weight
from product p1
where exists
	(select *
	from product p2
	where p2.weight < p1.weight) 

-- Cho biết những nhà cung cấp đã cung cấp sản phẩm 'P3' nhưng không cung cấp sản phẩm 'P4'
select scode
from supplier
where scode = any (select scode from supply where pcode = 'P3')
	and scode <> any (select scode from supply where pcode = 'P4')

select scode
from supplier
where scode = any (select scode from supply where pcode = 'P3')
	and not scode = any (select scode from supply where pcode = 'P4')

/**************************************************************
  JOIN OPERATORS
  Works for SQL Server
**************************************************************/

-- Cho biết tên những nhà cung cấp và tên những sản phẩm 
-- mà nhà cung cấp đó đã cung cấp tương ứng
select distinct sname, pname
from supplier s, supply spj, product p
where s.scode = spj.scode
	and p.pcode = spj.pcode

-- dùng join (inner join)
select distinct sname, pname
from (supplier s join supply spj on s.scode = spj.scode)
	join product p on p.pcode = spj.pcode

-- Cho biết những ncc ở 'London' cung cấp sản phẩm có tên 'Nut'
-- cho dự án có tên 'Console' với số lượng > 500.
select s.scode, sname, 
		p.pcode, pname, 
		j.jcode, jname, qty
from supplier s join supply spj on s.scode = spj.scode
	join product p on p.pcode = spj.pcode
	join project j on j.jcode = spj.jcode
where s.city = 'London'
	and p.pname = 'Nut'
	and j.jname = 'Console'
	and spj.qty > 500

-- Cho biết cặp dự án được thực hiện ở cùng thành phố
-- SELF-JOIN
select j1.jcode, j2.jcode, j1.city
from project j1 join project j2 on j1.city = j2.city
where j1.jcode < j2.jcode

-- Cho biết thông tin về nhà cung cấp và những sản phẩm họ cung cấp
-- (liệt kê cả những nhà cung cấp không cung cấp sản phẩm nào)
-- dùng LEFT JOIN
select distinct s.scode, pcode
from supplier s left join supply spj on s.scode = spj.scode

-- không dùng LEFT JOIN
select distinct scode, pcode
from supply
union
select scode, NULL
from supplier
where scode not in 
	(select scode from Supply)

/**************************************************************
  NULL VALUE
  Works for SQL Server
**************************************************************/

select * from supplier

select * 
from supplier 
where status >= 20 or status < 20

select * 
from supplier 
where status is not null

select * 
from supplier 
where status >= 20 or status < 20 or status is null

/**************************************************************
  AGGREGATION
  Works for SQL Server
**************************************************************/

-- Cho biết số loại sản phẩm khác nhau mà nhà cung cấp 'S5' đã cung cấp
select count(distinct pcode) as num_of_pcode
from supply
where scode = 'S5'

-- Với mỗi nhà cung cấp, cho biết nhà cung cấp đó đã cung cấp bao nhiêu sản phẩm
-- (liệt kê cả những nhà cung cấp không cung cấp sản phẩm)
select s.scode, count(distinct pcode) as num_of_pcode
from supplier s left join supply spj on s.scode = spj.scode 
group by s.scode

select scode, count(distinct pcode) as num_of_pcode
from supply
group by scode
union
select scode, 0
from supplier
where scode not in
	(select scode from supply)

-- Cho biết số lượng của mỗi loại sản phẩm mà nhà cung cấp 'S5' đã cung cấp
select pcode, sum(qty) as sum_of_qty
from supply
where scode = 'S5'
group by pcode

-- Cho biết những nhà cung cấp đã cung cấp >= 2 loại sản phẩm khác nhau cho dự án 'J3'
select scode, count(scode) as num_of_pcode
from supply
where jcode = 'J2'
group by scode
having count(scode) >= 2


/**************************************************************
  SUBQUERIES IN THE FROM AND SELECT CLAUSES
  Works for SQL Server
**************************************************************/

-- Với mỗi nhà cung cấp, cho biết số loại sản phẩm khác nhau mà nhà cung cấp đó cung cấp
select scode, sname,
	(select count(distinct pcode)
	from supply
	where supply.scode = supplier.scode) as num_pcode
from supplier

-- Với mỗi nhà cung cấp, cho biết mã sản phẩm được cung cấp với số lượng lớn nhất.
-- 1. Với mỗi nhà cung cấp, cho biết số lượng của mỗi loại sản phẩm 
select scode, pcode, sum(qty) as total_qty
from supply
group by scode, pcode

-- 2. Với mỗi nhà cung cấp, cho biết số lượng lớn nhất của các loại sản phẩm 
select scode, max(qty) as max_qty
from (select scode, pcode, sum(qty) as qty
	from supply
	group by scode, pcode) as t
group by scode

-- 3. Với mỗi nhà cung cấp, cho biết mã sản phẩm được cung cấp với số lượng lớn nhất.
select r.scode, r.pcode, qty
from (select scode, pcode, sum(qty) as qty
	from supply
	group by scode, pcode) as r,
	(select scode, max(qty) as max_qty
	from (select scode, pcode, sum(qty) as qty
		from supply
		group by scode, pcode) as t
	group by scode) as s
where r.scode = s.scode
	and r.qty = s.max_qty

-- Viết lại dùng cú pháp with
with r(scode, pcode, qty) as 
	(select scode, pcode, sum(qty)
	from supply
	group by scode, pcode),
	s(scode, max_qty) as
	(select scode, max(qty)
	from r
	group by scode)
select r.scode, r.pcode, qty
from r, s
where r.scode = s.scode
	and r.qty = s.max_qty

	
	
	
	
/**************************************************************
  EXAMPLES
  Works for SQL Server
**************************************************************/
--Q1: Cho biết thông tin chi tiết của tất cả các nhà cung cấp.
		SELECT * 
		FROM SUPPLIER;
--Q2: Liệt kê mã số của tất cả các sản phẩm đã được cung cấp.
		SELECT DISTINCT PCODE   
		FROM SUPPLY;
--Q3: Liệt kê mã số của những nhà cung cấp ở 'Paris' và có status > 20.
		SELECT SCODE 
		FROM SUPPLIER
		WHERE CITY = 'Paris' 
			AND STATUS > 20;
--Q4: Với mỗi sản phẩm, liệt kê mã số, trọng lượng theo gram (1 pound = 454 gram)
		SELECT 	PCODE, 
				WEIGHT * 454 AS 'Weight (grams)'
		FROM 	PRODUCT;
--Q5: Cho biết mã số và status của những nhà cung cấp ở 'Paris'  theo thứ tự giảm dần của status.
		SELECT 	SCODE, STATUS 
		FROM 	SUPPLIER 
		WHERE 	CITY = 'Paris' 
		ORDER BY STATUS DESC;
--Q6: Cho biết tất cả các sản phẩm có tên bắt đầu là ký tự C.
		SELECT 	* 
		FROM 	PRODUCT
		WHERE 	PNAME LIKE 'C%';
--Q7: Cho biết mã nhà cung cấp và mã sản phẩm tương ứng với điều kiện chúng đều ở cùng thành phố. 
		SELECT 	S.SCODE, P.PCODE 	
		FROM 	SUPPLIER S, PRODUCT P
		WHERE 	S.CITY = P.CITY;
--Q8: Với mỗi sản phẩm đã được cung cấp, cho biết mã số sản phẩm và tổng số lượng đã giao dịch của sản phẩm đó.
		SELECT 	PCODE, SUM(QTY) 	
		FROM 	SUPPLY 
		GROUP BY PCODE;
--Q9: Cho biết những mã số sản phẩm được cung cấp bởi nhiều hơn 1 nhà cung cấp.
		SELECT 	PCODE 
		FROM 	SUPPLY 
		GROUP BY PCODE 
		HAVING 	COUNT(*) > 1;
--Q10: Cho biết mã của những sản phẩm có trọng lượng nhỏ nhất.
		SELECT 	PCODE
		FROM 	PRODUCT
		WHERE 	WEIGHT = 
			 (SELECT 	MIN(WEIGHT)
			FROM 	PRODUCT);
--Q11: Tìm mã của những nhà cung cấp đã cung cấp sản phẩm cho dự án 'Console' và mã của những sản phẩm họ đã cung cấp.
		SELECT 	S.SCODE, P.PCODE
		FROM 	SUPPLIER S, SUPPLY SPJ, PRODUCT P, PROJECT J
		WHERE 	S.SCODE = SPJ.SCODE
			 AND	P.PCODE = SPJ.PCODE
			 AND	J.JCODE = SPJ.JCODE
			 AND	J.JNAME = ‘Console’
--Q11: Tìm mã của những nhà cung cấp đã cung cấp sản phẩm cho dự án 'Console' và mã của những sản phẩm họ đã cung cấp.
		SELECT 	S.SCODE, P.PCODE
		FROM 	((SUPPLIER S JOIN SUPPLY SPJ ON S.SCODE = SPJ.SCODE) 
				JOIN PRODUCT P  ON P.PCODE = SPJ.PCODE)
				JOIN PROJECT J ON J.JCODE = SPJ.JCODE
		WHERE 	J.JNAME = ‘Console’
--Q12: Cho biết cặp mã nhà cung cấp tương ứng với điều kiện chúng đều ở cùng thành phố. 
		SELECT 	S1.SCODE, S2.SCODE 
		FROM 	SUPPLIER S1, SUPPLIER S2
		WHERE 	S1.CITY = S2.CITY 
			AND 	S1.SCODE < S2.SCODE;

	
--Q13: Liệt kê tên của những sản phẩm chưa từng được cung cấp cho một dự án nào đó.
select pname 
from product
where pcode in
	(select pcode 
	from product
	where pcode not in 
		(select pcode 
		from supply))

--Q14: Liệt kê tên của những sản phẩm chưa từng được cung cấp cho một dự án tại 'London'.
select pname 
from product
where pcode in
	(select pcode 
	from product
	where pcode not in 
		(select pcode 
		from supply
		where jcode in 
			(select jcode 
			from project
			where city='London')))

--Q15: Tìm tên của mỗi nhà cung cấp và tên của mỗi sản phẩm mà nhà cung cấp đó đã cung cấp cho cả hai dự án 'J2' và 'J4'.
--(Tìm tên của các nhà cung cấp đã cung cấp cùng một sản phẩm cho cả hai dự án 'J2' và 'J4').
--cách 1: dùng phép tích kết hợp điều kiện
select sname, pname
from supply s1, supply s2, supplier s, product p
where s1.Scode = s2.scode
	and s1.jcode = 'J2' and s2.jcode = 'J4'
	and s1.pcode = s2.pcode
	and s.scode = s1.scode
	and p.pcode = s1.pcode

--cách 2: dùng intersect
select sname, pname
from supplier s, supply sp, product p
where s.scode = sp.scode
	and p.pcode = sp.pcode
	and sp.jcode ='J2'
intersect
select sname, pname
from supplier s, supply sp, product p
where s.scode = sp.scode
	and p.pcode = sp.pcode
	and sp.jcode ='J4'

--cách 3: dùng group by và count
select sname, pname
from supplier s, product p, 
	(select scode, pcode
	from supply
	where jcode = 'J2' or jcode = 'J4'
	group by scode, pcode
	having count(distinct jcode) = 2) t
where s.scode = t.scode
	and p.pcode = t.pcode

-- Câu hỏi tổng quát hơn: Tìm những ncc cung cấp cùng 1 sp cho tất cả các dự án ở 'London'
--không dùng được cách 1 và cách 2 nhưng có thể dùng cách 3
select sname, pname
from supplier s, product p, 
	(select scode, pcode
	from supply
	where jcode in 
		(select jcode
		from project 
		where city = 'London')
	group by scode, pcode
	having count(distinct jcode) =  
		(select count(*)
		from project 
		where city = 'London')) t
where s.scode = t.scode
	and p.pcode = t.pcode

--Q16: Liệt kê mã của nhà cung cấp đã cung cấp số lượng nhiều nhất cho mỗi loại sản phẩm (tính trên tất cả các dự án).
--cách 1: không dùng mệnh đề with
select t.pcode, t.scode, t.soluong
from 
	(select scode, pcode, sum(qty) as 'soluong'
	from supply
	group by scode, pcode) t, 
	(select t.pcode, max(soluong) as 'soluongln'
	from 
		(select scode, pcode, sum(qty) as 'soluong'
		from supply
		group by scode, pcode) t
	group by t.pcode) s
where t.pcode = s.pcode
	and t.soluong = s.soluongln
order by t.pcode

--cách 2: dùng mệnh đề with
with t(scode, pcode, soluong) as
	(select scode, pcode, sum(qty)
	from supply
	group by scode, pcode),
	s(pcode, soluongln) as
	(select pcode, max(soluong)
	from t
	group by pcode)
select t.pcode, t.scode, t.soluong
from t, s
where t.pcode = s.pcode
	and t.soluong = s.soluongln
order by t.pcode

--Q17: Liệt kê những nhà cung cấp đã cung cấp tất cả những sản phẩm có tên 'Screw'.
--cách 1: dùng group by và count
select sname
from supplier s , supply sp, product p
where s.scode = sp.scode
	and sp.pcode = p.pcode
	and pname = 'Screw'
group by s.scode, sname
having count(distinct sp.pcode) = 
	(select count(pcode)
	from product
	where pname = 'Screw')

--cách 2: dùng not exists và except 
select sname
from supplier s
where not exists
	(select pcode
	from product
	where pname = 'Screw'
	except 
	select sp.pcode
	from supply sp, product p
	where sp.pcode = p.pcode
		and pname = 'screw'
		and s.scode = sp.scode)

--Q18: Liệt kê những nhà cung cấp đã cung cấp tất cả những sản phẩm có tên 'Screw' cho cùng một dự án.
select sname
from supplier s , supply sp, product p
where s.scode = sp.scode
	and sp.pcode = p.pcode
	and pname = 'Screw'
group by s.scode, sname, sp.jcode
having count(distinct sp.pcode) = 
	(select count(pcode)
	from product
	where pname = 'Screw')

--Q19: Với mỗi loại sản phẩm, cho biết cặp nhà cung cấp nào đã cung cấp với số lượng nhiều nhất và ít nhất.
with t(scode, pcode, soluong) as
	(select scode, pcode, sum(qty)
	from supply
	group by scode, pcode),
	s(pcode, soluongln, soluongnn) as
	(select pcode, max(soluong), min(soluong)
	from t
	group by pcode)
select t1.pcode, t1.scode as scode1, s.soluongln, 
				t2.scode as scode2, s.soluongnn
from t t1, t t2, s
where t1.pcode = s.pcode
	and t2.pcode = s.pcode
	and t1.soluong = s.soluongln
	and t2.soluong = s.soluongnn
order by s.pcode
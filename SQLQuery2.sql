--Lab ในชั้นเรียนวันที่  6 สิงหาคม 2569
--ใช้ ฐานข้อมูล Northwind เพื่อ Query ข้อมูลต่อไปนี้
--1.ต้องการ คำนำหน้า ชื่อ นามสกุล พนักงาน ที่อยู่ในเมือง London 
SELECT TitleOfCourtesy, FirstName, LastName
FROM Employees
WHERE City = 'London';
--2.ข้อมูล รหัสสินค้า ชื่อสินค้า ราคา จำนวน ของสินค้าที่มีจำนวนน้อยกว่า 30
SELECT ProductID, ProductName, UnitPrice, UnitsInStock
FROM Products
WHERE UnitsInStock < 30;

--3.รหัสลูกค้า ชื่อบริษัท เบอร์โทรศัพท์ ของลูกค้าที่อยู่ในประเทศต่อไปนี้ 
--    Sweden, Germany, France, Spain, UK
SELECT CustomerID, CompanyName, Phone
FROM Customers
WHERE Country IN ('Sweden', 'Germany', 'France', 'Spain', 'UK');
--4.ข้อมูลลูกค้าที่ไม่มีหมายเลขโทรสาร (Fax) 
SELECT *
FROM Customers
WHERE Fax IS NULL;
--5.ข้อมูลสินค้าที่มีจำนวนสินค้าต่ำกว่าจุดสั่งซื้อ และ มีจำนวนที่สั่งซื้อแล้ว 
SELECT *
FROM Products
WHERE UnitsInStock < ReorderLevel AND UnitsOnOrder > 0;
--6.ชื่อ นามสกุล พนักงานที่เข้าทำงานในปี 1992 
SELECT FirstName, LastName
FROM Employees
WHERE YEAR(HireDate) = 1992;
--7.ต้องการข้อมูลสินค้าที่มีราคาตั้งแต่ 20-70
SELECT *
FROM Products
WHERE UnitPrice BETWEEN 20 AND 70;

--8.ข้อมูลลูกค้าที่มีชื่อบริษัทขึ้นต้นด้วย S และอยู่ประเทศ Mexico
SELECT *
FROM Customers
WHERE CompanyName LIKE 'S%' AND Country = 'Mexico';

--9.ข้อมูลลูกค้าที่มีตำแหน่งของผู้ที่ประสานงานเป็น Manager
Select *
from Customers
where ContactTitle LIKE '%Manager%';

--Aggregate Functon (หรือเรียกว่า Group Fution)
--เป็น Fuction ที่คำนวณ มาจากข้อมุลหลายแถว 
Select top(5) * from Products 

Select Count (*) as จำนวนชนิด,max(UnitPrice)as ราคาสูงสุด,
min(unitprice) ราคาต่ำสุด ,Avg(unitprice) ราคาเฉลี่ย ,Sum(UnitsInStock) ราคารวมทั้งหมด
from Products

--ต้องการทราบว่าสินค้าแแต่ละหมวดหมู่(CategoryID)มีสินค้าหี่ชนิด แต่ละชนิดมีราคาเฉลี่ย มีราคาสูงสุด และต่ำสุด
Select CategoryID ,Count (*) as จำนวนชนิด,max(UnitPrice)as ราคาสูงสุด,
min(unitprice) ราคาต่ำสุด ,Avg(unitprice) ราคาเฉลี่ย 
from Products
Group BY CategoryID

-- ต้องการทราบวข้อมุลว่าในแต่ละประเทศ (Country) มีลูกค้าอยุ่กี่ราย เพิ่ม City เข้าไปด้วย
Select Country ,city, COUNT(*)
from Customers
group by Country,city
order by Country asc , COUNT(*) desc
--order by count(*) DESC (แบบมาตฐาน!!)
--order by 3 DESC

-- ต้องการทราบวข้อมุลว่าในแต่ละประเทศ (Country) แสดงเฉพาะ ที่มีจำนวนลูกค้า 10 รายขึ้นไป
Select Country ,COUNT(*) 
from Customers 
group by Country
having count(*) >=10 

--ต้องการทราบสินค้า ที่มีมูลค้าสูง (ราคาตั้งแต่ 75 ขึ้นไป) แต่ละหมวดหมู่มีจำนวนกี่ชนิด มีราคาเฉลี่ยเท่าใด 
--ให้แสดงเฉพาะสินค้าที่มีราคาสูง
select CategoryID ,count(*) จำนวนชนิด , Avg(Unitprice)ราคาเฉลี่ย
from products
where Unitprice >=75 
group by CategoryID
Having avg(UnitPrice) >200

--จากตาราง [Order Details] ให้รวบรวมว่าในแต่ละการสั่งซื้อ มียอดเงินรวมเท่าใด
Select orderID , UnitPrice , Quantity ,Discount,
		UnitPrice * Quantity as ราคาเติม ,
		UnitPrice * Quantity * Discount  as ส่วนลด ,
		(Unitprice * Quantity) - (UnitPrice * Quantity * Discount) as ราคาหักส่วนลดแล้ว,
		(Unitprice * Quantity) * (1- Discount) as หักส่วนลดส่วนย่อ
from [Order Details] 

---ต้องการเฉพาะใบสั่งซื้อที่มียอดเงินรวม มากกว่า 1000
Select orderID ,count(*) จำนวนรายการ,
		sum ((UnitPrice * Quantity * (1-Discount))) as ยอดเงินรวม
from [Order Details]
group by OrderID
having sum ((UnitPrice * Quantity * (1-Discount))) > 2000
order by 3 desc
--order by sum ((UnitPrice * Quantity * (1-Discount))) desc
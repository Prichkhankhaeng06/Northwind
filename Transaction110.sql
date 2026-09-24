--เริ่ม Transaction และสร้าง Order: เริ่มต้นโดยการใช้ฐานข้อมูล เปิด Transaction และเพิ่มข้อมูลคำสั่งซื้อลงในตาราง Orders
-- เริ่ม Transaction และสร้าง Order
USE Northwind;
BEGIN TRANSACTION;

INSERT INTO Orders
(CustomerID, EmployeeID, OrderDate, RequiredDate, Freight)
VALUES
('ALFKI', 1, GETDATE(), DATEADD(DAY, 7, GETDATE()), 50.00);

-- ดึงเลข OrderID ล่าสุดที่เพิ่งสร้าง
-- เพิ่มสินค้าชิ้นที่ 1 ใน Order (เปลี่ยนเลข 11078 เป็นเลขที่คุณได้)
INSERT INTO [Order Details]
(OrderID, ProductID, UnitPrice, Quantity, Discount)
SELECT
11078, ProductID, UnitPrice, 2, 0
FROM Products
WHERE ProductID = 1;

-- เพิ่มสินค้าชิ้นที่ 2 ใน Order (เปลี่ยนเลข 11078 เป็นเลขที่คุณได้)
INSERT INTO [Order Details]
(OrderID, ProductID, UnitPrice, Quantity, Discount)
SELECT
11078, ProductID, UnitPrice, 3, 0
FROM Products
WHERE ProductID = 2;

-- ตรวจสอบข้อมูลก่อน COMMIT (เปลี่ยนเลข 11078 เป็นเลขที่คุณได้)
SELECT * FROM Orders WHERE OrderID = 11078;
SELECT * FROM [Order Details] WHERE OrderID = 11078;

-- ยืนยันการบันทึกข้อมูลอย่างถาวร
COMMIT;

--เริ่ม Transaction ใหม่และสร้าง Order: ทดลองสร้างคำสั่งซื้อใหม่อีกครั้ง
USE Northwind;
BEGIN TRANSACTION;

INSERT INTO Orders
(CustomerID, EmployeeID, OrderDate, RequiredDate, Freight)
VALUES
('ALFKI', 1, GETDATE(), DATEADD(DAY, 7, GETDATE()), 75.00);

SELECT SCOPE_IDENTITY() AS RollbackOrderID;

-- เพิ่มสินค้า Product 1
INSERT INTO [Order Details]
(OrderID, ProductID, UnitPrice, Quantity, Discount)
SELECT
11079, ProductID, UnitPrice, 1, 0   -- ลบ < > ออกแล้วใส่ตัวเลขแทน
FROM Products
WHERE ProductID = 1;

-- เพิ่มสินค้า Product 2
INSERT INTO [Order Details]
(OrderID, ProductID, UnitPrice, Quantity, Discount)
SELECT
11079, ProductID, UnitPrice, 2, 0   -- ลบ < > ออกแล้วใส่ตัวเลขแทน
FROM Products
WHERE ProductID = 2;

SELECT * FROM Orders WHERE OrderID = 11079;
SELECT * FROM [Order Details] WHERE OrderID = 11079;

ROLLBACK;

SELECT * FROM Orders WHERE OrderID = 11079;
SELECT * FROM [Order Details] WHERE OrderID = 11079;
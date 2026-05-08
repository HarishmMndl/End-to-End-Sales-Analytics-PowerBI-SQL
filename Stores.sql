-- Adding main table 
DROP TABLE IF EXISTS stores;

CREATE TABLE stores (
    Row_ID INT PRIMARY KEY,
    Order_ID VARCHAR(15),	
    Order_Date DATE,
    Ship_Date DATE,	
    Ship_Mode VARCHAR(30),	
    Customer_ID VARCHAR(40),	
    Customer_Name VARCHAR(40),	
    Segment VARCHAR(30),
    Country VARCHAR(30),
    City VARCHAR(30),	
    State VARCHAR(30),	
    Postal_Code INT,
    Region VARCHAR(30),
    Product_ID VARCHAR(30),	
    Category VARCHAR(30),
    Sub_Category VARCHAR(30),	
    Product_Name VARCHAR(200),	
    Sales FLOAT,
    Quantity INT,	
    Discount FLOAT,	
    Profit FLOAT
);


SELECT * FROM stores;


-- STEP 0: Delete Table if Exists
DROP TABLE IF EXISTS Fact_Sales;
DROP TABLE IF EXISTS Dim_Orders;
DROP TABLE IF EXISTS Dim_Geography;
DROP TABLE IF EXISTS Dim_Product;
DROP TABLE IF EXISTS Dim_Customer;

-- 1.  CUSTOMER DIMENSION TABLE
-- ==========================================
CREATE TABLE Dim_Customer AS 
SELECT DISTINCT 
    TRIM(Customer_ID) AS Customer_ID,
    TRIM(Customer_Name) AS Customer_Name, 
    TRIM(Segment) AS Segment
FROM stores;

-- Add Primary Key
ALTER TABLE Dim_Customer ADD PRIMARY KEY (Customer_ID);



-- 2. 📦 PRODUCT DIMENSION TABLE
-- ==========================================
CREATE TABLE Dim_Product AS 
SELECT 
    TRIM(Product_ID) AS Product_ID, 
    TRIM(MAX(Category)) AS Category, 
    TRIM(MAX(Sub_Category)) AS Sub_Category, 
    TRIM(MAX(Product_Name)) AS Product_Name 
FROM stores
GROUP BY Product_ID;

-- Add Primary Key
ALTER TABLE Dim_Product ADD PRIMARY KEY (Product_ID);


-- 3. 🚚 ORDERS / LOGISTICS DIMENSION TABLE
-- ==========================================
CREATE TABLE Dim_Orders AS 
SELECT DISTINCT 
    TRIM(Order_ID) AS Order_ID, 
    Order_Date,
    Ship_Date, 
    TRIM(Ship_Mode) AS Ship_Mode, 
    TRIM(Customer_ID) AS Customer_ID
FROM stores;

-- Primary Key lagayein
ALTER TABLE Dim_Orders ADD PRIMARY KEY (Order_ID);

-- connecting customers with orders
ALTER TABLE Dim_Orders 
ADD CONSTRAINT fk_orders_customer 
FOREIGN KEY (Customer_ID) REFERENCES Dim_Customer(Customer_ID);


-- 4. 🗺️ GEOGRAPHY / STORES DIMENSION TABLe
-- ==========================================
-- Purani table ko pehle drop karein

CREATE TABLE Dim_Geography AS 
SELECT 
    Postal_Code, 
    TRIM(MAX(Country)) AS Country, 
    TRIM(MAX(City)) AS City, 
    TRIM(MAX(State)) AS State, 
    TRIM(MAX(Region)) AS Region
FROM stores
WHERE Postal_Code IS NOT NULL;
GROUP BY Postal_Code; 

-- Primary Key lagayein (Postal_Code uniquely identifies the location here)
ALTER TABLE Dim_Geography ADD PRIMARY KEY (Postal_Code);


-- 5. 💰 FACT SALES TABLE (Asli Transactions)
-- ==========================================

CREATE TABLE Fact_Sales AS 
SELECT 
    Row_ID,
    TRIM(Order_ID) AS Order_ID, 
    TRIM(Product_ID) AS Product_ID, 
    Postal_Code,
    Quantity, 
    Sales, 
    Discount, 
    Profit
FROM stores
WHERE Postal_Code IS NOT NULL; -- Null values ko filter kiya taaki relationship tight rahe

-- Primary Key lagayein
ALTER TABLE Fact_Sales ADD PRIMARY KEY (Row_ID);

-- Saari Dimension tables ke sath Foreign Keys lagayein
ALTER TABLE Fact_Sales
ADD CONSTRAINT fk_sales_orders FOREIGN KEY (Order_ID) 
REFERENCES Dim_Orders(Order_ID);

ALTER TABLE Fact_Sales 
ADD CONSTRAINT fk_sales_product FOREIGN KEY (Product_ID) 
REFERENCES Dim_Product(Product_ID);

ALTER TABLE Fact_Sales 
ADD CONSTRAINT fk_sales_geography FOREIGN KEY (Postal_Code)
REFERENCES Dim_Geography(Postal_Code);

---------------------- Analysis ---------------------------------

--- count number of rows from all the table

SELECT COUNT(*) FROM stores;  -- 9994

SELECT COUNT(*) FROM Dim_Product; -- 1862

SELECT COUNT(*) FROM Dim_Customer;  --793 

SELECT COUNT(*) FROM Dim_Orders;   -- 5009 

SELECT COUNT(*) FROM Fact_Sales;   -- 9994

select count(*) from Dim_Geography; -- 631

SELECT COUNT(DISTINCT Customer_Name) FROM stores;


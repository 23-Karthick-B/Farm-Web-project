CREATE DATABASE KISSAN2;
USE KISSAN2;

CREATE TABLE Farmers (
    Farmer_ID INT PRIMARY KEY,
    User_Name VARCHAR(100) UNIQUE NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Street VARCHAR(255),
    District VARCHAR(100),
    Pincode VARCHAR(6) NOT NULL CHECK (LENGTH(Pincode) = 6),  -- 6-digit pincode constraint
    Contact_Number VARCHAR(20) NOT NULL,
    Password VARCHAR(255) NOT NULL,
    CHECK (LENGTH(Contact_Number) >= 10)
);

-- Table: Supplier
CREATE TABLE Supplier (
    Supplier_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Contact VARCHAR(20) NOT NULL,
    District VARCHAR(100) NOT NULL,
    Pincode VARCHAR(6) NOT NULL CHECK (LENGTH(Pincode) = 6),  -- 6-digit pincode constraint
    CHECK (LENGTH(Contact) >= 10)
);

-- Table: Fertilizers
CREATE TABLE Fertilizers (
    Fertilizer_ID INT PRIMARY KEY,
    Fertilizer_Name VARCHAR(100) NOT NULL,
    Availability INT NOT NULL CHECK (Availability >= 0),
    Supplier_ID INT NOT NULL,
    Unit_Price DECIMAL(10,2) NOT NULL CHECK (Unit_Price >= 0),
    FOREIGN KEY (Supplier_ID) REFERENCES Supplier(Supplier_ID) ON DELETE CASCADE
);

-- Table: Seeds
CREATE TABLE Seeds (
    Seed_ID INT PRIMARY KEY,
    Supplier_ID INT NOT NULL,
    Seed_Name VARCHAR(100) NOT NULL,
    Availability INT NOT NULL CHECK (Availability >= 0),
    Price DECIMAL(10,2) NOT NULL CHECK (Price >= 0),
    FOREIGN KEY (Supplier_ID) REFERENCES Supplier(Supplier_ID) ON DELETE CASCADE
);

-- Table: Products
CREATE TABLE Products (
    Product_ID INT PRIMARY KEY,
    Product_Type VARCHAR(100) NOT NULL,
    Product_Name VARCHAR(100) UNIQUE NOT NULL
);

-- Table: Available_Products
CREATE TABLE Available_Products (
    Farmer_ID INT NOT NULL,
    Product_ID INT NOT NULL,
     Product_Name VARCHAR(100),
    Quantity INT NOT NULL CHECK (Quantity >= 0),
    Price DECIMAL(10,2) NOT NULL CHECK (Price >= 0),
    FOREIGN KEY (Farmer_ID) REFERENCES Farmers(Farmer_ID) ON DELETE CASCADE,
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID) ON DELETE CASCADE,
    PRIMARY KEY (Farmer_ID, Product_ID)
);

-- Table: Sold_Products
CREATE TABLE Sold_Products (
    Farmer_ID INT NOT NULL,
    Product_ID INT NOT NULL,
     Product_Name VARCHAR(100),
    Quantity_Sold INT NOT NULL CHECK (Quantity_Sold >= 0),
    Price DECIMAL(10,2) NOT NULL CHECK (Price >= 0),
    Purchase_Date DATE NOT NULL,
    FOREIGN KEY (Farmer_ID) REFERENCES Farmers(Farmer_ID) ON DELETE CASCADE,
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID) ON DELETE CASCADE
);

-- Table: Consumers
CREATE TABLE Consumers (
    Consumer_ID INT PRIMARY KEY,
    User_Name VARCHAR(100) UNIQUE NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Street VARCHAR(100),
    District VARCHAR(100),
    Pincode VARCHAR(6) NOT NULL CHECK (LENGTH(Pincode) = 6),  -- 6-digit pincode constraint
    Contact_Number VARCHAR(20) NOT NULL,
    Password VARCHAR(255) NOT NULL,
    CHECK (LENGTH(Contact_Number) >= 10)
);

-- Table: Farmer_Cart
CREATE TABLE Farmer_Cart(
    Farmer_ID INT NOT NULL,
    Fertilizer_ID INT NOT NULL,
    Fertilizer_Bought INT NOT NULL CHECK (Fertilizer_Bought >= 0),
    Seed_ID INT NOT NULL,
    Seed_Bought INT NOT NULL CHECK (Seed_Bought >= 0),
    FOREIGN KEY (Farmer_ID) REFERENCES Farmers(Farmer_ID) ON DELETE CASCADE,
    FOREIGN KEY (Fertilizer_ID) REFERENCES Fertilizers(Fertilizer_ID) ON DELETE CASCADE,
    FOREIGN KEY (Seed_ID) REFERENCES Seeds(Seed_ID) ON DELETE CASCADE,
    PRIMARY KEY (Farmer_ID, Fertilizer_ID, Seed_ID)
);

-- Table: Consumer_Cart
CREATE TABLE Consumer_Cart(
    Consumer_ID INT NOT NULL,
    Farmer_ID INT NOT NULL,
    
     Product_Name VARCHAR(100),
    Quantity_Bought INT NOT NULL CHECK (Quantity_Bought >= 0),
    Price DECIMAL(10,2) NOT NULL CHECK (Price >= 0),
    Purchase_Date DATE NOT NULL,
    FOREIGN KEY (Consumer_ID) REFERENCES Consumers(Consumer_ID) ON DELETE CASCADE,
    FOREIGN KEY (Farmer_ID) REFERENCES Farmers(Farmer_ID) ON DELETE CASCADE,
    
    PRIMARY KEY (Consumer_ID, Farmer_ID, Purchase_Date)
);

INSERT INTO Farmers (Farmer_ID, User_Name, Name, Street, District, Pincode, Contact_Number, Password) VALUES
(1, 'John_1', 'John Doe', 'Anna Nagar', 'Chennai', 600001, '9123456789', 'Pass@123'),
(2, 'Raj_2', 'Raj Patel', 'Gandhi Market', 'Trichy', 620001, '9234567890', 'Farm#456'),
(3, 'Priya_3', 'Priya Sharma', 'VOC Main', 'Coimbatore', 641001, '9345678901', 'Grow$123'),
(4, 'Amit_4', 'Amit Kumar', 'Madurai Bypass', 'Madurai', 625001, '9456789012', 'Crop#456'),
(5, 'Nisha_5', 'Nisha Verma', 'Salem Main', 'Salem', 636001, '9567890123', 'Soil@789'),
(6, 'Suresh_6', 'Suresh Reddy', 'Nehru Street', 'Erode', 638001, '9678901234', 'Land@123'),
(7, 'Rita_7', 'Rita Singh', 'Kamaraj Salai', 'Thoothukudi', 628001, '9789012345', 'Farm!2025'),
(8, 'Rahul_8', 'Rahul Mehta', 'Avinashi Street', 'Tiruppur', 641602, '9890123456', 'Gr0w@L1fe'),
(9, 'Anita_9', 'Anita Joshi', 'Palayamkottai', 'Tirunelveli', 627002, '9012345678', 'Plant$789'),
(10, 'Vikas_10', 'Vikas Yadav', 'North Car', 'Kanyakumari', 629001, '9123456790', 'Tree#456'),
(11, 'Kiran_11', 'Kiran Nair', 'MGR Street', 'Dindigul', 624001, '9234567801', 'Crop@123'),
(12, 'Sunita_12', 'Sunita Rao', 'Ponneri High', 'Thiruvallur', 602001, '9345678912', 'Grow#789'),
(13, 'Manoj_13', 'Manoj Gupta', 'Vellore Fort', 'Vellore', 632001, '9456789023', 'Fert#456'),
(14, 'Ramesh_14', 'Ramesh Shah', 'Perundurai', 'Namakkal', 637001, '9567890134', 'Seed$999'),
(15, 'Neha_15', 'Neha Kapoor', 'Periyakulam', 'Theni', 625531, '9678901245', 'Land#456'),
(16, 'Pooja_16', 'Pooja Singh', 'Periyar Street', 'Karur', 639001, '9789012356', 'Gr0w@567'),
(17, 'Ajay_17', 'Ajay Thakur', 'Ambur Main', 'Tirupattur', 635601, '9890123467', 'Farm!999'),
(18, 'Vivek_18', 'Vivek Jain', 'Grand Southern Trunk', 'Chengalpattu', 603001, '9012345689', 'Crop@999'),
(19, 'Meera_19', 'Meera Pandey', 'Villupuram', 'Viluppuram', 605001, '9123456701', 'Tree#888'),
(20, 'Kartik_20', 'Kartik Iyer', 'Nagapattinam Main', 'Nagapattinam', 611001, '9234567812', 'Plant#456'),
(21, 'Swati_21', 'Swati Mishra', 'Velankanni', 'Thiruvarur', 610001, '9345678923', 'Fert!789'),
(22, 'Dinesh_22', 'Dinesh Nair', 'Pudukottai', 'Pudukottai', 622001, '9456789034', 'Soil@123'),
(23, 'Priyanka_23', 'Priyanka Yadav', 'Kumbakonam Main', 'Thanjavur', 613001, '9567890145', 'Grow#456'),
(24, 'Sanjay_24', 'Sanjay Singh', 'Melur', 'Sivaganga', 630001, '9678901256', 'Crop!789'),
(25, 'Asha_25', 'Asha Menon', 'Manapparai', 'Ariyalur', 621001, '9789012367', 'Soil#234'),
(26, 'Gopal_26', 'Gopal Reddy', 'Kollidam', 'Cuddalore', 607001, '9890123478', 'Tree@456'),
(27, 'Lakshmi_27', 'Lakshmi Iyer', 'Krishnagiri', 'Krishnagiri', 635001, '9012345690', 'Seed!789'),
(28, 'Prakash_28', 'Prakash Verma', 'Dharmapuri Main', 'Dharmapuri', 636701, '9123456711', 'Plant@567'),
(29, 'Rekha_29', 'Rekha Das', 'Singanallur', 'Coimbatore', 641005, '9234567822', 'Crop$456'),
(30, 'Ravi_30', 'Ravi Shankar', 'Red Hills', 'Chennai', 600052, '9345678933', 'Soil@999');

INSERT INTO Supplier (Supplier_ID, Name, Contact, District, Pincode) VALUES
(1, 'AgriCare', '9012345678', 'Chennai', 600001),
(2, 'GreenGrow', '9123456789', 'Coimbatore', 641001),
(3, 'AgroFarm', '9234567890', 'Madurai', 625002),
(4, 'FarmFresh', '9345678901', 'Salem', 636001),
(5, 'CropTech', '9456789012', 'Trichy', 620001),
(6, 'AgroWorld', '9567890123', 'Erode', 638001),
(7, 'GrowPlus', '9678901234', 'Vellore', 632001),
(8, 'HarvestHub', '9789012345', 'Dindigul', 624001),
(9, 'NatureFarm', '9890123456', 'Thanjavur', 613001),
(10, 'SeedPro', '9901234567', 'Chennai', 600002),
(11, 'BioFarm', '9912345678', 'Coimbatore', 641002),
(12, 'AgriLand', '9923456789', 'Madurai', 625003),
(13, 'CropMasters', '9934567890', 'Salem', 636002),
(14, 'FarmEase', '9945678901', 'Trichy', 620002),
(15, 'AgriLink', '9956789012', 'Erode', 638002),
(16, 'AgroSolutions', '9967890123', 'Vellore', 632002),
(17, 'HarvestPoint', '9978901234', 'Dindigul', 624002),
(18, 'FarmerFirst', '9989012345', 'Thanjavur', 613002),
(19, 'AgroBazaar', '9990123456', 'Chennai', 600003),
(20, 'CropSafe', '9001234567', 'Coimbatore', 641003),
(21, 'FertileLand', '9012345678', 'Madurai', 625004),
(22, 'GreenHarvest', '9023456789', 'Salem', 636003),
(23, 'AgriSolutions', '9034567890', 'Trichy', 620003),
(24, 'CropKing', '9045678901', 'Erode', 638003),
(25, 'FarmDirect', '9056789012', 'Vellore', 632003),
(26, 'AgroSupply', '9067890123', 'Dindigul', 624003),
(27, 'HarvestLink', '9078901234', 'Thanjavur', 613003),
(28, 'FarmElite', '9089012345', 'Chennai', 600004),
(29, 'SeedWorld', '9090123456', 'Coimbatore', 641004),
(30, 'AgroMarket', '9101234567', 'Madurai', 625005);

INSERT INTO Fertilizers (Fertilizer_ID, Fertilizer_Name, Availability, Supplier_ID, Unit_Price) VALUES
(1, 'Urea', 500, 1, 45.50),
(2, 'DAP', 300, 2, 60.00),
(3, 'NPK', 400, 3, 55.75),
(4, 'Potash', 350, 4, 47.20),
(5, 'Zinc Sulfate', 200, 5, 75.00),
(6, 'Magnesium Sulfate', 250, 6, 65.00),
(7, 'Ammonium Nitrate', 600, 7, 52.30),
(8, 'Calcium Nitrate', 450, 8, 68.40),
(9, 'Super Phosphate', 500, 9, 49.90),
(10, 'Sulfur Fertilizer', 300, 10, 55.60),
(11, 'NitroPhos', 420, 11, 58.75),
(12, 'Muriate of Potash', 380, 12, 62.00),
(13, 'Bio-Fertilizer', 270, 13, 70.50),
(14, 'Compost', 700, 14, 25.00),
(15, 'Vermicompost', 800, 15, 35.00),
(16, 'Liquid Fertilizer', 600, 16, 90.00),
(17, 'Organic Manure', 1000, 17, 20.00),
(18, 'Seaweed Extract', 450, 18, 85.00),
(19, 'Rock Phosphate', 300, 19, 42.00),
(20, 'Neem Cake Fertilizer', 500, 20, 50.00),
(21, 'Bone Meal', 400, 21, 40.00),
(22, 'Gypsum', 350, 22, 38.50),
(23, 'Fish Emulsion', 450, 23, 55.00),
(24, 'Blood Meal', 300, 24, 60.00),
(25, 'Green Manure', 700, 25, 28.00),
(26, 'Potassium Sulfate', 420, 26, 67.50),
(27, 'Slow Release Fertilizer', 380, 27, 75.00),
(28, 'Humic Acid', 250, 28, 95.00),
(29, 'Fulvic Acid', 200, 29, 110.00),
(30, 'Microbial Fertilizer', 300, 30, 65.00);

INSERT INTO Seeds (Seed_ID, Supplier_ID, Seed_Name, Availability, Price) VALUES
(1, 1, 'Paddy', 1000, 20.00),
(2, 2, 'Wheat', 800, 18.50),
(3, 3, 'Corn', 600, 22.75),
(4, 4, 'Millet', 700, 19.00),
(5, 5, 'Barley', 500, 21.50),
(6, 6, 'Sorghum', 750, 23.00),
(7, 7, 'Oats', 900, 25.00),
(8, 8, 'Green Gram', 850, 30.00),
(9, 9, 'Black Gram', 650, 27.00),
(10, 10, 'Chickpea', 700, 28.50),
(11, 11, 'Groundnut', 600, 35.00),
(12, 12, 'Soybean', 550, 32.00),
(13, 13, 'Cotton', 500, 40.00),
(14, 14, 'Sunflower', 400, 38.50),
(15, 15, 'Mustard', 750, 34.00),
(16, 16, 'Peas', 800, 29.00),
(17, 17, 'Lentils', 680, 26.50),
(18, 18, 'Red Gram', 570, 31.00),
(19, 19, 'Coriander', 900, 24.50),
(20, 20, 'Fenugreek', 1000, 20.00),
(21, 21, 'Tomato', 650, 15.00),
(22, 22, 'Brinjal', 720, 17.50),
(23, 23, 'Chilli', 500, 45.00),
(24, 24, 'Capsicum', 480, 42.00),
(25, 25, 'Pumpkin', 550, 18.00),
(26, 26, 'Cucumber', 600, 19.50),
(27, 27, 'Watermelon', 750, 22.00),
(28, 28, 'Muskmelon', 700, 21.00),
(29, 29, 'Carrot', 620, 14.00),
(30, 30, 'Beetroot', 580, 16.50);

-- Insert 40 rows into Products table (without Dairy)
INSERT INTO Products (Product_ID, Product_Type, Product_Name) VALUES
(1, 'Grain', 'Wheat'),
(2, 'Vegetable', 'Tomato'),
(3, 'Fruit', 'Apple'),
(4, 'Grain', 'Rice'),
(5, 'Spice', 'Turmeric'),
(6, 'Vegetable', 'Carrot'),
(7, 'Fruit', 'Orange'),
(8, 'Fruit', 'Banana'),
(9, 'Grain', 'Corn'),
(10, 'Spice', 'Cinnamon'),
(11, 'Vegetable', 'Onion'),
(12, 'Fruit', 'Mango'),
(13, 'Grain', 'Barley'),
(14, 'Vegetable', 'Spinach'),
(15, 'Spice', 'Clove'),
(16, 'Fruit', 'Pomegranate'),
(17, 'Vegetable', 'Broccoli'),
(18, 'Grain', 'Oats'),
(19, 'Vegetable', 'Pumpkin'),
(20, 'Vegetable', 'Potato'),
(21, 'Spice', 'Coriander'),
(22, 'Fruit', 'Watermelon'),
(23, 'Spice', 'Cardamom'),
(24, 'Fruit', 'Guava'),
(25, 'Fruit', 'Strawberry'),
(26, 'Grain', 'Millet'),
(27, 'Fruit', 'Pineapple'),
(28, 'Spice', 'Pepper'),
(29, 'Fruit', 'Grapes'),
(30, 'Spice', 'Saffron'),
(31, 'Grain', 'Sorghum'),
(32, 'Fruit', 'Papaya'),
(33, 'Spice', 'Ginger'),
(34, 'Fruit', 'Blueberry');

INSERT INTO Available_Products (Farmer_ID, Product_ID, Product_Name, Quantity, Price) VALUES
-- Single Products
(1, 1, 'Wheat', 250, 35.00),
(2, 2, 'Tomato', 300, 40.50),
(3, 3, 'Apple', 200, 25.75),               -- ✅ Correct Farmer_ID for Apple
(4, 4, 'Rice', 150, 30.00),
(5, 5, 'Turmeric', 500, 12.25),
(6, 6, 'Carrot', 400, 18.75),
(7, 7, 'Mint', 350, 20.50),
(8, 8, 'Banana', 600, 15.90),
(9, 9, 'Corn', 450, 22.00),
(10, 10, 'Cinnamon', 300, 55.30),
(11, 11, 'Onion', 200, 33.45),
(12, 12, 'Mango', 150, 60.20),
(13, 13, 'Barley', 500, 27.35),
(14, 14, 'Spinach', 400, 10.50),
(15, 15, 'Clove', 300, 28.75),
(16, 16, 'Rosemary', 350, 18.25),
(17, 17, 'Bell Pepper', 600, 75.00),
(18, 18, 'Pomegranate', 400, 90.50),
(19, 19, 'Buckwheat', 450, 30.20),
(20, 20, 'Broccoli', 350, 110.00),
(21, 21, 'Oats', 250, 60.45),
(22, 22, 'Pumpkin', 200, 40.75),
(23, 23, 'Oregano', 300, 35.00),
(24, 24, 'Nutmeg', 450, 55.00),
(25, 25, 'Rye', 700, 25.50),

-- Farmers with multiple products (correct mapping)
(3, 26, 'Potato', 200, 15.80),             -- ✅ Farmer 3 (Apple + Potato)
(7, 27, 'Coriander', 300, 20.25),          -- ✅ Farmer 7 (Mint + Coriander)
(9, 28, 'Watermelon', 250, 18.00),         -- ✅ Farmer 9 (Corn + Watermelon)
(12, 29, 'Cardamom', 200, 22.75),          -- ✅ Farmer 12 (Mango + Cardamom)
(15, 30, 'Guava', 350, 26.40),              -- ✅ Farmer 15 (Clove + Guava)
(18, 31, 'Quinoa', 250, 30.50),             -- ✅ Farmer 18 (Pomegranate + Quinoa)
(2, 32, 'Parsley', 300, 20.00),             -- ✅ Farmer 2 (Tomato + Parsley)
(4, 33, 'Strawberry', 200, 18.50),          -- ✅ Farmer 4 (Rice + Strawberry)
(6, 34, 'Millet', 250, 15.75),              -- ✅ Farmer 6 (Carrot + Millet)
(11, 35, 'Basil', 300, 25.00),              -- ✅ Farmer 11 (Onion + Basil)
(13, 36, 'Pineapple', 350, 35.75),          -- ✅ Farmer 13 (Barley + Pineapple)
(16, 37, 'Pepper', 200, 40.00),             -- ✅ Farmer 16 (Rosemary + Pepper)
(20, 38, 'Grapes', 300, 50.00),             -- ✅ Farmer 20 (Broccoli + Grapes)
(8, 39, 'Saffron', 150, 70.00),             -- ✅ Farmer 8 (Banana + Saffron)
(5, 40, 'Sorghum', 400, 32.00),             -- ✅ Farmer 5 (Turmeric + Sorghum)
(10, 41, 'Thyme', 300, 18.00),              -- ✅ Farmer 10 (Cinnamon + Thyme)
(14, 42, 'Papaya', 200, 28.00),             -- ✅ Farmer 14 (Spinach + Papaya)
(19, 43, 'Ginger', 250, 35.00),             -- ✅ Farmer 19 (Buckwheat + Ginger)
(22, 44, 'Foxtail Millet', 300, 22.50),     -- ✅ Farmer 22 (Pumpkin + Foxtail Millet)
(25, 45, 'Blueberry', 400, 55.00);          -- ✅ Farmer 25 (Rye + Blueberry)

INSERT INTO Sold_Products (Farmer_ID, Product_ID, Product_Name, Quantity_Sold, Price, Purchase_Date) VALUES
-- Single Product Sales (Randomized Product_IDs)
(1, 18, 'Wheat', 100, 35.00, '2025-01-10'),
(2, 22, 'Tomato', 150, 40.50, '2025-01-12'),
(3, 5, 'Apple', 120, 25.75, '2025-01-15'),               -- ✅ Correct Farmer_ID for Apple
(4, 11, 'Rice', 90, 30.00, '2025-01-18'),
(5, 27, 'Turmeric', 200, 12.25, '2025-01-20'),
(6, 30, 'Carrot', 300, 18.75, '2025-01-22'),
(7, 16, 'Mint', 250, 20.50, '2025-01-25'),
(8, 10, 'Banana', 400, 15.90, '2025-01-28'),
(9, 24, 'Corn', 350, 22.00, '2025-01-30'),
(10, 3, 'Cinnamon', 200, 55.30, '2025-02-02'),
(11, 19, 'Onion', 150, 33.45, '2025-02-05'),
(12, 7, 'Mango', 100, 60.20, '2025-02-08'),
(13, 21, 'Barley', 400, 27.35, '2025-02-10'),
(14, 9, 'Spinach', 300, 10.50, '2025-02-12'),
(15, 2, 'Clove', 200, 28.75, '2025-02-15'),
(16, 25, 'Rosemary', 250, 18.25, '2025-02-18'),
(17, 13, 'Bell Pepper', 500, 75.00, '2025-02-20'),
(18, 6, 'Pomegranate', 300, 90.50, '2025-02-22'),
(19, 28, 'Buckwheat', 400, 30.20, '2025-02-25'),
(20, 12, 'Broccoli', 300, 110.00, '2025-02-28'),
(21, 26, 'Oats', 200, 60.45, '2025-03-02'),
(22, 1, 'Pumpkin', 150, 40.75, '2025-03-05'),
(23, 14, 'Oregano', 250, 35.00, '2025-03-08'),
(24, 29, 'Nutmeg', 400, 55.00, '2025-03-10'),
(25, 20, 'Rye', 600, 25.50, '2025-03-12'),

-- Farmers with Multiple Products (Randomized Product_IDs)
(3, 4, 'Potato', 150, 15.80, '2025-03-15'),               -- ✅ Farmer 3 (Apple + Potato)
(7, 23, 'Coriander', 200, 20.25, '2025-03-18'),           -- ✅ Farmer 7 (Mint + Coriander)
(9, 15, 'Watermelon', 150, 18.00, '2025-03-20'),          -- ✅ Farmer 9 (Corn + Watermelon)
(12, 8, 'Cardamom', 100, 22.75, '2025-03-22'),            -- ✅ Farmer 12 (Mango + Cardamom)
(15, 17, 'Guava', 250, 26.40, '2025-03-25');              -- ✅ Farmer 15 (Clove + Guava)


INSERT INTO Consumers (Consumer_ID, User_Name, Name, Street, District, Pincode, Contact_Number, Password) VALUES
(1, 'Rohan_1', 'Rohan Sharma', 'Anna Nagar', 'Chennai', 600001, '8123456789', 'Buy@123'),
(2, 'Sneha_2', 'Sneha Patel', 'Gandhi Market', 'Trichy', 620001, '8223456789', 'Cart#456'),
(3, 'Kunal_3', 'Kunal Verma', 'VOC Street', 'Coimbatore', 641001, '8323456789', 'Deal$789'),
(4, 'Ananya_4', 'Ananya Das', 'Nehru Nagar', 'Madurai', 625001, '8423456789', 'Shop@567'),
(5, 'Rahul_5', 'Rahul Iyer', 'Salem Main', 'Salem', 636001, '8523456789', 'Buy#999'),
(6, 'Meera_6', 'Meera Menon', 'Avinashi Street', 'Tiruppur', 641602, '8623456789', 'Cart!456'),
(7, 'Varun_7', 'Varun Jain', 'Red Hills', 'Chennai', 600052, '8723456789', 'Deal@123'),
(8, 'Divya_8', 'Divya Kapoor', 'Palayamkottai', 'Tirunelveli', 627002, '8823456789', 'Shop$789'),
(9, 'Nikhil_9', 'Nikhil Thakur', 'Kamaraj Salai', 'Thoothukudi', 628001, '8923456789', 'Buy@456'),
(10, 'Pooja_10', 'Pooja Yadav', 'North Car', 'Kanyakumari', 629001, '9023456789', 'Cart!789'),
(11, 'Amit_11', 'Amit Joshi', 'MGR Street', 'Dindigul', 624001, '8124567890', 'Deal@999'),
(12, 'Simran_12', 'Simran Mehta', 'Ponneri High', 'Thiruvallur', 602001, '8224567890', 'Shop#456'),
(13, 'Yash_13', 'Yash Kumar', 'Vellore Fort', 'Vellore', 632001, '8324567890', 'Buy$999'),
(14, 'Kiran_14', 'Kiran Singh', 'Perundurai', 'Erode', 638001, '8424567890', 'Cart@567'),
(15, 'Sanjay_15', 'Sanjay Nair', 'Melur', 'Sivaganga', 630001, '8524567890', 'Deal#888'),
(16, 'Priya_16', 'Priya Rao', 'Periyakulam', 'Theni', 625531, '8624567890', 'Shop!999'),
(17, 'Manoj_17', 'Manoj Gupta', 'Grand Southern Trunk', 'Chengalpattu', 603001, '8724567890', 'Buy@789'),
(18, 'Ankita_18', 'Ankita Shah', 'Villupuram', 'Viluppuram', 605001, '8824567890', 'Cart#567'),
(19, 'Vivek_19', 'Vivek Thakur', 'Nagapattinam Main', 'Nagapattinam', 611001, '8924567890', 'Deal!123'),
(20, 'Reena_20', 'Reena Pandey', 'Velankanni', 'Thiruvarur', 610001, '9024567890', 'Shop#888'),
(21, 'Deepak_21', 'Deepak Verma', 'Pudukottai', 'Pudukottai', 622001, '8125678901', 'Buy$456'),
(22, 'Asha_22', 'Asha Kapoor', 'Kumbakonam Main', 'Thanjavur', 613001, '8225678901', 'Cart@123'),
(23, 'Ravi_23', 'Ravi Mehta', 'Periyar Street', 'Karur', 639001, '8325678901', 'Deal!789'),
(24, 'Neha_24', 'Neha Jain', 'Manapparai', 'Ariyalur', 621001, '8425678901', 'Shop#567'),
(25, 'Gopal_25', 'Gopal Yadav', 'Kollidam', 'Cuddalore', 607001, '8525678901', 'Buy@999'),
(26, 'Lata_26', 'Lata Nair', 'Krishnagiri', 'Krishnagiri', 635001, '8625678901', 'Cart!888'),
(27, 'Sunil_27', 'Sunil Sharma', 'Dharmapuri Main', 'Dharmapuri', 636701, '8725678901', 'Deal@456'),
(28, 'Meena_28', 'Meena Rao', 'Singanallur', 'Coimbatore', 641005, '8825678901', 'Shop!123'),
(29, 'Dilip_29', 'Dilip Menon', 'Red Hills', 'Chennai', 600052, '8925678901', 'Buy#888'),
(30, 'Rita_30', 'Rita Patel', 'Anna Salai', 'Chennai', 600002, '9025678901', 'Cart!567'),
(31, 'Anil_31', 'Anil Kumar', 'Sathyamangalam', 'Erode', 638401, '8126789012', 'Deal@789'),
(32, 'Shweta_32', 'Shweta Singh', 'Perambur', 'Chennai', 600011, '8226789012', 'Shop#456'),
(33, 'Ashok_33', 'Ashok Yadav', 'Tiruchengode', 'Namakkal', 637211, '8326789012', 'Buy!999'),
(34, 'Rekha_34', 'Rekha Thakur', 'Karaikudi', 'Sivaganga', 630001, '8426789012', 'Cart@888'),
(35, 'Kiran_35', 'Kiran Iyer', 'Rajapalayam', 'Virudhunagar', 626117, '8526789012', 'Deal#123'),
(36, 'Arjun_36', 'Arjun Mehta', 'Neyveli', 'Cuddalore', 607801, '8626789012', 'Shop!456'),
(37, 'Lalita_37', 'Lalita Menon', 'Pollachi', 'Coimbatore', 642001, '8726789012', 'Buy@567'),
(38, 'Vishal_38', 'Vishal Shah', 'Hosur', 'Krishnagiri', 635109, '8826789012', 'Cart#789'),
(39, 'Preeti_39', 'Preeti Rao', 'Chidambaram', 'Cuddalore', 608001, '8926789012', 'Deal@456'),
(40, 'Kamal_40', 'Kamal Verma', 'Ambur', 'Tirupattur', 635802, '9026789012', 'Shop!999'),
(41, 'Naveen_41', 'Naveen Kapoor', 'Vaniyambadi', 'Tirupattur', 635751, '8127890123', 'Buy#567'),
(42, 'Komal_42', 'Komal Nair', 'Nanguneri', 'Tirunelveli', 627108, '8227890123', 'Cart@123'),
(43, 'Ramesh_43', 'Ramesh Yadav', 'Mayiladuthurai', 'Nagapattinam', 609001, '8327890123', 'Deal!456'),
(44, 'Alok_44', 'Alok Thakur', 'Thirukoilur', 'Viluppuram', 605757, '8427890123', 'Shop#789'),
(45, 'Bhavna_45', 'Bhavna Shah', 'Palladam', 'Tiruppur', 641664, '8527890123', 'Buy@888');


-- Insert 55 rows into Consumer_Cart table
INSERT INTO Consumer_Cart (Consumer_ID, Farmer_ID, Product_Name, Quantity_Bought, Price, Purchase_Date) VALUES
-- Consumers buying products from different farmers
(1, 1, 'Wheat', 20, 35, '2025-01-10'),              -- Consumer 1 buys Wheat from Farmer 1
(2, 22, 'Tomato', 50, 40, '2025-01-12'),             -- Consumer 2 buys Tomato from Farmer 22
(3, 5, 'Apple', 30, 25, '2025-01-15'),               -- Consumer 3 buys Apple from Farmer 5
(4, 11, 'Rice', 40, 30, '2025-01-18'),               -- Consumer 4 buys Rice from Farmer 11
(5, 27, 'Turmeric', 70, 12, '2025-01-20'),           -- Consumer 5 buys Turmeric from Farmer 27
(6, 30, 'Carrot', 80, 18, '2025-01-22'),             -- Consumer 6 buys Carrot from Farmer 30
(7, 16, 'Mint', 60, 20, '2025-01-25'),               -- Consumer 7 buys Mint from Farmer 16
(8, 10, 'Banana', 120, 15, '2025-01-28'),            -- Consumer 8 buys Banana from Farmer 10
(9, 24, 'Corn', 90, 22, '2025-01-30'),               -- Consumer 9 buys Corn from Farmer 24
(10, 3, 'Cinnamon', 110, 55, '2025-02-02'),          -- Consumer 10 buys Cinnamon from Farmer 3
(11, 19, 'Onion', 130, 33, '2025-02-05'),            -- Consumer 11 buys Onion from Farmer 19
(12, 7, 'Mango', 45, 60, '2025-02-08'),              -- Consumer 12 buys Mango from Farmer 7
(13, 21, 'Barley', 150, 27, '2025-02-10'),           -- Consumer 13 buys Barley from Farmer 21
(14, 9, 'Spinach', 90, 10, '2025-02-12'),            -- Consumer 14 buys Spinach from Farmer 9
(15, 2, 'Clove', 55, 28, '2025-02-15'),              -- Consumer 15 buys Clove from Farmer 2
(16, 25, 'Rosemary', 70, 18, '2025-02-18'),          -- Consumer 16 buys Rosemary from Farmer 25
(17, 13, 'Bell Pepper', 95, 75, '2025-02-20'),       -- Consumer 17 buys Bell Pepper from Farmer 13
(18, 6, 'Pomegranate', 85, 90, '2025-02-22'),        -- Consumer 18 buys Pomegranate from Farmer 6
(19, 28, 'Buckwheat', 100, 30, '2025-02-25'),        -- Consumer 19 buys Buckwheat from Farmer 28
(20, 12, 'Broccoli', 120, 110, '2025-02-28'),        -- Consumer 20 buys Broccoli from Farmer 12
(21, 26, 'Oats', 60, 60, '2025-03-02'),              -- Consumer 21 buys Oats from Farmer 26
(22, 1, 'Pumpkin', 55, 40, '2025-03-05'),            -- Consumer 22 buys Pumpkin from Farmer 1
(23, 14, 'Oregano', 80, 35, '2025-03-08'),           -- Consumer 23 buys Oregano from Farmer 14
(24, 29, 'Nutmeg', 100, 55, '2025-03-10'),           -- Consumer 24 buys Nutmeg from Farmer 29
(25, 20, 'Rye', 150, 25, '2025-03-12'),              -- Consumer 25 buys Rye from Farmer 20

-- Multiple Products Bought by the Same Consumer
(3, 4, 'Potato', 35, 15, '2025-03-15'),              -- Consumer 3 buys Potato from Farmer 4
(7, 23, 'Coriander', 40, 20, '2025-03-18'),          -- Consumer 7 buys Coriander from Farmer 23
(9, 15, 'Watermelon', 50, 18, '2025-03-20'),         -- Consumer 9 buys Watermelon from Farmer 15
(12, 8, 'Cardamom', 25, 22, '2025-03-22'),           -- Consumer 12 buys Cardamom from Farmer 8
(15, 17, 'Guava', 60, 26, '2025-03-25');             -- Consumer 15 buys Guava from Farmer 17


-- Insert 25 rows into Farmer_Cart table
INSERT INTO Farmer_Cart (Farmer_ID, Fertilizer_ID, Fertilizer_Bought, Seed_ID, Seed_Bought) VALUES
(1, 3, 15, 2, 10),
(2, 5, 20, 1, 5),
(3, 2, 12, 4, 8),
(4, 6, 18, 3, 9),
(5, 1, 10, 2, 7),
(6, 4, 14, 5, 12),
(7, 7, 22, 6, 15),
(8, 3, 11, 8, 10),
(9, 8, 25, 9, 13),
(10, 9, 19, 7, 11),
(11, 2, 16, 10, 14),
(12, 5, 21, 4, 9),
(13, 6, 23, 3, 8),
(14, 7, 13, 1, 12),
(15, 4, 17, 2, 6),
(16, 1, 9, 8, 15),
(17, 3, 14, 7, 10),
(18, 10, 26, 5, 13),
(19, 2, 18, 6, 7),
(20, 8, 20, 9, 11),
(21, 7, 12, 3, 8),
(22, 9, 24, 10, 14),
(23, 4, 19, 5, 12),
(24, 6, 15, 8, 10),
(25, 10, 27, 1, 9);

-- Last Six Months Sales for a Particular Farmer
SELECT 
    sp.Product_ID,
    p.Product_Name,
    p.Product_Type,
    SUM(sp.Quantity_Sold) AS Total_Quantity_Sold,
    SUM(sp.Quantity_Sold * sp.Price) AS Total_Revenue,
    MIN(sp.Price) AS Minimum_Price,
    MAX(sp.Price) AS Maximum_Price,
    AVG(sp.Price) AS Average_Price,
    COUNT(DISTINCT cc.Consumer_ID) AS Unique_Customers
FROM 
    Sold_Products sp
JOIN 
    Products p ON sp.Product_ID = p.Product_ID
LEFT JOIN 
    Consumer_Cart cc ON sp.Farmer_ID = cc.Farmer_ID 
                    AND sp.Product_ID = (SELECT Product_ID FROM Products WHERE Product_Name = cc.Product_Name)
                    AND sp.Purchase_Date = cc.Purchase_Date
WHERE 
    sp.Farmer_ID = 2 -- Replace with actual farmer ID
    AND sp.Purchase_Date >= DATE_SUB(CURRENT_DATE(), INTERVAL 6 MONTH)
GROUP BY 
    sp.Product_ID, p.Product_Name, p.Product_Type
ORDER BY 
    Total_Revenue DESC;
-- TOTAL PURCHASE HISTORY OF CUSTOMER     
    SELECT 
    c.Consumer_ID,
    c.Name AS Customer_Name,
    f.Farmer_ID,
    f.Name AS Farmer_Name,
    f.District AS Farmer_District,
    cc.Product_Name,
    p.Product_Type,
    SUM(cc.Quantity_Bought) AS Total_Quantity_Purchased,
    SUM(cc.Quantity_Bought * cc.Price) AS Total_Amount_Spent,
    COUNT(DISTINCT cc.Farmer_ID) AS Number_Of_Farmers_Purchased_From,
    MIN(cc.Purchase_Date) AS First_Purchase_Date,
    MAX(cc.Purchase_Date) AS Last_Purchase_Date
FROM 
    Consumer_Cart cc
JOIN 
    Consumers c ON cc.Consumer_ID = c.Consumer_ID
JOIN 
    Farmers f ON cc.Farmer_ID = f.Farmer_ID
JOIN 
    Products p ON p.Product_Name = cc.Product_Name
WHERE 
    cc.Consumer_ID = 5 -- Replace with actual consumer ID
GROUP BY 
    c.Consumer_ID, c.Name, f.Farmer_ID, f.Name, f.District, cc.Product_Name, p.Product_Type
ORDER BY 
    Total_Amount_Spent DESC;
-- TOTAL SALES IN LAST SIX MONTHS 
SELECT 
    SUM(cc.Quantity_Bought) AS Total_Items_Sold,
    SUM(cc.Quantity_Bought * cc.Price) AS Total_Revenue,
    COUNT(DISTINCT cc.Consumer_ID) AS Unique_Customers,
    COUNT(DISTINCT cc.Farmer_ID) AS Active_Farmers,
    COUNT(DISTINCT cc.Product_Name) AS Unique_Products_Sold,
    MIN(cc.Price) AS Minimum_Product_Price,
    MAX(cc.Price) AS Maximum_Product_Price,
    AVG(cc.Price) AS Average_Product_Price
FROM 
    Consumer_Cart cc
WHERE 
    cc.Purchase_Date >= DATE_SUB(CURRENT_DATE(), INTERVAL 6 MONTH);
-- Basic Monthly Sales Summary    
SELECT 
    DATE_FORMAT(cc.Purchase_Date, '%Y-%m') AS Month,
    SUM(cc.Quantity_Bought) AS Total_Items_Sold,
    SUM(cc.Quantity_Bought * cc.Price) AS Total_Revenue,
    COUNT(DISTINCT cc.Consumer_ID) AS Unique_Customers,
    COUNT(DISTINCT cc.Farmer_ID) AS Active_Farmers
FROM 
    Consumer_Cart cc
WHERE 
    DATE_FORMAT(cc.Purchase_Date, '%Y-%m') = '2023-11'  -- Replace with desired month (YYYY-MM)
GROUP BY 
    DATE_FORMAT(cc.Purchase_Date, '%Y-%m');
    
-- View all available fertilizers with supplier information
SELECT 
    f.Fertilizer_ID,
    f.Fertilizer_Name,
    f.Availability,
    f.Unit_Price,
    s.Supplier_ID,
    s.Name AS Supplier_Name,
    s.District AS Supplier_District,
    s.Contact AS Supplier_Contact
FROM 
    Fertilizers f
JOIN 
    Supplier s ON f.Supplier_ID = s.Supplier_ID
WHERE 
    f.Availability > 0
ORDER BY 
    f.Fertilizer_Name;

-- View all available seeds with supplier information
SELECT 
    s.Seed_ID,
    s.Seed_Name,
    s.Availability,
    s.Price,
    sup.Supplier_ID,
    sup.Name AS Supplier_Name,
    sup.District AS Supplier_District,
    sup.Contact AS Supplier_Contact
FROM 
    Seeds s
JOIN 
    Supplier sup ON s.Supplier_ID = sup.Supplier_ID
WHERE 
    s.Availability > 0
ORDER BY 
    s.Seed_Name;

-- Farmer Sales in Descending Order
SELECT 
    f.Farmer_ID,
    f.Name AS Farmer_Name,
    f.District,
    COUNT(DISTINCT cc.Consumer_ID) AS Total_Customers,
    COUNT(DISTINCT cc.Product_Name) AS Unique_Products_Sold,
    SUM(cc.Quantity_Bought) AS Total_Items_Sold,
    SUM(cc.Quantity_Bought * cc.Price) AS Total_Sales_Revenue,
    ROUND(AVG(cc.Price), 2) AS Average_Product_Price,
    MIN(cc.Purchase_Date) AS First_Sale_Date,
    MAX(cc.Purchase_Date) AS Most_Recent_Sale_Date
FROM 
    Consumer_Cart cc
JOIN 
    Farmers f ON cc.Farmer_ID = f.Farmer_ID
GROUP BY 
    f.Farmer_ID, f.Name, f.District
ORDER BY 
    Total_Sales_Revenue DESC;
    
SELECT 
    c.Consumer_ID,
    c.Name AS Customer_Name,
    c.District,
    COUNT(DISTINCT cc.Farmer_ID) AS Farmers_Purchased_From,
    COUNT(DISTINCT cc.Product_Name) AS Unique_Products_Bought,
    SUM(cc.Quantity_Bought) AS Total_Items_Purchased,
    SUM(cc.Quantity_Bought * cc.Price) AS Total_Spending,
    ROUND(AVG(cc.Price), 2) AS Average_Product_Price,
    MIN(cc.Purchase_Date) AS First_Purchase_Date,
    MAX(cc.Purchase_Date) AS Most_Recent_Purchase_Date
FROM 
    Consumer_Cart cc
JOIN 
    Consumers c ON cc.Consumer_ID = c.Consumer_ID
GROUP BY 
    c.Consumer_ID, c.Name, c.District
ORDER BY 
    Total_Spending DESC;
    
-- Products with low inventory (less than 20 available)
SELECT p.Product_ID, p.Product_Name, ap.Quantity AS Available_Quantity
FROM Products p
JOIN Available_Products ap ON p.Product_ID = ap.Product_ID
WHERE ap.Quantity < 20
ORDER BY ap.Quantity ASC;

-- Complete order processing transaction
START TRANSACTION;

-- 1. Add to consumer cart
INSERT INTO Consumer_Cart (Consumer_ID, Farmer_ID, Product_Name, Quantity_Bought, Price, Purchase_Date)
VALUES (101, 5, 'Tomato', 10, 45.00, CURDATE());

-- 2. Update available products
UPDATE Available_Products 
SET Quantity = Quantity - 10
WHERE Farmer_ID = 5 AND Product_Name = 'Tomato';

-- 3. Record in sold products
INSERT INTO Sold_Products (Farmer_ID, Product_ID, Product_Name, Quantity_Sold, Price, Purchase_Date)
SELECT 5, p.Product_ID, 'Tomato', 10, 45.00, CURDATE()
FROM Products p
WHERE p.Product_Name = 'Tomato';

COMMIT;
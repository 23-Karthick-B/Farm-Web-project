CREATE DATABASE FINAL_DATABASE12;
USE  FINAL_DATABASE12;

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

INSERT INTO farmers VALUES (31, 'Arun_31', 'Arun Kumar', 'Udayarpalayam', 'Ariyalur', 621801, '9123456780', 'Rice@123');
INSERT INTO farmers VALUES (32, 'Bala_32', 'Bala Subramanian', 'Sendurai', 'Ariyalur', 621804, '9234567891', 'Wheat#456');
INSERT INTO farmers VALUES (33, 'Chitra_33', 'Chitra Devi', 'Jayankondam', 'Ariyalur', 621802, '9345678902', 'Cotton$789');
INSERT INTO farmers VALUES (34, 'Durai_34', 'Durai Rajan', 'Tirumanur', 'Ariyalur', 621803, '9456789013', 'Sugarcan@1');
INSERT INTO farmers VALUES (35, 'Eswari_35', 'Eswari Ammal', 'Varadarajanpettai', 'Ariyalur', 621805, '9567890124', 'Pulse#2023');

-- Chengalpattu District Farmers (excluding Vivek_18)
INSERT INTO farmers VALUES (36, 'Farook_36', 'Farook Khan', 'Madurantakam', 'Chengalpattu', 603306, '9678901235', 'Farm@1234');
INSERT INTO farmers VALUES (37, 'Geetha_37', 'Geetha Rani', 'Cheyyur', 'Chengalpattu', 603302, '9789012346', 'Grow$5678');
INSERT INTO farmers VALUES (38, 'Harish_38', 'Harish Kumar', 'Tirukalukundram', 'Chengalpattu', 603109, '9890123457', 'Crop!9012');
INSERT INTO farmers VALUES (39, 'Indira_39', 'Indira Gandhi', 'Potheri', 'Chengalpattu', 603203, '9012345679', 'Soil#3456');
INSERT INTO farmers VALUES (40, 'Jagan_40', 'Jagan Mohan', 'Kelambakkam', 'Chengalpattu', 603103, '9123456781', 'Plant@7890');

-- Chennai District Farmers (excluding John_1 and Ravi_30)
INSERT INTO farmers VALUES (41, 'Kumar_41', 'Kumaravel', 'T Nagar', 'Chennai', 600017, '9234567892', 'FarmChen@1');
INSERT INTO farmers VALUES (42, 'Latha_42', 'Latha Priya', 'Adyar', 'Chennai', 600020, '9345678903', 'GrowMadra$');
INSERT INTO farmers VALUES (43, 'Mohan_43', 'Mohan Das', 'Ambattur', 'Chennai', 600053, '9456789014', 'Crop!6000');
INSERT INTO farmers VALUES (44, 'Nandini_44', 'Nandini Devi', 'Porur', 'Chennai', 600116, '9567890125', 'SoilPor#1');
INSERT INTO farmers VALUES (45, 'Omkar_45', 'Omkar Sundar', 'Pallavaram', 'Chennai', 600043, '9678901236', 'PlantPall@');

-- Coimbatore District Farmers (excluding Priya_3 and Rekha_29)
INSERT INTO farmers VALUES (46, 'Padmini_46', 'Padmini Iyer', 'Saravanampatti', 'Coimbatore', 641035, '9789012347', 'Saravana$1');
INSERT INTO farmers VALUES (47, 'Qadir_47', 'Qadir Basha', 'Peelamedu', 'Coimbatore', 641004, '9890123458', 'Peela#123');
INSERT INTO farmers VALUES (48, 'Radha_48', 'Radha Krishnan', 'Gandhipuram', 'Coimbatore', 641012, '9012345680', 'Gandhi@45');
INSERT INTO farmers VALUES (49, 'Sathish_49', 'Sathish Kumar', 'Sitra', 'Coimbatore', 641047, '9123456782', 'SitraFarm$');
INSERT INTO farmers VALUES (50, 'Thara_50', 'Thara Mohan', 'Kovaipudur', 'Coimbatore', 641042, '9234567893', 'Kovai#789');

-- Cuddalore District Farmers (excluding Gopal_26)
INSERT INTO farmers VALUES (51, 'Uday_51', 'Uday Shankar', 'Chidambaram', 'Cuddalore', 608001, '9345678904', 'Chidam@123');
INSERT INTO farmers VALUES (52, 'Vasantha_52', 'Vasantha Kumari', 'Panruti', 'Cuddalore', 607106, '9456789015', 'Panruti#1');
INSERT INTO farmers VALUES (53, 'Wilson_53', 'Wilson Raj', 'Neyveli', 'Cuddalore', 607801, '9567890126', 'Neyveli@2');
INSERT INTO farmers VALUES (54, 'Xavier_54', 'Xavier Fernando', 'Cuddalore OT', 'Cuddalore', 607001, '9678901237', 'CuddOT#45');
INSERT INTO farmers VALUES (55, 'Yamuna_55', 'Yamuna Devi', 'Kurinjipadi', 'Cuddalore', 607302, '9789012348', 'Kurinji$3');

-- Dharmapuri District Farmers (excluding Prakash_28)
INSERT INTO farmers VALUES (56, 'Zubair_56', 'Zubair Ahmed', 'Harur', 'Dharmapuri', 636903, '9890123459', 'HarurFarm@');
INSERT INTO farmers VALUES (57, 'Anand_57', 'Anand Babu', 'Palacode', 'Dharmapuri', 636808, '9012345681', 'Palacode#');
INSERT INTO farmers VALUES (58, 'Bhavani_58', 'Bhavani Shanmugam', 'Pappireddipatti', 'Dharmapuri', 636905, '9123456783', 'Pappi$123');
INSERT INTO farmers VALUES (59, 'Chandru_59', 'Chandrasekar', 'Nallampalli', 'Dharmapuri', 636808, '9234567894', 'Nallam#45');
INSERT INTO farmers VALUES (60, 'Divya_60', 'Divya Prakash', 'Karimangalam', 'Dharmapuri', 636803, '9345678905', 'Kariman@1');

-- Dindigul District Farmers (excluding Kiran_11)
INSERT INTO farmers VALUES (61, 'Elango_61', 'Elango Murugan', 'Palani', 'Dindigul', 624601, '9456789016', 'Palani#123');
INSERT INTO farmers VALUES (62, 'Fathima_62', 'Fathima Beevi', 'Oddanchatram', 'Dindigul', 624619, '9567890127', 'Oddan$456');
INSERT INTO farmers VALUES (63, 'Ganesh_63', 'Ganesh Moorthy', 'Vedasandur', 'Dindigul', 624710, '9678901238', 'Veda#7890');
INSERT INTO farmers VALUES (64, 'Hema_64', 'Hema Malini', 'Kodaikanal', 'Dindigul', 624101, '9789012349', 'KodaiFarm@');
INSERT INTO farmers VALUES (65, 'Ismail_65', 'Ismail Khan', 'Batlagundu', 'Dindigul', 624202, '9890123460', 'Batla#123');

-- Erode District Farmers (excluding Suresh_6)
INSERT INTO farmers VALUES (66, 'Jayanthi_66', 'Jayanthi Ravi', 'Bhavani', 'Erode', 638301, '9012345682', 'Bhavani@1');
INSERT INTO farmers VALUES (67, 'Karthick_67', 'Karthick Raja', 'Gobichettipalayam', 'Erode', 638452, '9123456784', 'Gobi#4567');
INSERT INTO farmers VALUES (68, 'Loganathan_68', 'Loganathan', 'Sathyamangalam', 'Erode', 638401, '9234567895', 'Sathya$89');
INSERT INTO farmers VALUES (69, 'Malini_69', 'Malini Sundar', 'Kodumudi', 'Erode', 638151, '9345678906', 'KoduFarm@1');
INSERT INTO farmers VALUES (70, 'Naveen_70', 'Naveen Kumar', 'Perundurai', 'Erode', 638052, '9456789017', 'Perun#2023');

-- Kanyakumari District Farmers (excluding Vikas_10)
INSERT INTO farmers VALUES (71, 'Olivia_71', 'Olivia Fernando', 'Nagercoil', 'Kanyakumari', 629001, '9567890128', 'Nagercoil$');
INSERT INTO farmers VALUES (72, 'Prabhu_72', 'Prabhu Dayal', 'Kuzhithurai', 'Kanyakumari', 629163, '9678901239', 'Kuzhi#1234');
INSERT INTO farmers VALUES (73, 'Queen_73', 'Queen Mary', 'Colachel', 'Kanyakumari', 629251, '9789012350', 'ColaFarm@1');
INSERT INTO farmers VALUES (74, 'Ramesh_74', 'Ramesh Kumar', 'Thuckalay', 'Kanyakumari', 629175, '9890123461', 'Thucka#12');
INSERT INTO farmers VALUES (75, 'Saroja_75', 'Saroja Devi', 'Suchindram', 'Kanyakumari', 629704, '9012345683', 'Suchin$45');

-- Karur District Farmers (excluding Pooja_16)
INSERT INTO farmers VALUES (76, 'Thangam_76', 'Thangamani', 'Kulithalai', 'Karur', 639104, '9123456785', 'Kuli#1234');
INSERT INTO farmers VALUES (77, 'Usha_77', 'Usha Rani', 'Thanthoni', 'Karur', 639006, '9234567896', 'Thantho$1');
INSERT INTO farmers VALUES (78, 'Vijay_78', 'Vijay Anand', 'Aravakurichi', 'Karur', 639201, '9345678907', 'Arava@123');
INSERT INTO farmers VALUES (79, 'Waseem_79', 'Waseem Ahmed', 'Kadavur', 'Karur', 639117, '9456789018', 'Kadavur#1');
INSERT INTO farmers VALUES (80, 'Yogesh_80', 'Yogesh Kumar', 'Pugalur', 'Karur', 639102, '9567890129', 'PugalFarm@');

-- Krishnagiri District Farmers (excluding Lakshmi_27)
INSERT INTO farmers VALUES (81, 'Zarina_81', 'Zarina Begum', 'Hosur', 'Krishnagiri', 635109, '9678901240', 'Hosur#123');
INSERT INTO farmers VALUES (82, 'Arvind_82', 'Arvind Kejriwal', 'Denkanikottai', 'Krishnagiri', 635107, '9789012351', 'Denkani$1');
INSERT INTO farmers VALUES (83, 'Bharathi_83', 'Bharathi Raja', 'Pochampalli', 'Krishnagiri', 635206, '9890123462', 'Pocha@123');
INSERT INTO farmers VALUES (84, 'Chinnasamy_84', 'Chinnasamy', 'Uthangarai', 'Krishnagiri', 635207, '9012345684', 'Uthanga#1');
INSERT INTO farmers VALUES (85, 'Deepa_85', 'Deepa Venkat', 'Bargur', 'Krishnagiri', 635104, '9123456786', 'Bargur$12');

-- Madurai District Farmers (excluding Amit_4)
INSERT INTO farmers VALUES (86, 'Elavarasi_86', 'Elavarasi', 'Melur', 'Madurai', 625106, '9234567897', 'MelurFarm@');
INSERT INTO farmers VALUES (87, 'Feroz_87', 'Feroz Khan', 'Thirumangalam', 'Madurai', 625706, '9345678908', 'Thiru#1234');
INSERT INTO farmers VALUES (88, 'Gowri_88', 'Gowri Shankar', 'Usilampatti', 'Madurai', 625532, '9456789019', 'Usila$567');
INSERT INTO farmers VALUES (89, 'Hari_89', 'Hariharan', 'Vadipatti', 'Madurai', 625218, '9567890130', 'VadiFarm@');
INSERT INTO farmers VALUES (90, 'Ibrahim_90', 'Ibrahim', 'Tirupparankundram', 'Madurai', 625005, '9678901241', 'Tirupp#12');

-- Nagapattinam District Farmers (excluding Kartik_20)
INSERT INTO farmers VALUES (91, 'Janaki_91', 'Janaki Raman', 'Mayiladuthurai', 'Nagapattinam', 609001, '9789012352', 'Mayila$12');
INSERT INTO farmers VALUES (92, 'Kannan_92', 'Kannan Ganesan', 'Sirkazhi', 'Nagapattinam', 609111, '9890123463', 'SirkaFarm@');
INSERT INTO farmers VALUES (93, 'Lakshmanan_93', 'Lakshmanan', 'Thirukkuvalai', 'Nagapattinam', 611103, '9012345685', 'Thirukku#');
INSERT INTO farmers VALUES (94, 'Mari_94', 'Mari Ammal', 'Vedaranyam', 'Nagapattinam', 614810, '9123456787', 'Vedara@12');
INSERT INTO farmers VALUES (95, 'Narayanan_95', 'Narayanan', 'Kilvelur', 'Nagapattinam', 611104, '9234567898', 'Kilve#123');

-- Namakkal District Farmers (excluding Ramesh_14)
INSERT INTO farmers VALUES (96, 'Oviya_96', 'Oviya', 'Rasipuram', 'Namakkal', 637408, '9345678909', 'RasiFarm@1');
INSERT INTO farmers VALUES (97, 'Pandian_97', 'Pandian', 'Paramathi', 'Namakkal', 637207, '9456789020', 'Paramathi#');
INSERT INTO farmers VALUES (98, 'Quaid_98', 'Quaid Miller', 'Tiruchengode', 'Namakkal', 637211, '9567890131', 'Tiruche$12');
INSERT INTO farmers VALUES (99, 'Rani_99', 'Rani Devi', 'Kolli Hills', 'Namakkal', 637411, '9678901242', 'Kolli#123');
INSERT INTO farmers VALUES (100, 'Sankar_100', 'Sankaralingam', 'Mohanur', 'Namakkal', 637015, '9789012353', 'Mohana@12');

-- Pudukottai District Farmers (excluding Dinesh_22)
INSERT INTO farmers VALUES (101, 'Thulasi_101', 'Thulasi Ram', 'Aranthangi', 'Pudukottai', 614616, '9890123464', 'AranFarm@');
INSERT INTO farmers VALUES (102, 'Umar_102', 'Umar Farooq', 'Iluppur', 'Pudukottai', 622103, '9012345686', 'Iluppur#1');
INSERT INTO farmers VALUES (103, 'Valli_103', 'Valli', 'Gandharvakottai', 'Pudukottai', 622301, '9123456788', 'Gandha$12');
INSERT INTO farmers VALUES (104, 'Wahab_104', 'Wahab Khan', 'Keeranur', 'Pudukottai', 622502, '9234567899', 'KeeraFarm@');
INSERT INTO farmers VALUES (105, 'Xavier_105', 'Xavier James', 'Ponnamaravathi', 'Pudukottai', 622403, '9345678910', 'Ponna#123');

-- Salem District Farmers (excluding Nisha_5)
INSERT INTO farmers VALUES (106, 'Yesoda_106', 'Yesoda', 'Attur', 'Salem', 636102, '9456789021', 'AtturFarm$');
INSERT INTO farmers VALUES (107, 'Zahir_107', 'Zahir Hussain', 'Mettur', 'Salem', 636401, '9567890132', 'Mettur#12');
INSERT INTO farmers VALUES (108, 'Arjun_108', 'Arjun Singh', 'Omalur', 'Salem', 636455, '9678901243', 'Omalur@12');
INSERT INTO farmers VALUES (109, 'Bala_109', 'Bala Murugan', 'Sankari', 'Salem', 637301, '9789012354', 'Sankari$1');
INSERT INTO farmers VALUES (110, 'Chitra_110', 'Chitra Devi', 'Yercaud', 'Salem', 636601, '9890123465', 'Yercaud#1');

-- Sivaganga District Farmers (excluding Sanjay_24)
INSERT INTO farmers VALUES (111, 'Dhanush_111', 'Dhanush Kumar', 'Karaikudi', 'Sivaganga', 630001, '9012345687', 'Karaikudi@');
INSERT INTO farmers VALUES (112, 'Eswari_112', 'Eswari', 'Devakottai', 'Sivaganga', 630302, '9123456789', 'DevaFarm$1');
INSERT INTO farmers VALUES (113, 'Farooq_113', 'Farooq Ali', 'Ilayangudi', 'Sivaganga', 630702, '9234567900', 'Ilaya#123');
INSERT INTO farmers VALUES (114, 'Gayathri_114', 'Gayathri', 'Manamadurai', 'Sivaganga', 630606, '9345678911', 'Manamadu$');
INSERT INTO farmers VALUES (115, 'Hari_115', 'Hari Prasad', 'Singampunari', 'Sivaganga', 630502, '9456789022', 'Singam#12');

-- Thanjavur District Farmers (excluding Priyanka_23)
INSERT INTO farmers VALUES (116, 'Ishwari_116', 'Ishwari Devi', 'Pattukkottai', 'Thanjavur', 614601, '9567890133', 'PattuFarm@');
INSERT INTO farmers VALUES (117, 'Jayaram_117', 'Jayaram', 'Orathanadu', 'Thanjavur', 614625, '9678901244', 'Oratha#12');
INSERT INTO farmers VALUES (118, 'Kavitha_118', 'Kavitha', 'Peravurani', 'Thanjavur', 614804, '9789012355', 'Peravur$1');
INSERT INTO farmers VALUES (119, 'Lokesh_119', 'Lokesh', 'Thiruvaiyaru', 'Thanjavur', 613204, '9890123466', 'Thiruva@12');
INSERT INTO farmers VALUES (120, 'Mani_120', 'Mani Ratnam', 'Thiruvonam', 'Thanjavur', 613010, '9012345688', 'Thiruvo#1');

-- Theni District Farmers (excluding Neha_15)
INSERT INTO farmers VALUES (121, 'Nagaraj_121', 'Nagaraj', 'Bodinayakanur', 'Theni', 625513, '9123456790', 'BodiFarm@1');
INSERT INTO farmers VALUES (122, 'Omana_122', 'Omana', 'Cumbum', 'Theni', 625516, '9234567901', 'Cumbum#12');
INSERT INTO farmers VALUES (123, 'Pandiyan_123', 'Pandiyan', 'Andipatti', 'Theni', 625512, '9345678912', 'AndiFarm$');
INSERT INTO farmers VALUES (124, 'Queen_124', 'Queen Bee', 'Theni Allinagaram', 'Theni', 625531, '9456789023', 'TheniAgri@');
INSERT INTO farmers VALUES (125, 'Raja_125', 'Raja', 'Uthamapalayam', 'Theni', 625533, '9567890134', 'Uthama#1');

-- Thiruvallur District Farmers (excluding Sunita_12)
INSERT INTO farmers VALUES (126, 'Sundar_126', 'Sundar Rajan', 'Poonamallee', 'Thiruvallur', 600056, '9678901245', 'PoonaFarm@');
INSERT INTO farmers VALUES (127, 'Thara_127', 'Thara', 'Avadi', 'Thiruvallur', 600054, '9789012356', 'Avadi#1234');
INSERT INTO farmers VALUES (128, 'Udhaya_128', 'Udhaya Kumar', 'Ambattur', 'Thiruvallur', 600053, '9890123467', 'AmbaFarm$');
INSERT INTO farmers VALUES (129, 'Valli_129', 'Valli', 'Tiruttani', 'Thiruvallur', 631209, '9012345689', 'TirutFarm@');
INSERT INTO farmers VALUES (130, 'Wilson_130', 'Wilson', 'Gummidipoondi', 'Thiruvallur', 601201, '9123456791', 'Gummidi#');

-- Thiruvarur District Farmers (excluding Swati_21)
INSERT INTO farmers VALUES (131, 'Xavier_131', 'Xavier', 'Mannargudi', 'Thiruvarur', 614001, '9234567902', 'MannaFarm@');
INSERT INTO farmers VALUES (132, 'Yamini_132', 'Yamini', 'Thiruvarur', 'Thiruvarur', 610001, '9345678913', 'Thiruvaru$');
INSERT INTO farmers VALUES (133, 'Zahir_133', 'Zahir', 'Nannilam', 'Thiruvarur', 610105, '9456789024', 'Nanni#1234');
INSERT INTO farmers VALUES (134, 'Aruna_134', 'Aruna', 'Koothanur', 'Thiruvarur', 610101, '9567890135', 'KoothaFarm');
INSERT INTO farmers VALUES (135, 'Balu_135', 'Balu', 'Needamangalam', 'Thiruvarur', 610107, '9678901246', 'Needam#12');

-- Thoothukudi District Farmers (excluding Rita_7)
INSERT INTO farmers VALUES (136, 'Chandran_136', 'Chandran', 'Kovilpatti', 'Thoothukudi', 628501, '9789012357', 'KovilFarm@');
INSERT INTO farmers VALUES (137, 'Devi_137', 'Devi Priya', 'Ettayapuram', 'Thoothukudi', 628902, '9890123468', 'Ettaya#12');
INSERT INTO farmers VALUES (138, 'Elango_138', 'Elango', 'Kayathar', 'Thoothukudi', 628952, '9012345690', 'Kayathar$1');
INSERT INTO farmers VALUES (139, 'Fathima_139', 'Fathima', 'Vilathikulam', 'Thoothukudi', 628907, '9123456792', 'VilaFarm@1');
INSERT INTO farmers VALUES (140, 'Gopal_140', 'Gopal', 'Sathankulam', 'Thoothukudi', 628704, '9234567903', 'Sathan#123');

-- Tirunelveli District Farmers (excluding Anita_9)
INSERT INTO farmers VALUES (141, 'Hema_141', 'Hema', 'Ambasamudram', 'Tirunelveli', 627401, '9345678914', 'AmbaFarm$1');
INSERT INTO farmers VALUES (142, 'Irfan_142', 'Irfan Khan', 'Nanguneri', 'Tirunelveli', 627108, '9456789025', 'Nangun#12');
INSERT INTO farmers VALUES (143, 'Jayanthi_143', 'Jayanthi', 'Radhapuram', 'Tirunelveli', 627111, '9567890136', 'RadhaFarm@');
INSERT INTO farmers VALUES (144, 'Kannan_144', 'Kannan', 'Sankarankovil', 'Tirunelveli', 627756, '9678901247', 'Sankara$1');
INSERT INTO farmers VALUES (145, 'Lakshmi_145', 'Lakshmi', 'Tenkasi', 'Tirunelveli', 627811, '9789012358', 'Tenkasi#12');

-- Tirupattur District Farmers (excluding Ajay_17)
INSERT INTO farmers VALUES (146, 'Mohan_146', 'Mohan', 'Vaniyambadi', 'Tirupattur', 635751, '9890123469', 'VaniyaFarm@');
INSERT INTO farmers VALUES (147, 'Nalini_147', 'Nalini', 'Ambur', 'Tirupattur', 635802, '9012345691', 'Ambur#1234');
INSERT INTO farmers VALUES (148, 'Omar_148', 'Omar', 'Jolarpettai', 'Tirupattur', 635851, '9123456793', 'JolarFarm$');
INSERT INTO farmers VALUES (149, 'Priya_149', 'Priya', 'Natrampalli', 'Tirupattur', 635852, '9234567904', 'Natra#1234');
INSERT INTO farmers VALUES (150, 'Quadir_150', 'Quadir', 'Tirupattur', 'Tirupattur', 635601, '9345678915', 'Tirupat$1');

-- Tiruppur District Farmers (excluding Rahul_8)
INSERT INTO farmers VALUES (151, 'Ramesh_151', 'Ramesh', 'Dharapuram', 'Tiruppur', 638656, '9456789026', 'DharaFarm@');
INSERT INTO farmers VALUES (152, 'Sangeetha_152', 'Sangeetha', 'Palladam', 'Tiruppur', 641664, '9567890137', 'Pallad#123');
INSERT INTO farmers VALUES (153, 'Thangam_153', 'Thangam', 'Udumalpet', 'Tiruppur', 642126, '9678901248', 'UdumalFarm');
INSERT INTO farmers VALUES (154, 'Umar_154', 'Umar', 'Madathukulam', 'Tiruppur', 642113, '9789012359', 'Madathu$1');
INSERT INTO farmers VALUES (155, 'Vasuki_155', 'Vasuki', 'Avinashi', 'Tiruppur', 641654, '9890123470', 'AvinaFarm@');

-- Vellore District Farmers (excluding Manoj_13)
INSERT INTO farmers VALUES (156, 'Walter_156', 'Walter', 'Arcot', 'Vellore', 632503, '9012345692', 'Arcot#1234');
INSERT INTO farmers VALUES (157, 'Xena_157', 'Xena', 'Gudiyatham', 'Vellore', 632602, '9123456794', 'GudiyaFarm');
INSERT INTO farmers VALUES (158, 'Yuvan_158', 'Yuvan', 'Katpadi', 'Vellore', 632007, '9234567905', 'KatpaFarm@');
INSERT INTO farmers VALUES (159, 'Zareen_159', 'Zareen', 'Arakkonam', 'Vellore', 631001, '9345678916', 'Arakko#123');
INSERT INTO farmers VALUES (160, 'Arul_160', 'Arul', 'Vaniyambadi', 'Vellore', 635751, '9456789027', 'Vaniya$123');

-- Viluppuram District Farmers (excluding Meera_19)
INSERT INTO farmers VALUES (161, 'Baskar_161', 'Baskar', 'Tindivanam', 'Viluppuram', 604001, '9567890138', 'TindiFarm@');
INSERT INTO farmers VALUES (162, 'Chitra_162', 'Chitra', 'Gingee', 'Viluppuram', 604202, '9678901249', 'Gingee#12');
INSERT INTO farmers VALUES (163, 'Daniel_163', 'Daniel', 'Kallakurichi', 'Viluppuram', 606202, '9789012360', 'KallaFarm$');
INSERT INTO farmers VALUES (164, 'Eswari_164', 'Eswari', 'Ulundurpet', 'Viluppuram', 606107, '9890123471', 'Ulundu#123');
INSERT INTO farmers VALUES (165, 'Farhan_165', 'Farhan', 'Sankarapuram', 'Viluppuram', 605701, '9012345693', 'SankaFarm@');

-- Ariyalur District (Additional 5 Farmers)
INSERT INTO farmers VALUES (166, 'Murugan_166', 'Murugan Vel', 'Thirumanur', 'Ariyalur', 621803, '9123456702', 'Ariy@166');
INSERT INTO farmers VALUES (167, 'Kavitha_167', 'Kavitha Arumugam', 'Jayankondam', 'Ariyalur', 621802, '9234567813', 'Kavi#167');
INSERT INTO farmers VALUES (168, 'Senthil_168', 'Senthil Kumar', 'Udayarpalayam', 'Ariyalur', 621801, '9345678924', 'Sent$168');
INSERT INTO farmers VALUES (169, 'Lakshmi_169', 'Lakshmi Narayanan', 'Sendurai', 'Ariyalur', 621804, '9456789035', 'Laksh@169');
INSERT INTO farmers VALUES (170, 'Rajesh_170', 'Rajesh Kannan', 'Varadarajanpettai', 'Ariyalur', 621805, '9567890146', 'Raj#170');

-- Chengalpattu District (Additional 5 Farmers)
INSERT INTO farmers VALUES (171, 'Mani_171', 'Mani Ratnam', 'Madurantakam', 'Chengalpattu', 603306, '9678901257', 'Mani@171');
INSERT INTO farmers VALUES (172, 'Shanti_172', 'Shanti Devi', 'Cheyyur', 'Chengalpattu', 603302, '9789012368', 'Shan#172');
INSERT INTO farmers VALUES (173, 'Karthik_173', 'Karthik Subramanian', 'Tirukalukundram', 'Chengalpattu', 603109, '9890123479', 'Kart$173');
INSERT INTO farmers VALUES (174, 'Anjali_174', 'Anjali Priya', 'Potheri', 'Chengalpattu', 603203, '9012345694', 'Anja@174');
INSERT INTO farmers VALUES (175, 'Vijay_175', 'Vijay Anand', 'Kelambakkam', 'Chengalpattu', 603103, '9123456805', 'Vijay#175');

-- Chennai District (Additional 5 Farmers)
INSERT INTO farmers VALUES (176, 'Deepak_176', 'Deepak Sharma', 'T Nagar', 'Chennai', 600017, '9234567916', 'Deep@176');
INSERT INTO farmers VALUES (177, 'Priya_177', 'Priya Sundar', 'Adyar', 'Chennai', 600020, '9345679027', 'Priya$177');
INSERT INTO farmers VALUES (178, 'Arun_178', 'Arun Joshi', 'Ambattur', 'Chennai', 600053, '9456780138', 'Arun#178');
INSERT INTO farmers VALUES (179, 'Meena_179', 'Meena Kumari', 'Porur', 'Chennai', 600116, '9567891249', 'Meena@179');
INSERT INTO farmers VALUES (180, 'Surya_180', 'Surya Prakash', 'Pallavaram', 'Chennai', 600043, '9678902350', 'Surya$180');

-- Coimbatore District (Additional 5 Farmers)
INSERT INTO farmers VALUES (181, 'Gopal_181', 'Gopalakrishnan', 'Saravanampatti', 'Coimbatore', 641035, '9789013461', 'Gopal@181');
INSERT INTO farmers VALUES (182, 'Rani_182', 'Rani Devi', 'Peelamedu', 'Coimbatore', 641004, '9890124572', 'Rani#182');
INSERT INTO farmers VALUES (183, 'Murali_183', 'Murali Mohan', 'Gandhipuram', 'Coimbatore', 641012, '9012346783', 'Mural$183');
INSERT INTO farmers VALUES (184, 'Latha_184', 'Latha Venkat', 'Sitra', 'Coimbatore', 641047, '9123457894', 'Latha@184');
INSERT INTO farmers VALUES (185, 'Krishna_185', 'Krishna Kumar', 'Kovaipudur', 'Coimbatore', 641042, '9234568905', 'Krish#185');

-- Cuddalore District (Additional 5 Farmers)
INSERT INTO farmers VALUES (186, 'Venkat_186', 'Venkatesh', 'Chidambaram', 'Cuddalore', 608001, '9345679016', 'Venkat@186');
INSERT INTO farmers VALUES (187, 'Radha_187', 'Radha Krishnan', 'Panruti', 'Cuddalore', 607106, '9456780127', 'Radha$187');
INSERT INTO farmers VALUES (188, 'Siva_188', 'Siva Kumar', 'Neyveli', 'Cuddalore', 607801, '9567891238', 'Siva#188');
INSERT INTO farmers VALUES (189, 'Geetha_189', 'Geetha Rani', 'Cuddalore OT', 'Cuddalore', 607001, '9678902349', 'Geeth@189');
INSERT INTO farmers VALUES (190, 'Raju_190', 'Raju Pillai', 'Kurinjipadi', 'Cuddalore', 607302, '9789013450', 'Raju$190');

-- Dharmapuri District (Additional 5 Farmers)
INSERT INTO farmers VALUES (191, 'Anand_191', 'Anand Babu', 'Harur', 'Dharmapuri', 636903, '9890124561', 'Anand@191');
INSERT INTO farmers VALUES (192, 'Bhavani_192', 'Bhavani Shanmugam', 'Palacode', 'Dharmapuri', 636808, '9012345672', 'Bhav#192');
INSERT INTO farmers VALUES (193, 'Chandru_193', 'Chandrasekar', 'Pappireddipatti', 'Dharmapuri', 636905, '9123456783', 'Chand$193');
INSERT INTO farmers VALUES (194, 'Divya_194', 'Divya Prakash', 'Nallampalli', 'Dharmapuri', 636808, '9234567894', 'Divya@194');
INSERT INTO farmers VALUES (195, 'Elango_195', 'Elango Murugan', 'Karimangalam', 'Dharmapuri', 636803, '9345678905', 'Elang#195');

-- Dindigul District (Additional 5 Farmers)
INSERT INTO farmers VALUES (196, 'Fathima_196', 'Fathima Beevi', 'Palani', 'Dindigul', 624601, '9456789016', 'Fathi@196');
INSERT INTO farmers VALUES (197, 'Ganesh_197', 'Ganesh Moorthy', 'Oddanchatram', 'Dindigul', 624619, '9567890127', 'Ganes$197');
INSERT INTO farmers VALUES (198, 'Hema_198', 'Hema Malini', 'Vedasandur', 'Dindigul', 624710, '9678901238', 'Hema#198');
INSERT INTO farmers VALUES (199, 'Ismail_199', 'Ismail Khan', 'Kodaikanal', 'Dindigul', 624101, '9789012349', 'Ismai@199');
INSERT INTO farmers VALUES (200, 'Jayanthi_200', 'Jayanthi Ravi', 'Batlagundu', 'Dindigul', 624202, '9890123450', 'Jayan$200');

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


-- Inserting the products into the Products table with ascending IDs
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
(34, 'Fruit', 'Blueberry'),
(35, 'Fruit', 'Kiwi'),          -- Example - replace with actual product
(36, 'Fruit', 'Peach'),         -- Example - replace with actual product
(37, 'Spice', 'Nutmeg'),        -- Example - replace with actual product
(38, 'Fruit', 'Cherry'),        -- Example - replace with actual product
(39, 'Spice', 'Vanilla'),       -- Example - replace with actual product
(40, 'Grain', 'Quinoa'),        -- Example - replace with actual product
(42, 'Vegetable', 'Eggplant'),  -- Example - replace with actual product
(43, 'Vegetable', 'Zucchini'),  -- Example - replace with actual product
(45, 'Fruit', 'Raspberry');     -- Exa

INSERT INTO Available_Products (Farmer_ID, Product_ID, Product_Name, Quantity, Price) VALUES
-- Farmer 1 (Wheat + Tomato)
(1, 1, 'Wheat', 250, 35.00),
(1, 2, 'Tomato', 300, 40.50),

-- Farmer 2 (Apple + Rice)
(2, 3, 'Apple', 200, 25.75),
(2, 4, 'Rice', 150, 30.00),

-- Farmer 3 (Banana + Onion + Turmeric)
(3, 8, 'Banana', 180, 32.00),
(3, 11, 'Onion', 220, 18.50),
(3, 5, 'Turmeric', 50, 110.00),

-- Farmer 4 (Orange + Carrot)
(4, 7, 'Orange', 170, 28.00),
(4, 6, 'Carrot', 190, 22.00),

-- Farmer 5 (Mango + Spinach + Cinnamon)
(5, 12, 'Mango', 120, 65.00),
(5, 14, 'Spinach', 80, 35.00),
(5, 10, 'Cinnamon', 30, 95.00),

-- Farmer 6 (Corn + Potato)
(6, 9, 'Corn', 300, 28.00),
(6, 20, 'Potato', 400, 15.00),

-- Farmer 7 (Pomegranate + Broccoli)
(7, 16, 'Pomegranate', 90, 75.00),
(7, 17, 'Broccoli', 110, 45.00),

-- Farmer 8 (Watermelon + Pumpkin + Clove)
(8, 22, 'Watermelon', 40, 20.00),
(8, 19, 'Pumpkin', 150, 25.00),
(8, 15, 'Clove', 25, 130.00),

-- Farmer 9 (Grapes + Coriander)
(9, 29, 'Grapes', 130, 55.00),
(9, 21, 'Coriander', 70, 40.00),

-- Farmer 10 (Papaya + Ginger)
(10, 32, 'Papaya', 60, 30.00),
(10, 33, 'Ginger', 90, 65.00),

-- Farmer 11 (Blueberry + Barley)
(11, 34, 'Blueberry', 45, 180.00),
(11, 13, 'Barley', 200, 32.00),

-- Farmer 12 (Strawberry + Oats)
(12, 25, 'Strawberry', 75, 120.00),
(12, 18, 'Oats', 180, 38.00),

-- Farmer 13 (Pineapple + Pepper)
(13, 27, 'Pineapple', 65, 45.00),
(13, 28, 'Pepper', 35, 140.00),

-- Farmer 14 (Guava + Saffron)
(14, 24, 'Guava', 85, 40.00),
(14, 30, 'Saffron', 10, 190.00),

-- Farmer 15 (Cardamom + Millet)
(15, 23, 'Cardamom', 20, 160.00),
(15, 26, 'Millet', 150, 42.00),

-- Farmer 16 (Sorghum + Tomato + Apple)
(16, 31, 'Sorghum', 170, 36.00),
(16, 2, 'Tomato', 280, 38.00),
(16, 3, 'Apple', 160, 27.00),

-- Farmer 17 (Rice + Banana + Onion)
(17, 4, 'Rice', 140, 31.00),
(17, 8, 'Banana', 190, 30.00),
(17, 11, 'Onion', 210, 19.00),

-- Farmer 18 (Wheat + Orange + Carrot)
(18, 1, 'Wheat', 230, 36.00),
(18, 7, 'Orange', 160, 29.00),
(18, 6, 'Carrot', 180, 23.00),

-- Farmer 19 (Turmeric + Mango + Spinach)
(19, 5, 'Turmeric', 55, 105.00),
(19, 12, 'Mango', 110, 68.00),
(19, 14, 'Spinach', 85, 36.00),

-- Farmer 20 (Cinnamon + Corn + Potato)
(20, 10, 'Cinnamon', 32, 90.00),
(20, 9, 'Corn', 290, 29.00),
(20, 20, 'Potato', 380, 16.00),

-- Continue this pattern for 100 farmers (300 total entries)

-- Farmer 21 (Pomegranate + Broccoli + Wheat)
(21, 16, 'Pomegranate', 85, 78.00),
(21, 17, 'Broccoli', 105, 48.00),
(21, 1, 'Wheat', 240, 37.00),

-- Farmer 22 (Watermelon + Pumpkin)
(22, 22, 'Watermelon', 45, 22.00),
(22, 19, 'Pumpkin', 160, 27.00),

-- Farmer 23 (Clove + Grapes + Coriander)
(23, 15, 'Clove', 28, 135.00),
(23, 29, 'Grapes', 140, 58.00),
(23, 21, 'Coriander', 75, 42.00),

-- Farmer 24 (Papaya + Ginger + Rice)
(24, 32, 'Papaya', 65, 32.00),
(24, 33, 'Ginger', 95, 68.00),
(24, 4, 'Rice', 155, 33.00),

-- Farmer 25 (Blueberry + Barley + Tomato)
(25, 34, 'Blueberry', 50, 185.00),
(25, 13, 'Barley', 210, 35.00),
(25, 2, 'Tomato', 290, 42.00),

-- Farmer 26 (Strawberry + Oats + Onion)
(26, 25, 'Strawberry', 80, 125.00),
(26, 18, 'Oats', 190, 40.00),
(26, 11, 'Onion', 220, 20.00),

-- Farmer 27 (Pineapple + Pepper + Banana)
(27, 27, 'Pineapple', 70, 48.00),
(27, 28, 'Pepper', 38, 145.00),
(27, 8, 'Banana', 200, 33.00),

-- Farmer 28 (Guava + Saffron + Carrot)
(28, 24, 'Guava', 90, 43.00),
(28, 30, 'Saffron', 12, 195.00),
(28, 6, 'Carrot', 185, 25.00),

-- Farmer 29 (Cardamom + Millet + Apple)
(29, 23, 'Cardamom', 22, 165.00),
(29, 26, 'Millet', 160, 45.00),
(29, 3, 'Apple', 210, 28.00),

-- Farmer 30 (Sorghum + Spinach)
(30, 31, 'Sorghum', 180, 38.00),
(30, 14, 'Spinach', 90, 38.00),

-- Farmer 31 (Turmeric + Mango + Potato)
(31, 5, 'Turmeric', 60, 108.00),
(31, 12, 'Mango', 115, 70.00),
(31, 20, 'Potato', 390, 17.00),

-- Farmer 32 (Cinnamon + Corn + Orange)
(32, 10, 'Cinnamon', 35, 92.00),
(32, 9, 'Corn', 310, 30.00),
(32, 7, 'Orange', 175, 31.00),

-- Farmer 33 (Rice + Banana + Broccoli)
(33, 4, 'Rice', 165, 34.00),
(33, 8, 'Banana', 210, 35.00),
(33, 17, 'Broccoli', 120, 50.00),

-- Farmer 34 (Wheat + Pomegranate)
(34, 1, 'Wheat', 260, 38.00),
(34, 16, 'Pomegranate', 95, 80.00),

-- Farmer 35 (Tomato + Watermelon + Ginger)
(35, 2, 'Tomato', 310, 43.00),
(35, 22, 'Watermelon', 50, 24.00),
(35, 33, 'Ginger', 100, 70.00),

-- Farmer 36 (Apple + Pumpkin + Clove)
(36, 3, 'Apple', 220, 30.00),
(36, 19, 'Pumpkin', 170, 28.00),
(36, 15, 'Clove', 30, 140.00),

-- Farmer 37 (Barley + Grapes)
(37, 13, 'Barley', 220, 36.00),
(37, 29, 'Grapes', 150, 60.00),

-- Farmer 38 (Oats + Coriander + Papaya)
(38, 18, 'Oats', 200, 42.00),
(38, 21, 'Coriander', 80, 45.00),
(38, 32, 'Papaya', 70, 35.00),

-- Farmer 39 (Pepper + Blueberry)
(39, 28, 'Pepper', 40, 150.00),
(39, 34, 'Blueberry', 55, 190.00),

-- Farmer 40 (Saffron + Strawberry + Onion)
(40, 30, 'Saffron', 15, 200.00),
(40, 25, 'Strawberry', 85, 130.00),
(40, 11, 'Onion', 230, 22.00),


-- Farmer 41 (Wheat + Tomato + Apple)
(41, 1, 'Wheat', 220, 37.00),
(41, 2, 'Tomato', 180, 42.00),
(41, 3, 'Apple', 150, 28.00),

-- Farmer 42 (Rice + Turmeric + Carrot)
(42, 4, 'Rice', 190, 33.00),
(42, 5, 'Turmeric', 45, 115.00),
(42, 6, 'Carrot', 200, 25.00),

-- Farmer 43 (Orange + Banana + Corn)
(43, 7, 'Orange', 160, 32.00),
(43, 8, 'Banana', 170, 35.00),
(43, 9, 'Corn', 280, 30.00),

-- Farmer 44 (Cinnamon + Onion + Mango)
(44, 10, 'Cinnamon', 30, 95.00),
(44, 11, 'Onion', 210, 20.00),
(44, 12, 'Mango', 90, 70.00),

-- Farmer 45 (Barley + Spinach + Clove)
(45, 13, 'Barley', 200, 36.00),
(45, 14, 'Spinach', 85, 38.00),
(45, 15, 'Clove', 25, 135.00),

-- Farmer 46 (Pomegranate + Broccoli + Oats)
(46, 18, 'Pomegranate', 80, 82.00),
(46, 20, 'Broccoli', 100, 48.00),
(46, 21, 'Oats', 180, 40.00),

-- Farmer 47 (Pumpkin + Potato + Coriander)
(47, 22, 'Pumpkin', 150, 27.00),
(47, 26, 'Potato', 370, 18.00),
(47, 27, 'Coriander', 70, 42.00),

-- Farmer 48 (Watermelon + Cardamom + Guava)
(48, 28, 'Watermelon', 50, 23.00),
(48, 29, 'Cardamom', 20, 165.00),
(48, 30, 'Guava', 85, 43.00),

-- Farmer 49 (Strawberry + Millet + Pineapple)
(49, 33, 'Strawberry', 75, 130.00),
(49, 34, 'Millet', 160, 45.00),
(49, 36, 'Pineapple', 65, 48.00),

-- Farmer 50 (Grapes + Pepper + Saffron)
(50, 38, 'Grapes', 140, 60.00),
(50, 37, 'Pepper', 32, 150.00),
(50, 39, 'Saffron', 8, 195.00),

-- Farmer 51 (Sorghum + Papaya + Ginger)
(51, 40, 'Sorghum', 170, 38.00),
(51, 42, 'Papaya', 70, 33.00),
(51, 43, 'Ginger', 80, 68.00),

-- Farmer 52 (Blueberry + Wheat + Tomato)
(52, 45, 'Blueberry', 45, 185.00),
(52, 1, 'Wheat', 230, 37.50),
(52, 2, 'Tomato', 190, 43.00),

-- Farmer 53 (Apple + Rice + Turmeric)
(53, 3, 'Apple', 155, 29.00),
(53, 4, 'Rice', 180, 34.00),
(53, 5, 'Turmeric', 50, 118.00),

-- Farmer 54 (Carrot + Orange + Banana)
(54, 6, 'Carrot', 195, 26.00),
(54, 7, 'Orange', 165, 33.00),
(54, 8, 'Banana', 175, 36.00),

-- Farmer 55 (Corn + Cinnamon + Onion)
(55, 9, 'Corn', 270, 31.00),
(55, 10, 'Cinnamon', 35, 98.00),
(55, 11, 'Onion', 205, 21.00),

-- Farmer 56 (Mango + Barley + Spinach)
(56, 12, 'Mango', 95, 72.00),
(56, 13, 'Barley', 195, 37.00),
(56, 14, 'Spinach', 90, 39.00),

-- Farmer 57 (Clove + Pomegranate + Broccoli)
(57, 15, 'Clove', 28, 140.00),
(57, 18, 'Pomegranate', 85, 85.00),
(57, 20, 'Broccoli', 105, 49.00),

-- Farmer 58 (Oats + Pumpkin + Potato)
(58, 21, 'Oats', 185, 41.00),
(58, 22, 'Pumpkin', 155, 28.00),
(58, 26, 'Potato', 360, 19.00),

-- Farmer 59 (Coriander + Watermelon + Cardamom)
(59, 27, 'Coriander', 75, 43.00),
(59, 28, 'Watermelon', 55, 24.00),
(59, 29, 'Cardamom', 22, 168.00),

-- Farmer 60 (Guava + Strawberry + Millet)
(60, 30, 'Guava', 90, 44.00),
(60, 33, 'Strawberry', 80, 132.00),
(60, 34, 'Millet', 165, 46.00),

-- Farmer 61 (Pineapple + Grapes + Pepper)
(61, 36, 'Pineapple', 70, 49.00),
(61, 38, 'Grapes', 145, 62.00),
(61, 37, 'Pepper', 35, 152.00),

-- Farmer 62 (Saffron + Sorghum + Papaya)
(62, 39, 'Saffron', 10, 198.00),
(62, 40, 'Sorghum', 175, 39.00),
(62, 42, 'Papaya', 75, 34.00),

-- Farmer 63 (Ginger + Blueberry + Wheat)
(63, 43, 'Ginger', 85, 70.00),
(63, 45, 'Blueberry', 50, 188.00),
(63, 1, 'Wheat', 240, 38.00),

-- Farmer 64 (Tomato + Apple + Rice)
(64, 2, 'Tomato', 200, 44.00),
(64, 3, 'Apple', 160, 30.00),
(64, 4, 'Rice', 185, 35.00),

-- Farmer 65 (Turmeric + Carrot + Orange)
(65, 5, 'Turmeric', 55, 120.00),
(65, 6, 'Carrot', 190, 27.00),
(65, 7, 'Orange', 170, 34.00),

-- Farmer 66 (Banana + Corn + Cinnamon)
(66, 8, 'Banana', 180, 37.00),
(66, 9, 'Corn', 260, 32.00),
(66, 10, 'Cinnamon', 40, 100.00),

-- Farmer 67 (Onion + Mango + Barley)
(67, 11, 'Onion', 215, 22.00),
(67, 12, 'Mango', 100, 74.00),
(67, 13, 'Barley', 190, 38.00),

-- Farmer 68 (Spinach + Clove + Pomegranate)
(68, 14, 'Spinach', 95, 40.00),
(68, 15, 'Clove', 30, 142.00),
(68, 18, 'Pomegranate', 90, 87.00),

-- Farmer 69 (Broccoli + Oats + Pumpkin)
(69, 20, 'Broccoli', 110, 50.00),
(69, 21, 'Oats', 190, 42.00),
(69, 22, 'Pumpkin', 160, 29.00),

-- Farmer 70 (Potato + Coriander + Watermelon)
(70, 26, 'Potato', 350, 20.00),
(70, 27, 'Coriander', 80, 44.00),
(70, 28, 'Watermelon', 60, 25.00),

-- Farmer 71 (Cardamom + Guava + Strawberry)
(71, 29, 'Cardamom', 25, 170.00),
(71, 30, 'Guava', 95, 45.00),
(71, 33, 'Strawberry', 85, 135.00),

-- Farmer 72 (Millet + Pineapple + Grapes)
(72, 34, 'Millet', 170, 47.00),
(72, 36, 'Pineapple', 75, 50.00),
(72, 38, 'Grapes', 150, 63.00),

-- Farmer 73 (Pepper + Saffron + Sorghum)
(73, 37, 'Pepper', 38, 155.00),
(73, 39, 'Saffron', 12, 200.00),
(73, 40, 'Sorghum', 180, 40.00),

-- Farmer 74 (Papaya + Ginger + Blueberry)
(74, 42, 'Papaya', 80, 35.00),
(74, 43, 'Ginger', 90, 72.00),
(74, 45, 'Blueberry', 55, 190.00),

-- Farmer 75 (Wheat + Tomato + Apple)
(75, 1, 'Wheat', 250, 39.00),
(75, 2, 'Tomato', 210, 45.00),
(75, 3, 'Apple', 170, 31.00),

-- Farmer 76 (Rice + Turmeric + Carrot)
(76, 4, 'Rice', 195, 36.00),
(76, 5, 'Turmeric', 60, 122.00),
(76, 6, 'Carrot', 205, 28.00),

-- Farmer 77 (Orange + Banana + Corn)
(77, 7, 'Orange', 175, 35.00),
(77, 8, 'Banana', 185, 38.00),
(77, 9, 'Corn', 290, 33.00),

-- Farmer 78 (Cinnamon + Onion + Mango)
(78, 10, 'Cinnamon', 45, 102.00),
(78, 11, 'Onion', 220, 23.00),
(78, 12, 'Mango', 110, 76.00),

-- Farmer 79 (Barley + Spinach + Clove)
(79, 13, 'Barley', 205, 39.00),
(79, 14, 'Spinach', 100, 41.00),
(79, 15, 'Clove', 35, 145.00),

-- Farmer 80 (Pomegranate + Broccoli + Oats)
(80, 18, 'Pomegranate', 95, 90.00),
(80, 20, 'Broccoli', 115, 52.00),
(80, 21, 'Oats', 195, 43.00),

-- Farmer 81 (Pumpkin + Potato + Coriander)
(81, 22, 'Pumpkin', 170, 30.00),
(81, 26, 'Potato', 380, 21.00),
(81, 27, 'Coriander', 85, 45.00),

-- Farmer 82 (Watermelon + Cardamom + Guava)
(82, 28, 'Watermelon', 65, 26.00),
(82, 29, 'Cardamom', 28, 175.00),
(82, 30, 'Guava', 100, 46.00),

-- Farmer 83 (Strawberry + Millet + Pineapple)
(83, 33, 'Strawberry', 90, 138.00),
(83, 34, 'Millet', 175, 48.00),
(83, 36, 'Pineapple', 80, 52.00),

-- Farmer 84 (Grapes + Pepper + Saffron)
(84, 38, 'Grapes', 155, 65.00),
(84, 37, 'Pepper', 40, 158.00),
(84, 39, 'Saffron', 15, 205.00),

-- Farmer 85 (Sorghum + Papaya + Ginger)
(85, 40, 'Sorghum', 185, 41.00),
(85, 42, 'Papaya', 85, 36.00),
(85, 43, 'Ginger', 95, 75.00),

-- Farmer 86 (Blueberry + Wheat + Tomato)
(86, 45, 'Blueberry', 60, 192.00),
(86, 1, 'Wheat', 260, 40.00),
(86, 2, 'Tomato', 220, 46.00),

-- Farmer 87 (Apple + Rice + Turmeric)
(87, 3, 'Apple', 180, 32.00),
(87, 4, 'Rice', 200, 37.00),
(87, 5, 'Turmeric', 65, 125.00),

-- Farmer 88 (Carrot + Orange + Banana)
(88, 6, 'Carrot', 210, 29.00),
(88, 7, 'Orange', 185, 36.00),
(88, 8, 'Banana', 190, 39.00),

-- Farmer 89 (Corn + Cinnamon + Onion)
(89, 9, 'Corn', 300, 34.00),
(89, 10, 'Cinnamon', 50, 105.00),
(89, 11, 'Onion', 230, 24.00),

-- Farmer 90 (Mango + Barley + Spinach)
(90, 12, 'Mango', 120, 78.00),
(90, 13, 'Barley', 210, 40.00),
(90, 14, 'Spinach', 105, 42.00),

-- Farmer 91 (Clove + Pomegranate + Broccoli)
(91, 15, 'Clove', 40, 150.00),
(91, 18, 'Pomegranate', 100, 92.00),
(91, 20, 'Broccoli', 120, 54.00),

-- Farmer 92 (Oats + Pumpkin + Potato)
(92, 21, 'Oats', 200, 44.00),
(92, 22, 'Pumpkin', 180, 31.00),
(92, 26, 'Potato', 400, 22.00),

-- Farmer 93 (Coriander + Watermelon + Cardamom)
(93, 27, 'Coriander', 90, 46.00),
(93, 28, 'Watermelon', 70, 27.00),
(93, 29, 'Cardamom', 30, 180.00),

-- Farmer 94 (Guava + Strawberry + Millet)
(94, 30, 'Guava', 105, 47.00),
(94, 33, 'Strawberry', 95, 140.00),
(94, 34, 'Millet', 180, 49.00),

-- Farmer 95 (Pineapple + Grapes + Pepper)
(95, 36, 'Pineapple', 85, 54.00),
(95, 38, 'Grapes', 160, 67.00),
(95, 37, 'Pepper', 42, 160.00),

-- Farmer 96 (Saffron + Sorghum + Papaya)
(96, 39, 'Saffron', 18, 210.00),
(96, 40, 'Sorghum', 190, 42.00),
(96, 42, 'Papaya', 90, 37.00),

-- Farmer 97 (Ginger + Blueberry + Wheat)
(97, 43, 'Ginger', 100, 78.00),
(97, 45, 'Blueberry', 65, 195.00),
(97, 1, 'Wheat', 270, 41.00),

-- Farmer 98 (Tomato + Apple + Rice)
(98, 2, 'Tomato', 230, 47.00),
(98, 3, 'Apple', 190, 33.00),
(98, 4, 'Rice', 210, 38.00),

-- Farmer 99 (Turmeric + Carrot + Orange)
(99, 5, 'Turmeric', 70, 128.00),
(99, 6, 'Carrot', 220, 30.00),
(99, 7, 'Orange', 195, 37.00),

-- Farmer 100 (Banana + Corn + Cinnamon)
(100, 8, 'Banana', 200, 40.00),
(100, 9, 'Corn', 320, 35.00),
(100, 10, 'Cinnamon', 55, 108.00),

(101, 3, 'Apple', 230, 32.00),
(101, 14, 'Spinach', 100, 42.00),
(101, 1, 'Wheat', 280, 40.00),

-- Farmer 102 (Banana + Onion)
(102, 8, 'Banana', 220, 36.00),
(102, 11, 'Onion', 240, 23.00),

-- Farmer 103 (Orange + Carrot + Cinnamon)
(103, 7, 'Orange', 190, 34.00),
(103, 6, 'Carrot', 200, 27.00),
(103, 10, 'Cinnamon', 40, 98.00),

-- Farmer 104 (Pineapple + Broccoli)
(104, 27, 'Pineapple', 80, 52.00),
(104, 17, 'Broccoli', 130, 52.00),

-- Farmer 105 (Grapes + Pumpkin + Rice)
(105, 29, 'Grapes', 160, 63.00),
(105, 19, 'Pumpkin', 180, 30.00),
(105, 4, 'Rice', 170, 36.00),

-- Farmer 106 (Papaya + Coriander)
(106, 32, 'Papaya', 75, 38.00),
(106, 21, 'Coriander', 85, 48.00),

-- Farmer 107 (Blueberry + Turmeric)
(107, 34, 'Blueberry', 60, 195.00),
(107, 5, 'Turmeric', 70, 115.00),

-- Farmer 108 (Strawberry + Oats + Tomato)
(108, 25, 'Strawberry', 90, 135.00),
(108, 18, 'Oats', 210, 45.00),
(108, 2, 'Tomato', 330, 46.00),

-- Farmer 109 (Guava + Barley)
(109, 24, 'Guava', 100, 48.00),
(109, 13, 'Barley', 230, 38.00),

-- Farmer 110 (Watermelon + Clove + Corn)
(110, 22, 'Watermelon', 55, 26.00),
(110, 15, 'Clove', 35, 145.00),
(110, 9, 'Corn', 320, 33.00),

-- Farmer 111 (Pomegranate + Ginger)
(111, 16, 'Pomegranate', 100, 82.00),
(111, 33, 'Ginger', 110, 72.00),

-- Farmer 112 (Cardamom + Millet + Spinach)
(112, 23, 'Cardamom', 28, 175.00),
(112, 26, 'Millet', 180, 50.00),
(112, 14, 'Spinach', 110, 45.00),

-- Farmer 113 (Sorghum + Mango)
(113, 31, 'Sorghum', 200, 42.00),
(113, 12, 'Mango', 130, 75.00),

-- Farmer 114 (Pepper + Apple + Potato)
(114, 28, 'Pepper', 50, 160.00),
(114, 3, 'Apple', 240, 33.00),
(114, 20, 'Potato', 420, 19.00),

-- Farmer 115 (Saffron + Banana + Carrot)
(115, 30, 'Saffron', 18, 205.00),
(115, 8, 'Banana', 230, 38.00),
(115, 6, 'Carrot', 210, 28.00),

-- Farmer 116 (Rice + Orange + Broccoli)
(116, 4, 'Rice', 180, 37.00),
(116, 7, 'Orange', 200, 35.00),
(116, 17, 'Broccoli', 140, 55.00),

-- Farmer 117 (Wheat + Pineapple)
(117, 1, 'Wheat', 290, 41.00),
(117, 27, 'Pineapple', 85, 54.00),

-- Farmer 118 (Tomato + Grapes + Coriander)
(118, 2, 'Tomato', 340, 47.00),
(118, 29, 'Grapes', 170, 65.00),
(118, 21, 'Coriander', 90, 50.00),

-- Farmer 119 (Onion + Papaya + Cinnamon)
(119, 11, 'Onion', 250, 24.00),
(119, 32, 'Papaya', 80, 40.00),
(119, 10, 'Cinnamon', 45, 100.00),

-- Farmer 120 (Turmeric + Blueberry + Pumpkin)
(120, 5, 'Turmeric', 75, 118.00),
(120, 34, 'Blueberry', 65, 200.00),
(120, 19, 'Pumpkin', 190, 32.00),

-- Farmer 121 (Apple + Wheat + Coriander)
(121, 3, 'Apple', 235, 34.00),
(121, 1, 'Wheat', 300, 42.00),
(121, 21, 'Coriander', 95, 51.00),

-- Farmer 122 (Banana + Onion + Pepper)
(122, 8, 'Banana', 235, 39.00),
(122, 11, 'Onion', 265, 26.00),
(122, 28, 'Pepper', 55, 162.00),

-- Farmer 123 (Orange + Carrot + Barley)
(123, 7, 'Orange', 205, 36.00),
(123, 6, 'Carrot', 215, 29.00),
(123, 13, 'Barley', 215, 41.00),

-- Farmer 124 (Pineapple + Broccoli + Rice)
(124, 27, 'Pineapple', 90, 56.00),
(124, 17, 'Broccoli', 145, 56.00),
(124, 4, 'Rice', 185, 38.00),

-- Farmer 125 (Grapes + Pumpkin + Clove)
(125, 29, 'Grapes', 165, 66.00),
(125, 19, 'Pumpkin', 195, 33.00),
(125, 15, 'Clove', 40, 147.00),

-- Farmer 126 (Papaya + Spinach + Corn)
(126, 32, 'Papaya', 85, 41.00),
(126, 14, 'Spinach', 115, 46.00),
(126, 9, 'Corn', 330, 34.00),

-- Farmer 127 (Blueberry + Turmeric + Oats)
(127, 34, 'Blueberry', 70, 203.00),
(127, 5, 'Turmeric', 80, 120.00),
(127, 18, 'Oats', 220, 46.00),

-- Farmer 128 (Strawberry + Tomato + Ginger)
(128, 25, 'Strawberry', 100, 142.00),
(128, 2, 'Tomato', 350, 48.00),
(128, 33, 'Ginger', 120, 75.00),

-- Farmer 129 (Guava + Potato + Cinnamon)
(129, 24, 'Guava', 110, 49.00),
(129, 20, 'Potato', 430, 20.00),
(129, 10, 'Cinnamon', 50, 103.00),

-- Farmer 130 (Watermelon + Mango + Millet)
(130, 22, 'Watermelon', 60, 27.00),
(130, 12, 'Mango', 140, 77.00),
(130, 26, 'Millet', 190, 51.00),

-- Farmer 131 (Pomegranate + Saffron + Wheat)
(131, 16, 'Pomegranate', 110, 85.00),
(131, 30, 'Saffron', 20, 208.00),
(131, 1, 'Wheat', 310, 43.00),

-- Farmer 132 (Cardamom + Broccoli + Rice)
(132, 23, 'Cardamom', 32, 178.00),
(132, 17, 'Broccoli', 150, 57.00),
(132, 4, 'Rice', 190, 39.00),

-- Farmer 133 (Sorghum + Orange + Onion)
(133, 31, 'Sorghum', 215, 44.00),
(133, 7, 'Orange', 210, 37.00),
(133, 11, 'Onion', 270, 27.00),

-- Farmer 134 (Pepper + Apple + Pumpkin)
(134, 28, 'Pepper', 60, 165.00),
(134, 3, 'Apple', 245, 35.00),
(134, 19, 'Pumpkin', 200, 34.00),

-- Farmer 135 (Saffron + Banana + Carrot)
(135, 30, 'Saffron', 22, 210.00),
(135, 8, 'Banana', 240, 40.00),
(135, 6, 'Carrot', 220, 30.00),

-- Farmer 136 (Rice + Grapes + Coriander)
(136, 4, 'Rice', 195, 40.00),
(136, 29, 'Grapes', 175, 67.00),
(136, 21, 'Coriander', 100, 52.00),

-- Farmer 137 (Wheat + Pineapple + Spinach)
(137, 1, 'Wheat', 320, 44.00),
(137, 27, 'Pineapple', 95, 58.00),
(137, 14, 'Spinach', 120, 47.00),

-- Farmer 138 (Tomato + Papaya + Clove)
(138, 2, 'Tomato', 360, 49.00),
(138, 32, 'Papaya', 90, 42.00),
(138, 15, 'Clove', 45, 150.00),

-- Farmer 139 (Onion + Blueberry + Barley)
(139, 11, 'Onion', 275, 28.00),
(139, 34, 'Blueberry', 75, 205.00),
(139, 13, 'Barley', 220, 42.00),

-- Farmer 140 (Turmeric + Guava + Corn)
(140, 5, 'Turmeric', 85, 122.00),
(140, 24, 'Guava', 115, 50.00),
(140, 9, 'Corn', 340, 35.00),

-- Farmer 141 (Cinnamon + Strawberry + Potato)
(141, 10, 'Cinnamon', 55, 105.00),
(141, 25, 'Strawberry', 105, 145.00),
(141, 20, 'Potato', 440, 21.00),

-- Farmer 142 (Ginger + Watermelon + Oats)
(142, 33, 'Ginger', 130, 78.00),
(142, 22, 'Watermelon', 65, 28.00),
(142, 18, 'Oats', 230, 47.00),

-- Farmer 143 (Millet + Mango + Broccoli)
(143, 26, 'Millet', 200, 52.00),
(143, 12, 'Mango', 150, 80.00),
(143, 17, 'Broccoli', 155, 58.00),

-- Farmer 144 (Pepper + Apple + Pumpkin)
(144, 28, 'Pepper', 65, 168.00),
(144, 3, 'Apple', 250, 36.00),
(144, 19, 'Pumpkin', 205, 35.00),

-- Farmer 145 (Saffron + Banana + Carrot)
(145, 30, 'Saffron', 25, 215.00),
(145, 8, 'Banana', 245, 41.00),
(145, 6, 'Carrot', 225, 31.00),

-- Farmer 146 (Rice + Grapes + Coriander)
(146, 4, 'Rice', 200, 41.00),
(146, 29, 'Grapes', 180, 68.00),
(146, 21, 'Coriander', 105, 53.00),

-- Farmer 147 (Wheat + Pineapple + Spinach)
(147, 1, 'Wheat', 330, 45.00),
(147, 27, 'Pineapple', 100, 60.00),
(147, 14, 'Spinach', 125, 48.00),

-- Farmer 148 (Tomato + Papaya + Clove)
(148, 2, 'Tomato', 370, 50.00),
(148, 32, 'Papaya', 95, 43.00),
(148, 15, 'Clove', 50, 155.00),

-- Farmer 149 (Onion + Blueberry + Barley)
(149, 11, 'Onion', 280, 29.00),
(149, 34, 'Blueberry', 80, 208.00),
(149, 13, 'Barley', 225, 43.00),

-- Farmer 150 (Strawberry + Sorghum + Onion)
(150, 25, 'Strawberry', 110, 148.00),
(150, 31, 'Sorghum', 230, 45.00),
(150, 11, 'Onion', 290, 30.00),

-- Farmer 151 (Apple + Spinach + Wheat)
(151, 3, 'Apple', 235, 33.00),
(151, 14, 'Spinach', 105, 43.00),
(151, 1, 'Wheat', 295, 42.00),

-- Farmer 152 (Banana + Onion + Turmeric)
(152, 8, 'Banana', 225, 37.00),
(152, 11, 'Onion', 245, 24.00),
(152, 5, 'Turmeric', 80, 120.00),

-- Farmer 153 (Orange + Carrot)
(153, 7, 'Orange', 195, 35.00),
(153, 6, 'Carrot', 205, 28.00),

-- Farmer 154 (Pineapple + Broccoli + Rice)
(154, 27, 'Pineapple', 85, 55.00),
(154, 17, 'Broccoli', 135, 53.00),
(154, 4, 'Rice', 175, 37.00),

-- Farmer 155 (Grapes + Pumpkin)
(155, 29, 'Grapes', 165, 64.00),
(155, 19, 'Pumpkin', 185, 31.00),

-- Farmer 156 (Papaya + Coriander + Corn)
(156, 32, 'Papaya', 80, 39.00),
(156, 21, 'Coriander', 90, 49.00),
(156, 9, 'Corn', 330, 34.00),

-- Farmer 157 (Blueberry + Cinnamon)
(157, 34, 'Blueberry', 70, 198.00),
(157, 10, 'Cinnamon', 50, 102.00),

-- Farmer 158 (Strawberry + Oats)
(158, 25, 'Strawberry', 100, 138.00),
(158, 18, 'Oats', 215, 46.00),

-- Farmer 159 (Guava + Barley + Tomato)
(159, 24, 'Guava', 105, 49.00),
(159, 13, 'Barley', 235, 39.00),
(159, 2, 'Tomato', 350, 48.00),

-- Farmer 160 (Watermelon + Clove)
(160, 22, 'Watermelon', 60, 27.00),
(160, 15, 'Clove', 40, 148.00),

-- Farmer 161 (Pomegranate + Ginger + Potato)
(161, 16, 'Pomegranate', 110, 85.00),
(161, 33, 'Ginger', 115, 75.00),
(161, 20, 'Potato', 430, 20.00),

-- Farmer 162 (Cardamom + Millet)
(162, 23, 'Cardamom', 30, 178.00),
(162, 26, 'Millet', 185, 51.00),

-- Farmer 163 (Sorghum + Mango + Spinach)
(163, 31, 'Sorghum', 205, 43.00),
(163, 12, 'Mango', 140, 77.00),
(163, 14, 'Spinach', 115, 46.00),

-- Farmer 164 (Pepper + Apple)
(164, 28, 'Pepper', 55, 163.00),
(164, 3, 'Apple', 245, 34.00),

-- Farmer 165 (Saffron + Banana + Carrot)
(165, 30, 'Saffron', 20, 208.00),
(165, 8, 'Banana', 235, 39.00),
(165, 6, 'Carrot', 215, 29.00),

-- Farmer 166 (Rice + Orange + Broccoli)
(166, 4, 'Rice', 185, 38.00),
(166, 7, 'Orange', 205, 36.00),
(166, 17, 'Broccoli', 145, 56.00),

-- Farmer 167 (Wheat + Pineapple + Onion)
(167, 1, 'Wheat', 300, 43.00),
(167, 27, 'Pineapple', 90, 57.00),
(167, 11, 'Onion', 255, 25.00),

-- Farmer 168 (Tomato + Grapes)
(168, 2, 'Tomato', 360, 49.00),
(168, 29, 'Grapes', 175, 66.00),

-- Farmer 169 (Coriander + Papaya + Turmeric)
(169, 21, 'Coriander', 95, 51.00),
(169, 32, 'Papaya', 85, 41.00),
(169, 5, 'Turmeric', 85, 122.00),

-- Farmer 170 (Blueberry + Pumpkin + Wheat)
(170, 34, 'Blueberry', 75, 203.00),
(170, 19, 'Pumpkin', 195, 33.00),
(170, 1, 'Wheat', 310, 44.00),

-- Farmer 171 (Strawberry + Sorghum)
(171, 25, 'Strawberry', 105, 142.00),
(171, 31, 'Sorghum', 210, 44.00),

-- Farmer 172 (Guava + Barley + Potato)
(172, 24, 'Guava', 110, 50.00),
(172, 13, 'Barley', 240, 40.00),
(172, 20, 'Potato', 440, 21.00),

-- Farmer 173 (Watermelon + Clove + Spinach)
(173, 22, 'Watermelon', 65, 28.00),
(173, 15, 'Clove', 45, 150.00),
(173, 14, 'Spinach', 120, 47.00),

-- Farmer 174 (Pomegranate + Ginger + Corn)
(174, 16, 'Pomegranate', 115, 87.00),
(174, 33, 'Ginger', 120, 77.00),
(174, 9, 'Corn', 340, 35.00),

-- Farmer 175 (Cardamom + Millet + Carrot)
(175, 23, 'Cardamom', 32, 180.00),
(175, 26, 'Millet', 190, 52.00),
(175, 6, 'Carrot', 220, 30.00),

-- Farmer 176 (Sorghum + Mango)
(176, 31, 'Sorghum', 215, 45.00),
(176, 12, 'Mango', 145, 80.00),

-- Farmer 177 (Pepper + Apple + Broccoli)
(177, 28, 'Pepper', 60, 165.00),
(177, 3, 'Apple', 250, 35.00),
(177, 17, 'Broccoli', 150, 57.00),

-- Farmer 178 (Saffron + Banana)
(178, 30, 'Saffron', 22, 210.00),
(178, 8, 'Banana', 240, 40.00),

-- Farmer 179 (Rice + Orange + Onion)
(179, 4, 'Rice', 190, 39.00),
(179, 7, 'Orange', 210, 37.00),
(179, 11, 'Onion', 260, 26.00),

-- Farmer 180 (Wheat + Pineapple + Tomato)
(180, 1, 'Wheat', 320, 45.00),
(180, 27, 'Pineapple', 95, 60.00),
(180, 2, 'Tomato', 370, 50.00),

-- Farmer 181 (Grapes + Coriander)
(181, 29, 'Grapes', 180, 68.00),
(181, 21, 'Coriander', 100, 52.00),

-- Farmer 182 (Papaya + Turmeric + Barley)
(182, 32, 'Papaya', 90, 42.00),
(182, 5, 'Turmeric', 90, 125.00),
(182, 13, 'Barley', 245, 41.00),

-- Farmer 183 (Blueberry + Pumpkin)
(183, 34, 'Blueberry', 80, 205.00),
(183, 19, 'Pumpkin', 200, 34.00),

-- Farmer 184 (Strawberry + Sorghum + Spinach)
(184, 25, 'Strawberry', 110, 145.00),
(184, 31, 'Sorghum', 220, 46.00),
(184, 14, 'Spinach', 125, 48.00),

-- Farmer 185 (Guava + Clove + Potato)
(185, 24, 'Guava', 115, 52.00),
(185, 15, 'Clove', 50, 155.00),
(185, 20, 'Potato', 450, 22.00),

-- Farmer 186 (Watermelon + Ginger + Wheat)
(186, 22, 'Watermelon', 70, 29.00),
(186, 33, 'Ginger', 125, 80.00),
(186, 1, 'Wheat', 330, 46.00),

-- Farmer 187 (Pomegranate + Millet)
(187, 16, 'Pomegranate', 120, 90.00),
(187, 26, 'Millet', 195, 53.00),

-- Farmer 188 (Cardamom + Apple + Carrot)
(188, 23, 'Cardamom', 35, 185.00),
(188, 3, 'Apple', 255, 36.00),
(188, 6, 'Carrot', 225, 31.00),

-- Farmer 189 (Sorghum + Orange + Broccoli)
(189, 31, 'Sorghum', 225, 47.00),
(189, 7, 'Orange', 215, 38.00),
(189, 17, 'Broccoli', 155, 58.00),

-- Farmer 190 (Pepper + Banana + Onion)
(190, 28, 'Pepper', 65, 168.00),
(190, 8, 'Banana', 245, 41.00),
(190, 11, 'Onion', 265, 27.00),

-- Farmer 191 (Saffron + Pineapple + Rice)
(191, 30, 'Saffron', 25, 215.00),
(191, 27, 'Pineapple', 100, 62.00),
(191, 4, 'Rice', 195, 40.00),

-- Farmer 192 (Wheat + Grapes)
(192, 1, 'Wheat', 340, 47.00),
(192, 29, 'Grapes', 185, 70.00),

-- Farmer 193 (Tomato + Coriander + Turmeric)
(193, 2, 'Tomato', 380, 51.00),
(193, 21, 'Coriander', 105, 53.00),
(193, 5, 'Turmeric', 95, 128.00),

-- Farmer 194 (Papaya + Barley + Spinach)
(194, 32, 'Papaya', 95, 43.00),
(194, 13, 'Barley', 250, 42.00),
(194, 14, 'Spinach', 130, 49.00),

-- Farmer 195 (Blueberry + Pumpkin + Corn)
(195, 34, 'Blueberry', 85, 208.00),
(195, 19, 'Pumpkin', 205, 35.00),
(195, 9, 'Corn', 350, 36.00),

-- Farmer 196 (Strawberry + Sorghum + Potato)
(196, 25, 'Strawberry', 115, 148.00),
(196, 31, 'Sorghum', 230, 48.00),
(196, 20, 'Potato', 460, 23.00),

-- Farmer 197 (Guava + Clove)
(197, 24, 'Guava', 120, 53.00),
(197, 15, 'Clove', 55, 160.00),

-- Farmer 198 (Watermelon + Ginger + Mango)
(198, 22, 'Watermelon', 75, 30.00),
(198, 33, 'Ginger', 130, 82.00),
(198, 12, 'Mango', 150, 85.00),

-- Farmer 199 (Pomegranate + Millet + Carrot)
(199, 16, 'Pomegranate', 125, 92.00),
(199, 26, 'Millet', 200, 54.00),
(199, 6, 'Carrot', 230, 32.00),

-- Farmer 200 (Final Entry - Cardamom + Apple + Wheat)
(200, 23, 'Cardamom', 40, 190.00),
(200, 3, 'Apple', 260, 37.00),
(200, 1, 'Wheat', 350, 48.00);

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


INSERT INTO Consumer_Cart (Consumer_ID, Farmer_ID, Product_Name, Quantity_Bought, Price, Purchase_Date) VALUES
-- Consumer 1 (buys Wheat + Tomato)
(1, 1, 'Wheat', 20, 35.00, '2025-01-10'),
(1, 22, 'Tomato', 15, 40.50, '2025-01-10'),

-- Consumer 2 (buys Apple + Rice)
(2, 5, 'Apple', 10, 25.75, '2025-01-12'),
(2, 11, 'Rice', 25, 30.00, '2025-01-12'),

-- Consumer 3 (buys Turmeric + Banana + Onion)
(3, 27, 'Turmeric', 5, 120.00, '2025-01-15'),
(3, 33, 'Banana', 12, 32.00, '2025-01-15'),
(3, 44, 'Onion', 8, 18.50, '2025-01-15'),

-- Consumer 4 (buys Orange + Carrot)
(4, 8, 'Orange', 18, 28.00, '2025-01-18'),
(4, 16, 'Carrot', 20, 22.00, '2025-01-18'),

-- Consumer 5 (buys Mango + Spinach)
(5, 12, 'Mango', 6, 65.00, '2025-01-20'),
(5, 29, 'Spinach', 10, 35.00, '2025-01-20'),

-- Consumer 6 (buys Cinnamon + Corn + Potato)
(6, 10, 'Cinnamon', 3, 95.00, '2025-01-22'),
(6, 19, 'Corn', 30, 28.00, '2025-01-22'),
(6, 37, 'Potato', 25, 15.00, '2025-01-22'),

-- Consumer 7 (buys Pomegranate + Broccoli)
(7, 16, 'Pomegranate', 4, 75.00, '2025-01-25'),
(7, 24, 'Broccoli', 8, 45.00, '2025-01-25'),

-- Consumer 8 (buys Watermelon + Pumpkin)
(8, 22, 'Watermelon', 2, 20.00, '2025-01-28'),
(8, 39, 'Pumpkin', 15, 25.00, '2025-01-28'),

-- Consumer 9 (buys Clove + Grapes)
(9, 15, 'Clove', 2, 130.00, '2025-02-01'),
(9, 31, 'Grapes', 9, 55.00, '2025-02-01'),

-- Consumer 10 (buys Coriander + Papaya)
(10, 21, 'Coriander', 5, 40.00, '2025-02-05'),
(10, 32, 'Papaya', 7, 30.00, '2025-02-05'),

-- Consumer 11-20 purchases...
(11, 5, 'Turmeric', 4, 120.00, '2025-02-10'),
(11, 18, 'Blueberry', 3, 180.00, '2025-02-10'),

(12, 13, 'Barley', 20, 32.00, '2025-02-12'),
(12, 25, 'Strawberry', 5, 120.00, '2025-02-12'),

(13, 18, 'Oats', 15, 38.00, '2025-02-15'),
(13, 28, 'Pepper', 2, 140.00, '2025-02-15'),

(14, 30, 'Saffron', 1, 190.00, '2025-02-18'),
(14, 7, 'Guava', 10, 40.00, '2025-02-18'),

(15, 23, 'Cardamom', 3, 160.00, '2025-02-20'),
(15, 26, 'Millet', 18, 42.00, '2025-02-20'),
(15, 34, 'Sorghum', 12, 36.00, '2025-02-20'),

-- Consumer 21-30 purchases...
(21, 3, 'Apple', 8, 25.75, '2025-03-01'),
(21, 20, 'Potato', 30, 15.00, '2025-03-01'),

(22, 14, 'Spinach', 12, 35.00, '2025-03-05'),
(22, 27, 'Pineapple', 4, 45.00, '2025-03-05'),

(23, 9, 'Corn', 40, 28.00, '2025-03-08'),
(23, 17, 'Broccoli', 10, 45.00, '2025-03-08'),

(24, 11, 'Onion', 15, 18.50, '2025-03-10'),
(24, 29, 'Grapes', 7, 55.00, '2025-03-10'),

(25, 6, 'Carrot', 25, 22.00, '2025-03-12'),
(25, 19, 'Pumpkin', 10, 25.00, '2025-03-12'),
(25, 35, 'Ginger', 5, 65.00, '2025-03-12'),

-- Consumer 31-45 purchases...
(31, 4, 'Rice', 30, 30.00, '2025-03-15'),
(31, 24, 'Papaya', 6, 30.00, '2025-03-15'),

(32, 2, 'Tomato', 20, 40.50, '2025-03-18'),
(32, 16, 'Pomegranate', 3, 75.00, '2025-03-18'),

(33, 8, 'Orange', 15, 28.00, '2025-03-20'),
(33, 22, 'Watermelon', 3, 20.00, '2025-03-20'),

(34, 12, 'Mango', 8, 65.00, '2025-03-22'),
(34, 31, 'Blueberry', 2, 180.00, '2025-03-22'),

(35, 1, 'Wheat', 50, 35.00, '2025-03-25'),
(35, 13, 'Barley', 25, 32.00, '2025-03-25'),
(35, 28, 'Pepper', 4, 140.00, '2025-03-25'),

-- Last 10 consumers (36-45)...
(36, 10, 'Cinnamon', 5, 95.00, '2025-03-28'),
(36, 21, 'Coriander', 8, 40.00, '2025-03-28'),

(37, 15, 'Clove', 3, 130.00, '2025-04-01'),
(37, 32, 'Guava', 12, 40.00, '2025-04-01'),

(38, 23, 'Cardamom', 2, 160.00, '2025-04-05'),
(38, 30, 'Saffron', 1, 190.00, '2025-04-05'),

(39, 7, 'Orange', 20, 28.00, '2025-04-08'),
(39, 17, 'Broccoli', 15, 45.00, '2025-04-08'),

(40, 5, 'Apple', 25, 25.75, '2025-04-10'),
(40, 20, 'Potato', 40, 15.00, '2025-04-10'),
(40, 33, 'Banana', 18, 32.00, '2025-04-10'),

-- Final 5 consumers...
(41, 9, 'Corn', 35, 28.00, '2025-04-12'),
(41, 26, 'Millet', 20, 42.00, '2025-04-12'),

(42, 14, 'Spinach', 25, 35.00, '2025-04-15'),
(42, 27, 'Pineapple', 6, 45.00, '2025-04-15'),

(43, 3, 'Apple', 30, 25.75, '2025-04-18'),
(43, 19, 'Pumpkin', 12, 25.00, '2025-04-18'),

(44, 11, 'Onion', 50, 18.50, '2025-04-20'),
(44, 29, 'Grapes', 10, 55.00, '2025-04-20'),

(45, 6, 'Carrot', 40, 22.00, '2025-04-22'),
(45, 18, 'Oats', 30, 38.00, '2025-04-22'),
(45, 34, 'Sorghum', 25, 36.00, '2025-04-22');

INSERT INTO Sold_Products (Farmer_ID, Product_ID, Product_Name, Quantity_Sold, Price, Purchase_Date) VALUES
-- January 2025 Sales
(1, 1, 'Wheat', 20, 35.00, '2025-01-10'),
(22, 2, 'Tomato', 15, 40.50, '2025-01-10'),
(5, 3, 'Apple', 10, 25.75, '2025-01-12'),
(11, 4, 'Rice', 25, 30.00, '2025-01-12'),
(27, 5, 'Turmeric', 5, 120.00, '2025-01-15'),
(33, 8, 'Banana', 12, 32.00, '2025-01-15'),
(44, 11, 'Onion', 8, 18.50, '2025-01-15'),
(8, 7, 'Orange', 18, 28.00, '2025-01-18'),
(16, 6, 'Carrot', 20, 22.00, '2025-01-18'),
(12, 12, 'Mango', 6, 65.00, '2025-01-20'),
(29, 14, 'Spinach', 10, 35.00, '2025-01-20'),
(10, 10, 'Cinnamon', 3, 95.00, '2025-01-22'),
(19, 9, 'Corn', 30, 28.00, '2025-01-22'),
(37, 20, 'Potato', 25, 15.00, '2025-01-22'),
(16, 16, 'Pomegranate', 4, 75.00, '2025-01-25'),
(24, 17, 'Broccoli', 8, 45.00, '2025-01-25'),
(22, 22, 'Watermelon', 2, 20.00, '2025-01-28'),
(39, 19, 'Pumpkin', 15, 25.00, '2025-01-28'),

-- February 2025 Sales
(15, 15, 'Clove', 2, 130.00, '2025-02-01'),
(31, 29, 'Grapes', 9, 55.00, '2025-02-01'),
(21, 21, 'Coriander', 5, 40.00, '2025-02-05'),
(32, 32, 'Papaya', 7, 30.00, '2025-02-05'),
(5, 5, 'Turmeric', 4, 120.00, '2025-02-10'),
(18, 34, 'Blueberry', 3, 180.00, '2025-02-10'),
(13, 13, 'Barley', 20, 32.00, '2025-02-12'),
(25, 25, 'Strawberry', 5, 120.00, '2025-02-12'),
(18, 18, 'Oats', 15, 38.00, '2025-02-15'),
(28, 28, 'Pepper', 2, 140.00, '2025-02-15'),
(30, 30, 'Saffron', 1, 190.00, '2025-02-18'),
(7, 24, 'Guava', 10, 40.00, '2025-02-18'),
(23, 23, 'Cardamom', 3, 160.00, '2025-02-20'),
(26, 26, 'Millet', 18, 42.00, '2025-02-20'),
(34, 31, 'Sorghum', 12, 36.00, '2025-02-20'),

-- March 2025 Sales
(3, 3, 'Apple', 8, 25.75, '2025-03-01'),
(20, 20, 'Potato', 30, 15.00, '2025-03-01'),
(14, 14, 'Spinach', 12, 35.00, '2025-03-05'),
(27, 27, 'Pineapple', 4, 45.00, '2025-03-05'),
(9, 9, 'Corn', 40, 28.00, '2025-03-08'),
(17, 17, 'Broccoli', 10, 45.00, '2025-03-08'),
(11, 11, 'Onion', 15, 18.50, '2025-03-10'),
(29, 29, 'Grapes', 7, 55.00, '2025-03-10'),
(6, 6, 'Carrot', 25, 22.00, '2025-03-12'),
(19, 19, 'Pumpkin', 10, 25.00, '2025-03-12'),
(35, 33, 'Ginger', 5, 65.00, '2025-03-12'),
(4, 4, 'Rice', 30, 30.00, '2025-03-15'),
(24, 24, 'Guava', 6, 40.00, '2025-03-15'),
(2, 2, 'Tomato', 20, 40.50, '2025-03-18'),
(16, 16, 'Pomegranate', 3, 75.00, '2025-03-18'),
(8, 7, 'Orange', 15, 28.00, '2025-03-20'),
(22, 22, 'Watermelon', 3, 20.00, '2025-03-20'),
(12, 12, 'Mango', 8, 65.00, '2025-03-22'),
(31, 34, 'Blueberry', 2, 180.00, '2025-03-22'),
(1, 1, 'Wheat', 50, 35.00, '2025-03-25'),
(13, 13, 'Barley', 25, 32.00, '2025-03-25'),
(28, 28, 'Pepper', 4, 140.00, '2025-03-25'),
(10, 10, 'Cinnamon', 5, 95.00, '2025-03-28'),
(21, 21, 'Coriander', 8, 40.00, '2025-03-28'),

-- April 2025 Sales
(15, 15, 'Clove', 3, 130.00, '2025-04-01'),
(32, 32, 'Papaya', 12, 30.00, '2025-04-01'),
(23, 23, 'Cardamom', 2, 160.00, '2025-04-05'),
(30, 30, 'Saffron', 1, 190.00, '2025-04-05'),
(7, 7, 'Orange', 20, 28.00, '2025-04-08'),
(17, 17, 'Broccoli', 15, 45.00, '2025-04-08'),
(5, 3, 'Apple', 25, 25.75, '2025-04-10'),
(20, 20, 'Potato', 40, 15.00, '2025-04-10'),
(33, 8, 'Banana', 18, 32.00, '2025-04-10'),
(9, 9, 'Corn', 35, 28.00, '2025-04-12'),
(26, 26, 'Millet', 20, 42.00, '2025-04-12'),
(14, 14, 'Spinach', 25, 35.00, '2025-04-15'),
(27, 27, 'Pineapple', 6, 45.00, '2025-04-15'),
(3, 3, 'Apple', 30, 25.75, '2025-04-18'),
(19, 19, 'Pumpkin', 12, 25.00, '2025-04-18'),
(11, 11, 'Onion', 50, 18.50, '2025-04-20'),
(29, 29, 'Grapes', 10, 55.00, '2025-04-20'),
(6, 6, 'Carrot', 40, 22.00, '2025-04-22'),
(18, 18, 'Oats', 30, 38.00, '2025-04-22'),
(34, 31, 'Sorghum', 25, 36.00, '2025-04-22'),

-- May 2025 Sales
(1, 1, 'Wheat', 35, 35.00, '2025-05-05'),
(13, 13, 'Barley', 20, 32.00, '2025-05-05'),
(28, 28, 'Pepper', 3, 140.00, '2025-05-05'),
(2, 2, 'Tomato', 25, 40.50, '2025-05-08'),
(16, 16, 'Pomegranate', 4, 75.00, '2025-05-08'),
(3, 3, 'Apple', 15, 25.75, '2025-05-10'),
(20, 20, 'Potato', 35, 15.00, '2025-05-10'),
(4, 4, 'Rice', 40, 30.00, '2025-05-12'),
(24, 24, 'Guava', 8, 40.00, '2025-05-12'),
(5, 5, 'Turmeric', 6, 120.00, '2025-05-15'),
(34, 34, 'Blueberry', 3, 180.00, '2025-05-15'),
(21, 21, 'Coriander', 10, 40.00, '2025-05-15'),
(6, 6, 'Carrot', 30, 22.00, '2025-05-18'),
(18, 18, 'Oats', 25, 38.00, '2025-05-18'),
(7, 7, 'Orange', 22, 28.00, '2025-05-20'),
(17, 17, 'Broccoli', 12, 45.00, '2025-05-20'),
(8, 8, 'Banana', 20, 32.00, '2025-05-22'),
(22, 22, 'Watermelon', 4, 20.00, '2025-05-22'),
(9, 9, 'Corn', 45, 28.00, '2025-05-25'),
(19, 19, 'Pumpkin', 15, 25.00, '2025-05-25'),
(35, 33, 'Ginger', 6, 65.00, '2025-05-25'),
(10, 10, 'Cinnamon', 4, 95.00, '2025-05-28'),
(23, 23, 'Cardamom', 3, 160.00, '2025-05-28'),

-- June 2025 Sales
(11, 11, 'Onion', 55, 18.50, '2025-06-01'),
(29, 29, 'Grapes', 12, 55.00, '2025-06-01'),
(12, 12, 'Mango', 10, 65.00, '2025-06-05'),
(30, 30, 'Saffron', 2, 190.00, '2025-06-05'),
(14, 14, 'Spinach', 30, 35.00, '2025-06-08'),
(27, 27, 'Pineapple', 8, 45.00, '2025-06-08'),
(15, 15, 'Clove', 4, 130.00, '2025-06-10'),
(31, 31, 'Sorghum', 30, 36.00, '2025-06-10'),
(25, 25, 'Strawberry', 8, 120.00, '2025-06-15'),
(32, 32, 'Papaya', 15, 30.00, '2025-06-15'),
(26, 26, 'Millet', 25, 42.00, '2025-06-15');

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



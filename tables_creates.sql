--
-- File generated with SQLiteStudio v3.3.3 on Mon Aug 9 20:44:54 2021
--
-- Text encoding used: System
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: DispensaryTable
DROP TABLE IF EXISTS DispensaryTable;

CREATE TABLE DispensaryTable (
    DispensaryID   VARCHAR UNIQUE,
    DispensaryName VARCHAR,
    Delivery       BOOLEAN,
    DispensaryCity VARCHAR
);


-- Table: MedicalNormalPricing
DROP TABLE IF EXISTS MedicalNormalPricing;

CREATE TABLE MedicalNormalPricing (
    ProductID         VARCHAR,
    Quantity1         VARCHAR,
    Price1            DECIMAL,
    Quantity2         VARCHAR,
    Price2            DECIMAL,
    Quantity3         VARCHAR,
    Price3            DECIMAL,
    Quantity4         VARCHAR,
    Price4            DECIMAL,
    Quantity5         VARCHAR,
    Price5            DECIMAL,
    Quantity6         VARCHAR,
    Price6            DECIMAL,
    Quantity7         VARCHAR,
    Price7            DECIMAL,
    Quantity8         VARCHAR,
    Price8            DECIMAL,
    InsertionDate     DATE,
    QuantityAvailable INTEGER,
    IsSpecial         BOOLEAN
);


-- Table: MedicalSpecialPricing
DROP TABLE IF EXISTS MedicalSpecialPricing;

CREATE TABLE MedicalSpecialPricing (
    ProductID         VARCHAR,
    Quantity1         VARCHAR,
    Price1            VARCHAR,
    Quantity2         VARCHAR,
    Price2            VARCHAR,
    Quantity3         VARCHAR,
    Price3            VARCHAR,
    Quantity4         VARCHAR,
    Price4            VARCHAR,
    Quantity5         VARCHAR,
    Price5            VARCHAR,
    Quantity6         VARCHAR,
    Price6            VARCHAR,
    Quantity7         VARCHAR,
    Price7            VARCHAR,
    Quantity8         VARCHAR,
    Price8            VARCHAR,
    InsertionDate     DATE,
    QuantityAvailable INTEGER,
    IsSpecial         BOOLEAN
);


-- Table: ProductCannabinoidsContent
DROP TABLE IF EXISTS ProductCannabinoidsContent;

CREATE TABLE ProductCannabinoidsContent (
    ProductID        VARCHAR UNIQUE ON CONFLICT IGNORE,
    ProductTHCUnit   VARCHAR,
    ProductTHCAmount DECIMAL,
    ProductCBDUnit   VARCHAR,
    ProductCBDAmount DECIMAL
);


-- Table: ProductNameBrandType
DROP TABLE IF EXISTS ProductNameBrandType;

CREATE TABLE ProductNameBrandType (
    ProductID      VARCHAR UNIQUE ON CONFLICT REPLACE,
    ProductBrand   VARCHAR,
    ProductName    VARCHAR,
    ProductType    VARCHAR,
    ProductTypeSub VARCHAR,
    ProductImage   VARCHAR,
    ProductStatus  BOOLEAN,
    IsSpecial      BOOLEAN,
    DispensaryID   VARCHAR
);


-- Table: RecNormalPricing
DROP TABLE IF EXISTS RecNormalPricing;

CREATE TABLE RecNormalPricing (
    ProductID         VARCHAR,
    Quantity1         VARCHAR,
    Price1            VARCHAR,
    Quantity2         VARCHAR,
    Price2            VARCHAR,
    Quantity3         VARCHAR,
    Price3            VARCHAR,
    Quantity4         VARCHAR,
    Price4            VARCHAR,
    Quantity5         VARCHAR,
    Price5            VARCHAR,
    Quantity6         VARCHAR,
    Price6            VARCHAR,
    Quantity7         VARCHAR,
    Price7            VARCHAR,
    Quantity8         VARCHAR,
    Price8            VARCHAR,
    InsertionDate     DATE,
    QuantityAvailable INTEGER
);


-- Table: RecSpecialPricing
DROP TABLE IF EXISTS RecSpecialPricing;

CREATE TABLE RecSpecialPricing (
    ProductID         VARCHAR,
    Quantity1         VARCHAR,
    Price1            VARCHAR,
    Quantity2         VARCHAR,
    Price2            VARCHAR,
    Quantity3         VARCHAR,
    Price3            VARCHAR,
    Quantity4         VARCHAR,
    Price4            VARCHAR,
    Quantity5         VARCHAR,
    Price5            VARCHAR,
    Quantity6         VARCHAR,
    Price6            VARCHAR,
    Quantity7         VARCHAR,
    Price7            VARCHAR,
    Quantity8         VARCHAR,
    Price8            VARCHAR,
    InsertionDate     DATE,
    QuantityAvailable INTEGER
);


COMMIT TRANSACTION;
PRAGMA foreign_keys = on;

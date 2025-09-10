-- sql/01_create_dw.sql

IF DB_ID('ChinookDW') IS NULL
BEGIN
    CREATE DATABASE ChinookDW;
END
GO
USE ChinookDW;
GO

-- Dimensiones
IF OBJECT_ID('dimCustomer') IS NOT NULL DROP TABLE dimCustomer;
CREATE TABLE dimCustomer (
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerId INT, -- natural key from Chinook
    FirstName NVARCHAR(40),
    LastName NVARCHAR(40),
    FullName AS (RTRIM(FirstName) + ' ' + RTRIM(LastName)),
    Country NVARCHAR(80),
    City NVARCHAR(80),
    Email NVARCHAR(120)
);

IF OBJECT_ID('dimArtist') IS NOT NULL DROP TABLE dimArtist;
CREATE TABLE dimArtist (
    ArtistKey INT IDENTITY(1,1) PRIMARY KEY,
    ArtistId INT,
    Name NVARCHAR(200)
);

IF OBJECT_ID('dimGenre') IS NOT NULL DROP TABLE dimGenre;
CREATE TABLE dimGenre (
    GenreKey INT IDENTITY(1,1) PRIMARY KEY,
    GenreId INT,
    Name NVARCHAR(120)
);

IF OBJECT_ID('dimTrack') IS NOT NULL DROP TABLE dimTrack;
CREATE TABLE dimTrack (
    TrackKey INT IDENTITY(1,1) PRIMARY KEY,
    TrackId INT,
    Name NVARCHAR(200),
    AlbumTitle NVARCHAR(160),
    MediaTypeName NVARCHAR(120),
    GenreName NVARCHAR(120),
    Composer NVARCHAR(220),
    Milliseconds INT,
    UnitPrice DECIMAL(10,2)
);

IF OBJECT_ID('dimDate') IS NOT NULL DROP TABLE dimDate;
CREATE TABLE dimDate (
    DateKey INT PRIMARY KEY, -- YYYYMMDD
    FullDate DATE,
    Year INT,
    Quarter INT,
    Month INT,
    Day INT,
    WeekDayName NVARCHAR(20)
);

-- Tabla de hechos
IF OBJECT_ID('factSales') IS NOT NULL DROP TABLE factSales;
CREATE TABLE factSales (
    SalesKey INT IDENTITY(1,1) PRIMARY KEY,
    InvoiceId INT,
    InvoiceLineId INT,
    DateKey INT NOT NULL,        -- FK to dimDate.DateKey
    CustomerKey INT NOT NULL,    -- FK to dimCustomer
    ArtistKey INT NULL,
    GenreKey INT NULL,
    TrackKey INT NULL,
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    TotalAmount DECIMAL(12,2)
);

-- Índices de ayuda
CREATE NONCLUSTERED INDEX IX_factSales_DateKey ON factSales(DateKey);
CREATE NONCLUSTERED INDEX IX_factSales_CustomerKey ON factSales(CustomerKey);
CREATE NONCLUSTERED INDEX IX_factSales_ArtistKey ON factSales(ArtistKey);
GO

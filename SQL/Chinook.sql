-- Crear la base de datos
CREATE DATABASE Chinook;
GO

USE Chinook;
GO

-- ==========================
-- Tabla: Artist: Artista
-- ==========================
CREATE TABLE Artist (
    ArtistId INT PRIMARY KEY,
    Name NVARCHAR(120) NOT NULL
);

-- ==========================
-- Tabla: Album: Album
-- ==========================
CREATE TABLE Album (
    AlbumId INT PRIMARY KEY,
    Title NVARCHAR(160) NOT NULL,
    ArtistId INT NOT NULL,
    FOREIGN KEY (ArtistId) REFERENCES Artist(ArtistId)
);

-- ==========================
-- Tabla: Genre: Genero
-- ==========================
CREATE TABLE Genre (
    GenreId INT PRIMARY KEY,
    Name NVARCHAR(120) NOT NULL
);

-- ==========================
-- Tabla: MediaType
-- ==========================
CREATE TABLE MediaType (
    MediaTypeId INT PRIMARY KEY,
    Name NVARCHAR(120) NOT NULL
);

-- ==========================
-- Tabla: Track: pista
-- ==========================
CREATE TABLE Track (
    TrackId INT PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    AlbumId INT,
    MediaTypeId INT NOT NULL,
    GenreId INT,
    Composer NVARCHAR(220),
    Milliseconds INT NOT NULL,
    Bytes INT,
    UnitPrice DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (AlbumId) REFERENCES Album(AlbumId),
    FOREIGN KEY (MediaTypeId) REFERENCES MediaType(MediaTypeId),
    FOREIGN KEY (GenreId) REFERENCES Genre(GenreId)
);

-- ==========================
-- Tabla: Playlist
-- ==========================
CREATE TABLE Playlist (
    PlaylistId INT PRIMARY KEY,
    Name NVARCHAR(120)
);

-- ==========================
-- Tabla: PlaylistTrack (relación N a N)
-- ==========================
CREATE TABLE PlaylistTrack (
    PlaylistId INT NOT NULL,
    TrackId INT NOT NULL,
    PRIMARY KEY (PlaylistId, TrackId),
    FOREIGN KEY (PlaylistId) REFERENCES Playlist(PlaylistId),
    FOREIGN KEY (TrackId) REFERENCES Track(TrackId)
);

-- ==========================
-- Tabla: Employee: empleado
-- ==========================
CREATE TABLE Employee (
    EmployeeId INT PRIMARY KEY,
    LastName NVARCHAR(20) NOT NULL,
    FirstName NVARCHAR(20) NOT NULL,
    Title NVARCHAR(30),
    ReportsTo INT,
    BirthDate DATETIME,
    HireDate DATETIME,
    Address NVARCHAR(70),
    City NVARCHAR(40),
    State NVARCHAR(40),
    Country NVARCHAR(40),
    PostalCode NVARCHAR(10),
    Phone NVARCHAR(24),
    Fax NVARCHAR(24),
    Email NVARCHAR(60),
    FOREIGN KEY (ReportsTo) REFERENCES Employee(EmployeeId)
);

-- ==========================
-- Tabla: Customer: Cliente
-- ==========================
CREATE TABLE Customer (
    CustomerId INT PRIMARY KEY,
    FirstName NVARCHAR(40) NOT NULL,
    LastName NVARCHAR(20) NOT NULL,
    Company NVARCHAR(80),
    Address NVARCHAR(70),
    City NVARCHAR(40),
    State NVARCHAR(40),
    Country NVARCHAR(40),
    PostalCode NVARCHAR(10),
    Phone NVARCHAR(24),
    Fax NVARCHAR(24),
    Email NVARCHAR(60) NOT NULL,
    SupportRepId INT,
    FOREIGN KEY (SupportRepId) REFERENCES Employee(EmployeeId)
);

-- ==========================
-- Tabla: Invoice: Factura
-- ==========================
CREATE TABLE Invoice (
    InvoiceId INT PRIMARY KEY,
    CustomerId INT NOT NULL,
    InvoiceDate DATETIME NOT NULL,
    BillingAddress NVARCHAR(70),
    BillingCity NVARCHAR(40),
    BillingState NVARCHAR(40),
    BillingCountry NVARCHAR(40),
    BillingPostalCode NVARCHAR(10),
    Total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId)
);

-- ==========================
-- Tabla: InvoiceLine : Línea de factura
-- ==========================
CREATE TABLE InvoiceLine (
    InvoiceLineId INT PRIMARY KEY,
    InvoiceId INT NOT NULL,
    TrackId INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    Quantity INT NOT NULL,
    FOREIGN KEY (InvoiceId) REFERENCES Invoice(InvoiceId),
    FOREIGN KEY (TrackId) REFERENCES Track(TrackId)
);

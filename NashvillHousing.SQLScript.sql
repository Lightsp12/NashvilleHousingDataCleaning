/*

Cleaning Data in SQL Queries

*/
-- Standardize Date Format

SELECT SaleDateConverted AS "Sale Date", CONVERT(Date, saleDate)
FROM master.dbo.NashvilleHousing

Update NashvilleHousing
SET SaleDate = CONVERT(Date, SaleDate)


ALTER TABLE NashvilleHousing
Add SaleDateConverted Date;

Update NashvilleHousing
SET SaleDateConverted = CONVERT(Date, SaleDate)

-- Populate Property Address Date 

SELECT *
FROM master.dbo.NashvilleHousing
--Where  PropertyAddress IS NULL
Order by ParcelID

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM master.dbo.NashvilleHousing a
JOIN master.dbo.NashvilleHousing b
   ON a.ParcelID = b.ParcelID
   AND a.[UniqueID ]<> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL


Update a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM master.dbo.NashvilleHousing a
JOIN master.dbo.NashvilleHousing b
   ON a.ParcelID = b.ParcelID
   AND a.[UniqueID ]<> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL


-- Breaking out address into Indivitual Columes (Address, City, State)

SELECT PropertyAddress
FROM master.dbo.NashvilleHousing
--WHERE  PropertyAddress IS NULL
--Order By ParcelID


SELECT 
SUBSTRING(ProPertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) AS Address,
SUBSTRING(ProPertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress)) AS Address

FROM master.dbo.NashvilleHousing


ALTER TABLE NashvilleHousing
Add PropertySplitAddress Nvarchar(255);

Update NashvilleHousing
SET  PropertySplitAddress = SUBSTRING(ProPertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) 


ALTER TABLE NashvilleHousing
Add PropertySplitCity Nvarchar(255);

Update NashvilleHousing
SET  PropertySplitCity = SUBSTRING(ProPertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress))


SELECT *
FROM master.dbo.NashvilleHousing

-- another way to Breaking out address into Indivitual Columes (Address, City, State)

SELECT OwnerAddress
FROM master.dbo.NashvilleHousing


SELECT
PARSENAME(REPLACE(OwnerAddress,',', '.'), 3) AS Address,
PARSENAME(REPLACE(OwnerAddress,',', '.'), 2) AS City,
PARSENAME(REPLACE(OwnerAddress,',', '.'), 1) AS State
FROM master.dbo.NashvilleHousing


ALTER TABLE NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update NashvilleHousing
SET  OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',', '.'), 3) 


ALTER TABLE NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update NashvilleHousing
SET  OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',', '.'), 2)


ALTER TABLE NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update NashvilleHousing
SET  OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',', '.'), 1)

SELECT *
FROM master.dbo.NashvilleHousing
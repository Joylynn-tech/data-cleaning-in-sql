SELECT*
FROM nashhousing

--STANDARDIZED DATE FORMAT
SELECT SaleDate
FROM nashhousing

SELECT SaleDate,CONVERT(Date,SaleDate)
FROM nashhousing

UPDATE nashhousing
SET SaleDate=CONVERT(Date,SaleDate)

ALTER TABLE nashhousing
ADD SalesDateConverted Date

UPDATE nashhousing
SET SalesDateConverted=CONVERT(Date,SaleDate)


--POPULATE PROPERTY ADDRESS

SELECT *
FROM nashhousing
WHERE PropertyAddress IS NULL

SELECT *
FROM nashhousing
--WHERE PropertyAddress IS NULL
ORDER BY ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From nashhousing a
JOIN nashhousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From nashhousing a
JOIN nashhousing b 
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

-- Breaking out Address into Individual Columns (Address, City, State)


Select PropertyAddress
From nashhousing
--Where PropertyAddress is null
--order by ParcelID

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address

From nashhousing


ALTER TABLE nashhousing
Add PropertySplitAddress Nvarchar(255);

Update nashhousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )

ALTER TABLE nashhousing 
Add PropertySplitCity Nvarchar(255);

Update nashhousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))



Select *
From nashhousing




Select OwnerAddress
From nashhousing


Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From nashhousing

ALTER TABLE nashhousing
Add OwnerSplitAddress Nvarchar(255);

Update nashhousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE nashhousing 
Add OwnerSplitCity Nvarchar(255);

Update nashhousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE nashhousing
Add OwnerSplitState Nvarchar(255);

Update nashhousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)


Select *
From nashhousing





--Change Y and N to Yes and No in "Sold as Vacant" field


Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From nashhousing
Group by SoldAsVacant
order by 2



Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From nashhousing


Update nashhousing 
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END






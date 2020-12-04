SELECT pbr.ProductBrand, pbr.ProductName, pbr.ProductType, pbr.ProductTypeSub, mnp.Quantity1, mnp.Price1, mnp.Quantity2, mnp.Price2, mnp.Quantity3, mnp.Price3, mnp.Quantity4, mnp.Price4, mnp.QuantityAvailable from ProductNameBrandType as pbr
INNER JOIN MedicalNormalPricing as mnp on pbr.ProductID = mnp.ProductID and pbr.IsSpecial = mnp.IsSpecial
WHERE mnp.QuantityAvailable > 0 AND pbr.ProductName LIKE '%rosin%'
UNION
SELECT pbr2.ProductBrand, pbr2.ProductName, pbr2.ProductType, pbr2.ProductTypeSub, msp.Quantity1, msp.Price1, msp.Quantity2, msp.Price2, msp.Quantity3, msp.Price3, msp.Quantity4, msp.Price4, msp.QuantityAvailable from ProductNameBrandType as pbr2
INNER JOIN MedicalSpecialPricing as msp on pbr2.ProductID = msp.ProductID and pbr2.IsSpecial = msp.IsSpecial
WHERE msp.QuantityAvailable > 0 AND pbr2.ProductName LIKE '%rosin%'
ORDER BY pbr.ProductType
SELECT pbr.ProductBrand, pbr.ProductName, pcc.ProductTHCUnit, pcc.ProductTHCAmount, pcc.ProductCBDUnit, pcc.ProductCBDAmount, dt.DispensaryName, dt.Delivery, pbr.ProductType, pbr.ProductTypeSub, mnp.Quantity1, mnp.Price1, mnp.QuantityAvailable from ProductNameBrandType as pbr
INNER JOIN MedicalNormalPricing as mnp on pbr.ProductID = mnp.ProductID and pbr.IsSpecial = mnp.IsSpecial
INNER JOIN DispensaryTable as dt on pbr.DispensaryID = dt.DispensaryID
INNER JOIN ProductCannabinoidsContent as pcc on pbr.ProductID = pcc.ProductID
WHERE mnp.QuantityAvailable > 0 AND mnp.InsertionDate = date('now', 'localtime') AND pbr.ProductName LIKE '%rosin%' AND dt.DispensaryCity = 'Portland'
UNION
SELECT pbr2.ProductBrand, pbr2.ProductName, pcc2.ProductTHCUnit, pcc2.ProductTHCAmount, pcc2.ProductCBDUnit, pcc2.ProductCBDAmount, dt2.DispensaryName, dt2.Delivery, pbr2.ProductType, pbr2.ProductTypeSub, msp.Quantity1, msp.Price1, msp.QuantityAvailable  from ProductNameBrandType as pbr2
INNER JOIN MedicalSpecialPricing as msp on pbr2.ProductID = msp.ProductID and pbr2.IsSpecial = msp.IsSpecial
INNER JOIN DispensaryTable as dt2 on pbr2.DispensaryID = dt2.DispensaryID
INNER JOIN ProductCannabinoidsContent as pcc2 on pbr2.ProductID = pcc2.ProductID
WHERE msp.QuantityAvailable > 0 AND msp.InsertionDate = date('now', 'localtime') AND pbr2.ProductName LIKE '%rosin%' AND dt2.DispensaryCity = 'Portland'
ORDER BY ProductType, Price1
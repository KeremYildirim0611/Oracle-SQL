-- ======================================================================
-- 03) SORGULAR (Örnek)
-- ======================================================================

-- 1) Statement with Subquery
-- Bu sorgu, bakıcılara atanan hayvanları ve sponsorlarını listeler.
SELECT a.Name AS AnimalName, a.Species,
       (SELECT s.Name FROM Sponsors s WHERE s.SponsorID = a.SponsorID) AS SponsorName
FROM Animals a
WHERE a.AnimalID IN (
    SELECT AnimalID
    FROM KeeperAssignments
    WHERE EmployeeID = 2
);

-- 2) Statement with Join
-- Hayvanları yaşadıkları alan ve tür bilgisiyle listeler.
SELECT a.Name AS AnimalName, a.Species, e.Name AS EnclosureName, e.Location,
       t.TypeName, t.NaturalHabitat
FROM Animals a
JOIN Enclosures e ON a.EnclosureID = e.EnclosureID
JOIN AnimalTypes t ON a.TypeID = t.TypeID;

-- 3) Statement with Group By
-- Her bakıcının kaç hayvanla ilgilendiğini gösterir.
SELECT e.EmployeeID,
       e.FirstName || ' ' || e.LastName AS EmployeeName,
       COUNT(k.AnimalID) AS AnimalCount
FROM Employees e
LEFT JOIN KeeperAssignments k ON e.EmployeeID = k.EmployeeID
WHERE e.EmployeeType = 'Keeper'
GROUP BY e.EmployeeID, e.FirstName, e.LastName;

-- 4) Statement with Date Function
-- Hayvan yaşını hesaplar (yıl bazında).
SELECT Name, Species, BirthDate,
       TRUNC(MONTHS_BETWEEN(SYSDATE, BirthDate)/12) AS Age
FROM Animals
ORDER BY Age DESC;

-- 5) Statement with Character Function
-- Hayvan isimlerini büyük harfe çevirir ve uzunluğunu gösterir.
SELECT AnimalID, UPPER(Name) AS UppercaseName, LENGTH(Name) AS NameLength
FROM Animals;

-- 6) Statement with Update
-- Belirli hayvanın sağlık durumunu günceller.
UPDATE Animals
SET HealthStatus = 'Excellent',
    Description = Description || ' - Updated health record on ' || TO_CHAR(SYSDATE, 'DD-MM-YYYY')
WHERE AnimalID = 1;

COMMIT;

-- 7) Statement with Alter Table
-- Animals tablosuna yeni bir sütun ekler.
ALTER TABLE Animals ADD (LastHealthCheckDate DATE);

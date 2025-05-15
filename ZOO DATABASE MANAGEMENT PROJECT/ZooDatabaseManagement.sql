-- ======================================================
--          HAYVANAT BAHÇESİ YÖNETİM SİSTEMİ
-- ======================================================
-- TABLOLARIN OLUŞTURULMASI
-- Hayvan türleri ile ilgili temel bilgiler içerir.
CREATE TABLE AnimalTypes (
    TypeID INTEGER PRIMARY KEY,
    TypeName VARCHAR(50) NOT NULL,
    ClassificationGroup VARCHAR(50),
    NaturalHabitat VARCHAR(100),
    ConservationStatus VARCHAR(50)
);

-- Hayvanların tutulduğu alanlarla ilgili bilgileri içerir.
CREATE TABLE Enclosures (
    EnclosureID INTEGER PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Location VARCHAR(50),
    EnclosureSize VARCHAR(20),
    Capacity INTEGER,
    Description VARCHAR(255),
    CleaningSchedule VARCHAR(50),
    TemperatureControl CHAR(3),
    CONSTRAINT chk_TemperatureControl CHECK (TemperatureControl IN ('Yes', 'No'))
);

-- Sponsor bilgilerini içerir. Kişi ya da kurum olabilir.
CREATE TABLE Sponsors (
    SponsorID INTEGER PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Type VARCHAR(20),
    ContactPerson VARCHAR(100),
    ContactNumber VARCHAR(20),
    Email VARCHAR(100),
    Address VARCHAR(255),
    ContributionAmount DECIMAL(10,2),
    StartDate DATE,
    EndDate DATE,
    CONSTRAINT chk_SponsorType CHECK (Type IN ('Individual', 'Organization'))
);

-- Hayvanlara ait tüm temel bilgileri tutar.
CREATE TABLE Animals (
    AnimalID INTEGER PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Species VARCHAR(50) NOT NULL,
    BirthDate DATE,
    Gender VARCHAR(10),
    HealthStatus VARCHAR(20),
    AcquisitionDate DATE,
    Description VARCHAR(255),
    Lifespan VARCHAR(20),
    DietType VARCHAR(20),
    TypeID INTEGER,
    EnclosureID INTEGER,
    SponsorID INTEGER,
    CONSTRAINT fk_Animals_Type FOREIGN KEY (TypeID) REFERENCES AnimalTypes(TypeID),
    CONSTRAINT fk_Animals_Enclosure FOREIGN KEY (EnclosureID) REFERENCES Enclosures(EnclosureID),
    CONSTRAINT fk_Animals_Sponsor FOREIGN KEY (SponsorID) REFERENCES Sponsors(SponsorID)
);

-- Personel bilgilerini içerir. Türüne göre sınıflandırılır.
CREATE TABLE Employees (
    EmployeeID INTEGER PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE,
    Gender VARCHAR(10),
    ContactNumber VARCHAR(20),
    Email VARCHAR(100),
    Address VARCHAR(255),
    HireDate DATE,
    Position VARCHAR(50),
    Salary DECIMAL(10,2),
    EmployeeType VARCHAR(20),
    CONSTRAINT chk_EmployeeType CHECK (EmployeeType IN ('Administrative', 'Keeper', 'Guide'))
);

-- Ziyaretçi bilgilerini içerir.
CREATE TABLE Visitors (
    VisitorID INTEGER PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100),
    ContactNumber VARCHAR(20),
    MembershipStatus VARCHAR(20),
    RegistrationDate DATE
);

-- Hayvanların beslenme programlarını içerir.
CREATE TABLE FeedingSchedules (
    ScheduleID INTEGER PRIMARY KEY,
    Time DATE,
    Duration VARCHAR(20),
    FoodType VARCHAR(50),
    Quantity VARCHAR(20),
    SpecialInstructions VARCHAR(255),
    AnimalID INTEGER,
    CONSTRAINT fk_Feeding_Animal FOREIGN KEY (AnimalID) REFERENCES Animals(AnimalID)
);

-- Temizlik/bakım görevleri tanımlanır.
CREATE TABLE MaintenanceTasks (
    TaskID INTEGER PRIMARY KEY,
    TaskName VARCHAR(50) NOT NULL,
    Description VARCHAR(255),
    Frequency VARCHAR(20),
    Duration VARCHAR(20),
    SpecialEquipment VARCHAR(100)
);

-- Belirli günlerde yapılan ziyaret planları tutulur.
CREATE TABLE VisitPlans (
    PlanID INTEGER PRIMARY KEY,
    VisitDate DATE,
    StartTime DATE,
    EndTime DATE,
    GroupSize INTEGER,
    SpecialRequests VARCHAR(255),
    VisitorID INTEGER,
    CONSTRAINT fk_VisitPlan_Visitor FOREIGN KEY (VisitorID) REFERENCES Visitors(VisitorID)
);

-- Hayvanlara atanan bakım görevleri.
CREATE TABLE AnimalMaintenance (
    AnimalID INTEGER,
    TaskID INTEGER,
    AssignedDate DATE,
    CompletionStatus VARCHAR(20),
    PRIMARY KEY (AnimalID, TaskID),
    CONSTRAINT fk_AM_Animal FOREIGN KEY (AnimalID) REFERENCES Animals(AnimalID),
    CONSTRAINT fk_AM_Task FOREIGN KEY (TaskID) REFERENCES MaintenanceTasks(TaskID)
);

-- Bakıcı atamaları.
CREATE TABLE KeeperAssignments (
    EmployeeID INTEGER,
    AnimalID INTEGER,
    AssignmentDate DATE,
    Responsibilities VARCHAR(255),
    PRIMARY KEY (EmployeeID, AnimalID),
    CONSTRAINT fk_KA_Employee FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    CONSTRAINT fk_KA_Animal FOREIGN KEY (AnimalID) REFERENCES Animals(AnimalID)
);

-- Hayvan sunumları için çalışan atamaları.
CREATE TABLE PresentationAssignments (
    EmployeeID INTEGER,
    AnimalID INTEGER,
    PresentationTime DATE,
    Duration VARCHAR(20),
    PRIMARY KEY (EmployeeID, AnimalID),
    CONSTRAINT fk_PA_Employee FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    CONSTRAINT fk_PA_Animal FOREIGN KEY (AnimalID) REFERENCES Animals(AnimalID)
);

-- Belirli bir ziyaret planı kapsamında hangi hayvanların görüleceğini belirtir.
CREATE TABLE VisitPlanAnimals (
    PlanID INTEGER,
    AnimalID INTEGER,
    VisitOrder INTEGER,
    SpecialNotes VARCHAR(255),
    PRIMARY KEY (PlanID, AnimalID),
    CONSTRAINT fk_VPA_Plan FOREIGN KEY (PlanID) REFERENCES VisitPlans(PlanID),
    CONSTRAINT fk_VPA_Animal FOREIGN KEY (AnimalID) REFERENCES Animals(AnimalID)
);

-- ===========================================================
--       INSERT INTO ILE TABLOLARA VERI GİRİLMESİ
-- ===========================================================


-- AnimalTypes
INSERT INTO AnimalTypes (TypeID, TypeName, ClassificationGroup, NaturalHabitat, ConservationStatus)
VALUES (1, 'Felidae', 'Mammal', 'Savanna', 'Vulnerable');
INSERT INTO AnimalTypes (TypeID, TypeName, ClassificationGroup, NaturalHabitat, ConservationStatus)
VALUES (2, 'Elephantidae', 'Mammal', 'Grasslands', 'Endangered');
INSERT INTO AnimalTypes (TypeID, TypeName, ClassificationGroup, NaturalHabitat, ConservationStatus)
VALUES (3, 'Hominidae', 'Mammal', 'Tropical Forest', 'Endangered');

-- Enclosures
INSERT INTO Enclosures (EnclosureID, Name, Location, EnclosureSize, Capacity, Description, CleaningSchedule, TemperatureControl)
VALUES (1, 'Savanna', 'East Wing', '500 m²', 5, 'Large open area with rocks', 'Weekly', 'No');
INSERT INTO Enclosures (EnclosureID, Name, Location, EnclosureSize, Capacity, Description, CleaningSchedule, TemperatureControl)
VALUES (2, 'Elephant Habitat', 'South Wing', '800 m²', 4, 'Open field with mud pool', 'Bi-weekly', 'No');
INSERT INTO Enclosures (EnclosureID, Name, Location, EnclosureSize, Capacity, Description, CleaningSchedule, TemperatureControl)
VALUES (3, 'Primate Paradise', 'West Wing', '300 m²', 10, 'Trees and climbing structures', 'Daily', 'Yes');

-- Sponsors
INSERT INTO Sponsors (SponsorID, Name, Type, ContactPerson, ContactNumber, Email, Address, ContributionAmount, StartDate, EndDate)
VALUES (1, 'ABC Corporation', 'Organization', 'Jane Doe', '555-1111', 'jane@abc.com', '100 Corp Blvd', 50000, TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2025-12-31', 'YYYY-MM-DD'));
INSERT INTO Sponsors (SponsorID, Name, Type, ContactPerson, ContactNumber, Email, Address, ContributionAmount, StartDate, EndDate)
VALUES (2, 'John Williams', 'Individual', 'John Williams', '555-2222', 'jwilliams@email.com', '200 Rich St', 10000, TO_DATE('2023-03-15', 'YYYY-MM-DD'), TO_DATE('2024-03-14', 'YYYY-MM-DD'));
INSERT INTO Sponsors (SponsorID, Name, Type, ContactPerson, ContactNumber, Email, Address, ContributionAmount, StartDate, EndDate)
VALUES (3, 'Wildlife Foundation', 'Organization', 'Robert Green', '555-3333', 'rgreen@wildlife.org', '300 Nature Rd', 75000, TO_DATE('2022-11-01', 'YYYY-MM-DD'), TO_DATE('2026-10-31', 'YYYY-MM-DD'));


-- Animals
INSERT INTO Animals (AnimalID, Name, Species, BirthDate, Gender, HealthStatus, AcquisitionDate, Description, Lifespan, DietType, TypeID, EnclosureID, SponsorID)
VALUES (1, 'Leo', 'Lion', TO_DATE('2018-05-10', 'YYYY-MM-DD'), 'Male', 'Good', TO_DATE('2019-06-15', 'YYYY-MM-DD'), 'African lion', '15 years', 'Carnivore', 1, 1, 1);
INSERT INTO Animals (AnimalID, Name, Species, BirthDate, Gender, HealthStatus, AcquisitionDate, Description, Lifespan, DietType, TypeID, EnclosureID, SponsorID)
VALUES (2, 'Ellie', 'Elephant', TO_DATE('2015-03-22', 'YYYY-MM-DD'), 'Female', 'Excellent', TO_DATE('2016-01-10', 'YYYY-MM-DD'), 'African elephant', '60 years', 'Herbivore', 2, 2, 2);
INSERT INTO Animals (AnimalID, Name, Species, BirthDate, Gender, HealthStatus, AcquisitionDate, Description, Lifespan, DietType, TypeID, EnclosureID, SponsorID)
VALUES (3, 'Charlie', 'Chimpanzee', TO_DATE('2017-11-05', 'YYYY-MM-DD'), 'Male', 'Good', TO_DATE('2018-04-20', 'YYYY-MM-DD'), 'Common chimpanzee', '40 years', 'Omnivore', 3, 3, 3);

-- Employees
INSERT INTO Employees (EmployeeID, FirstName, LastName, DateOfBirth, Gender, ContactNumber, Email, Address, HireDate, Position, Salary, EmployeeType)
VALUES (1, 'John', 'Smith', TO_DATE('1985-07-15', 'YYYY-MM-DD'), 'Male', '555-1234', 'john@zoo.com', '123 Park Ave', TO_DATE('2015-03-10', 'YYYY-MM-DD'), 'Manager', 65000, 'Administrative');
INSERT INTO Employees (EmployeeID, FirstName, LastName, DateOfBirth, Gender, ContactNumber, Email, Address, HireDate, Position, Salary, EmployeeType)
VALUES (2, 'Sarah', 'Johnson', TO_DATE('1990-02-28', 'YYYY-MM-DD'), 'Female', '555-5678', 'sarah@zoo.com', '456 Zoo Dr', TO_DATE('2017-06-22', 'YYYY-MM-DD'), 'Keeper', 45000, 'Keeper');
INSERT INTO Employees (EmployeeID, FirstName, LastName, DateOfBirth, Gender, ContactNumber, Email, Address, HireDate, Position, Salary, EmployeeType)
VALUES (3, 'Mike', 'Brown', TO_DATE('1988-11-12', 'YYYY-MM-DD'), 'Male', '555-9012', 'mike@zoo.com', '789 Animal Ln', TO_DATE('2016-09-05', 'YYYY-MM-DD'), 'Guide', 42000, 'Guide');

-- Visitors
INSERT INTO Visitors (VisitorID, FirstName, LastName, Email, ContactNumber, MembershipStatus, RegistrationDate)
VALUES (1, 'Emily', 'Parker', 'emily@email.com', '555-4444', 'Premium', TO_DATE('2023-02-10', 'YYYY-MM-DD'));
INSERT INTO Visitors (VisitorID, FirstName, LastName, Email, ContactNumber, MembershipStatus, RegistrationDate)
VALUES (2, 'David', 'Johnson', 'david@email.com', '555-5555', 'Standard', TO_DATE('2023-05-22', 'YYYY-MM-DD'));
INSERT INTO Visitors (VisitorID, FirstName, LastName, Email, ContactNumber, MembershipStatus, RegistrationDate)
VALUES (3, 'Lisa', 'Wilson', 'lisa@email.com', '555-6666', 'None', TO_DATE('2023-07-05', 'YYYY-MM-DD'));

-- FeedingSchedules
INSERT INTO FeedingSchedules (ScheduleID, Time, Duration, FoodType, Quantity, SpecialInstructions, AnimalID)
VALUES (1, TO_TIMESTAMP('09:00:00', 'HH24:MI:SS'), '30 min', 'Meat', '10 kg', 'Fresh meat only', 1);
INSERT INTO FeedingSchedules (ScheduleID, Time, Duration, FoodType, Quantity, SpecialInstructions, AnimalID)
VALUES (2, TO_TIMESTAMP('11:00:00', 'HH24:MI:SS'), '60 min', 'Vegetables', '50 kg', 'Include fruit mix', 2);
INSERT INTO FeedingSchedules (ScheduleID, Time, Duration, FoodType, Quantity, SpecialInstructions, AnimalID)
VALUES (3, TO_TIMESTAMP('14:00:00', 'HH24:MI:SS'), '45 min', 'Mixed', '5 kg', 'Include nuts', 3);

-- MaintenanceTasks
INSERT INTO MaintenanceTasks (TaskID, TaskName, Description, Frequency, Duration, SpecialEquipment)
VALUES (1, 'Grooming', 'Brushing and cleaning', 'Daily', '30 min', 'Brushes, combs');
INSERT INTO MaintenanceTasks (TaskID, TaskName, Description, Frequency, Duration, SpecialEquipment)
VALUES (2, 'Medical Checkup', 'Regular health examination', 'Monthly', '60 min', 'Medical kit');
INSERT INTO MaintenanceTasks (TaskID, TaskName, Description, Frequency, Duration, SpecialEquipment)
VALUES (3, 'Training', 'Basic command training', 'Weekly', '45 min', 'Training tools');

-- VisitPlans
INSERT INTO VisitPlans (PlanID, VisitDate, StartTime, EndTime, GroupSize, SpecialRequests, VisitorID)
VALUES (1, TO_DATE('2023-08-15', 'YYYY-MM-DD'), TO_TIMESTAMP('10:00:00', 'HH24:MI:SS'), TO_TIMESTAMP('14:00:00', 'HH24:MI:SS'), 2, 'Lion feeding view', 1);
INSERT INTO VisitPlans (PlanID, VisitDate, StartTime, EndTime, GroupSize, SpecialRequests, VisitorID)
VALUES (2, TO_DATE('2023-08-20', 'YYYY-MM-DD'), TO_TIMESTAMP('09:00:00', 'HH24:MI:SS'), TO_TIMESTAMP('12:00:00', 'HH24:MI:SS'), 4, 'Guided tour', 2);
INSERT INTO VisitPlans (PlanID, VisitDate, StartTime, EndTime, GroupSize, SpecialRequests, VisitorID)
VALUES (3, TO_DATE('2023-08-25', 'YYYY-MM-DD'), TO_TIMESTAMP('13:00:00', 'HH24:MI:SS'), TO_TIMESTAMP('16:00:00', 'HH24:MI:SS'), 1, 'Primate presentation', 3);

-- AnimalMaintenance
INSERT INTO AnimalMaintenance (AnimalID, TaskID, AssignedDate, CompletionStatus)
VALUES (1, 1, TO_DATE('2023-08-01', 'YYYY-MM-DD'), 'Completed');
INSERT INTO AnimalMaintenance (AnimalID, TaskID, AssignedDate, CompletionStatus)
VALUES (2, 2, TO_DATE('2023-07-15', 'YYYY-MM-DD'), 'Scheduled');
INSERT INTO AnimalMaintenance (AnimalID, TaskID, AssignedDate, CompletionStatus)
VALUES (3, 3, TO_DATE('2023-08-05', 'YYYY-MM-DD'), 'In Progress');

-- KeeperAssignments
INSERT INTO KeeperAssignments (EmployeeID, AnimalID, AssignmentDate, Responsibilities)
VALUES (2, 1, TO_DATE('2023-01-10', 'YYYY-MM-DD'), 'Feeding, grooming');
INSERT INTO KeeperAssignments (EmployeeID, AnimalID, AssignmentDate, Responsibilities)
VALUES (2, 2, TO_DATE('2023-01-10', 'YYYY-MM-DD'), 'Feeding, health monitoring');
INSERT INTO KeeperAssignments (EmployeeID, AnimalID, AssignmentDate, Responsibilities)
VALUES (2, 3, TO_DATE('2023-03-15', 'YYYY-MM-DD'), 'Feeding, training');

-- PresentationAssignments
INSERT INTO PresentationAssignments (EmployeeID, AnimalID, PresentationTime, Duration)
VALUES (3, 1, TO_TIMESTAMP('11:00:00', 'HH24:MI:SS'), '30 min');
INSERT INTO PresentationAssignments (EmployeeID, AnimalID, PresentationTime, Duration)
VALUES (3, 2, TO_TIMESTAMP('14:00:00', 'HH24:MI:SS'), '30 min');
INSERT INTO PresentationAssignments (EmployeeID, AnimalID, PresentationTime, Duration)
VALUES (3, 3, TO_TIMESTAMP('16:00:00', 'HH24:MI:SS'), '30 min');

-- VisitPlanAnimals
INSERT INTO VisitPlanAnimals (PlanID, AnimalID, VisitOrder, SpecialNotes)
VALUES (1, 1, 1, 'Feeding time');
INSERT INTO VisitPlanAnimals (PlanID, AnimalID, VisitOrder, SpecialNotes)
VALUES (1, 3, 2, 'Training session');
INSERT INTO VisitPlanAnimals (PlanID, AnimalID, VisitOrder, SpecialNotes)
VALUES (2, 1, 1, 'Photo opportunity');
INSERT INTO VisitPlanAnimals (PlanID, AnimalID, VisitOrder, SpecialNotes)
VALUES (2, 2, 2, 'None');
INSERT INTO VisitPlanAnimals (PlanID, AnimalID, VisitOrder, SpecialNotes)
VALUES (2, 3, 3, 'None');
INSERT INTO VisitPlanAnimals (PlanID, AnimalID, VisitOrder, SpecialNotes)
VALUES (3, 3, 1, 'Research purpose');

-- ======================================================================
--                             SORGULAR
-- ======================================================================

-- Statement with Subquery
--Bu sorgu, hayvanat bahçesindeki bakıcılara atanan hayvanları ve bu hayvanların sponsor bilgilerini listeler:
SELECT a.Name AS AnimalName, a.Species,
 (SELECT s.Name FROM Sponsors s WHERE s.SponsorID = a.SponsorID) AS SponsorName
FROM Animals a
WHERE a.AnimalID IN (
 SELECT AnimalID
 FROM KeeperAssignments
 WHERE EmployeeID = 2
);

-- Statement with Join
-- Bu sorgu, hayvanları yaşadıkları alanlar ve türleriyle birlikte listeler:
SELECT a.Name AS AnimalName, a.Species, e.Name AS EnclosureName, e.Location,
 t.TypeName, t.NaturalHabitat
FROM Animals a
JOIN Enclosures e ON a.EnclosureID = e.EnclosureID
JOIN AnimalTypes t ON a.TypeID = t.TypeID;

-- Statement with Group By
-- Bu sorgu, her bir çalışanın kaç hayvanla ilgilendiğini gösterir:
SELECT e.EmployeeID, e.FirstName || ' ' || e.LastName AS EmployeeName,
COUNT(k.AnimalID) AS AnimalCount
FROM Employees e LEFT JOIN KeeperAssignments k ON e.EmployeeID = k.EmployeeID
WHERE e.EmployeeType = 'Keeper'
GROUP BY e.EmployeeID, e.FirstName, e.LastName;

-- Statement with Date Function
-- Bu sorgu, hayvanların yaşını hesaplar:
SELECT Name, Species, BirthDate, TRUNC(MONTHS_BETWEEN(SYSDATE, BirthDate)/12) AS
Age
FROM Animals
ORDER BY Age DESC;

-- Statement with Character Function
-- Bu sorgu, hayvan isimlerini büyük harfe çevirir ve karakter uzunluğunu gösterir:
SELECT AnimalID, UPPER(Name) AS UppercaseName, LENGTH(Name) AS NameLength
FROM Animals;

-- Statement with Update
-- Bu sorgu, belirli bir hayvanın sağlık durumunu günceller:
UPDATE Animals
SET HealthStatus = 'Excellent', Description = Description || ' - Updated health record on ' ||
TO_CHAR(SYSDATE, 'DD-MM-YYYY')
WHERE AnimalID = 1;

-- Statement with Alter Table
-- Bu sorgu, Animals tablosuna yeni bir sütun ekler:
ALTER TABLE Animals ADD (LastHealthCheckDate DATE);


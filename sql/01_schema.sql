-- ======================================================
--          HAYVANAT BAHÇESİ YÖNETİM SİSTEMİ
-- ======================================================
-- 01) TABLOLARIN OLUŞTURULMASI (Oracle uyumlu)
-- Not: Bazı alanlar TIMESTAMP olarak düzenlendi (zaman bilgisi için).
-- ======================================================

-- DROP (tekrar çalıştırmak için açabilirsin)
-- DROP TABLE VisitPlanAnimals CASCADE CONSTRAINTS;
-- DROP TABLE PresentationAssignments CASCADE CONSTRAINTS;
-- DROP TABLE KeeperAssignments CASCADE CONSTRAINTS;
-- DROP TABLE AnimalMaintenance CASCADE CONSTRAINTS;
-- DROP TABLE VisitPlans CASCADE CONSTRAINTS;
-- DROP TABLE FeedingSchedules CASCADE CONSTRAINTS;
-- DROP TABLE MaintenanceTasks CASCADE CONSTRAINTS;
-- DROP TABLE Visitors CASCADE CONSTRAINTS;
-- DROP TABLE Employees CASCADE CONSTRAINTS;
-- DROP TABLE Animals CASCADE CONSTRAINTS;
-- DROP TABLE Sponsors CASCADE CONSTRAINTS;
-- DROP TABLE Enclosures CASCADE CONSTRAINTS;
-- DROP TABLE AnimalTypes CASCADE CONSTRAINTS;

-- Hayvan türleri
CREATE TABLE AnimalTypes (
    TypeID INTEGER PRIMARY KEY,
    TypeName VARCHAR2(50) NOT NULL,
    ClassificationGroup VARCHAR2(50),
    NaturalHabitat VARCHAR2(100),
    ConservationStatus VARCHAR2(50)
);

-- Hayvanların tutulduğu alanlar
CREATE TABLE Enclosures (
    EnclosureID INTEGER PRIMARY KEY,
    Name VARCHAR2(50) NOT NULL,
    Location VARCHAR2(50),
    EnclosureSize VARCHAR2(20),
    Capacity INTEGER,
    Description VARCHAR2(255),
    CleaningSchedule VARCHAR2(50),
    TemperatureControl CHAR(3),
    CONSTRAINT chk_TemperatureControl CHECK (TemperatureControl IN ('Yes', 'No'))
);

-- Sponsor bilgileri
CREATE TABLE Sponsors (
    SponsorID INTEGER PRIMARY KEY,
    Name VARCHAR2(100) NOT NULL,
    Type VARCHAR2(20),
    ContactPerson VARCHAR2(100),
    ContactNumber VARCHAR2(20),
    Email VARCHAR2(100),
    Address VARCHAR2(255),
    ContributionAmount NUMBER(10,2),
    StartDate DATE,
    EndDate DATE,
    CONSTRAINT chk_SponsorType CHECK (Type IN ('Individual', 'Organization'))
);

-- Hayvanlar
CREATE TABLE Animals (
    AnimalID INTEGER PRIMARY KEY,
    Name VARCHAR2(50) NOT NULL,
    Species VARCHAR2(50) NOT NULL,
    BirthDate DATE,
    Gender VARCHAR2(10),
    HealthStatus VARCHAR2(20),
    AcquisitionDate DATE,
    Description VARCHAR2(255),
    Lifespan VARCHAR2(20),
    DietType VARCHAR2(20),
    TypeID INTEGER,
    EnclosureID INTEGER,
    SponsorID INTEGER,
    CONSTRAINT fk_Animals_Type FOREIGN KEY (TypeID) REFERENCES AnimalTypes(TypeID),
    CONSTRAINT fk_Animals_Enclosure FOREIGN KEY (EnclosureID) REFERENCES Enclosures(EnclosureID),
    CONSTRAINT fk_Animals_Sponsor FOREIGN KEY (SponsorID) REFERENCES Sponsors(SponsorID)
);

-- Personel
CREATE TABLE Employees (
    EmployeeID INTEGER PRIMARY KEY,
    FirstName VARCHAR2(50) NOT NULL,
    LastName VARCHAR2(50) NOT NULL,
    DateOfBirth DATE,
    Gender VARCHAR2(10),
    ContactNumber VARCHAR2(20),
    Email VARCHAR2(100),
    Address VARCHAR2(255),
    HireDate DATE,
    Position VARCHAR2(50),
    Salary NUMBER(10,2),
    EmployeeType VARCHAR2(20),
    CONSTRAINT chk_EmployeeType CHECK (EmployeeType IN ('Administrative', 'Keeper', 'Guide'))
);

-- Ziyaretçiler
CREATE TABLE Visitors (
    VisitorID INTEGER PRIMARY KEY,
    FirstName VARCHAR2(50) NOT NULL,
    LastName VARCHAR2(50) NOT NULL,
    Email VARCHAR2(100),
    ContactNumber VARCHAR2(20),
    MembershipStatus VARCHAR2(20),
    RegistrationDate DATE
);

-- Beslenme programları (Time -> TIMESTAMP)
CREATE TABLE FeedingSchedules (
    ScheduleID INTEGER PRIMARY KEY,
    Time TIMESTAMP,
    Duration VARCHAR2(20),
    FoodType VARCHAR2(50),
    Quantity VARCHAR2(20),
    SpecialInstructions VARCHAR2(255),
    AnimalID INTEGER,
    CONSTRAINT fk_Feeding_Animal FOREIGN KEY (AnimalID) REFERENCES Animals(AnimalID)
);

-- Bakım/temizlik görevleri
CREATE TABLE MaintenanceTasks (
    TaskID INTEGER PRIMARY KEY,
    TaskName VARCHAR2(50) NOT NULL,
    Description VARCHAR2(255),
    Frequency VARCHAR2(20),
    Duration VARCHAR2(20),
    SpecialEquipment VARCHAR2(100)
);

-- Ziyaret planları (Start/End -> TIMESTAMP)
CREATE TABLE VisitPlans (
    PlanID INTEGER PRIMARY KEY,
    VisitDate DATE,
    StartTime TIMESTAMP,
    EndTime TIMESTAMP,
    GroupSize INTEGER,
    SpecialRequests VARCHAR2(255),
    VisitorID INTEGER,
    CONSTRAINT fk_VisitPlan_Visitor FOREIGN KEY (VisitorID) REFERENCES Visitors(VisitorID)
);

-- Hayvan-bakım görevi atamaları
-- Aynı görev ileride tekrar atanabilsin diye AssignedDate PK'ye eklendi.
CREATE TABLE AnimalMaintenance (
    AnimalID INTEGER,
    TaskID INTEGER,
    AssignedDate DATE,
    CompletionStatus VARCHAR2(20),
    PRIMARY KEY (AnimalID, TaskID, AssignedDate),
    CONSTRAINT fk_AM_Animal FOREIGN KEY (AnimalID) REFERENCES Animals(AnimalID),
    CONSTRAINT fk_AM_Task FOREIGN KEY (TaskID) REFERENCES MaintenanceTasks(TaskID)
);

-- Bakıcı atamaları
-- Tekrar atama senaryosu için AssignmentDate PK'ye eklendi.
CREATE TABLE KeeperAssignments (
    EmployeeID INTEGER,
    AnimalID INTEGER,
    AssignmentDate DATE,
    Responsibilities VARCHAR2(255),
    PRIMARY KEY (EmployeeID, AnimalID, AssignmentDate),
    CONSTRAINT fk_KA_Employee FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    CONSTRAINT fk_KA_Animal FOREIGN KEY (AnimalID) REFERENCES Animals(AnimalID)
);

-- Sunum atamaları (PresentationTime -> TIMESTAMP ve PK'ye dahil)
CREATE TABLE PresentationAssignments (
    EmployeeID INTEGER,
    AnimalID INTEGER,
    PresentationTime TIMESTAMP,
    Duration VARCHAR2(20),
    PRIMARY KEY (EmployeeID, AnimalID, PresentationTime),
    CONSTRAINT fk_PA_Employee FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    CONSTRAINT fk_PA_Animal FOREIGN KEY (AnimalID) REFERENCES Animals(AnimalID)
);

-- Ziyaret planındaki hayvan rotası
CREATE TABLE VisitPlanAnimals (
    PlanID INTEGER,
    AnimalID INTEGER,
    VisitOrder INTEGER,
    SpecialNotes VARCHAR2(255),
    PRIMARY KEY (PlanID, AnimalID),
    CONSTRAINT fk_VPA_Plan FOREIGN KEY (PlanID) REFERENCES VisitPlans(PlanID),
    CONSTRAINT fk_VPA_Animal FOREIGN KEY (AnimalID) REFERENCES Animals(AnimalID)
);

-- İndex önerileri (FK kolonları)
CREATE INDEX idx_animals_typeid      ON Animals(TypeID);
CREATE INDEX idx_animals_enclosureid ON Animals(EnclosureID);
CREATE INDEX idx_animals_sponsorid   ON Animals(SponsorID);

CREATE INDEX idx_feed_animalid       ON FeedingSchedules(AnimalID);
CREATE INDEX idx_visitplans_visitor  ON VisitPlans(VisitorID);

CREATE INDEX idx_am_taskid           ON AnimalMaintenance(TaskID);
CREATE INDEX idx_am_animalid         ON AnimalMaintenance(AnimalID);

CREATE INDEX idx_ka_emp              ON KeeperAssignments(EmployeeID);
CREATE INDEX idx_ka_animal           ON KeeperAssignments(AnimalID);

CREATE INDEX idx_pa_emp              ON PresentationAssignments(EmployeeID);
CREATE INDEX idx_pa_animal           ON PresentationAssignments(AnimalID);

CREATE INDEX idx_vpa_plan            ON VisitPlanAnimals(PlanID);
CREATE INDEX idx_vpa_animal          ON VisitPlanAnimals(AnimalID);

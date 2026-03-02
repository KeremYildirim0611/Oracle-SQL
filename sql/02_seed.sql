-- ===========================================================
-- 02) INSERT INTO ILE TABLOLARA VERI GİRİLMESİ (Seed Data)
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
VALUES (1, 'ABC Corporation', 'Organization', 'Jane Doe', '555-1111', 'jane@abc.com', '100 Corp Blvd', 50000,
        TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2025-12-31', 'YYYY-MM-DD'));

INSERT INTO Sponsors (SponsorID, Name, Type, ContactPerson, ContactNumber, Email, Address, ContributionAmount, StartDate, EndDate)
VALUES (2, 'John Williams', 'Individual', 'John Williams', '555-2222', 'jwilliams@email.com', '200 Rich St', 10000,
        TO_DATE('2023-03-15', 'YYYY-MM-DD'), TO_DATE('2024-03-14', 'YYYY-MM-DD'));

INSERT INTO Sponsors (SponsorID, Name, Type, ContactPerson, ContactNumber, Email, Address, ContributionAmount, StartDate, EndDate)
VALUES (3, 'Wildlife Foundation', 'Organization', 'Robert Green', '555-3333', 'rgreen@wildlife.org', '300 Nature Rd', 75000,
        TO_DATE('2022-11-01', 'YYYY-MM-DD'), TO_DATE('2026-10-31', 'YYYY-MM-DD'));

-- Animals
INSERT INTO Animals (AnimalID, Name, Species, BirthDate, Gender, HealthStatus, AcquisitionDate, Description, Lifespan, DietType, TypeID, EnclosureID, SponsorID)
VALUES (1, 'Leo', 'Lion', TO_DATE('2018-05-10', 'YYYY-MM-DD'), 'Male', 'Good', TO_DATE('2019-06-15', 'YYYY-MM-DD'), 'African lion', '15 years', 'Carnivore', 1, 1, 1);

INSERT INTO Animals (AnimalID, Name, Species, BirthDate, Gender, HealthStatus, AcquisitionDate, Description, Lifespan, DietType, TypeID, EnclosureID, SponsorID)
VALUES (2, 'Ellie', 'Elephant', TO_DATE('2015-03-22', 'YYYY-MM-DD'), 'Female', 'Excellent', TO_DATE('2016-01-10', 'YYYY-MM-DD'), 'African elephant', '60 years', 'Herbivore', 2, 2, 2);

INSERT INTO Animals (AnimalID, Name, Species, BirthDate, Gender, HealthStatus, AcquisitionDate, Description, Lifespan, DietType, TypeID, EnclosureID, SponsorID)
VALUES (3, 'Charlie', 'Chimpanzee', TO_DATE('2017-11-05', 'YYYY-MM-DD'), 'Male', 'Good', TO_DATE('2018-04-20', 'YYYY-MM-DD'), 'Common chimpanzee', '40 years', 'Omnivore', 3, 3, 3);

-- Employees
INSERT INTO Employees (EmployeeID, FirstName, LastName, DateOfBirth, Gender, ContactNumber, Email, Address, HireDate, Position, Salary, EmployeeType)
VALUES (1, 'John', 'Smith', TO_DATE('1985-07-15', 'YYYY-MM-DD'), 'Male', '555-1234', 'john@zoo.com', '123 Park Ave',
        TO_DATE('2015-03-10', 'YYYY-MM-DD'), 'Manager', 65000, 'Administrative');

INSERT INTO Employees (EmployeeID, FirstName, LastName, DateOfBirth, Gender, ContactNumber, Email, Address, HireDate, Position, Salary, EmployeeType)
VALUES (2, 'Sarah', 'Johnson', TO_DATE('1990-02-28', 'YYYY-MM-DD'), 'Female', '555-5678', 'sarah@zoo.com', '456 Zoo Dr',
        TO_DATE('2017-06-22', 'YYYY-MM-DD'), 'Keeper', 45000, 'Keeper');

INSERT INTO Employees (EmployeeID, FirstName, LastName, DateOfBirth, Gender, ContactNumber, Email, Address, HireDate, Position, Salary, EmployeeType)
VALUES (3, 'Mike', 'Brown', TO_DATE('1988-11-12', 'YYYY-MM-DD'), 'Male', '555-9012', 'mike@zoo.com', '789 Animal Ln',
        TO_DATE('2016-09-05', 'YYYY-MM-DD'), 'Guide', 42000, 'Guide');

-- Visitors
INSERT INTO Visitors (VisitorID, FirstName, LastName, Email, ContactNumber, MembershipStatus, RegistrationDate)
VALUES (1, 'Emily', 'Parker', 'emily@email.com', '555-4444', 'Premium', TO_DATE('2023-02-10', 'YYYY-MM-DD'));

INSERT INTO Visitors (VisitorID, FirstName, LastName, Email, ContactNumber, MembershipStatus, RegistrationDate)
VALUES (2, 'David', 'Johnson', 'david@email.com', '555-5555', 'Standard', TO_DATE('2023-05-22', 'YYYY-MM-DD'));

INSERT INTO Visitors (VisitorID, FirstName, LastName, Email, ContactNumber, MembershipStatus, RegistrationDate)
VALUES (3, 'Lisa', 'Wilson', 'lisa@email.com', '555-6666', 'None', TO_DATE('2023-07-05', 'YYYY-MM-DD'));

-- FeedingSchedules (TIMESTAMP)
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
VALUES (1, TO_DATE('2023-08-15', 'YYYY-MM-DD'),
        TO_TIMESTAMP('10:00:00', 'HH24:MI:SS'),
        TO_TIMESTAMP('14:00:00', 'HH24:MI:SS'),
        2, 'Lion feeding view', 1);

INSERT INTO VisitPlans (PlanID, VisitDate, StartTime, EndTime, GroupSize, SpecialRequests, VisitorID)
VALUES (2, TO_DATE('2023-08-20', 'YYYY-MM-DD'),
        TO_TIMESTAMP('09:00:00', 'HH24:MI:SS'),
        TO_TIMESTAMP('12:00:00', 'HH24:MI:SS'),
        4, 'Guided tour', 2);

INSERT INTO VisitPlans (PlanID, VisitDate, StartTime, EndTime, GroupSize, SpecialRequests, VisitorID)
VALUES (3, TO_DATE('2023-08-25', 'YYYY-MM-DD'),
        TO_TIMESTAMP('13:00:00', 'HH24:MI:SS'),
        TO_TIMESTAMP('16:00:00', 'HH24:MI:SS'),
        1, 'Primate presentation', 3);

-- AnimalMaintenance (AssignedDate PK'de)
INSERT INTO AnimalMaintenance (AnimalID, TaskID, AssignedDate, CompletionStatus)
VALUES (1, 1, TO_DATE('2023-08-01', 'YYYY-MM-DD'), 'Completed');

INSERT INTO AnimalMaintenance (AnimalID, TaskID, AssignedDate, CompletionStatus)
VALUES (2, 2, TO_DATE('2023-07-15', 'YYYY-MM-DD'), 'Scheduled');

INSERT INTO AnimalMaintenance (AnimalID, TaskID, AssignedDate, CompletionStatus)
VALUES (3, 3, TO_DATE('2023-08-05', 'YYYY-MM-DD'), 'In Progress');

-- KeeperAssignments (AssignmentDate PK'de)
INSERT INTO KeeperAssignments (EmployeeID, AnimalID, AssignmentDate, Responsibilities)
VALUES (2, 1, TO_DATE('2023-01-10', 'YYYY-MM-DD'), 'Feeding, grooming');

INSERT INTO KeeperAssignments (EmployeeID, AnimalID, AssignmentDate, Responsibilities)
VALUES (2, 2, TO_DATE('2023-01-10', 'YYYY-MM-DD'), 'Feeding, health monitoring');

INSERT INTO KeeperAssignments (EmployeeID, AnimalID, AssignmentDate, Responsibilities)
VALUES (2, 3, TO_DATE('2023-03-15', 'YYYY-MM-DD'), 'Feeding, training');

-- PresentationAssignments (PresentationTime TIMESTAMP ve PK'de)
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

COMMIT;

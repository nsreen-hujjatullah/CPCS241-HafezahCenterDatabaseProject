REM   Script: Session 07
REM   pp

CREATE TABLE Person (PersonSerialNumber number(10) PRIMARY KEY,    
      PersonNationalID varchar2(10) UNIQUE,    
      PersonFname varchar2(50),    
      PersonMname varchar2(50),    
      PersonLname varchar2(50),    
      DoB DATE,    
      PhoneNumber number(16) ,     
      Email varchar2(100),    
      Nationality varchar2(50),    
      Country varchar2(50),     
      City varchar2(50),    
      Neighborhood varchar2(50),     
      HomeLocation varchar2(250),     
      ClosestLandmark varchar2(50) 
);

CREATE TABLE IjazahTeacher (    
    IjazahTeacherSerialNumber number(10) PRIMARY KEY,     
    CONSTRAINT FK_IjazahTeacherSN FOREIGN KEY (IjazahTeacherSerialNumber)     
    REFERENCES Person (PersonSerialNumber)    
    ON DELETE CASCADE   
);

CREATE TABLE IjazahStudent (    
    IjazahStudentSerialNumber number(10) PRIMARY KEY ,    
    CONSTRAINT FK_IjazahStudentSN FOREIGN KEY (IjazahStudentSerialNumber)     
    REFERENCES Person (PersonSerialNumber)    
    ON DELETE CASCADE   
);

CREATE TABLE CommitteeMember (    
    CommitteeMemberSerialNumber number(10) PRIMARY KEY ,    
    CONSTRAINT FK_CommitteeMemberSN FOREIGN KEY (CommitteeMemberSerialNumber)     
    REFERENCES Person (PersonSerialNumber)    
    ON DELETE CASCADE   
);

CREATE TABLE CourseTeacher (    
    CourseTeacherSerialNumber number(10) PRIMARY KEY ,    
    CONSTRAINT FK_CourseTeacherSN FOREIGN KEY (CourseTeacherSerialNumber)     
    REFERENCES Person (PersonSerialNumber)    
    ON DELETE CASCADE   
);

CREATE TABLE CourseStudent (    
    CourseStudentSerialNumber number(10) PRIMARY KEY ,    
    CONSTRAINT FK_CourseStudentSN FOREIGN KEY (CourseStudentSerialNumber)     
    REFERENCES Person (PersonSerialNumber)    
    ON DELETE CASCADE   
);

CREATE TABLE Qeraah_Rewaiah (  
    QeraahRewaiahID number(6) PRIMARY KEY ,  
    QRName varchar2(100)  
);

CREATE TABLE EvaluationTest (  
    EvaluationID number(6) PRIMARY KEY ,  
    EvaluationDay varchar2(20), EvaluationDate DATE  
);

CREATE TABLE Ijazah (     
    IjazahID number(6) PRIMARY KEY ,     
    Mechanism varchar2(50),IjazahStatus varchar2(50),KhatemCode varchar2(15),     
    KhatemNumber number(4) ,KhatemDate DATE, Notes varchar2(250),     
    TeacherSerialNumber number(10), StudentSerialNumber number(10),     
    QeraahRewaiahID number(6),      
    CONSTRAINT CHK_IjazahTeaterStudent CHECK (TeacherSerialNumber != StudentSerialNumber), 
    CONSTRAINT FK_TeacherSerialNum FOREIGN KEY (TeacherSerialNumber)     
    REFERENCES IjazahTeacher (IjazahTeacherSerialNumber),     
    CONSTRAINT FK_StudentSerialNum FOREIGN KEY (StudentSerialNumber)     
    REFERENCES IjazahStudent (IjazahStudentSerialNumber),     
    CONSTRAINT FK_QeraahRewaiahID FOREIGN KEY (QeraahRewaiahID)     
    REFERENCES Qeraah_Rewaiah (QeraahRewaiahID)     
    ON DELETE CASCADE     
 
);

CREATE TABLE CoursesType (  
    TypeID number(6) PRIMARY KEY,  
    CourseTypeName varchar2(50)  
    );

CREATE TABLE Initiatives (  
    InitativeID number(6) PRIMARY KEY,   
    QRName varchar2(50)  
);

CREATE TABLE Courses (     
    CourseID number(6) PRIMARY KEY,     
    StartingDate date,     
    EndingDate date,     
    ClassTime VARCHAR2(50),     
    RequiersInterview varchar2 (3),      
    CONSTRAINT CONSTRAINT_YesNo CHECK (RequiersInterview IN ('Yes','No')), 
    NumOfLectures number (3),     
    CourseProvider varchar2(50),     
    TeacherSerialNumber number(10),     
    InitativeID number(6),     
    TypeID number(6),     
    CONSTRAINT FK_TeacherSerialNum_Courses FOREIGN KEY (TeacherSerialNumber)     
    REFERENCES CourseTeacher (CourseTeacherSerialNumber),     
    CONSTRAINT FK_InitativeID FOREIGN KEY (InitativeID)     
    REFERENCES Initiatives (InitativeID),     
    CONSTRAINT FK_TypeID FOREIGN KEY (TypeID)     
    REFERENCES CoursesType (TypeID)     
    ON DELETE CASCADE     
);

CREATE TABLE CoursesDays (   
    CourseID number(6),      
    CourseDays varchar2(10),     
    CONSTRAINT PK_CoursesDays PRIMARY KEY (CourseID,CourseDays), 
    CONSTRAINT FK_IDCourseDays FOREIGN KEY(CourseID) REFERENCES Courses (CourseID) 
    ON DELETE CASCADE  
);

CREATE TABLE Study (    
    CourseID number(6),     
    StudentSerialNumber number(10),    
    CONSTRAINT PK_Study PRIMARY KEY (CourseID,StudentSerialNumber),    
    CONSTRAINT FK_IDCourse FOREIGN KEY(CourseID)    
    REFERENCES Courses (CourseID),    
    CONSTRAINT FK_StudentSN FOREIGN KEY(StudentSerialNumber)    
    REFERENCES CourseStudent(CourseStudentSerialNumber)    
    ON DELETE CASCADE    
);

CREATE TABLE Evaluation (        
    IjazahID NUMBER(6),        
    IjazahIDEvaluationID NUMBER(6),         
    EvaID NUMBER(6),         
    EvaluationType VARCHAR2(50),         
    EvaluationTime VARCHAR2(50), Surah VARCHAR2(50),         
    TeacherFeedback VARCHAR2(250),         
    CommitteeFeedback VARCHAR2(250),         
    EvaluationResult VARCHAR2(50),         
    CONSTRAINT PK_IjaEvaID PRIMARY KEY (IjazahID, IjazahIDEvaluationID, EvaID),   
    CONSTRAINT FK_IjazahID FOREIGN KEY (IjazahID)      
    REFERENCES Ijazah (IjazahID),   
    CONSTRAINT FK_EvaluationID FOREIGN KEY (IjazahIDEvaluationID)      
    REFERENCES EvaluationTest (EvaluationID), 
    CONSTRAINT con_EvaluationTime UNIQUE(IjazahIDEvaluationID,EvaluationTime) 
);

CREATE TABLE Assigning (    
    CommitteeSerialNumber number(10),    
    IjazahID number(6),    
    IJazahIDEvaluation number(6),    
    EvalID number(6),    
    CONSTRAINT PK_Assigning PRIMARY KEY (CommitteeSerialNumber, IjazahID, IJazahIDEvaluation,EvalID),    
    CONSTRAINT FK_CommitteeSerialNumber FOREIGN KEY (CommitteeSerialNumber)    
    REFERENCES CommitteeMember (CommitteeMemberSerialNumber),    
    CONSTRAINT FK_EvaluationAssigning FOREIGN KEY (IjazahID,IJazahIDEvaluation,EvalID)    
    REFERENCES Evaluation (IjazahID,IjazahIDEvaluationID,EvaID)    
    ON DELETE CASCADE    
    );

create sequence SeqPerson    
start with 1000000000    
increment by 1;

INSERT INTO Person VALUES (  
    SeqPerson.NEXTVAL, '1124481359', 'Deem',   
    'Salem','Alsaed', TO_DATE('22-10-2001', 'DD-MM-YYYY'),  
     547748983, 'deemsa@hotmail.com', 'Saudi', 'KSA','Jeddah','Al-yaqoot',   
     'https://goo.gl/maps/6ux3ZybivXbuS2hV6','Sasco station' 
);

INSERT INTO Person VALUES (  
     SeqPerson.NEXTVAL, '112448160', 'Renad',   
     'Loai','Alghamdi', TO_DATE('09-12-2002', 'DD-MM-YYYY'),  
      547748983, 'renooh3@hotmail.com', 'Saudi', 'KSA','Jeddah',  
      'Al-Naeem', 'https://goo.gl/maps/tPziVdC8LvuVJuqVA','Alnaem mall' 
);

INSERT INTO Person VALUES (  
    SeqPerson.NEXTVAL, '1038472683', 'Rina',   
    'Mohammed','Albarakati',   
    TO_DATE('03-03-1999', 'DD-MM-YYYY'),  
    594670203, 'rralilo@gmail.com', 'Saudi', 'KSA','Jeddah','Alsafa',   
    'https://goo.gl/maps/yF9v9U3wToyZHr5V6','Hyper Panda'  
    );

INSERT INTO Person VALUES (  
    SeqPerson.NEXTVAL, 'L93838C93', 'Zara', 'Saleh','Aljuhani',   
    TO_DATE('01-01-2001', 'DD-MM-YYYY'), 541783483,   
    'zarasaleh@gmail.com', 'Syria', 'KSA','Jeddah','Al-Rawdah',   
    'https://goo.gl/maps/YXpgkMHKvs6Nnuzd8','Mida station'  
    );

INSERT INTO Person VALUES (  
    SeqPerson.NEXTVAL, '1227839012', 'Futoon', 'Ayham','Alsolami',  
    TO_DATE('09-10-1998', 'DD-MM-YYYY'),   
    581720325, 'futoona@gmail.com', 'Saudi',  
    'KSA','Jeddah','Al-Khalidiya',   
    'https://goo.gl/maps/r9BFBssB2Co52rJ68','Sports academy'  
    );

INSERT INTO Person VALUES (  
    SeqPerson.NEXTVAL, '1002732873', 'Shuruq',   
    'Abdulmajeed','Alsharif',   
    TO_DATE('22-10-2001', 'DD-MM-YYYY'), 514838011,   
    'shuoso@gmail.com', 'Saudi',   
    'KSA','Jeddah','Muhammadiyah',   
    'https://goo.gl/maps/DkDcFr7BnBA4HsPi6','Riyadh Bank'  
    );

INSERT INTO Person VALUES (  
    SeqPerson.NEXTVAL, 'N9804C284', 'Raghad', 'Hassan','Khan',   
    TO_DATE('16-09-2000', 'DD-MM-YYYY'), 596258695,   
    'raghadi2006@gmail.com', 'indian', 'KSA','Jeddah',  
    'Obhur', 'https://goo.gl/maps/JxWwYdzHSAVrZ8rT7','Alrajhi Bank'  
    );

INSERT INTO Person VALUES (  
    SeqPerson.NEXTVAL, 'E003279L6', 'Jana', 'Safwan','Nahlawi',   
    TO_DATE('03-02-1997', 'DD-MM-YYYY'), 509778603, 'jooni@hotmail.com',   
    'Egyptian', 'KSA','Jeddah','Al Basateen',   
    'https://goo.gl/maps/611Knf1XUZaW7s29A','Mall'  
    );

INSERT INTO Person VALUES (  
    SeqPerson.NEXTVAL, '1217937974', 'Layan', 'Lilo','Bafarhan',   
    TO_DATE('03-02-1994', 'DD-MM-YYYY'), 584547217,   
    'misslolo@hotmail.com', 'Saudi', 'KSA','Jeddah',' Al-Nahda',   
    'https://goo.gl/maps/YXpIOfmioMHKvs6Nnuzd8','SNB'  
    );

INSERT INTO Person VALUES (  
    SeqPerson.NEXTVAL, '1032877434', 'Zeinab', 'Ahmad',  
    'Almahyawi', TO_DATE('18-09-1983', 'DD-MM-YYYY'), 525554620,  
    'zeinabola@gmail.com', 'Saudi', 'KSA','Jeddah','Alzumurod',   
    'https://goo.gl/maps/tPfoior4vuVJuqVA','Obhur Mall'  
    );

INSERT INTO Person VALUES (  
    SeqPerson.NEXTVAL, '1129835797', 'Malak', 'Mohammed','Alharbi',   
    TO_DATE('23-10-1989', 'DD-MM-YYYY'), 506967499, 'malakmoh@gmail.com',  
    'Saudi', 'KSA','Jeddah','Alsawari',   
    'https://goo.gl/maps/jf299VdC8Lfe32op','Mida station'  
    );

INSERT INTO Person VALUES (  
    SeqPerson.NEXTVAL, '0179378297', 'Salwa', 'Saad','Alghamdi',   
    TO_DATE('10-04-1991', 'DD-MM-YYYY'), 594410111, 'salwasa@gmail.com',   
    'Saudi', 'KSA','Jeddah','Obhur',   
    'https://goo.gl/maps/ewomFB2042jk52r3dw','Obhur Mall'  
    );

INSERT INTO Person VALUES (  
    SeqPerson.NEXTVAL, '0181397327', 'Raghad', 'Yacoub','Algarni',   
    TO_DATE('11-03-1992', 'DD-MM-YYYY'), 572593898,   
    'ragyacoub@gmail.com', 'Saudi', 'KSA','Jeddah','Alolo',   
    'https://goo.gl/maps/soe3Ffojfoiew','Bhadur Resort'  
    );

INSERT INTO Person VALUES (  
    SeqPerson.NEXTVAL, 'P193872K2', 'Jameela', 'Jameel','Zayni',  
    TO_DATE('12-05-1982', 'DD-MM-YYYY'), 503914686,   
    'jameela@gmail.com',   
    'palestinian', 'KSA','Jeddah','Alhamra',   
    'https://goo.gl/maps/fj32o52rJkkowid','Sasco'  
    );

INSERT INTO Person VALUES (  
    SeqPerson.NEXTVAL, '1093284783', 'Asmaa',   
    'Osama','Almaliki', TO_DATE('17-07-1999', 'DD-MM-YYYY'), 548728329,   
    'asmaaosama@gmail.com', 'Saudi',   
    'KSA','Jeddah','Alfadaa',   
    'https://goo.gl/maps/fjiewjfrkfoweijio','SNB' 
);

CREATE sequence SeqQeraahRewaiahID  
start with 1   
increment by 1;

INSERT INTO Qeraah_Rewaiah VALUES (  
    SeqQeraahRewaiahID.NEXTVAL, 'Al-Asher Al-sugra' );

INSERT INTO Qeraah_Rewaiah VALUES (  
    SeqQeraahRewaiahID.NEXTVAL, 'Qaloon An Nafee' );

INSERT INTO Qeraah_Rewaiah VALUES (  
    SeqQeraahRewaiahID.NEXTVAL, 'Warsh An Nafee' );

INSERT INTO Qeraah_Rewaiah VALUES (  
    SeqQeraahRewaiahID.NEXTVAL, 'Nafee Al-Madany' );

INSERT INTO Qeraah_Rewaiah VALUES (  
    SeqQeraahRewaiahID.NEXTVAL, 'Asim Al-Coofey' );

INSERT INTO Qeraah_Rewaiah VALUES (  
    SeqQeraahRewaiahID.NEXTVAL, 'Abu Amr Al-Basry' );

INSERT INTO Qeraah_Rewaiah VALUES (  
    SeqQeraahRewaiahID.NEXTVAL, 'Hamzah Al Coofey' );

INSERT INTO IjazahTeacher VALUES (1000000001);

INSERT INTO IjazahTeacher VALUES (1000000004);

INSERT INTO IjazahTeacher VALUES (1000000006);

INSERT INTO IjazahTeacher VALUES (1000000008);

INSERT INTO IjazahStudent VALUES (1000000001);

INSERT INTO IjazahStudent VALUES (1000000009);

INSERT INTO IjazahStudent VALUES (1000000010);

INSERT INTO IjazahStudent VALUES (1000000012);

INSERT INTO IjazahStudent VALUES (1000000013);

INSERT INTO IjazahStudent VALUES (1000000014);

INSERT INTO CommitteeMember VALUES (1000000000);

INSERT INTO CommitteeMember VALUES (1000000001);

INSERT INTO CommitteeMember VALUES (1000000002);

INSERT INTO CommitteeMember VALUES (1000000004);

INSERT INTO CourseTeacher VALUES (1000000001);

INSERT INTO CourseTeacher VALUES (1000000002);

INSERT INTO CourseTeacher VALUES (1000000006);

INSERT INTO CourseStudent VALUES (1000000001);

INSERT INTO CourseStudent VALUES (1000000003);

INSERT INTO CourseStudent VALUES (1000000005);

INSERT INTO CourseStudent VALUES (1000000007);

INSERT INTO CourseStudent VALUES (1000000009);

INSERT INTO CourseStudent VALUES (1000000011);

INSERT INTO CourseStudent VALUES (1000000013);

CREATE sequence SeqEvaluationID  
start with 100000   
increment by 1;

INSERT INTO EvaluationTest VALUES  
    (SeqEvaluationID.NEXTVAL, 'SUN', TO_DATE('20-07-2020', 'DD-MM-YYYY'));

INSERT INTO EvaluationTest VALUES  
    (SeqEvaluationID.NEXTVAL, 'SUN', TO_DATE('15-01-2021', 'DD-MM-YYYY'));

INSERT INTO EvaluationTest VALUES  
    (SeqEvaluationID.NEXTVAL, 'MON', TO_DATE('17-06-2021', 'DD-MM-YYYY'));

INSERT INTO EvaluationTest VALUES  
    (SeqEvaluationID.NEXTVAL, 'SUN', TO_DATE('08-11-2022', 'DD-MM-YYYY'));

INSERT INTO EvaluationTest VALUES  
    (SeqEvaluationID.NEXTVAL, 'TUSE', TO_DATE('18-04-2023', 'DD-MM-YYYY'));

INSERT INTO EvaluationTest VALUES  
    (SeqEvaluationID.NEXTVAL, 'SUN', TO_DATE('01-09-2023', 'DD-MM-YYYY'));

CREATE sequence SeqIjazah    
start with 100000     
increment by 1;

INSERT INTO Ijazah VALUES   
    (SeqIjazah.NEXTVAL, 'present', 'continuous', null, null, null, null, 1000000004, 1000000001, 1);

INSERT INTO Ijazah VALUES  
    (SeqIjazah.NEXTVAL, 'present', 'complete', 'R.Z.4563', 3, TO_DATE('09-12-2023', 'DD-MM-YYYY'), null, 1000000006, 1000000009, 2);

INSERT INTO Ijazah VALUES  
    (SeqIjazah.NEXTVAL, 'present', 'interrupted', null, null, null, 'student has traveled and cannot continue', 1000000006, 1000000010, 3);

INSERT INTO Ijazah VALUES  
    (SeqIjazah.NEXTVAL, 'present', 'complete', 'F.R.5668', 1, TO_DATE('15-07-2022', 'DD-MM-YYYY'),null, 1000000004, 1000000012, 2);

INSERT INTO Ijazah VALUES  
    (SeqIjazah.NEXTVAL, 'combined', 'continuous', null, null, null, null, 1000000008, 1000000012, 4);

INSERT INTO Ijazah VALUES  
    (SeqIjazah.NEXTVAL, 'present', 'starting', null, null, null, null, 1000000001, 1000000013, 7);

INSERT INTO Ijazah VALUES  
    (SeqIjazah.NEXTVAL, 'combined', 'starting', null, null, null, 'student need to practice more', 1000000001, 1000000014, 7);

CREATE sequence SeqEvaID    
start with 100000     
increment by 1;

INSERT INTO Evaluation VALUES (   
       100000, 100000, SeqEvaID.NEXTVAL, 'new student', '7:00AM', null,  
       'need to practice pronouncing the letter (Raa)', 
       'need to practice pronouncing the letter (Raa & Qaf)', 'Start the Ijazah');

INSERT INTO Evaluation VALUES (    
       100000, 100002, SeqEvaID.NEXTVAL, 'follow-up student', '7:00AM', 'al-nesaa',   
       'need to practice (tide time)',  
       'need to practice pronouncing the letter (Raa)', 'continue');

INSERT INTO Evaluation VALUES (   
       100000, 100005, SeqEvaID.NEXTVAL, 'follow-up student', '9:00AM', 'alkahf',  
       'nothing', 
       'need to practice (tide time)', 'continue');

INSERT INTO Evaluation VALUES (   
       100001, 100001, SeqEvaID.NEXTVAL, 'new student', '7:30AM', null,  
       'need to practice pronouncing the letter (noon)', 
       'need to practice pronouncing the letter (laam & noon)', 'Start, enter next evaluation in surah al-Emraan');

INSERT INTO Evaluation VALUES (    
       100001, 100003, SeqEvaID.NEXTVAL, 'follow-up student', '8:00AM', 'al-Emraan',   
       'need to practice (tide time)',  
       'need to practice (tide time)', 'continuem  enter next evaluation in surah alkahf');

INSERT INTO Evaluation VALUES (   
       100001, 100004, SeqEvaID.NEXTVAL, 'follow-up student', '9:30AM', 'alkahf',  
       'nothing', 
       'Review the tajweed information', 'continue');

INSERT INTO Evaluation VALUES (   
       100001, 100005, SeqEvaID.NEXTVAL, 'follow-up student', '10:00AM', 'al-Ahqaaf',  
       'nothing', 
       'nothing', 'takhtem');

INSERT INTO Evaluation VALUES (   
       100002, 100002, SeqEvaID.NEXTVAL, 'new student', '10:00AM', null,  
       'need to practice pronouncing the letter (haa) & (tide time)', 
       'need to practice pronouncing the letter (haa & noon)', 'Start, enter next evaluation in surah al-Baqarah');

INSERT INTO Evaluation VALUES (    
       100002, 100003, SeqEvaID.NEXTVAL, 'follow-up student', '8:15AM', 'al-Baqarah',   
       'need to practice (tide time)',  
       'need to practice (tide time) & Review the tajweed information', 'continuem  enter next evaluation in surah Al-Nesaa');

INSERT INTO Evaluation VALUES (   
       100003, 100000, SeqEvaID.NEXTVAL, 'new student', '11:00AM', null,  
       'need to practice pronouncing the letter (noon & raa)', 
       'need to practice pronouncing the letter(noon & raa)', 'Start');

INSERT INTO Evaluation VALUES (    
       100003, 100001, SeqEvaID.NEXTVAL, 'follow-up student', '11:00AM', 'alkahf',   
       'need to practice pronouncing the letter (raa)',  
       'need to practice pronouncing the letter (raa)', 'continue');

INSERT INTO Evaluation VALUES (   
       100003, 100002, SeqEvaID.NEXTVAL, 'follow-up student', '9:45AM', 'alkahf',  
       'nothing', 
       'need to practice pronouncing the letter (raa)', 'takhtem');

INSERT INTO Evaluation VALUES (   
       100004, 100003, SeqEvaID.NEXTVAL, 'new student', '7:45AM', null,  
       'nothing', 
       'need to practice pronouncing the letter (raa)', 'Start');

INSERT INTO Evaluation VALUES (   
       100004, 100004, SeqEvaID.NEXTVAL, 'follow-up student', '9:45AM', 'al-maeedah', 
       'nothing', 
       'nothing', 'continue');

INSERT INTO Evaluation VALUES (   
       100005, 100004, SeqEvaID.NEXTVAL, 'new student', '11:30AM', null,  
       'need to practice pronouncing the letter (haa & raa)', 
       'need to practice pronouncing the letter(noon, qaaf, lam, & raa), Also review the tajweed information', 'Do not start, practice and re-test');

INSERT INTO Evaluation VALUES (   
       100006, 100004, SeqEvaID.NEXTVAL, 'new student', '11:45AM', null,  
       'need to practice (tide time)', 
       'need to practice (tide time)', 'Start');

CREATE sequence SeqInitativeID  
start with 100000     
increment by 1;

INSERT INTO Initiatives VALUES ( 
    SeqInitativeID.NEXTVAL, 'Shmoos Alquraa' 
);

INSERT INTO Initiatives VALUES ( 
    SeqInitativeID.NEXTVAL, 'Albudoor Al-zaherah' 
);

INSERT INTO Initiatives VALUES ( 
    SeqInitativeID.NEXTVAL, 'Maraqee' 
);

CREATE sequence SeqIypeID  
start with 100000     
increment by 1;

INSERT INTO CoursesType VALUES ( 
    SeqIypeID.NEXTVAL, 'Qefayat Aleqraa' 
);

INSERT INTO CoursesType VALUES ( 
    SeqIypeID.NEXTVAL, 'Manzomah Al-shatibiah' 
);

INSERT INTO CoursesType VALUES ( 
    SeqIypeID.NEXTVAL, 'Manzomah Al-Durahh' 
);

INSERT INTO CoursesType VALUES ( 
    SeqIypeID.NEXTVAL, 'tathbeet Almushaf' 
);

INSERT INTO CoursesType VALUES ( 
    SeqIypeID.NEXTVAL, 'Manzomah Al-tiybah' 
);

INSERT INTO CoursesType VALUES ( 
    SeqIypeID.NEXTVAL, 'Qefayat tajweedyah' 
);

CREATE sequence SeqCourseID  
start with 100000     
increment by 1;

INSERT INTO Courses VALUES ( 
    SeqCourseID.NEXTVAL,  
    TO_DATE('01-01-2022', 'DD-MM-YYYY'), TO_DATE('30-11-2022', 'DD-MM-YYYY'), '07:00 - 09:00PM', 
    'No', 45, 'hafizah center', 1000000001, 100000, 100004 
);

INSERT INTO Courses VALUES (  
    SeqCourseID.NEXTVAL,   
    TO_DATE('01-01-2023', 'DD-MM-YYYY'), TO_DATE('05-01-2023', 'DD-MM-YYYY'), '06:00 - 08:00AM',  
    'Yes', 5, 'Masjed Al-Noor', 1000000006, 100000, 100001  
);

INSERT INTO Courses VALUES ( 
    SeqCourseID.NEXTVAL,  
    TO_DATE('01-01-2023', 'DD-MM-YYYY'), TO_DATE('17-01-2025', 'DD-MM-YYYY'), '06:00 - 08:00AM', 
    'Yes', 120, 'hafizah center', 1000000002, 100000, 100002 
);

INSERT INTO Courses VALUES ( 
    SeqCourseID.NEXTVAL,  
    TO_DATE('01-01-2023', 'DD-MM-YYYY'), TO_DATE('30-11-2024', 'DD-MM-YYYY'), '02:00 - 04:00PM', 
    'No', 90, 'hafizah center', 1000000001, 100001, 100003 
);

INSERT INTO Courses VALUES (  
    SeqCourseID.NEXTVAL,   
    TO_DATE('01-06-2023', 'DD-MM-YYYY'), TO_DATE('05-07-2023', 'DD-MM-YYYY'), '06:00 - 08:00AM',  
    'Yes', 10, 'Dar Al-Huda', 1000000006, 100002, 100005  
);

INSERT INTO Courses VALUES ( 
    SeqCourseID.NEXTVAL,  
    TO_DATE('01-01-2023', 'DD-MM-YYYY'), TO_DATE('17-01-2025', 'DD-MM-YYYY'), '05:00 - 07:00AM', 
    'Yes', 120, 'hafizah center', 1000000002, 100002, 100000 
);

INSERT INTO CoursesDays VALUES( 
    100000, 'SUNDAY' 
);

INSERT INTO CoursesDays VALUES( 
    100001, 'SUNDAY' 
);

INSERT INTO CoursesDays VALUES( 
    100001, 'MONDAAY' 
);

INSERT INTO CoursesDays VALUES( 
    100001, 'TUSEDAY' 
);

INSERT INTO CoursesDays VALUES( 
    100001, 'WEDNESDAY' 
);

INSERT INTO CoursesDays VALUES( 
    100001, 'THURSDAY' 
);

INSERT INTO CoursesDays VALUES( 
    100002, 'WEDNESDAY' 
);

INSERT INTO CoursesDays VALUES( 
    100005, 'MONDAY' 
);

INSERT INTO CoursesDays VALUES( 
    100003, 'SUNDAY' 
);

INSERT INTO CoursesDays VALUES( 
    100003, 'THURSDAY' 
);

INSERT INTO CoursesDays VALUES( 
    100004, 'MONDAY' 
);

INSERT INTO CoursesDays VALUES( 
    100004, 'WEDNESDAY' 
);

INSERT INTO Assigning VALUES ( 
    1000000000, 100000, 100000, 100000 
);

INSERT INTO Assigning VALUES ( 
    1000000001, 100000, 100000, 100000 
);

INSERT INTO Assigning VALUES ( 
    1000000002, 100000, 100000, 100000 
);

INSERT INTO Assigning VALUES ( 
    1000000000, 100000, 100002, 100001 
);

INSERT INTO Assigning VALUES ( 
    1000000001, 100000, 100002, 100001 
);

INSERT INTO Assigning VALUES ( 
    1000000002, 100000, 100002, 100001 
);

INSERT INTO Assigning VALUES ( 
    1000000000, 100000, 100005, 100002 
);

INSERT INTO Assigning VALUES ( 
    1000000001, 100000, 100005, 100002 
);

INSERT INTO Assigning VALUES ( 
    1000000002, 100000, 100005, 100002 
);

INSERT INTO Assigning VALUES ( 
    1000000000, 100001, 100001, 100003 
);

INSERT INTO Assigning VALUES ( 
    1000000001, 100001, 100001, 100003 
);

INSERT INTO Assigning VALUES ( 
    1000000002, 100001, 100001, 100003 
);

INSERT INTO Assigning VALUES ( 
    1000000000, 100001, 100003, 100004 
);

INSERT INTO Assigning VALUES ( 
    1000000001, 100001, 100003, 100004 
);

INSERT INTO Assigning VALUES ( 
    1000000002, 100001, 100003, 100004 
);

INSERT INTO Assigning VALUES ( 
    1000000000, 100001, 100004, 100005 
);

INSERT INTO Assigning VALUES ( 
    1000000001, 100001, 100004, 100005 
);

INSERT INTO Assigning VALUES ( 
    1000000002, 100001, 100004, 100005 
);

INSERT INTO Assigning VALUES ( 
    1000000000, 100001, 100005, 100006 
);

INSERT INTO Assigning VALUES ( 
    1000000001, 100001, 100005, 100006 
);

INSERT INTO Assigning VALUES ( 
    1000000002, 100001, 100005, 100006 
);

INSERT INTO Assigning VALUES ( 
    1000000000, 100002, 100002, 100007 
);

INSERT INTO Assigning VALUES ( 
    1000000001, 100002, 100002, 100007 
);

INSERT INTO Assigning VALUES ( 
    1000000002, 100002, 100002, 100007 
);

INSERT INTO Assigning VALUES ( 
    1000000000, 100002, 100003, 100008 
);

INSERT INTO Assigning VALUES ( 
    1000000001, 100002, 100003, 100008 
);

INSERT INTO Assigning VALUES ( 
    1000000002, 100002, 100003, 100008 
);

INSERT INTO Assigning VALUES ( 
    1000000000, 100003, 100000, 100009 
);

INSERT INTO Assigning VALUES ( 
    1000000001, 100003, 100000, 100009 
);

INSERT INTO Assigning VALUES ( 
    1000000002, 100003, 100000, 100009 
);

INSERT INTO Assigning VALUES ( 
    1000000000, 100003, 100001, 100010 
);

INSERT INTO Assigning VALUES ( 
    1000000001, 100003, 100001, 100010 
);

INSERT INTO Assigning VALUES ( 
    1000000002, 100003, 100001, 100010 
);

INSERT INTO Assigning VALUES ( 
    1000000000, 100003, 100002, 100011 
);

INSERT INTO Assigning VALUES ( 
    1000000001, 100003, 100002, 100011 
);

INSERT INTO Assigning VALUES ( 
    1000000002, 100003, 100002, 100011 
);

INSERT INTO Assigning VALUES ( 
    1000000000, 100004, 100003, 100012 
);

INSERT INTO Assigning VALUES ( 
    1000000001, 100004, 100003, 100012 
);

INSERT INTO Assigning VALUES ( 
    1000000002, 100004, 100003, 100012 
);

INSERT INTO Assigning VALUES ( 
    1000000000, 100004, 100004, 100013 
);

INSERT INTO Assigning VALUES ( 
    1000000001, 100004, 100004, 100013 
);

INSERT INTO Assigning VALUES ( 
    1000000002, 100004, 100004, 100013 
);

INSERT INTO Assigning VALUES ( 
    1000000000, 100005, 100004, 100014 
);

INSERT INTO Assigning VALUES ( 
    1000000001, 100005, 100004, 100014 
);

INSERT INTO Assigning VALUES ( 
    1000000002, 100005, 100004, 100014 
);

INSERT INTO Assigning VALUES ( 
    1000000000, 100006, 100004, 100015 
);

INSERT INTO Assigning VALUES ( 
    1000000001, 100006, 100004, 100015 
);

INSERT INTO Assigning VALUES ( 
    1000000002, 100006, 100004, 100015 
);

INSERT INTO Person VALUES (  
    SeqPerson.NEXTVAL, '1226838092', 'Layla', 'Ayham',' Alsulaymani',  
    TO_DATE('09-10-1996', 'DD-MM-YYYY'),   
    579003595, 'LaylaA@gmail.com', 'Saudi',  
    'KSA','Jeddah','Al-Murjan',   
    ' https://maps.app.goo.gl/AdGkJg7N4w2dwroS9?g_st=ic','Duaar alnaafura ' 
    );

INSERT INTO Person VALUES (  
    SeqPerson.NEXTVAL, '1722783501', 'Reim', 'Salih','Saeid',  
    TO_DATE('04-08-1986', 'DD-MM-YYYY'),   
    579090332, ' Reim@gmail.com', 'Saudi',  
    'KSA','Jeddah','Al-Murjan',   
    'https://maps.app.goo.gl/AdGkJg7N4kbklkk','Duaar alnaafura '  
    );

INSERT INTO Person VALUES (  
    SeqPerson.NEXTVAL, '1787635019', 'Hadeel', 'Ali',' Alqarni',  
    TO_DATE('05-05-1999', 'DD-MM-YYYY'),   
    579020705, 'Hadeel@gmail.com', 'Saudi',  
    'KSA','Jeddah','Al-Murjan',   
    'https://maps.app.goo.gl/AdGkJg7hbw2dwr','Jarir Bookstore'  
    );

INSERT INTO Person VALUES (  
    SeqPerson.NEXTVAL, '1488935059', 'Shahad', 'Maher',' Alqarni',  
    TO_DATE('05-09-1990', 'DD-MM-YYYY'),   
    579020705, 'Shahad_m@gmail.com', 'Saudi',  
    'KSA','Jeddah','Al-Murjan',   
    'https://maps.app.goo.gl/AdGki7hbw2dwr',' Obhur Police Station '  
    );

INSERT INTO Person VALUES (  
    SeqPerson.NEXTVAL, '1788036039', 'Awatif', 'Maher',' Muhammad',  
    TO_DATE('04-09-1980', 'DD-MM-YYYY'),   
    577029705, 'Awatif_m@gmail.com', 'Saudi',  
    'KSA','Jeddah','Al-faysalia',   
    'https://maps.app.goo.gl/V9ZVc2hqTGVXK9Sx7?g_st=ic','Duaar-Aldaraaja'  
    );

SELECT * 
FROM Evaluation e, Ijazah i , IjazahStudent s, person p   
WHERE e.IjazahID=i.IjazahID  
and i.StudentSerialNumber =s.IjazahStudentSerialNumber 
and s.IjazahStudentSerialNumber= p.PersonSerialNumber 
and e.TeacherFeedback= 'need to practice pronouncing the letter (Raa)' ;

INSERT INTO Person VALUES (   
     SeqPerson.NEXTVAL, '015647564', 'Sara',    
     'Mohammed','Alghamdi', TO_DATE('09-12-2001', 'DD-MM-YYYY'),   
      566729098, 'sarah33@hotmail.com', 'Saudi', 'KSA','Jeddah',   
      'Al-Naeem', 'https://goo.gl/maps/tPziVdC8LvuVJuqVA','NSB'  
);

INSERT INTO Person VALUES (   
     SeqPerson.NEXTVAL, '014447564', 'Salma',    
     'Hassan','Alharbi', TO_DATE('20-12-2001', 'DD-MM-YYYY'),   
      566729078, 'salmah4@hotmail.com', 'Saudi', 'KSA','Jeddah',   
      'Obhur', 'https://goo.gl/maps/tsziVsfeLvuVJuqVA','Hyperpanda'  
);

INSERT INTO Person VALUES (   
     SeqPerson.NEXTVAL, '016667564', 'Raghad',    
     'Abduallah','Alghamdi', TO_DATE('11-11-2001', 'DD-MM-YYYY'),   
      566734598, 'Raghadalgh@hotmail.com', 'Saudi', 'KSA','Jeddah',   
      'Al-Naeem', 'https://goo.gl/maps/tkziVdawvvuVJuqVA','Naqaa Gas station'  
);

INSERT INTO Person VALUES (   
     SeqPerson.NEXTVAL, '017777564', 'Sarah',    
     'Osama','Alqarni', TO_DATE('08-09-2001', 'DD-MM-YYYY'),   
      566720008, 'sarahalgqarni@hotmail.com', 'Saudi', 'KSA','Jeddah',   
      'Al-murjan', 'https://goo.gl/maps/tlzkldC8LvuVJuqVA','Alinmaa'  
);

INSERT INTO Person VALUES (   
     SeqPerson.NEXTVAL, '018887564', 'Ola',    
     'Hamad','Alharthi', TO_DATE('08-09-1999', 'DD-MM-YYYY'),   
      566720008, 'Ola1999@hotmail.com', 'Saudi', 'KSA','Jeddah',   
      'Al-yaqoot', 'https://goo.gl/maps/tlzkldC8LvuVJuqVA','NSB'  
);

INSERT INTO CourseStudent VALUES (1000000015);

INSERT INTO CourseStudent VALUES (1000000016);

INSERT INTO CourseStudent VALUES (1000000017);

INSERT INTO CourseStudent VALUES (1000000018);

INSERT INTO CourseStudent VALUES (1000000019);

INSERT INTO CourseStudent VALUES (1000000020);

INSERT INTO CourseStudent VALUES (1000000021);

INSERT INTO CourseStudent VALUES (1000000022);

INSERT INTO CourseStudent VALUES (1000000023);

INSERT INTO CourseStudent VALUES (1000000024);

INSERT INTO Study VALUES (100000,1000000015);

INSERT INTO Study VALUES (100000,1000000016);

INSERT INTO Study VALUES (100000,1000000017);

INSERT INTO Study VALUES (100000,1000000018);

INSERT INTO Study VALUES (100000,1000000019);

INSERT INTO Study VALUES (100001,1000000020);

INSERT INTO Study VALUES (100001,1000000021);

INSERT INTO Study VALUES (100001,1000000022);

INSERT INTO Study VALUES (100001,1000000023);

INSERT INTO Study VALUES (100001,1000000024);

INSERT INTO Study VALUES (100002,1000000020);

INSERT INTO Study VALUES (100002,1000000022);

INSERT INTO Study VALUES (100002,1000000024);

INSERT INTO Study VALUES (100003,1000000015);

INSERT INTO Study VALUES (100003,1000000020);

INSERT INTO Study VALUES (100003,1000000023);

INSERT INTO Study VALUES (100004,1000000015);

INSERT INTO Study VALUES (100004,1000000016);

INSERT INTO Study VALUES (100004,1000000017);

INSERT INTO Study VALUES (100004,1000000018);

INSERT INTO Study VALUES (100004,1000000019);

INSERT INTO Study VALUES (100004,1000000020);

INSERT INTO Study VALUES (100005,1000000020);

INSERT INTO Study VALUES (100005,1000000021);

INSERT INTO Study VALUES (100005,1000000022);

INSERT INTO Study VALUES (100005,1000000023);

INSERT INTO Study VALUES (100005,1000000024);

SELECT ct.CourseTypeName, pe.PersonFname || ' ' || pe.PersonLname as TeacherName 
FROM   courses co, CoursesType ct, Person pe 
WHERE  co.TeacherSerialNumber = pe.PersonSerialNumber  
        AND co.TypeID = ct.TypeID 
        AND co.CourseProvider like ('hafizah center');

SELECT p.PERSONFNAME || ' ' || p.PERSONLNAME as StudentName , e.IJAZAHID, e.EVALUATIONTYPE, e.TEACHERFEEDBACK, e.COMMITTEEFEEDBACK 
FROM Evaluation e, Ijazah i , IjazahStudent s, person p    
WHERE e.IjazahID=i.IjazahID   
AND i.StudentSerialNumber =s.IjazahStudentSerialNumber  
AND s.IjazahStudentSerialNumber= p.PersonSerialNumber  
AND e.COMMITTEEFEEDBACK like '%tide time%';

SELECT * from EvaluationTest 
WHERE EVALUATIONDATE > to_date('31-12-2020', 'dd-mm-yyyy') 
AND EVALUATIONDAY= 'SUN';

SELECT co.CourseID, ct.CourseTypeName, numberOfStudents  
from CoursesType ct, Courses co, (SELECT st.CourseID AS CouID, COUNT(st.StudentSerialNumber) AS numberOfStudents 
                                  FROM Study st 
                                  GROUP BY CourseID) 
WHERE co.TypeID = ct.TypeID AND co.CourseID = CouID 
ORDER BY co.CourseID;

select * from Person;

SELECT COURSEID,CLASSTIME,COURSEPROVIDER, 
CASE COURSEID 
    WHEN 100001 then 'Online' 
    WHEN 100004 then 'Combined' 
    ELSE 'present' 
    END "Mechanism" 
FROM courses;


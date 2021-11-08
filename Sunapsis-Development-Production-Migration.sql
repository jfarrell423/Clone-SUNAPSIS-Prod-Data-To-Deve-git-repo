-- ****************************************************************************
-- ****************************************************************************
-- ****************************************************************************
-- ****************************************************************************
-- ****************************************************************************
--      WARNING! This script is meant to be run in a Development Environment
--       to Anonymize Production International Services data in Development
--             Created 2021-09 Jerry Farrell OIT Business Applications
--          This script is being created for the Center for Global Engagement
--             WARNING!!! Run this script at your own risk.
--             Backup all data before executing this script!
-- ****************************************************************************
-- ****************************************************************************
-- ****************************************************************************
-- ****************************************************************************
-- ****************************************************************************
--  This script is created to anonymize a copy of Production SUNAPSIS DB.
--  To change the data to be used in a development or test environment.
--  This script does not touch all student tables as UTK does not make use of
--  all the tables in the database. This script may need to be reviewed bfore
--  each use to see if the table status has changed as in being used by 
--  the university.
-- ****************************************************************************
-- ****************************************************************************
-- ****************************************************************************
-- ****************************************************************************
-- ****************************************************************************
USE [InternationalServices]
-- ****************************************************************************
--  Configure Variables to use by the script.
-- ****************************************************************************
   DECLARE @SUNAPSISPROD  CHAR(4);
   DECLARE @SUNAPSISTEST  CHAR(4);
   DECLARE @SERVERPROD    CHAR(13);
   DECLARE @SERVERTEST    CHAR(19);
   DECLARE @CGEDEVMAIL    CHAR(18);
   DECLARE @CGEDEVBIRTH   CHAR(12);
   DECLARE @CGESSNDEV     CHAR(12);
-- ****************************************************************************
--  These values are being used in the queries below. 
-- ****************************************************************************
-- Use the prod server value in [dbo].[configSunapsisEnvironment].[instance]
   SET @SUNAPSISPROD = 'PROD';
-- Use the deve server value in [dbo].[configSunapsisEnvironment].[instance]
   SET @SUNAPSISTEST = 'TEST';
-- Use the prod server value in [dbo].[configIOfficeBasePath].[systemValue]   
   SET @SERVERPROD   = 'ivols.sunapsisprod.edu';
-- Use the deve server value in [dbo].[configIOfficeBasePath].[systemValue]   
   SET @SERVERTEST   = 'ivols.sunapsisdeve.edu';
-- User the department group email for testing
   SET @CGEDEVMAIL   = 'ischolars@sunapsisdev.edu';
-- Use a generic date for all student's birthdates
   SET @CGEDEVBIRTH  = '1942-07-28';
-- Use a generic SSN for all student's
   SET @CGESSNDEV    = '123-12-1234';
-- ****************************************************************************
--  Change environment setting to TEST from PROD in the DB
-- ****************************************************************************
PRINT(N'Updating Machine Instance rows in [dbo].[configSunapsisEnvironment]');

UPDATE [dbo].[configSunapsisEnvironment]
   SET [instance] = @SUNAPSISTEST
 WHERE [module] = 'IOM'
        and   [instance] = @SUNAPSISPROD
-- ****************************************************************************
-- ****************************************************************************
-- Set the machine name in the DB.
-- ****************************************************************************
-- ****************************************************************************
PRINT(N'Updating Machine Name rows in [dbo].[configIOfficeBasePath]');

UPDATE [dbo].[configIOfficeBasePath]
   SET [systemValue] = @SERVERTEST
      ,[clientValue] = @SERVERTEST
 WHERE [systemValue] = @SERVERPROD
    and[clientValue] = @SERVERPROD

-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[extractjbDependent]
-- ****************************************************************************
PRINT(N'Updating Name rows in [InternationalServices].[dbo].[extractjbDependent]');

UPDATE [InternationalServices].[dbo].[extractjbDependent]
       SET [famname]            = [idnumber], 
	       [givname]            = [idnumber], 
	       [dob]                = @CGEDEVBIRTH ,
	       [email]              = @CGEDEVMAIL,
           [sevisPreferredName] = [idnumber],
           [sevisPassportName]  = [idnumber],
           [dob]                = @CGEDEVBIRTH
WHERE  [idnumber] =  [idnumber];

-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[formI129]
-- ****************************************************************************
PRINT(N'Updating Name rows in [InternationalServices].[dbo].[formI129]');

UPDATE [InternationalServices].[dbo].[formI129]
       SET [firstname] = [idnumber], 
           [midname]   = [idnumber], 
           [lastname]  = [idnumber],
           [dob]       = @CGEDEVBIRTH
WHERE  [idnumber] =  [idnumber];


-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[formI129DataCollection]
-- ****************************************************************************
PRINT(N'Updating Name rows in [InternationalServices].[dbo].[formI129DataCollection]');

UPDATE [InternationalServices].[dbo].[formI129DataCollection]
       SET [firstname] = [idnumber], [midname] = [idnumber], [lastname] = [idnumber]
WHERE  [idnumber] =  [idnumber];

-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[formI129FTSup]
-- ****************************************************************************
PRINT(N'Updating Name rows in [InternationalServices].[dbo].[formI129FTSup]');

UPDATE [InternationalServices].[dbo].[formI129FTSup]
       SET [lastName]             = [idnumber], 
	       [firstName]            = [idnumber], 
	       [midName]              = [idnumber], 
	       [signerName]           = [idnumber],
	       [signerLastName]       = [idnumber],
	       [signerFirstName]      = [idnumber],
	       [signerEmail]          = @CGEDEVMAIL,
	       [preparerFirstName]    = [idnumber],
	       [preparerLastName]     = [idnumber],
	       [preparerEmail]        = @CGEDEVMAIL
WHERE  [idnumber] =  [idnumber];

-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[extractjbNames]
-- ****************************************************************************
PRINT(N'Updating Name rows in [InternationalServices].[dbo].[extractjbNames]');

UPDATE [InternationalServices].[dbo].[extractjbNames]
       SET [name1]            = [idnumber], 
	       [name2]            = [idnumber], 
--	       [name3]            = [idnumber], This column is missing from the table??
	       [name4]            = [idnumber]
WHERE  [idnumber] =  [idnumber];

-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[formI129H] 
-- ****************************************************************************
PRINT(N'Updating Name rows in [InternationalServices].[dbo].[formI129H]');
UPDATE [InternationalServices].[dbo].[formI129H]
       SET [firstname] = [idnumber], [midname] = [idnumber], [lastname] = [idnumber]
WHERE  [idnumber] =  [idnumber];

-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[formI129OP]
-- ****************************************************************************
PRINT(N'Updating Name rows in [InternationalServices].[dbo].[formI129OP]');

UPDATE [InternationalServices].[dbo].[formI129OP]
       SET [lastName]             = [idnumber], 
	       [firstName]            = [idnumber], 
	       [midName]              = [idnumber], 
	       [signerMiddleName]     = [idnumber],
	       [signerLastName]       = [idnumber],
	       [signerFirstName]      = [idnumber],
	       [signerEmail]          = @CGEDEVMAIL
WHERE  [idnumber] =  [idnumber];

-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[formI131]
-- ****************************************************************************
PRINT(N'Updating Name rows in [InternationalServices].[dbo].[formI131]');

UPDATE [InternationalServices].[dbo].[formI131]
       SET [lastName]                 = [idnumber], 
	       [firstName]                = [idnumber], 
	       [midName]                  = [idnumber], 
		   [dob]                      = @CGEDEVBIRTH,
		   [ssn]                      = @CGESSNDEV,
           [submitterLastName]        = [idnumber], 
	       [submitterFirstName]       = [idnumber], 
	       [submitterMidName]         = [idnumber], 
		   [submitterDob]             = @CGEDEVBIRTH,
	       [personSubmittingrequest] = [idnumber]
WHERE  [idnumber] =  [idnumber];

-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[formI140] 
-- ****************************************************************************
PRINT(N'Updating Name rows in [InternationalServices].[dbo].[formI140]');

UPDATE [InternationalServices].[dbo].[formI140]
       SET [alienFirstname] = [idnumber]
          ,[alienMidName]   = [idnumber]
          ,[alienLastName]  = [idnumber]
          ,[firstName]      = [idnumber]
          ,[midName]        = [idnumber]
          ,[lastName]       = [idnumber]
          ,[dob1]           = @CGEDEVBIRTH
          ,[dob2]           = @CGEDEVBIRTH
          ,[dob3]           = @CGEDEVBIRTH
          ,[dob4]           = @CGEDEVBIRTH
          ,[dob5]           = @CGEDEVBIRTH
          ,[dob6]           = @CGEDEVBIRTH
WHERE  [idnumber] =  [idnumber];

-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[formI485] 
-- ****************************************************************************
PRINT(N'Updating Name rows in [InternationalServices].[dbo].[formI485]');

UPDATE [InternationalServices].[dbo].[formI485]
       SET 
	       [firstName] = [idnumber], 
		   [midName] = [idnumber], 
		   [lastName] = [idnumber],
		   [lastNameOther1] = [idnumber],
		   [firstNameOther1] = [idnumber],
		   [midNameOther1] = [idnumber],
		   [lastNameOther2] = [idnumber],
		   [firstNameOther2] = [idnumber],
		   [midNameOther2] = [idnumber],
		   [lastNameOther3] = [idnumber],
		   [lastNameI94] = [idnumber],
		   [firstNameI94] = [idnumber],
		   [midNameI94] = [idnumber],
           [lastNamePrincipalApplicant] = [idnumber],
		   [firstNamePrincipalApplicant] = [idnumber],
		   [midNamePrincipalApplicant] = [idnumber],
		   [lastNameParent1] = [idnumber],
		   [firstNameParent1] = [idnumber],
		   [midNameParent1] = [idnumber],
		   [lastNameParent2] = [idnumber],
		   [firstNameParent2] = [idnumber],
		   [midNameParent2] = [idnumber],
		   [lastNameOtherParent1] = [idnumber],
		   [firstNameOtherParent1] = [idnumber],
		   [midNameOtherParent1] = [idnumber],
		   [lastNameOtherParent2] = [idnumber],
		   [firstNameOtherParent2] = [idnumber],
		   [midNameOtherParent2] = [idnumber],
		   [lastNameSpouse] = [idnumber],
		   [firstNameSpouse] = [idnumber],
		   [midNameSpouse] = [idnumber],
		   [lastNameEx] = [idnumber],
		   [firstNameEx] = [idnumber],
		   [midNameEx] = [idnumber],
		   [child1LastName] = [idnumber],
		   [child1FirstName] = [idnumber],
		   [child1MidName] = [idnumber],
		   [child2LastName] = [idnumber],
		   [child2FirstName] = [idnumber],
		   [child2MidName] = [idnumber],
		   [child3LastName] = [idnumber],
		   [child3FirstName] = [idnumber],
		   [child3MidName] = [idnumber],
		   [interpreterLastName] = [idnumber],
		   [interpreterFirstName] = [idnumber],
		   [preparerLastName] = [idnumber],
		   [preparerFirstName] = [idnumber]
WHERE  [idnumber] =  [idnumber];

-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[formI485supj] 
-- ****************************************************************************
PRINT(N'Updating Name rows in [InternationalServices].[dbo].[formI485supj]');

UPDATE [InternationalServices].[dbo].[formI485supj]
       SET [employerPreparerFirstname]            = [idnumber]
          ,[employerPreparerLastName]             = [idnumber]
          ,[employerAuthorizedSignatoryFirstname] = [idnumber]
          ,[employerAuthorizedSignatoryLastName]  = [idnumber]
          ,[employerFirstName]                    = [idnumber]
          ,[employerLastName]                     = [idnumber]
          ,[employerMiddleName]                   = [idnumber]
          ,[firstName]                            = [idnumber]
          ,[midName]                              = [idnumber]
          ,[lastName]                             = [idnumber]
          ,[dob]                                  = @CGEDEVBIRTH
           ,[applicantEmailAddress]               = @CGEDEVMAIL
WHERE  [idnumber] =  [idnumber];

-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[formI539]
-- ****************************************************************************
PRINT(N'Updating Name rows in [InternationalServices].[dbo].[formI539');

UPDATE [InternationalServices].[dbo].[formI539]
       SET [lastName]                = [idnumber], 
	       [firstName]               = [idnumber], 
	       [midName]                 = [idnumber], 
		   [dob]                     = @CGEDEVBIRTH,
		   [ssn]                     = @CGESSNDEV,
           [interpreterLastName]     = [idnumber], 
	       [interpreterFirstName]    = [idnumber], 
	       [interpreterBusinessName] = [idnumber], 
           [preparerLastName]        = [idnumber], 
	       [preparerFirstName]       = [idnumber], 
	       [preparerBusinessName]    = [idnumber], 
           [person1LastName]         = [idnumber], 
	       [person1FirstName]        = [idnumber], 
	       [person1MidName]          = [idnumber],
	       [person1dob]              = @CGEDEVBIRTH ,
	       [person1ssn]              = @CGESSNDEV ,
           [person2LastName]         = [idnumber], 
	       [person2FirstName]        = [idnumber], 
	       [person2MidName]          = [idnumber],
	       [person2dob]              = @CGEDEVBIRTH ,
	       [person2ssn]              = @CGESSNDEV ,
           [person3LastName]         = [idnumber], 
	       [person3FirstName]        = [idnumber], 
	       [person3MidName]          = [idnumber],
	       [person3dob]              = @CGEDEVBIRTH ,
	       [person3ssn]              = @CGESSNDEV ,
           [person4LastName]         = [idnumber], 
	       [person4FirstName]        = [idnumber], 
	       [person4MidName]          = [idnumber],
	       [person4dob]              = @CGEDEVBIRTH ,
	       [person4ssn]              = @CGESSNDEV ,
           [person5LastName]         = [idnumber], 
	       [person5FirstName]        = [idnumber], 
	       [person5MidName]          = [idnumber],
	       [person5dob]              = @CGEDEVBIRTH ,
	       [person5ssn]              = @CGESSNDEV ,
           [person6LastName]         = [idnumber], 
	       [person6FirstName]        = [idnumber], 
	       [person6MidName]          = [idnumber],
	       [person6dob]              = @CGEDEVBIRTH ,
	       [person6ssn]              = @CGESSNDEV 
WHERE  [idnumber] =  [idnumber];

-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[formI539a]
-- ****************************************************************************
PRINT(N'Updating Name rows in [InternationalServices].[dbo].[formI539a]');

UPDATE [InternationalServices].[dbo].[formI539a]
       SET [lastNameI539]            = [idnumber], 
	       [firstNameI539]           = [idnumber], 
	       [midNameI539]             = [idnumber],
	       [lastName]                = [idnumber], 
	       [firstName]               = [idnumber], 
	       [midName]                 = [idnumber], 
		   [dob]                     = @CGEDEVBIRTH,
		   [ssn]                     = @CGESSNDEV,
           [interpreterLastName]     = [idnumber], 
	       [interpreterFirstName]    = [idnumber], 
	       [interpreterBusinessName] = [idnumber], 
           [preparerLastName]        = [idnumber], 
	       [preparerFirstName]       = [idnumber], 
	       [preparerBusinessName]    = [idnumber], 
	       [preparerEmail]           = @CGEDEVMAIL
WHERE  [idnumber] =  [idnumber];

-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[formI765]
-- ****************************************************************************
PRINT(N'Updating Name rows in [InternationalServices].[dbo].[formI765]');

UPDATE [InternationalServices].[dbo].[formI765]
       SET [lastName]                = [idnumber], 
	       [firstName]               = [idnumber], 
	       [midName]                 = [idnumber], 
		   [dob]                     = @CGEDEVBIRTH,
		   [ssn]                     = @CGESSNDEV,
           [otherLastName1]          = [idnumber], 
	       [otherFirstName1]         = [idnumber], 
	       [otherMiddleName1]        = [idnumber],
           [otherLastName2]          = [idnumber], 
	       [otherFirstName2]         = [idnumber], 
	       [otherMiddleName2]        = [idnumber],
           [otherLastName3]          = [idnumber], 
	       [otherFirstName3]         = [idnumber], 
	       [otherMiddleName3]        = [idnumber],
		   [interpreterLastName]     = [idnumber], 
	       [interpreterFirstName]    = [idnumber], 
	       [interpreterBusinessName] = [idnumber], 
           [preparerLastName]        = [idnumber], 
	       [preparerFirstName]       = [idnumber], 
	       [preparerBusinessName]    = [idnumber], 
	       [preparerEmail]           = @CGEDEVMAIL
WHERE  [idnumber] =  [idnumber];

-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[formI765ws]
-- ****************************************************************************
PRINT(N'Updating Name rows in [InternationalServices].[dbo].[formI765ws]');

UPDATE [InternationalServices].[dbo].[formI765ws]
       SET [lastName]                = [idnumber], 
	       [firstName]               = [idnumber], 
	       [midName]                 = [idnumber] 
WHERE  [idnumber] =  [idnumber];

-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[formI907] 
-- ****************************************************************************
PRINT(N'Updating Name rows in [InternationalServices].[dbo].[formI907]');

UPDATE [InternationalServices].[dbo].[formI907]
       SET       
	   [lastName] = [idnumber]
      ,[firstName] = [idnumber]
      ,[midName] = [idnumber]
      ,[relatedPetitionerLastName] = [idnumber]
      ,[relatedPetitionerFirstName] = [idnumber]
      ,[relatedPetitionerMiddleName] = [idnumber]
      ,[relatedBeneficiaryLastName] = [idnumber]
      ,[relatedBeneficiaryFirstName] = [idnumber]
      ,[relatedBeneficiaryMiddleName] = [idnumber]
      ,[companyContactLastName] = [idnumber]
      ,[companyContactFirstName] = [idnumber]
      ,[companyContactMiddleName] = [idnumber]
      ,[interpreterLastName] = [idnumber]
      ,[interpreterFirstName] = [idnumber]
      ,[preparerLastName] = [idnumber]
      ,[preparerFirstName] = [idnumber]
WHERE  [idnumber] =  [idnumber];

-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[formI983]
-- ****************************************************************************
PRINT(N'Updating Name rows in [InternationalServices].[dbo].[formI983]');

UPDATE [InternationalServices].[dbo].[formI983]
       SET [studentNameLast]                = [idnumber], 
	       [studentNameFirst]               = [idnumber], 
	       [studentEmail]                   = @CGEDEVMAIL,
		   [employerSiteOfficialEmail]      = @CGEDEVMAIL
WHERE  [idnumber] =  [idnumber];

-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[iuieBio] 
-- ****************************************************************************
PRINT(N'Updating Name rows in [InternationalServices].[dbo].[iuieBio]');

UPDATE [InternationalServices].[dbo].[iuieBio]
       SET       
       [DERIVED_LAST_NAME]       = [idnumber]
      ,[DERIVED_FIRST_NAME]      = [idnumber]
      ,[DERIVED_MIDDLE_NAME]     = [idnumber]
      ,[PRSN_PRM_LAST_NM]        = [idnumber]
      ,[PRSN_PRM_1ST_NM]         = [idnumber]
      ,[PRSN_PRM_MID_NM]         = [idnumber]
      ,[PRSN_PSPT_LAST_NM]       = [idnumber]
      ,[PRSN_PSPT_1ST_NM]        = [idnumber]
      ,[PRSN_PSPT_MID_NM]        = [idnumber]
      ,[PRSN_PREF_LAST_NM]       = [idnumber]
      ,[PRSN_PREF_1ST_NM]        = [idnumber]
      ,[PRSN_PREF_MID_NM]        = [idnumber]
      ,[PRSN_BIRTH_DT]           = @CGEDEVBIRTH
      ,[PRSN_GDS_CMP_EMAIL_ADDR] = @CGEDEVMAIL
      ,[PRSN_OTHR_EMAIL_ID]      = @CGEDEVMAIL
      ,[DERIVED_EMAIL_ADDR]      = @CGEDEVMAIL
WHERE  [idnumber] =  [idnumber];


-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[jbDependent] 
-- ****************************************************************************
PRINT(N'Updating Name rows in [InternationalServices].[dbo].[jbDependent]');

UPDATE [InternationalServices].[dbo].[jbDependent]
       SET       
       [famname]  = [idnumber]
      ,[givname]  = [idnumber]
      ,[dob]      = @CGEDEVBIRTH
WHERE  [idnumber] =  [idnumber];


-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[jbEFormActionLog] 
-- ****************************************************************************
PRINT(N'Updating Name rows in [InternationalServices].[dbo].[jbEFormActionLog]');
UPDATE [InternationalServices].[dbo].[jbEFormActionLog]
       SET       
      [userFullName] = [idnumber]
WHERE  [idnumber] =  [idnumber];


-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[jbFrontDeskCheckin] 
-- ****************************************************************************
PRINT(N'Updating Name rows in [InternationalServices].[dbo].[jbFrontDeskCheckin]');

UPDATE [InternationalServices].[dbo].[jbFrontDeskCheckin]
       SET       
      [fullName] = [idnumber]
WHERE  [idnumber] =  [idnumber];


-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[jbInternational]
-- ****************************************************************************

UPDATE [InternationalServices].[dbo].[jbInternational]
       SET [firstname] = [idnumber], [midname] = [idnumber], [lastname] = [idnumber]
WHERE  [idnumber] =  [idnumber];


-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[jbNames] 
-- ****************************************************************************
PRINT(N'Updating Name rows in [InternationalServices].[dbo].[jbNames]');

UPDATE [InternationalServices].[dbo].[jbNames]
       SET       
       [name1] = [idnumber]
      ,[name2] = [idnumber]
      ,[name3] = [idnumber]
      ,[name4] = [idnumber]
WHERE  [idnumber] =  [idnumber];


-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[jbOrientationCheckin] 
-- ****************************************************************************
PRINT(N'Updating Name rows in [InternationalServices].[dbo].[jbOrientationCheckin]');

UPDATE [InternationalServices].[dbo].[jbOrientationCheckin]
       SET       
       [relative1Name] = [idnumber]
      ,[relative2Name] = [idnumber]
WHERE  [idnumber] =  [idnumber];


-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[jbOrphanDerivedPotentialMatches] 
-- ****************************************************************************
PRINT(N'Updating Name rows in [InternationalServices].[dbo].[jbOrphanDerivedPotentialMatches]');

UPDATE [InternationalServices].[dbo].[jbOrphanDerivedPotentialMatches]
       SET       
       [orphanLastName] = [idnumber]
      ,[orphanFirstName] = [idnumber]
      ,[lastname] = [idnumber]
      ,[firstname] = [idnumber]
      ,[midname] = [idnumber]
WHERE  [idnumber] =  [idnumber];

-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[jbOrphanDocuments]
-- ****************************************************************************
PRINT(N'Updating Name rows in [InternationalServices].[dbo].[jbOrphanDocuments]');

UPDATE [InternationalServices].[dbo].[jbOrphanDocuments]
       SET [lastname]                = [idnumber], 
	       [firstname]               = [idnumber], 
	       [dob]                     = @CGEDEVBIRTH
WHERE  [idnumber] =  [idnumber];

-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[jbPassport] 
-- ****************************************************************************
PRINT(N'Updating Name rows in [InternationalServices].[dbo].[jbPassport]');

UPDATE [InternationalServices].[dbo].[jbPassport]
       SET       
       [givenName] = [idnumber]
      ,[lastname]  = [idnumber]
WHERE  [idnumber] =  [idnumber];


-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[sevisTransferIn]
-- ****************************************************************************
PRINT(N'Updating Name rows in [InternationalServices].[dbo].[sevisTransferIn]');

UPDATE [InternationalServices].[dbo].[sevisTransferIn]
       SET       
       [lastname]  =  [sevisid]
      ,[firstname] =  [sevisid]
WHERE  [sevisid]   =  [sevisid];


-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[jbInternationalBioExt]
-- ****************************************************************************
PRINT(N'Updating Name rows in [InternationalServices].[dbo].[jbInternationalBioExt]');

UPDATE [InternationalServices].[dbo].[jbInternationalBioExt]
SET    [dob]                    = @CGEDEVBIRTH;

-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[jbCommunication]
-- ****************************************************************************
PRINT(N'Updating Name rows in [InternationalServices].[dbo].[jbCommunication]');

UPDATE [InternationalServices].[dbo].[jbCommunication]
SET    [universityEmail]               = @CGEDEVMAIL
      ,[otherEmail]                    = @CGEDEVMAIL;

-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[iuieBioCondensed]
-- ****************************************************************************
PRINT(N'Updating Name rows in [InternationalServices].[dbo].[iuieBioCondensed]');

UPDATE [InternationalServices].[dbo].[iuieBioCondensed]
SET     [PRSN_PRM_LAST_NM]        = [PRSN_UNIV_ID]
       ,[PRSN_PRM_1ST_NM]         = [PRSN_UNIV_ID]
	   ,[PRSN_PRM_MID_NM]         = [PRSN_UNIV_ID]
	   ,[PRSN_BIRTH_DT]           = @CGEDEVBIRTH
	   ,[PRSN_OTHR_EMAIL_ID]      = @CGEDEVMAIL
       ,[PRSN_GDS_CMP_EMAIL_ADDR] = @CGEDEVMAIL
WHERE  [PRSN_UNIV_ID]             = [PRSN_UNIV_ID];

-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[extractjbInternationalBioExt]
-- ****************************************************************************
PRINT(N'Updating Name rows in [InternationalServices].[dbo].[extractjbInternationalBioExt]');

UPDATE [InternationalServices].[dbo].[extractjbInternationalBioExt]
SET     [dob]                     = @CGEDEVBIRTH
WHERE   [idnumber]                = [idnumber];

-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[extractsevisDS7002TIPPPhase]
-- ****************************************************************************
PRINT(N'Updating Name rows in [InternationalServices].[dbo].[extractsevisDS7002TIPPPhase]');

UPDATE [InternationalServices].[dbo].[extractsevisDS7002TIPPPhase]
SET     [superLastName]           = [idnumber]
       ,[superFirstName]          = [idnumber]
	   ,[superMiddleInitial]      = [idnumber]
	   ,[superEmail]              = @CGEDEVMAIL
WHERE   [idnumber]                = [idnumber];

-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[iuieAdmissionsEAppData]
-- ****************************************************************************
PRINT(N'Updating Name rows in [InternationalServices].[dbo].[iuieAdmissionsEAppData]');

UPDATE [InternationalServices].[dbo].[iuieAdmissionsEAppData]
SET     [APPL_EMAIL_ADDR]         = @CGEDEVMAIL
WHERE   [idnumber]                = [idnumber];

-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[jbOrphanDerivedPotentialMatches]
-- ****************************************************************************
PRINT(N'Updating Name rows in [InternationalServices].[dbo].[jbOrphanDerivedPotentialMatches]');

UPDATE [InternationalServices].[dbo].[jbOrphanDerivedPotentialMatches]
SET     [orphanLastName]          = [universityid]
       ,[orphanFirstName]         = [universityid]
	   ,[orphanDOB]               = @CGEDEVBIRTH
	   ,[lastname]                = [universityid]
	   ,[firstname]               = [universityid]
	   ,[midname]                 = [universityid]
	   ,[dob]                     = @CGEDEVBIRTH
WHERE   [idnumber]                = [idnumber]
    AND     
	    [recnum]                  = [recnum];
-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[sevisBatchOverrideBiographical]
-- ****************************************************************************
PRINT(N'Updating Name rows in [InternationalServices].[dbo].[sevisBatchOverrideBiographical]');

UPDATE [InternationalServices].[dbo].[sevisBatchOverrideBiographical]
SET     [lastnamePrior]           = [idnumber]
       ,[firstnamePrior]          = [idnumber]
	   ,[dobPrior]                = @CGEDEVBIRTH
	   ,[lastnameBatch]           = [idnumber]
	   ,[firstnameBatch]          = [idnumber]
	   ,[dobBatch]                = @CGEDEVBIRTH
	   ,[preferredNamePrior]      = [idnumber]
	   ,[preferredNameBatch]      = [idnumber]
	   ,[midnamePrior]            = [idnumber]
	   ,[midnameBatch]            = [idnumber]
	   ,[sevisFamilyNamePrior]    = [idnumber]
	   ,[sevisFamilyNameBatch]    = [idnumber]
	   ,[sevisGivenNamePrior]     = [idnumber]
	   ,[sevisGivenNameBatch]     = [idnumber]
WHERE   [idnumber]                = [idnumber]
    AND     
	    [recnum]                  = [recnum];

-- ****************************************************************************
-- Set Name in [InternationalServices].[dbo].[sevisDS7002TIPPPhase]
-- ****************************************************************************
PRINT(N'Updating Name rows in [InternationalServices].[dbo].[sevisDS7002TIPPPhase]');

UPDATE [InternationalServices].[dbo].[sevisDS7002TIPPPhase]
SET     [superLastName]           = [idnumber]
       ,[superFirstName]          = [idnumber]
	   ,[superMiddleInitial]      = [idnumber]
	   ,[superEmail]              = @CGEDEVMAIL
WHERE   [idnumber]                = [idnumber]
    AND     
	    [recnum]                  = [recnum];
PRINT(N'Finished with the InternationalServices record updates!!!!!!!!!!!!!!!!!!!');
-- ****************************************************************************
-- ****************************************************************************
-- ****************************************************************************
-- ****************************************************************************
-- ****************************************************************************
-- ** End of the script for data changes.           ***************************
-- ****************************************************************************
-- ****************************************************************************
-- ****************************************************************************
-- ****************************************************************************
-- ****************************************************************************


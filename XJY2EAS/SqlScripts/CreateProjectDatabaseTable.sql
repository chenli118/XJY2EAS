/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2012                    */
/* Created on:     2019/1/8 12:58:06                            */
/*==============================================================*/



if exists (select 1
            from  sysobjects
           where  id = object_id('View_DetailAccount')
            and   type = 'V')
   drop view View_DetailAccount
go

if exists (select 1
            from  sysobjects
           where  id = object_id('View_AllAccount')
            and   type = 'V')
   drop view View_AllAccount
go

if exists (select 1
            from  sysobjects
           where  id = object_id('VIEW_TBFS')
            and   type = 'V')
   drop view VIEW_TBFS
go

if exists (select 1
            from  sysobjects
           where  id = object_id('VIEW_TBDetail')
            and   type = 'V')
   drop view VIEW_TBDetail
go

if exists (select 1
            from  sysobjects
           where  id = object_id('VIEW_AllExistUser')
            and   type = 'V')
   drop view VIEW_AllExistUser
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ACCOUNT')
            and   type = 'U')
   drop table ACCOUNT
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.AccountQues')
            and   type = 'U')
   drop table dbo.AccountQues
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.AccountingAgeOfFscode')
            and   type = 'U')
   drop table dbo.AccountingAgeOfFscode
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.AccountingPolicies')
            and   type = 'U')
   drop table dbo.AccountingPolicies
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.Announce')
            and   type = 'U')
   drop table dbo.Announce
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.AuditGoalandCognizance')
            and   type = 'U')
   drop table dbo.AuditGoalandCognizance
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.AuditProgramConfig')
            and   type = 'U')
   drop table dbo.AuditProgramConfig
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.AuditProgramFile')
            and   name  = 'Index_AuditProgramFiel'
            and   indid > 0
            and   indid < 255)
   drop index dbo.AuditProgramFile.Index_AuditProgramFiel
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.AuditProgramFile')
            and   type = 'U')
   drop table dbo.AuditProgramFile
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.AuditProgramForm')
            and   type = 'U')
   drop table dbo.AuditProgramForm
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.AuditProgramLibrary')
            and   type = 'U')
   drop table dbo.AuditProgramLibrary
go

if exists (select 1
            from  sysobjects
           where  id = object_id('AuxiliaryFDetail')
            and   type = 'U')
   drop table AuxiliaryFDetail
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.BActivitiesAndCGoal')
            and   type = 'U')
   drop table dbo.BActivitiesAndCGoal
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.BCycleAndAccounts')
            and   type = 'U')
   drop table dbo.BCycleAndAccounts
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.BCycleAndBActivities')
            and   type = 'U')
   drop table dbo.BCycleAndBActivities
go

if exists (select 1
            from  sysobjects
           where  id = object_id('BankAcceptBill')
            and   type = 'U')
   drop table BankAcceptBill
go

if exists (select 1
            from  sysobjects
           where  id = object_id('BankAccount')
            and   type = 'U')
   drop table BankAccount
go

if exists (select 1
            from  sysobjects
           where  id = object_id('BankBorrow')
            and   type = 'U')
   drop table BankBorrow
go

if exists (select 1
            from  sysobjects
           where  id = object_id('BankInfo')
            and   type = 'U')
   drop table BankInfo
go

if exists (select 1
            from  sysobjects
           where  id = object_id('BankUnsubscribe')
            and   type = 'U')
   drop table BankUnsubscribe
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.BusinessCycle')
            and   type = 'U')
   drop table dbo.BusinessCycle
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.ClientMaintainProposed')
            and   type = 'U')
   drop table dbo.ClientMaintainProposed
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.Communication')
            and   type = 'U')
   drop table dbo.Communication
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.Consultation')
            and   type = 'U')
   drop table dbo.Consultation
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.ConsultationBank')
            and   type = 'U')
   drop table dbo.ConsultationBank
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ContentofSampleTest')
            and   type = 'U')
   drop table ContentofSampleTest
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ContentofsampleTestInfo')
            and   type = 'U')
   drop table ContentofsampleTestInfo
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.CriticalElementofPM')
            and   type = 'U')
   drop table dbo.CriticalElementofPM
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Cutofftest')
            and   type = 'U')
   drop table Cutofftest
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.ERisksLevel')
            and   type = 'U')
   drop table dbo.ERisksLevel
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.ErrorRelationItem')
            and   type = 'U')
   drop table dbo.ErrorRelationItem
go

if exists (select 1
            from  sysobjects
           where  id = object_id('EvaluationError')
            and   type = 'U')
   drop table EvaluationError
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.FSCodeConfig')
            and   type = 'U')
   drop table dbo.FSCodeConfig
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.FileReviews')
            and   type = 'U')
   drop table dbo.FileReviews
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.FileReviewsImage')
            and   type = 'U')
   drop table dbo.FileReviewsImage
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.FileScriptList')
            and   type = 'U')
   drop table dbo.FileScriptList
go

if exists (select 1
            from  sysobjects
           where  id = object_id('FlowsAction')
            and   type = 'U')
   drop table FlowsAction
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.InherentRisk')
            and   type = 'U')
   drop table dbo.InherentRisk
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.InherentRiskAccount')
            and   type = 'U')
   drop table dbo.InherentRiskAccount
go

if exists (select 1
            from  sysobjects
           where  id = object_id('MainDefine')
            and   type = 'U')
   drop table MainDefine
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.PIDInformation')
            and   type = 'U')
   drop table dbo.PIDInformation
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.PMofFsCode')
            and   type = 'U')
   drop table dbo.PMofFsCode
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.PMvalueofJ')
            and   type = 'U')
   drop table dbo.PMvalueofJ
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.PlanningProcedures')
            and   type = 'U')
   drop table dbo.PlanningProcedures
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.PmPlanningMateriality')
            and   type = 'U')
   drop table dbo.PmPlanningMateriality
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ProJect')
            and   type = 'U')
   drop table ProJect
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ProjectError')
            and   type = 'U')
   drop table ProjectError
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ProjectType')
            and   type = 'U')
   drop table ProjectType
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.Qcwljzpz')
            and   type = 'U')
   drop table dbo.Qcwljzpz
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.QhJzpz')
            and   type = 'U')
   drop table dbo.QhJzpz
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Qmyegc')
            and   type = 'U')
   drop table Qmyegc
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.RecordOfSampleTest')
            and   type = 'U')
   drop table dbo.RecordOfSampleTest
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ReplaceTestVoucher')
            and   type = 'U')
   drop table ReplaceTestVoucher
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.RiskModel')
            and   type = 'U')
   drop table dbo.RiskModel
go

if exists (select 1
            from  sysobjects
           where  id = object_id('RiskResponse')
            and   type = 'U')
   drop table RiskResponse
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.Riskfactor')
            and   type = 'U')
   drop table dbo.Riskfactor
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.RoleInfo')
            and   type = 'U')
   drop table dbo.RoleInfo
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.StrategicPlanning')
            and   type = 'U')
   drop table dbo.StrategicPlanning
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.TBAdjustedItems')
            and   type = 'U')
   drop table dbo.TBAdjustedItems
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.TBAdjustedSubItems')
            and   type = 'U')
   drop table dbo.TBAdjustedSubItems
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TBAux')
            and   type = 'U')
   drop table TBAux
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('TBDetail')
            and   name  = 'TBDeatil_Index_Code'
            and   indid > 0
            and   indid < 255)
   drop index TBDetail.TBDeatil_Index_Code
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TBDetail')
            and   type = 'U')
   drop table TBDetail
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TBDetailExtra')
            and   type = 'U')
   drop table TBDetailExtra
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.TBEliminationItems')
            and   type = 'U')
   drop table dbo.TBEliminationItems
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.TBEliminationSubItems')
            and   type = 'U')
   drop table dbo.TBEliminationSubItems
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TBFS')
            and   type = 'U')
   drop table TBFS
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.TBVoucher')
            and   name  = 'Index_Voucher'
            and   indid > 0
            and   indid < 255)
   drop index dbo.TBVoucher.Index_Voucher
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.TBVoucher')
            and   type = 'U')
   drop table dbo.TBVoucher
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.TBWlhz')
            and   type = 'U')
   drop table dbo.TBWlhz
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TbAppendTable')
            and   type = 'U')
   drop table TbAppendTable
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.Tbwlzl')
            and   name  = 'TBwlzl_Index'
            and   indid > 0
            and   indid < 255)
   drop index dbo.Tbwlzl.TBwlzl_Index
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.Tbwlzl')
            and   type = 'U')
   drop table dbo.Tbwlzl
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.WlhzandTB')
            and   type = 'U')
   drop table dbo.WlhzandTB
go

if exists (select 1
            from  sysobjects
           where  id = object_id('accountperiod')
            and   type = 'U')
   drop table accountperiod
go

if exists (select 1
            from  sysobjects
           where  id = object_id('kjqj')
            and   type = 'U')
   drop table kjqj
go

if exists (select 1
            from  sysobjects
           where  id = object_id('UserRequestRecord')
            and   type = 'U')
   drop table UserRequestRecord
go

/*==============================================================*/
/* Table: ACCOUNT                                               */
/*==============================================================*/
create table ACCOUNT (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AccountCode          varchar(255)         collate Chinese_PRC_CS_AS_KS_WS not null,
   UpperCode            varchar(255)         collate Chinese_PRC_CS_AS_KS_WS null,
   AccountName          varchar(1000)        not null,
   Attribute            int                  null,
   Jd                   int                  null,
   Hsxms                int                  not null,
   TypeCode             varchar(255)         collate Chinese_PRC_CS_AS_KS_WS null,
   Jb                   int                  not null,
   IsMx                 int                  null,
   Ncye                 decimal(20,2)        null,
   Qqccgz               decimal(20,2)        null,
   Jfje                 decimal(20,2)        null,
   Dfje                 decimal(20,2)        null,
   Ncsl                 int                  null,
   Syjz                 int                  not null default 0,
   constraint PK_ACCOUNT primary key (ProjectID, AccountCode)
)
go

/*==============================================================*/
/* Table: AccountQues                                           */
/*==============================================================*/
create table dbo.AccountQues (
   ID                   int                  identity(1, 1),
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AccountCode          varchar(50)          collate Chinese_PRC_CS_AS_KS_WS null,
   QuesID               varchar(50)          collate Chinese_PRC_CI_AS null,
   QuesDescription      nvarchar(2000)       collate Chinese_PRC_CI_AS null,
   SelectedYesNo        int                  null,
   AuditProgramCode     varchar(50)          collate Chinese_PRC_CI_AS null,
   QuestionType         bit                  null,
   MutexQuesIDs         varchar(100)         collate Chinese_PRC_CI_AS null,
   constraint PK_ACCOUNTQUES primary key (ID)
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: AccountingAgeOfFscode                                 */
/*==============================================================*/
create table dbo.AccountingAgeOfFscode (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   ID                   int                  not null,
   "ORDER"              varchar(50)          null,
   FSCode               varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   FIELDNAME            varchar(50)          not null,
   FIELDTEXT            varchar(50)          null,
   AGEMINIMUM           int                  null,
   AGECEILING           int                  null,
   BADDEBTRATE          float                not null default (0),
   SAMPLING             bit                  not null default (0),
   ApplyYesno           int                  not null default (1),
   constraint PK_ACCOUNTINGAGEOFFSCODE primary key (ProjectID, ID)
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: AccountingPolicies                                    */
/*==============================================================*/
create table dbo.AccountingPolicies (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   ID                   int                  not null,
   UpperID              varchar(50)          collate Chinese_PRC_CI_AS null,
   PoliciesID           varchar(50)          collate Chinese_PRC_CI_AS not null,
   "Order"              int                  null,
   Policies             varchar(50)          collate Chinese_PRC_CI_AS null,
   ClientPolicies       nvarchar(4000)       collate Chinese_PRC_CI_AS null,
   PoliciesEvaluation   text                 collate Chinese_PRC_CI_AS null,
   Change               int                  null,
   OldPolicies          text                 collate Chinese_PRC_CI_AS null,
   ChangeDate           datetime             null,
   ChangeReasons        text                 collate Chinese_PRC_CI_AS null,
   ChangeResults        text                 collate Chinese_PRC_CI_AS null,
   ChangeEvaluation     text                 collate Chinese_PRC_CI_AS null,
   constraint PK_ACCOUNTINGPOLICIES primary key (ProjectID, ID)
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: Announce                                              */
/*==============================================================*/
create table dbo.Announce (
   ID                   int                  identity(1, 1),
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   StruCode             nvarchar(50)         collate Chinese_PRC_CI_AS null,
   AnnounceContent      text                 collate Chinese_PRC_CI_AS null,
   RoleName             nvarchar(50)         collate Chinese_PRC_CI_AS null,
   LoginName            nvarchar(50)         collate Chinese_PRC_CI_AS null,
   SignOffTime          datetime             null,
   SignOffSequence      int                  null,
   constraint PK_Announce primary key (ID)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: AuditGoalandCognizance                                */
/*==============================================================*/
create table dbo.AuditGoalandCognizance (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   ClassCode            varchar(50)          collate Chinese_PRC_CI_AS not null,
   AuditGoalCode        varchar(50)          collate Chinese_PRC_CI_AS not null,
   AuditGoalName        nvarchar(1000)       collate Chinese_PRC_CI_AS null,
   Cognizance           varchar(50)          collate Chinese_PRC_CI_AS null,
   constraint PK_AUDITGOALANDCOGNIZANCE primary key (ProjectID, ClassCode, AuditGoalCode)
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: AuditProgramConfig                                    */
/*==============================================================*/
create table dbo.AuditProgramConfig (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AuditProgramCode     varchar(50)          collate Chinese_PRC_CI_AS not null,
   FSCodeOrCycleCode    varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   SortID               int                  not null,
   AuditGoalCode        varchar(50)          collate Chinese_PRC_CI_AS not null,
   Category             int                  not null,
   ApplyYesNo           int                  not null,
   ProgramLevel         int                  not null,
   QuesID               varchar(50)          collate Chinese_PRC_CI_AS not null,
   SelectedYesNo        int                  not null,
   SelectedReason       varchar(1000)        not null,
   constraint PK_AuditProgramConfig primary key (ProjectID, FSCodeOrCycleCode, AuditProgramCode)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: AuditProgramFile                                      */
/*==============================================================*/
create table dbo.AuditProgramFile (
   ID                   varchar(50)          not null,
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AuditProgramCode     varchar(50)          collate Chinese_PRC_CI_AS not null,
   FSCodeOrCycleCode    varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   StruCode             varchar(128)         collate Chinese_PRC_CI_AS not null,
   constraint PK_AuditProgramFile primary key (ID, ProjectID)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Index: Index_AuditProgramFiel                                */
/*==============================================================*/
create unique index Index_AuditProgramFiel on dbo.AuditProgramFile (
ProjectID ASC,
AuditProgramCode ASC,
FSCodeOrCycleCode ASC,
StruCode ASC
)
go

/*==============================================================*/
/* Table: AuditProgramForm                                      */
/*==============================================================*/
create table dbo.AuditProgramForm (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AuditProgramCode     varchar(50)          collate Chinese_PRC_CI_AS not null,
   SortID               int                  not null,
   Title                Varchar(100)         not null,
   AssemblyID           varchar(50)          not null,
   constraint PK_AuditProgramForm primary key (ProjectID, AuditProgramCode, SortID)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: AuditProgramLibrary                                   */
/*==============================================================*/
create table dbo.AuditProgramLibrary (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AuditProgramCode     varchar(50)          collate Chinese_PRC_CI_AS not null,
   AuditProgramTitle    varchar(500)         collate Chinese_PRC_CI_AS not null,
   AuditProgramName     varchar(1000)        collate Chinese_PRC_CI_AS not null,
   AuditProgramGuideline nvarchar(3000)       collate Chinese_PRC_CI_AS not null,
   StageCode            varchar(50)          not null,
   MenuID               int                  not null,
   UpperProgramCode     varchar(50)          not null,
   constraint PK_AuditProgramLibrary primary key (ProjectID, AuditProgramCode)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: AuxiliaryFDetail                                      */
/*==============================================================*/
create table AuxiliaryFDetail (
   projectid            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   Accountcode          varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AuxiliaryCode        varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   FDetailID            int                  not null,
   DataType             int                  not null,
   DataYear             int                  not null,
   constraint PK_AUXILIARYFDETAIL primary key (projectid, Accountcode, AuxiliaryCode, FDetailID, DataYear)
)
go

/*==============================================================*/
/* Table: BActivitiesAndCGoal                                   */
/*==============================================================*/
create table dbo.BActivitiesAndCGoal (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   CGoalID              varchar(50)          collate Chinese_PRC_CI_AS not null,
   BActivitiesID        varchar(50)          collate Chinese_PRC_CI_AS not null,
   CGoalName            varchar(50)          collate Chinese_PRC_CI_AS not null,
   CControlPointIDs     text                 collate Chinese_PRC_CI_AS null,
   AccountandCode       text                 collate Chinese_PRC_CI_AS null,
   RealtedCognizance    varchar(50)          collate Chinese_PRC_CI_AS null,
   CCActivities         text                 collate Chinese_PRC_CI_AS null,
   ControTestProgram    text                 collate Chinese_PRC_CI_AS null,
   ControlFrequence     varchar(50)          collate Chinese_PRC_CI_AS null,
   SampleCount          int                  null,
   Memo                 text                 collate Chinese_PRC_CI_AS null,
   RelationLevel        int                  null,
   SelectedYesNO        bit                  null,
   ACActivities         text                 collate Chinese_PRC_CI_AS null,
   EfficiencyYesNo      bit                  null default (1),
   ExecutedYesNo        bit                  null default (1),
   EEfficiencyYesNo     bit                  null default (1),
   SupportingYesNo      bit                  null,
   RelatedAccountandCognizance text                 collate Chinese_PRC_CI_AS null,
   constraint PK_BActivitiesAndCGoal primary key (ProjectID, CGoalID, BActivitiesID)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: BCycleAndAccounts                                     */
/*==============================================================*/
create table dbo.BCycleAndAccounts (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   BusinessCycleID      varchar(50)          collate Chinese_PRC_CI_AS not null,
   AccountID            varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   AccountName          varchar(50)          collate Chinese_PRC_CI_AS not null,
   Memo                 text                 collate Chinese_PRC_CI_AS null,
   SelectedYesNO        bit                  null,
   constraint PK_BCycleAndAccounts primary key (ProjectID, BusinessCycleID, AccountID)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: BCycleAndBActivities                                  */
/*==============================================================*/
create table dbo.BCycleAndBActivities (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   BusinessCycleID      varchar(50)          collate Chinese_PRC_CI_AS not null,
   BActivitiesID        varchar(50)          collate Chinese_PRC_CI_AS not null,
   BActivitiesName      varchar(50)          collate Chinese_PRC_CI_AS not null,
   Memo                 text                 collate Chinese_PRC_CI_AS null,
   RelationLevel        int                  not null,
   SelectedYesNO        bit                  null,
   UnSelectedReason     text                 collate Chinese_PRC_CI_AS null,
   constraint PK_BCYCLEANDBACTIVITIES primary key (ProjectID, BusinessCycleID, BActivitiesID)
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: BankAcceptBill                                        */
/*==============================================================*/
create table BankAcceptBill (
   ID                   varchar(100)         not null,
   ProjectID            varchar(100)         not null,
   BankID               varchar(100)         not null,
   BankName             varchar(100)         not null,
   AcceptBillNum        varchar(100)         not null,
   AcceptBankName       varchar(100)         not null,
   AccountName          varchar(100)         not null,
   AcceptMoney          decimal(20,2)        null,
   BeginDate            datetime             null,
   EndDate              datetime             null,
   constraint PK_BANKACCEPTBILL primary key (ID)
)
go

/*==============================================================*/
/* Table: BankAccount                                           */
/*==============================================================*/
create table BankAccount (
   ID                   varchar(100)         not null,
   ProjectID            varchar(100)         not null,
   BankID               varchar(100)         not null,
   BankName             varchar(100)         not null,
   AccountName          varchar(100)         not null,
   BankNum              varchar(100)         not null,
   Currency             varchar(50)          not null,
   Rate                 varchar(50)          null,
   AccountType          varchar(100)         not null,
   Balance              decimal(20,2)        null,
   BeginEndDate         varchar(50)          not null,
   Explain              varchar(100)         not null,
   Remark               varchar(1000)        not null,
   constraint PK_BANKACCOUNT primary key (ID)
)
go

/*==============================================================*/
/* Table: BankBorrow                                            */
/*==============================================================*/
create table BankBorrow (
   ID                   varchar(100)         not null,
   ProjectID            varchar(100)         not null,
   BankID               varchar(100)         not null,
   BankName             varchar(100)         not null,
   BorrowName           varchar(100)         not null,
   BankNum              varchar(100)         not null,
   Currency             varchar(50)          not null,
   Balance              decimal(20,2)        null,
   BorrowDate           datetime             null,
   BecomeDate           datetime             null,
   Rate                 varchar(50)          null,
   AssureName           varchar(100)         not null,
   Remark               varchar(1000)        not null,
   constraint PK_BANKBORROW primary key (ID)
)
go

/*==============================================================*/
/* Table: BankInfo                                              */
/*==============================================================*/
create table BankInfo (
   ID                   varchar(100)         not null,
   ProjectID            varchar(100)         not null,
   BankName             varchar(100)         not null,
   EndDate              datetime             null,
   HZNumber             varchar(100)         not null,
   HZSortID             varchar(10)          not null,
   Remark               varchar(1000)        not null,
   constraint PK_BANKINFO primary key (ID)
)
go

/*==============================================================*/
/* Table: BankUnsubscribe                                       */
/*==============================================================*/
create table BankUnsubscribe (
   ID                   varchar(100)         not null,
   ProjectID            varchar(100)         not null,
   BankID               varchar(100)         not null,
   BankName             varchar(100)         not null,
   AccountName          varchar(100)         not null,
   BankNum              varchar(100)         not null,
   Currency             varchar(50)          not null,
   UnsubscribeDate      datetime             null,
   constraint PK_BANKUNSUBSCRIBE primary key (ID)
)
go

/*==============================================================*/
/* Table: BusinessCycle                                         */
/*==============================================================*/
create table dbo.BusinessCycle (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   BusinessCycleID      varchar(50)          collate Chinese_PRC_CI_AS not null,
   BusinessCycleName    varchar(50)          collate Chinese_PRC_CI_AS not null,
   Memo                 text                 collate Chinese_PRC_CI_AS null,
   FileCodeFor15000     varchar(50)          collate Chinese_PRC_CI_AS null,
   FileCodeFor40000     varchar(50)          collate Chinese_PRC_CI_AS null,
   LastExecutedYear     int                  null,
   ExecutedYesNo        bit                  null,
   NextExecutedYear     int                  null,
   TotalInitialConslusion int                  not null default (0),
   constraint PK_BusinessCycle primary key (ProjectID, BusinessCycleID)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: ClientMaintainProposed                                */
/*==============================================================*/
create table dbo.ClientMaintainProposed (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   ID                   int                  not null,
   UpperID              int                  null,
   ConsiderElement      text                 collate Chinese_PRC_CI_AS null,
   Existence            bit                  null,
   IsTitle              bit                  null,
   constraint PK_ClientMaintainProposed primary key (ProjectID, ID)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: Communication                                         */
/*==============================================================*/
create table dbo.Communication (
   ID                   int                  identity(1, 1),
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   StruCode             nvarchar(50)         collate Chinese_PRC_CI_AS not null,
   CommunicationTargets int                  not null,
   CommunicationContent text                 collate Chinese_PRC_CI_AS null,
   ReferenceList        nvarchar(50)         collate Chinese_PRC_CI_AS null,
   constraint PK_Communication primary key (ID)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: Consultation                                          */
/*==============================================================*/
create table dbo.Consultation (
   ID                   varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   BankID               varchar(50)          collate Chinese_PRC_CI_AS not null,
   Bank                 varchar(50)          collate Chinese_PRC_CI_AS not null,
   Content              varchar(100)         collate Chinese_PRC_CI_AS null,
   AccountCode          varchar(50)          collate Chinese_PRC_CS_AS_KS_WS null,
   AuxiliaryCode        varchar(100)         collate Chinese_PRC_CS_AS_KS_WS null,
   Tbtype               int                  null,
   AccountName          varchar(100)         collate Chinese_PRC_CI_AS null,
   BankAccount          varchar(50)          collate Chinese_PRC_CI_AS null,
   ThirdParty           varchar(50)          collate Chinese_PRC_CI_AS null,
   currency             varchar(50)          collate Chinese_PRC_CI_AS null,
   Qmye                 decimal(20,4)        null,
   Rate                 decimal(20,4)        null,
   StartDate            datetime             null,
   EndDate              datetime             null,
   Securityway          varchar(50)          collate Chinese_PRC_CI_AS null,
   SecurityMatters      nvarchar(1000)       collate Chinese_PRC_CI_AS null,
   ContractNumber       varchar(50)          collate Chinese_PRC_CI_AS null,
   Remarks              text                 collate Chinese_PRC_CI_AS null,
   DiscountDate         datetime             null,
   Discountrate         decimal(20,4)        null,
   ConsultationAmount   decimal(20,4)        null,
   ConfirmBalance       decimal(20,4)        null,
   constraint PK_CONSULTATION primary key (ID)
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: ConsultationBank                                      */
/*==============================================================*/
create table dbo.ConsultationBank (
   ID                   varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   BankID               varchar(50)          collate Chinese_PRC_CI_AS not null,
   Bank                 varchar(50)          collate Chinese_PRC_CI_AS null,
   Address              varchar(100)         collate Chinese_PRC_CI_AS null,
   PostalCode           varchar(50)          collate Chinese_PRC_CI_AS null,
   Contact              varchar(50)          collate Chinese_PRC_CI_AS null,
   Tel                  varchar(50)          collate Chinese_PRC_CI_AS null,
   Fax                  varchar(50)          collate Chinese_PRC_CI_AS null,
   HZNumber             varchar(50)          not null,
   HZSortID             int                  not null,
   ConsultDate          datetime             null,
   ConfirmDate          datetime             null,
   constraint PK_CONSULTATIONBANK primary key (ID, ProjectID)
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: ContentofSampleTest                                   */
/*==============================================================*/
create table ContentofSampleTest (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   FSCode               varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   FunctionType         varchar(10)          not null,
   contentID            int                  not null,
   recordtype           int                  null,
   Fieldname            varchar(50)          null,
   Display              int                  not null,
   constraint PK_CONTENTOFSAMPLETEST primary key (ProjectID, FSCode, FunctionType, contentID)
)
go

/*==============================================================*/
/* Table: ContentofsampleTestInfo                               */
/*==============================================================*/
create table ContentofsampleTestInfo (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   FSCode               varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   contentID            int                  not null,
   FunctionType         varchar(10)          not null,
   recordtype           int                  null,
   NumberofAE           int                  not null,
   DateofAE             int                  not null,
   AmountofAE           int                  not null,
   QuantityofAE         int                  not null,
   AuditEvidence        int                  not null,
   copyofEvidence       int                  null,
   constraint PK_CONTENTOFSAMPLETESTINFO primary key (ProjectID, FSCode, contentID, FunctionType)
)
go

/*==============================================================*/
/* Table: CriticalElementofPM                                   */
/*==============================================================*/
create table dbo.CriticalElementofPM (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   ID                   varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   Fscode               varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   CriticalElement      varchar(100)         collate Chinese_PRC_CI_AS not null,
   OtherCriticalElement varchar(100)         collate Chinese_PRC_CI_AS null,
   CriticalElementCount decimal(22,2)        not null,
   SelectedIndex        decimal(10,4)        not null,
   SelectedIndexDescription varchar(500)         collate Chinese_PRC_CI_AS null,
   CurrentMateriality   decimal(22,2)        not null,
   selected             int                  not null,
   Reasons              varchar(500)         collate Chinese_PRC_CI_AS null,
   constraint PK_CriticalElementofPM primary key (ProjectID, ID)
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: Cutofftest                                            */
/*==============================================================*/
create table Cutofftest (
   VoucherID            varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   FSCode               varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   AccountCode          varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AccountName          varchar(100)         collate Chinese_PRC_CI_AS not null,
   ProjectCode          varchar(100)         collate Chinese_PRC_CS_AS_KS_WS null,
   IsBefore             int                  not null,
   Sample               int                  null,
   OsDate               datetime             null,
   PZH                  VARCHAR(100)         null,
   dfkm                 varchar(100)         collate Chinese_PRC_CS_AS_KS_WS null,
   JD                   INT                  not null,
   JE                   decimal(20,2)        null,
   ZY                   varchar(255)         null,
   constraint PK_CUTOFFTEST primary key (VoucherID, ProjectID)
)
go

/*==============================================================*/
/* Table: ERisksLevel                                           */
/*==============================================================*/
create table dbo.ERisksLevel (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   ID                   int                  not null,
   UpperID              int                  null,
   Riskcase             varchar(500)         collate Chinese_PRC_CI_AS null,
   RiskID               int                  null,
   RiskYesNO            int                  null,
   ImportantRiskYesNo   int                  null,
   Reference            varchar(50)          collate Chinese_PRC_CI_AS null,
   constraint PK_ERisksLevel primary key (ProjectID, ID)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: ErrorRelationItem                                     */
/*==============================================================*/
create table dbo.ErrorRelationItem (
   ID                   varchar(50)          not null,
   ErrorID              varchar(50)          not null,
   ErrorType            int                  not null,
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   FsCode               varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   JD                   int                  not null,
   JE                   decimal(20, 2)       not null,
   constraint PK_ErrorRelationItem primary key (ID)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: EvaluationError                                       */
/*==============================================================*/
create table EvaluationError (
   ID                   varchar(50)          not null,
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   FsCode               varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   AccountCode          varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AuxiliaryCode        varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   Type                 int                  not null,
   ReferCode            varchar(50)          null,
   SampleData           decimal(20, 2)       not null,
   ExpectedData         decimal(20, 2)       not null,
   AcceptDiff           decimal(20, 2)       not null,
   ConfirmedDiff        decimal(20, 2)       not null,
   EvaluationError      decimal(20, 2)       not null,
   AffectKm             varchar(500)         null,
   Memo                 varchar(100)         null,
   IsUse                int                  not null,
   constraint PK_EVALUATIONERROR primary key (ID)
)
go

/*==============================================================*/
/* Table: FSCodeConfig                                          */
/*==============================================================*/
create table dbo.FSCodeConfig (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   FsCode               varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   FsName               varchar(100)         collate Chinese_PRC_CI_AS not null,
   FSType               int                  not null,
   TBType               int                  not null,
   IsMx                 int                  not null,
   Kmsx                 varchar(50)          collate Chinese_PRC_CI_AS null,
   Yefx                 int                  not null,
   TBGrouping           varchar(50)          collate Chinese_PRC_CS_AS_KS_WS null,
   IsCashflow           int                  not null default (0),
   IsBankConfirmation   int                  not null default (0),
   IsRiskassess         int                  not null default (0),
   IsNote               int                  not null default (0),
   IsAuditplan          int                  not null default (0),
   IsAuditdocument      int                  not null default (0),
   AccountingMeasure    varchar(100)         collate Chinese_PRC_CI_AS null,
   FERcode              varchar(100)         collate Chinese_PRC_CI_AS null,
   IsUse                int                  not null,
   constraint PK_FSCodeConfig primary key (ProjectID, FsCode)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: FileReviews                                           */
/*==============================================================*/
create table dbo.FileReviews (
   ID                   varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   StruCode             varchar(50)          collate Chinese_PRC_CI_AS not null,
   AuditProgramCode     varchar(50)          collate Chinese_PRC_CI_AS not null,
   IsOpen               int                  not null,
   Context              varchar(max)         collate Chinese_PRC_CI_AS not null,
   feedback             varchar(max)         collate Chinese_PRC_CI_AS not null,
   feedbackdoc          varchar(50)          collate Chinese_PRC_CI_AS not null,
   Reviewer             varchar(50)          collate Chinese_PRC_CI_AS not null,
   ReviewerName         varchar(50)          not null,
   LastReviewerTime     datetime             not null,
   BackLoginName        varchar(50)          collate Chinese_PRC_CI_AS not null,
   BackUserName         varchar(50)          not null,
   lastfeedbackTime     datetime             not null,
   IsDelete             int                  not null,
   CreateTime           Datetime             not null,
   constraint PK_FileReviews primary key (ID)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: FileReviewsImage                                      */
/*==============================================================*/
create table dbo.FileReviewsImage (
   ID                   varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   FileID               varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   SortID               int                  not null,
   FilePath             varchar(1000)        collate Chinese_PRC_CI_AS not null,
   LibID                varchar(100)         not null,
   constraint PK_FileReviewsImage primary key (ID)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: FileScriptList                                        */
/*==============================================================*/
create table dbo.FileScriptList (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   FileLibID            varchar(128)         null,
   StruCode             varchar(128)         collate Chinese_PRC_CI_AS not null,
   StruCodeText         varchar(128)         null,
   StruName             nvarchar(500)        collate Chinese_PRC_CI_AS not null,
   UpperStruCode        varchar(128)         collate Chinese_PRC_CI_AS not null,
   StruType             int                  not null,
   StruDescription      nvarchar(1000)       collate Chinese_PRC_CI_AS null,
   StruCriticalYesNO    bit                  not null,
   StruTarget           varchar(500)         collate Chinese_PRC_CI_AS not null,
   BuildingType         varchar(100)         null,
   Checkout             int                  null,
   CheckedReviewer      nvarchar(1000)       null,
   StruPreparer         nvarchar(1000)       collate Chinese_PRC_CI_AS null,
   StruReviewer         nvarchar(1000)       collate Chinese_PRC_CI_AS null,
   StruMasterORCarbon   bit                  null,
   FlowExcutedState     int                  null default (0),
   OpenNotes            int                  null,
   ClosedNotes          int                  null,
   StruSize             int                  null,
   StruCreateTime       datetime             null,
   StruLastEditTime     datetime             null,
   FlowID               int                  null default (0),
   FlowExcutedTime      datetime             null,
   Fsitem               int                  null default (0),
   FSCode               varchar(50)          collate Chinese_PRC_CS_AS_KS_WS null,
   BCycleCode           varchar(100)         collate Chinese_PRC_CI_AS null,
   AppScopeProject      int                  null,
   NonAppScopeProject   int                  null,
   AppCombineProject    int                  null,
   BuildLevel           int                  null,
   carrieddown          int                  null default (0),
   ConnectData          int                  null default (1),
   constraint PK__A563069935A7728C primary key (ProjectID, StruCode)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: FlowsAction                                           */
/*==============================================================*/
create table FlowsAction (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   StruID               VARCHAR (50)         collate Chinese_PRC_CS_AS_KS_WS not null,
   FlowID               int                  null,
   NodeID               int                  null,
   NodeProcessor        VARCHAR (50)         not null,
   ActionDatetime       datetime             null,
   constraint PK_FLOWSACTION primary key (ProjectID, StruID, NodeProcessor)
)
go

/*==============================================================*/
/* Table: InherentRisk                                          */
/*==============================================================*/
create table dbo.InherentRisk (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   ID                   int                  not null,
   RiskLevelID          int                  null,
   RiskLevelType        int                  null,
   RiskSource           varchar(50)          collate Chinese_PRC_CI_AS not null,
   RiskYesNO            bit                  null,
   RiskDescription      text                 collate Chinese_PRC_CI_AS not null,
   ImportantRiskYesNo   bit                  null default (1),
   SpecialRiskYesNo     bit                  null,
   ReportSeverityYesNo  bit                  null,
   Solution             text                 collate Chinese_PRC_CI_AS null,
   Countermeasure       text                 collate Chinese_PRC_CI_AS null,
   Referencelist        text                 collate Chinese_PRC_CI_AS null,
   FinalcialRiskYesNo   bit                  not null,
   Results              text                 collate Chinese_PRC_CI_AS null,
   Conclusion1          text                 collate Chinese_PRC_CI_AS null,
   Conclusion2          text                 collate Chinese_PRC_CI_AS null,
   constraint PK_INHERENTRISK primary key (ProjectID, ID)
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: InherentRiskAccount                                   */
/*==============================================================*/
create table dbo.InherentRiskAccount (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   ID                   int                  not null,
   RiskID               int                  not null,
   RiskSource           nvarchar(50)         collate Chinese_PRC_CI_AS null,
   AccountID            varchar(50)          collate Chinese_PRC_CS_AS_KS_WS null,
   AccountName          nvarchar(50)         collate Chinese_PRC_CI_AS null,
   CognizanceCode       varchar(50)          collate Chinese_PRC_CI_AS null,
   AuditMethod          varchar(50)          collate Chinese_PRC_CI_AS null,
   ControlTestProgram   varchar(50)          collate Chinese_PRC_CI_AS null,
   MaterialityTestProgramYesNo bit                  null,
   DetailTestYesNo      bit                  null,
   Memo                 text                 collate Chinese_PRC_CI_AS null,
   CGoalID              varchar(50)          collate Chinese_PRC_CI_AS null,
   Referencelist1       text                 collate Chinese_PRC_CI_AS null,
   Referencelist2       text                 collate Chinese_PRC_CI_AS null,
   Referencelist3       text                 collate Chinese_PRC_CI_AS null,
   TotalConclusion      text                 collate Chinese_PRC_CI_AS null,
   Countermeasure       text                 collate Chinese_PRC_CI_AS null,
   constraint PK_InherentRiskAccount primary key (ProjectID, ID)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: MainDefine                                            */
/*==============================================================*/
create table MainDefine (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   DefineType           varchar(100)         not null,
   constraint PK_MAINDEFINE primary key (ProjectID, DefineType)
)
go

/*==============================================================*/
/* Table: PIDInformation                                        */
/*==============================================================*/
create table dbo.PIDInformation (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   ClientRiskType       int                  not null default (0),
   currentyearPID       varchar(50)          collate Chinese_PRC_CI_AS null,
   lastperiodPID        varchar(50)          collate Chinese_PRC_CI_AS null,
   IPOPrioryear1PID     varchar(50)          collate Chinese_PRC_CI_AS null,
   IPOPrioryear2PID     varchar(50)          collate Chinese_PRC_CI_AS null,
   IPOPrioryear3PID     varchar(50)          collate Chinese_PRC_CI_AS null,
   Carryforward         int                  not null default (0),
   FinDefine            int                  not null default (0),
   InvDefine            int                  not null default (0),
   WagDefine            int                  not null default (0),
   FADefine             int                  not null default (0),
   constraint PK_PIDINFORMA primary key (ProjectID)
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: PMofFsCode                                            */
/*==============================================================*/
create table dbo.PMofFsCode (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   ID                   varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   Fscode               varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   ValueofPM            decimal(20,2)        not null,
   ValueofMP            decimal(20,2)        not null,
   constraint PK_PMofFsCode primary key (ProjectID, ID)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: PMvalueofJ                                            */
/*==============================================================*/
create table dbo.PMvalueofJ (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   Fscode               varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   Testobject           int                  not null,
   Step                 int                  not null,
   ID                   varchar(50)          not null,
   Overallsample        decimal(20,2)        not null,
   ValueofJ             decimal(20,2)        not null,
   Samplesize           int                  not null,
   SampleTotal          int                  not null,
   Memo                 varchar(500)         collate Chinese_PRC_CI_AS null,
   constraint PK_PMvalueofJ primary key (ProjectID, Fscode, Testobject, Step)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: PlanningProcedures                                    */
/*==============================================================*/
create table dbo.PlanningProcedures (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   SortID               int                  not null,
   StruCode             nvarchar(50)         collate Chinese_PRC_CI_AS not null,
   BusinessCycleID      nvarchar(50)         collate Chinese_PRC_CI_AS not null,
   ProgramName          text                 collate Chinese_PRC_CI_AS not null,
   ReferenceList        nvarchar(50)         collate Chinese_PRC_CI_AS not null,
   constraint PK_PlanningProcedures primary key (ProjectID, SortID)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: PmPlanningMateriality                                 */
/*==============================================================*/
create table dbo.PmPlanningMateriality (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   ID                   varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   CurrentMateriality   decimal(20,2)        not null,
   PriorMateriality     decimal(20,2)        not null,
   CurrentNotAdjustedTax decimal(20,2)        not null,
   PriorNotAdjustedTax  decimal(20,2)        not null,
   CurrentAdjustedTax   decimal(20,2)        not null,
   PriorAdjustedTax     decimal(20,2)        not null,
   QuantityFactors      int                  not null,
   Misstatementratio    decimal(20,4)        not null,
   MinorMisstatements   decimal(20,2)        not null,
   Taxeffect            int                  not null default (1),
   AnticipatedErrorRate decimal(20,4)        not null,
   AnticipatedTaxRate   decimal(20,4)        not null,
   StatutoryTaxRate     decimal(20,4)        not null,
   CriticalElement      int                  not null,
   OtherCriticalElement varchar(50)          collate Chinese_PRC_CI_AS not null,
   CriticalElementCount decimal(22,2)        not null,
   SelectedIndex        decimal(22,4)        not null,
   SelectedIndexDescription varchar(max)         collate Chinese_PRC_CI_AS null,
   PMAfterTax           decimal(22,2)        not null,
   constraint PK_PmPlanningMateriality primary key (ProjectID, ID)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: ProJect                                               */
/*==============================================================*/
create table ProJect (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   TYPECODE             varchar(255)         collate Chinese_PRC_CS_AS_KS_WS not null,
   PROJECTCODE          varchar(255)         collate Chinese_PRC_CS_AS_KS_WS not null,
   PROJECTNAME          varchar(1000)        not null,
   UPPERCODE            varchar(255)         collate Chinese_PRC_CS_AS_KS_WS null,
   JB                   int                  null,
   ISMX                 int                  null,
   constraint PK_PROJECT primary key (ProjectID, TYPECODE, PROJECTCODE)
)
go

/*==============================================================*/
/* Table: ProjectError                                          */
/*==============================================================*/
create table ProjectError (
   ID                   varchar(50)          not null,
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   FsCode               varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   AccountCode          varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AuxiliaryCode        varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   VoucherID            varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null default newid(),
   Type                 int                  not null,
   ReferCode            varchar(50)          null,
   SampleData           decimal(20, 2)       not null,
   CheckedData          decimal(20, 2)       not null,
   ProjectError         decimal(20, 2)       not null,
   AffectKm             varchar(500)         null,
   ErrorData            decimal(20, 2)       not null,
   ErrorReason          varchar(100)         null,
   ErrorType            int                  not null,
   Memo                 varchar(100)         null,
   IsUse                int                  not null,
   constraint PK_PROJECTERROR primary key (ID)
)
go

/*==============================================================*/
/* Table: ProjectType                                           */
/*==============================================================*/
create table ProjectType (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   TYPECODE             varchar(255)         collate Chinese_PRC_CS_AS_KS_WS not null,
   TYPENAME             varchar(1000)        not null,
   constraint PK_PROJECTTYPE primary key (ProjectID, TYPECODE)
)
go

/*==============================================================*/
/* Table: Qcwljzpz                                              */
/*==============================================================*/
create table dbo.Qcwljzpz (
   VoucherID            varchar(50)          not null default newid(),
   Clientid             varchar(100)         not null,
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   IncNo                varchar(50)          collate Chinese_PRC_CI_AS not null,
   Date                 datetime             null,
   Period               int                  not null,
   Pzlx                 varchar(255)         collate Chinese_PRC_CI_AS null,
   Pzh                  varchar(255)         collate Chinese_PRC_CI_AS null,
   Djh                  int                  null,
   AccountCode          varchar(100)         collate Chinese_PRC_CS_AS_KS_WS null,
   ProjectCode          varchar(100)         collate Chinese_PRC_CS_AS_KS_WS null,
   Zy                   varchar(Max)         collate Chinese_PRC_CI_AS null,
   Jfje                 decimal(20,2)        null,
   Dfje                 decimal(20,2)        null,
   Jfsl                 decimal(20,4)        null,
   Dfsl                 decimal(20,4)        null,
   ZDR                  varchar(255)         collate Chinese_PRC_CI_AS null,
   dfkm                 varchar(200)         collate Chinese_PRC_CI_AS null,
   AccountingAge        int                  null default (0),
   qmyegc               int                  null default (0),
   Fsje                 decimal(20,2)        null,
   Jd                   int                  null,
   FDetailID            int                  null default -1,
   constraint PK_PK_Qcwljzpz primary key (VoucherID)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: QhJzpz                                                */
/*==============================================================*/
create table dbo.QhJzpz (
   VoucherID            varchar(50)          not null default newid(),
   Clientid             varchar(100)         not null,
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   IncNo                varchar(50)          collate Chinese_PRC_CI_AS not null,
   Date                 datetime             null,
   Period               int                  not null,
   Pzlx                 varchar(255)         collate Chinese_PRC_CI_AS null,
   Pzh                  varchar(255)         collate Chinese_PRC_CI_AS null,
   Djh                  int                  null,
   AccountCode          varchar(255)         collate Chinese_PRC_CS_AS_KS_WS null,
   ProjectCode          varchar(255)         collate Chinese_PRC_CS_AS_KS_WS null,
   Zy                   varchar(255)         collate Chinese_PRC_CI_AS null,
   Jfje                 decimal(20,2)        null,
   Dfje                 decimal(20,2)        null,
   Jfsl                 decimal(20,4)        null,
   Dfsl                 decimal(20,4)        null,
   ZDR                  varchar(255)         collate Chinese_PRC_CI_AS null,
   dfkm                 varchar(200)         collate Chinese_PRC_CI_AS null,
   Fsje                 decimal(20,2)        null,
   Jd                   int                  null,
   fllx                 INT                  null,
   FDetailID            int                  null default -1,
   constraint PK_QHJZPZ primary key (VoucherID)
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: Qmyegc                                                */
/*==============================================================*/
create table Qmyegc (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   VProjectID           varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AccountCode          varchar(255)         collate Chinese_PRC_CS_AS_KS_WS null,
   ProjectCode          varchar(255)         collate Chinese_PRC_CS_AS_KS_WS null,
   AccountingAge        int                  null,
   TableID              int                  null,
   VoucherID            varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   Date                 datetime             null,
   Jfje                 decimal(20,2)        null,
   Dfje                 decimal(20,2)        null,
   Fsje                 decimal(20,2)        null,
   constraint PK_QMYEGC primary key (ProjectID, VoucherID)
)
go

/*==============================================================*/
/* Table: RecordOfSampleTest                                    */
/*==============================================================*/
create table dbo.RecordOfSampleTest (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   VoucherID            varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   ContentID            int                  not null,
   RecordID             varchar(100)         not null,
   IncNo                varchar(500)          collate Chinese_PRC_CI_AS null,
   NumberofAE           varchar(500)          collate Chinese_PRC_CI_AS null,
   DateofAE             datetime             null,
   AmountofAE           decimal(20,2)        not null default (0),
   QuantityofAE         decimal(20,2)        not null default (0),
   AuditEvidence        varchar(500)         collate Chinese_PRC_CI_AS null,
   RecordType           int                  not null default (1),
   copyofEvidence       varchar(100)         collate Chinese_PRC_CI_AS null,
   constraint PK_RecordOfSampleTest primary key (ProjectID, VoucherID, ContentID)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: ReplaceTestVoucher                                    */
/*==============================================================*/
create table ReplaceTestVoucher (
   VoucherID            varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   FSCode               varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   AccountCode          varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AccountName          varchar(100)         collate Chinese_PRC_CI_AS not null,
   ProjectCode          varchar(100)         collate Chinese_PRC_CS_AS_KS_WS null,
   OsDate               datetime             null,
   PZH                  VARCHAR(100)         null,
   dfkm                 varchar(100)         collate Chinese_PRC_CS_AS_KS_WS null,
   JD                   INT                  not null,
   JE                   decimal(20,2)        null,
   ZY                   varchar(255)         null,
   constraint PK_REPLACETESTVOUCHER primary key (VoucherID, FSCode)
)
go

/*==============================================================*/
/* Table: RiskModel                                             */
/*==============================================================*/
create table dbo.RiskModel (
   ID                   int                  identity(1, 1),
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   RiskType             int                  not null,
   RiskText             varchar(100)         collate Chinese_PRC_CI_AS null,
   RiskValue            int                  not null,
   Riskfactor           float                not null,
   constraint PK_RiskModel primary key (ID)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: RiskResponse                                          */
/*==============================================================*/
create table RiskResponse (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   ID                   int                  not null,
   UpperID              int                  not null,
   DetailResponse       varchar(1000)        not null,
   constraint PK_RISKRESPONSE primary key (ProjectID, ID)
)
go

/*==============================================================*/
/* Table: Riskfactor                                            */
/*==============================================================*/
create table dbo.Riskfactor (
   ID                   int                  identity(1, 1),
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   FSCode               varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   CognizanceCode       varchar(50)          collate Chinese_PRC_CI_AS not null,
   RiskType             int                  not null,
   RiskValue            int                  not null,
   LastRiskValue        int                  not null default (0),
   BCycleCode           varchar(50)          collate Chinese_PRC_CI_AS not null,
   constraint PK_Riskfactor primary key (ID)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: RoleInfo                                              */
/*==============================================================*/
create table dbo.RoleInfo (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   RoleID               int                  not null,
   RoleName             varchar(50)          collate Chinese_PRC_CI_AS not null,
   AliasName            varchar(1000)        collate Chinese_PRC_CI_AS null,
   RolesDescription     varchar(max)         collate Chinese_PRC_CI_AS null,
   SortID               int                  not null,
   ISReview             int                  not null,
   ReviewType           nvarchar(50)         collate Chinese_PRC_CI_AS null,
   ReviewObjecttive     text                 collate Chinese_PRC_CI_AS null,
   IsReadOnly           int                  not null,
   constraint PK_RoleInfo primary key (ProjectID, RoleID)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: StrategicPlanning                                     */
/*==============================================================*/
create table dbo.StrategicPlanning (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   ID                   int                  not null,
   AuditPurposes        nvarchar(200)        collate Chinese_PRC_CI_AS null,
   AccountingStandard   nvarchar(200)        collate Chinese_PRC_CI_AS null,
   AuditingStandard     nvarchar(200)        collate Chinese_PRC_CI_AS null,
   ParticularSpecific   nvarchar(4000)       collate Chinese_PRC_CI_AS null,
   OtherInfo            nvarchar(4000)       collate Chinese_PRC_CI_AS null,
   OtherMatters         nvarchar(4000)       collate Chinese_PRC_CI_AS null,
   ControlStrategyRely  bit                  null,
   RotationTestApply    bit                  null,
   constraint PK_STRATEGICPLANNING primary key (ProjectID, ID)
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: TBAdjustedItems                                       */
/*==============================================================*/
create table dbo.TBAdjustedItems (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AdjustedNO           varchar(50)          collate Chinese_PRC_CI_AS not null,
   AdjustedDetails      varchar(1000)        collate Chinese_PRC_CI_AS not null,
   AdjustedType         varchar(5)           collate Chinese_PRC_CI_AS not null,
   ReferenceList        varchar(50)          collate Chinese_PRC_CI_AS not null,
   AdjustedyesNo        int                  not null default (1),
   TaxYesNo             int                  not null,
   PSYesNo              int                  not null,
   ResolveReference     varchar(50)          collate Chinese_PRC_CI_AS not null,
   FAP                  VARCHAR(MAX)         not null,
   IsAdjusted           int                  not null,
   CreatorLogin         varchar(50)          collate Chinese_PRC_CI_AS not null,
   CreatorName          varchar(50)          not null,
   Createdtime          datetime             not null,
   constraint PK_TBAdjustedItems primary key (ProjectID, AdjustedNO)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: TBAdjustedSubItems                                    */
/*==============================================================*/
create table dbo.TBAdjustedSubItems (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AdjustedNO           varchar(50)          collate Chinese_PRC_CI_AS not null,
   ID                   VARCHAR(50)          not null,
   SortID               int                  not null,
   FSCode               varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   FSName               varchar(500)         collate Chinese_PRC_CI_AS not null,
   AccountCode          varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AuxiliaryCode        varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AccAuxName           varchar(255)         collate Chinese_PRC_CI_AS not null,
   Jd                   int                  not null,
   Jfje                 decimal(20,2)        not null,
   Dfje                 decimal(20,2)        not null,
   Fsje                 decimal(20,2)        not null,
   VoucherID            int                  not null,
   constraint PK_TBAdjustedSubItems primary key (ProjectID, AdjustedNO, ID)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: TBAux                                                 */
/*==============================================================*/
create table TBAux (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AccountCode          varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AuxiliaryCode        varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AuxiliaryName        varchar(100)         collate Chinese_PRC_CI_AS not null,
   FSCode               varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   kmsx                 varchar(100)         collate Chinese_PRC_CI_AS not null,
   YEFX                 int                  not null default (1),
   TBGrouping           nvarchar(50)         collate Chinese_PRC_CS_AS_KS_WS not null,
   Sqqmye               decimal(20,2)        not null default (0),
   Qqccgz               decimal(20,2)        not null default (0),
   jfje                 decimal(20,2)        not null default (0),
   dfje                 decimal(20,2)        not null default (0),
   qmye                 decimal(20,2)        not null default (0),
   constraint PK_TBAUX primary key (ProjectID, AccountCode, AuxiliaryCode)
)
go

/*==============================================================*/
/* Table: TBDetail                                              */
/*==============================================================*/
create table TBDetail (
   ID                   varchar(50)          not null,
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   FSCode               varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   AccountCode          varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AuxiliaryCode        varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AccAuxName           varchar(100)         collate Chinese_PRC_CI_AS not null,
   DataType             int                  not null,
   TBGrouping           varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   TBType               int                  not null,
   IsAccMx              int                  not null,
   IsMx                 int                  not null,
   IsAux                Int                  not null,
   kmsx                 varchar(100)         collate Chinese_PRC_CI_AS not null,
   Yefx                 int                  not null default (1),
   SourceFSCode         varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   Sqqmye               decimal(20,2)        not null default (0),
   Qqccgz               decimal(20,2)        not null default (0),
   jfje                 decimal(20,2)        not null default (0),
   dfje                 decimal(20,2)        not null default (0),
   CrjeJF               decimal(20,2)        not null default (0),
   CrjeDF               decimal(20,2)        not null default (0),
   AjeJF                decimal(20,2)        not null default (0),
   AjeDF                decimal(20,2)        not null default (0),
   RjeJF                decimal(20,2)        not null default (0),
   RjeDF                decimal(20,2)        not null default (0),
   TaxBase              decimal(20,2)        not null default (0),
   PY1                  decimal(20,2)        not null default (0),
   jfje1                decimal(20,2)        not null default (0),
   dfje1                decimal(20,2)        not null default (0),
   jfje2                decimal(20,2)        not null default (0),
   dfje2                decimal(20,2)        not null default (0),
   constraint PK_TBDETAIL primary key (ID, ProjectID)
)
go

/*==============================================================*/
/* Index: TBDeatil_Index_Code                                   */
/*==============================================================*/
create index TBDeatil_Index_Code on TBDetail (
FSCode ASC,
AccountCode ASC,
DataType ASC
)
go

/*==============================================================*/
/* Table: TBDetailExtra                                         */
/*==============================================================*/
create table TBDetailExtra (
   ID                   varchar(50)          not null,
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   ReferenceList        varchar(50)          collate Chinese_PRC_CI_AS not null,
   SelectedSampleLebelYesNo int                  not null default 2,
   MaterialityProgram   int                  not null default 1,
   SelectSampleMethod   int                  not null default 1,
   DrSelectedSampleLebelYesNo int                  not null default 2,
   DrMaterialityProgram int                  not null default 1,
   DrSelectSampleMethod int                  not null default 1,
   CrSelectedSampleLebelYesNo int                  not null default 2,
   CrMaterialityProgram int                  not null default 1,
   CrSelectSampleMethod int                  not null default 1,
   SampleSelectedYesNo  int                  not null,
   SampleSelectedType   int                  not null default (0),
   ConsultBalance       decimal(20,2)        not null default (0),
   ConfirmBalance       decimal(20,2)        not null default (0),
   ConsultType          varchar(100)         collate Chinese_PRC_CI_AS not null,
   RelatedClientID      nvarchar(50)         collate Chinese_PRC_CI_AS not null,
   SampleSelecteStep    int                  not null default (0),
   ErrorYesNO           int                  not null default (0),
   StepofSample         int                  not null default (0),
   AdjustedNo           varchar(50)          collate Chinese_PRC_CI_AS not null,
   AccountProperty      varchar(500)         not null,
   Memo                 varchar(1000)        collate Chinese_PRC_CI_AS null,
   constraint PK_TBDETAILEXTRA primary key (ID, ProjectID)
)
go

/*==============================================================*/
/* Table: TBEliminationItems                                    */
/*==============================================================*/
create table dbo.TBEliminationItems (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   EliminationNO        varchar(50)          collate Chinese_PRC_CI_AS not null,
   EliminationType      int                  not null,
   RelatedProject1      varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   RelatedProject2      varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   EliminationDetails   varchar(1000)        collate Chinese_PRC_CI_AS not null,
   InterTransaction     int                  not null,
   EliminationyesNo     int                  not null,
   CreatorLogin         varchar(50)          collate Chinese_PRC_CI_AS not null,
   CreatorName          varchar(50)          not null,
   Createdtime          datetime             not null,
   constraint PK_TBEliminationItems primary key (ProjectID, EliminationNO)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: TBEliminationSubItems                                 */
/*==============================================================*/
create table dbo.TBEliminationSubItems (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   EliminationNO        varchar(50)          collate Chinese_PRC_CI_AS not null,
   ID                   VARCHAR(50)          not null,
   SortID               int                  not null,
   EliminationPID       varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   FSCode               varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   FSName               varchar(50)          not null,
   AccountCode          varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AccountName          varchar(100)         collate Chinese_PRC_CI_AS not null,
   AuxiliaryCode        varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AuxiliaryName        varchar(100)         collate Chinese_PRC_CI_AS not null,
   JD                   int                  not null,
   Unchecked            decimal(20,2)        not null default (0),
   Checked              decimal(20,2)        not null default (0),
   constraint PK_TBEliminationSubItems primary key (ProjectID, ID, EliminationNO)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: TBFS                                                  */
/*==============================================================*/
create table TBFS (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   FSCode               varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   FsName               varchar(100)         collate Chinese_PRC_CI_AS not null,
   FSType               int                  not null,
   TBType               int                  not null,
   IsMx                 int                  not null,
   Kmsx                 varchar(100)         collate Chinese_PRC_CI_AS not null,
   Yefx                 int                  not null default (1),
   TBGrouping           varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   Sqqmye               decimal(20,2)        not null default (0),
   Qqccgz               decimal(20,2)        not null default (0),
   jfje                 decimal(20,2)        not null default (0),
   dfje                 decimal(20,2)        not null default (0),
   CrjeJF               decimal(20,2)        not null default (0),
   CrjeDF               decimal(20,2)        not null default (0),
   AjeJF                decimal(20,2)        not null default (0),
   AjeDF                decimal(20,2)        not null default (0),
   RjeJF                decimal(20,2)        not null default (0),
   RjeDF                decimal(20,2)        not null default (0),
   TaxBase              decimal(20,2)        not null,
   YearEarlier          decimal(20,2)        not null,
   PY1                  decimal(20,2)        not null default (0),
   PyTaxBase            decimal(20,2)        not null,
   Random               decimal(20,2)        not null default (0),
   GrossPretax          int                  not null default (1),
   jfje1                decimal(20,2)        not null default (0),
   dfje1                decimal(20,2)        not null default (0),
   jfje2                decimal(20,2)        not null default (0),
   dfje2                decimal(20,2)        not null default (0),
   Memo                 nvarchar(500)        collate Chinese_PRC_CI_AS not null,
   constraint PK_TBFS primary key (ProjectID, FSCode)
)
go

/*==============================================================*/
/* Table: TBVoucher                                             */
/*==============================================================*/
create table dbo.TBVoucher (
   VoucherID            varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null default newid(),
   Clientid             varchar(100)         not null,
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   IncNo                varchar(50)          collate Chinese_PRC_CI_AS not null,
   Date                 datetime             not null,
   Period               int                  not null,
   Pzlx                 varchar(255)         collate Chinese_PRC_CI_AS null,
   Pzh                  varchar(255)         collate Chinese_PRC_CI_AS not null,
   Djh                  int                  not null,
   AccountCode          varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   ProjectCode          varchar(100)         collate Chinese_PRC_CS_AS_KS_WS null,
   Zy                   varchar(Max)         collate Chinese_PRC_CI_AS null,
   Jfje                 decimal(20,2)        not null,
   Dfje                 decimal(20,2)        not null,
   Jfsl                 decimal(20,4)        not null,
   Dfsl                 decimal(20,4)        not null,
   ZDR                  varchar(255)         collate Chinese_PRC_CI_AS null,
   dfkm                 varchar(200)         collate Chinese_PRC_CI_AS null,
   Jd                   int                  not null,
   Fsje                 decimal(20,2)        not null,
   Wbdm                 varchar(200)         collate Chinese_PRC_CI_AS null,
   Wbje                 decimal(20,4)        null,
   Hl                   decimal(20,4)        not null,
   FLLX                 int                  not null default (1),
   SampleSelectedYesNo  int                  not null default (0),
   SampleSelectedType   int                  not null default (0),
   TBGrouping           varchar(200)         null,
   EASREF               varchar(5)           collate Chinese_PRC_CI_AS null,
   AccountingAge        int                  not null default (0),
   qmyegc               int                  not null default (0),
   Stepofsample         int                  not null default (0),
   ErrorYesNo           int                  not null default (0),
   FDetailID            int                  null default -1,
   constraint PK_TBVoucher primary key (VoucherID)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Index: Index_Voucher                                         */
/*==============================================================*/
create index Index_Voucher on dbo.TBVoucher (
ProjectID ASC,
AccountCode ASC,
ProjectCode ASC
)
go

/*==============================================================*/
/* Table: TBWlhz                                                */
/*==============================================================*/
create table dbo.TBWlhz (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   ID                   varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   HZNumber             varchar(50)          not null,
   HZSortID             varchar(10)          not null,
   AccountName          varchar(255)         collate Chinese_PRC_CI_AS not null,
   OtherMatters         nvarchar(500)        collate Chinese_PRC_CI_AS null,
   ConsultDate          datetime             null,
   ConfirmDate          datetime             null,
   PostCode             varchar(50)          collate Chinese_PRC_CI_AS null,
   PostAddress          nvarchar(1000)       collate Chinese_PRC_CI_AS null,
   Recipient            nvarchar(100)        collate Chinese_PRC_CI_AS null,
   sample               int                  not null default (0),
   Sendletter           int                  not null default (1),
   Reason               nvarchar(1000)       collate Chinese_PRC_CI_AS null,
   constraint PK_TBWLHZ primary key (ProjectID, ID)
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: TbAppendTable                                         */
/*==============================================================*/
create table TbAppendTable (
   ID                   varchar(50)          not null,
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   FSName               nvarchar(100)        not null,
   FSType               int                  not null,
   AssociatedCode       varchar(max)         collate Chinese_PRC_CS_AS_KS_WS not null,
   CombinationCode      varchar(max)         not null,
   SortID               int                  not null,
   Orderid              int                  not null,
   NoteSort             varchar(50)          not null,
   YSbbQmye             decimal(20,2)        not null,
   QmyeFormula          varchar(1000)        not null,
   YSbbQcye             decimal(20,2)        not null,
   UncheckedVariationAnalysis varchar(1000)        not null,
   UncheckedProportionsAnalysis varchar(1000)        not null,
   CheckedVariationAnalysis varchar(1000)        not null,
   CheckedProportionsAnalysis varchar(1000)        not null,
   QcyeFormulaAccount   varchar(1000)        not null,
   QcyeFormulaStructure varchar(1000)        not null,
   CheckedFormulaAccount varchar(1000)        not null,
   CheckedFormulaStructure varchar(1000)        not null,
   constraint PK_TBAPPENDTABLE primary key (ID, ProjectID)
)
go

/*==============================================================*/
/* Table: Tbwlzl                                                */
/*==============================================================*/
create table dbo.Tbwlzl (
   ID                   varchar(50)          not null,
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   fsCode               varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   AccountCode          varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AuxiliaryCode        varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AgeAnalysis          int                  not null default (0),
   ZLD1                 decimal(20,2)        not null default (0),
   ZLD2                 decimal(20,2)        not null default (0),
   ZLD3                 decimal(20,2)        not null default (0),
   ZLD4                 decimal(20,2)        not null default (0),
   ZLD5                 decimal(20,2)        not null default (0),
   ZLD6                 decimal(20,2)        not null default (0),
   ZLD7                 decimal(20,2)        not null default (0),
   ZLD8                 decimal(20,2)        not null default (0),
   ZLD9                 decimal(20,2)        not null default (0),
   significant          int                  not null default (0),
   Impairmenttestmethod int                  not null default (1),
   impairmentamount     decimal(20,2)        not null default (0),
   BalanceAnalysis      int                  not null default (0),
   memo                 varchar(500)         collate Chinese_PRC_CI_AS not null,
   HZZBZLD1             decimal(20,2)        not null default (0),
   HZZBZLD2             decimal(20,2)        not null default (0),
   HZZBZLD3             decimal(20,2)        not null default (0),
   HZZBZLD4             decimal(20,2)        not null default (0),
   HZZBZLD5             decimal(20,2)        not null default (0),
   HZZBZLD6             decimal(20,2)        not null default (0),
   HZZBZLD7             decimal(20,2)        not null default (0),
   HZZBZLD8             decimal(20,2)        not null default (0),
   HZZBZLD9             decimal(20,2)        not null default (0),
   Creditperiod         int                  not null default (0),
   constraint PK__TBwlzl primary key (ID, ProjectID)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Index: TBwlzl_Index                                          */
/*==============================================================*/
create index TBwlzl_Index on dbo.Tbwlzl (
fsCode ASC,
AccountCode ASC
)
go

/*==============================================================*/
/* Table: WlhzandTB                                             */
/*==============================================================*/
create table dbo.WlhzandTB (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   ID                   varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   WlhzID               varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   FSCode               varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   AccountCode          varchar(255)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AuxiliaryCode        varchar(255)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AccountName          varchar(255)         collate Chinese_PRC_CI_AS not null,
   Sendletteryesno      int                  null default (1),
   constraint PK_WlhzandTB primary key (ProjectID, ID)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: accountperiod                                         */
/*==============================================================*/
create table accountperiod (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   accountperiod        int                  not null,
   Period               int                  not null,
   StartDate            datetime             not null,
   EndDate              datetime             not null,
   DateType             int                  not null,
   CurrentyearPID       varchar(100)         not null,
   constraint PK_ACCOUNTPERIOD primary key (ProjectID, accountperiod)
)
go

/*==============================================================*/
/* Table: kjqj                                                  */
/*==============================================================*/
create table kjqj (
   ProjectID            varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   KJDate               varchar(4)           not null,
   constraint PK_KJQJ primary key (ProjectID, KJDate)
)
go

/*==============================================================*/
/* Table: UserRequestRecord                                     */
/*==============================================================*/
create table UserRequestRecord (
   ID                   int                  identity,
   UserCode             varchar(50)          not null,
   ProjectID            varchar(50)          null,
   RequestContent       varchar(max)         null,
   RequestTime          datetime             null,
   constraint PK_USERREQUESTRECORD primary key (ID)
)
go


/*==============================================================*/
/* View: VIEW_AllExistUser                                      */
/*==============================================================*/
create view VIEW_AllExistUser as
select projectid,strupreparer as LoginName from FileScriptList where strupreparer is not null and strupreparer<>'' group by projectid,strupreparer
union
select projectid,StruReviewer as LoginName from FileScriptList where StruReviewer is not null and StruReviewer<>'' group by projectid,StruReviewer
union
select projectid,NodeProcessor as LoginName from FlowsAction group by projectid,NodeProcessor
union
select projectid,CreatorLogin as LoginName from TBAdjustedItems group by projectid,CreatorLogin
union
select projectid,CreatorLogin as LoginName from TBEliminationItems group by projectid,CreatorLogin
go

/*==============================================================*/
/* View: VIEW_TBDetail                                          */
/*==============================================================*/
create view VIEW_TBDetail as
select
   ID,
   ProjectID,
   AccountCode,
   AuxiliaryCode,
   AccAuxName,
   DataType,
   TBGrouping,
   FSCode,
   TBType,
   IsAccMx,
   IsMx,
   IsAux,
   kmsx,
   Yefx,
   SourceFSCode,
   Sqqmye,
   Qqccgz,
   (Sqqmye+Qqccgz) as QCYE,
   jfje,
   dfje,
   (Sqqmye+Qqccgz+jfje-dfje) as QMYE,
   CrjeJF,
   CrjeDF,
   (Sqqmye+Qqccgz+jfje-dfje+CrjeJF-CrjeDF) as Unchecked,
   AjeJF,
   AjeDF,
   (Sqqmye+Qqccgz+jfje-dfje+CrjeJF-CrjeDF+AjeJF-AjeDF) as Adjusted,
   RjeJF,
   RjeDF,
   (Sqqmye+Qqccgz+jfje-dfje+CrjeJF-CrjeDF+AjeJF-AjeDF+RjeJF-RjeDF) as Checked,
   TaxBase,
   PY1,
   jfje1,
   dfje1,
   jfje2,
   dfje2
from
   TBDetail
go

/*==============================================================*/
/* View: VIEW_TBFS                                              */
/*==============================================================*/
create view VIEW_TBFS as
select
   ProjectID,
   FSCode,
   FsName,
   FSType,
   TBType,
   IsMx,
   Kmsx,
   Yefx,
   TBGrouping,
   Sqqmye,
   Qqccgz,
   (Sqqmye+Qqccgz) as QCYE,
   jfje,
   dfje,
   (Sqqmye+Qqccgz+jfje-dfje) as QMYE,
   CrjeJF,
   CrjeDF,
   (Sqqmye+Qqccgz+jfje-dfje+CrjeJF-CrjeDF) as Unchecked,
   AjeJF,
   AjeDF,
   (Sqqmye+Qqccgz+jfje-dfje+CrjeJF-CrjeDF+AjeJF-AjeDF) as Adjusted,
   RjeJF,
   RjeDF,
   (Sqqmye+Qqccgz+jfje-dfje+CrjeJF-CrjeDF+AjeJF-AjeDF+RjeJF-RjeDF) as Checked,
   TaxBase,
   YearEarlier,
   PY1,
   PyTaxBase,
   Random,
   GrossPretax,
   jfje1,
   dfje1,
   jfje2,
   dfje2,
   Memo
from
   TBFS
where
   SUBSTRING(FSCODE, 1, 1) <> 8
UNION
select
   ProjectID,
   FSCode,
   FsName,
   FSType,
   TBType,
   IsMx,
   Kmsx,
   Yefx,
   TBGrouping,
   Sqqmye,
   Qqccgz,
   0 as QCYE,
   jfje,
   dfje,
   (jfje-dfje) as QMYE,
   CrjeJF,
   CrjeDF,
   (jfje-dfje+CrjeJF-CrjeDF) as Unchecked,
   AjeJF,
   AjeDF,
   (jfje-dfje+CrjeJF-CrjeDF+AjeJF-AjeDF) as Adjusted,
   RjeJF,
   RjeDF,
   (jfje-dfje+CrjeJF-CrjeDF+AjeJF-AjeDF+RjeJF-RjeDF) as Checked,
   TaxBase,
   YearEarlier,
   PY1,
   PyTaxBase,
   Random,
   GrossPretax,
   jfje1,
   dfje1,
   jfje2,
   dfje2,
   Memo
from
   TBFS
where
   SUBSTRING(FSCODE, 1, 1) = 8
go

/*==============================================================*/
/* View: View_AllAccount                                        */
/*==============================================================*/
create view View_AllAccount as
select
   t1.FSCode collate Chinese_PRC_CS_AS_KS_WS as id,
   t1.ProjectID,
   t1.FSCode,
   t1.FsName,
   '' as accountcode,
   '' as accountname,
   1 as AccountType,
   '' as auxiliarycode,
   '' as AuxiliaryName,
   t1.checked*t1.yefx as checked
from
   dbo.VIEW_TBFS t1
where
   t1.ismx = 1
union
select
   t1.id,
   t1.ProjectID,
   t1.FSCode,
   (select t.fsname from fscodeconfig t where t.projectid=t1.projectid and t.fscode=t1.fscode) as fsname,
   t1.AccountCode,
   t1.AccAuxName as accountname,
   (Case t1.IsAux when 0 then 2 else 3 end) as AccountType,
   t1.AuxiliaryCode,
   (Case t1.IsAux when 0 then t1.AccAuxName else (select Top 1 t.AccAuxName from dbo.TbDetail t where t.projectid=t1.ProjectID and t.IsAux=0 and t.AccountCode=t1.TBGrouping)+ '/' +t1.AccAuxName end) as AuxiliaryName,
   t1.checked*t1.yefx as checked
from
   dbo.VIEW_TBDetail t1
where
   t1.accountcode <> ''
   and t1.fscode <> ''
go

/*==============================================================*/
/* View: View_DetailAccount                                     */
/*==============================================================*/
create view View_DetailAccount as
select
   t1.fscode + t1.AccountCode+t1.AuxiliaryCode as id,
   t1.projectid,
   t1.fscode,
   (SELECT t .fsname FROM fscodeconfig t WHERE   t .projectid = t1.projectid AND t .fscode = t1.fscode) as fsname,
   t1.AccountCode,
   t1.AccAuxName as AccountName,
   t1.AuxiliaryCode,
   '' as AuxiliaryName,
   isaux,
   t1.checked,
   t1.qcye
from
   VIEW_TBDetail t1
where
   t1.ismx = 1
   AND t1.IsAux = 0
   AND t1.fscode <> ''
UNION
select
   t1.fscode + t1.AccountCode+t1.AuxiliaryCode as id,
   t1.ProjectID,
   t1.FSCode,
   (SELECT t .fsname FROM fscodeconfig t WHERE   t .projectid = t1.projectid AND t .fscode = t1.fscode) as fsname,
   t1.AccountCode,
   (SELECT top 1 d.AccAuxName from TBDetail d where d.ProjectID=t1.projectid and d.AccountCode=t1.tbgrouping and d.IsAux=0) as AccountName,
   t1.AuxiliaryCode,
   ((SELECT top 1 d.AccAuxName from TBDetail d where d.ProjectID=t1.projectid and d.AccountCode=t1.tbgrouping and d.IsAux=0)+'\'+t1.AccAuxName) as AuxiliaryName,
   IsAux,
   t1.checked,
   t1.qcye
from
   VIEW_TBDetail t1
where
   t1.ismx = 1
   AND t1.IsAux = 1
   AND t1.fscode <> ''
go




/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2012                    */
/* Created on:     2018/11/23 23:35:44                          */
/*==============================================================*/


if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.ComNoteData')
            and   name  = 'Index_ComNoteData'
            and   indid > 0
            and   indid < 255)
   drop index dbo.ComNoteData.Index_ComNoteData
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.ComNoteData')
            and   type = 'U')
   drop table dbo.ComNoteData
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.ComNoteDataDetail')
            and   name  = 'Index_ComNoteDataDetail'
            and   indid > 0
            and   indid < 255)
   drop index dbo.ComNoteDataDetail.Index_ComNoteDataDetail
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.ComNoteDataDetail')
            and   type = 'U')
   drop table dbo.ComNoteDataDetail
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.ComNoteMemo')
            and   type = 'U')
   drop table dbo.ComNoteMemo
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CombinationChangedReason')
            and   type = 'U')
   drop table CombinationChangedReason
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CombinationList')
            and   type = 'U')
   drop table CombinationList
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CombinationRange')
            and   type = 'U')
   drop table CombinationRange
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('EliminationAllocate')
            and   name  = 'Index_EliminationAllocate'
            and   indid > 0
            and   indid < 255)
   drop index EliminationAllocate.Index_EliminationAllocate
go

if exists (select 1
            from  sysobjects
           where  id = object_id('EliminationAllocate')
            and   type = 'U')
   drop table EliminationAllocate
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.NoteAndTB')
            and   name  = 'Index_NoteAndTB'
            and   indid > 0
            and   indid < 255)
   drop index dbo.NoteAndTB.Index_NoteAndTB
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.NoteAndTB')
            and   type = 'U')
   drop table dbo.NoteAndTB
go

if exists (select 1
            from  sysobjects
           where  id = object_id('NoteCheckRule')
            and   type = 'U')
   drop table NoteCheckRule
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.NoteColumnAttribute')
            and   type = 'U')
   drop table dbo.NoteColumnAttribute
go

if exists (select 1
            from  sysobjects
           where  id = object_id('NoteComFormula')
            and   type = 'U')
   drop table NoteComFormula
go

if exists (select 1
            from  sysobjects
           where  id = object_id('NoteConnectRule')
            and   type = 'U')
   drop table NoteConnectRule
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.NoteData')
            and   type = 'U')
   drop table dbo.NoteData
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.NoteDataDetail')
            and   type = 'U')
   drop table dbo.NoteDataDetail
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.NoteForm')
            and   type = 'U')
   drop table dbo.NoteForm
go

if exists (select 1
            from  sysobjects
           where  id = object_id('NoteFormula')
            and   type = 'U')
   drop table NoteFormula
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.NoteMemo')
            and   type = 'U')
   drop table dbo.NoteMemo
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.NoteRowAttribute')
            and   type = 'U')
   drop table dbo.NoteRowAttribute
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.SubComNoteData')
            and   name  = 'Index_SubComNoteData'
            and   indid > 0
            and   indid < 255)
   drop index dbo.SubComNoteData.Index_SubComNoteData
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.SubComNoteData')
            and   type = 'U')
   drop table dbo.SubComNoteData
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.SubComNoteDataDetail')
            and   name  = 'Index_SubComNoteDataDetail'
            and   indid > 0
            and   indid < 255)
   drop index dbo.SubComNoteDataDetail.Index_SubComNoteDataDetail
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.SubComNoteDataDetail')
            and   type = 'U')
   drop table dbo.SubComNoteDataDetail
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SubTBCombination')
            and   name  = 'Index_SubTBCombination'
            and   indid > 0
            and   indid < 255)
   drop index SubTBCombination.Index_SubTBCombination
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SubTBCombination')
            and   type = 'U')
   drop table SubTBCombination
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TBCombination')
            and   type = 'U')
   drop table TBCombination
go

/*==============================================================*/
/* Table: ComNoteData                                           */
/*==============================================================*/
create table dbo.ComNoteData (
   GUID                 varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   ProjectID            varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   StruCode             varchar(255)         not null,
   FormCode             varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   NoteCode             varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   Bth                  nvarchar(255)        not null,
   CheckData            decimal(20,2)        not null default 0,
   constraint PK_T_ComNoteData primary key (GUID)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Index: Index_ComNoteData                                     */
/*==============================================================*/
create index Index_ComNoteData on dbo.ComNoteData (
ProjectID ASC,
StruCode ASC,
FormCode ASC,
NoteCode ASC
)
go

/*==============================================================*/
/* Table: ComNoteDataDetail                                     */
/*==============================================================*/
create table dbo.ComNoteDataDetail (
   GUID                 varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   UpperGUID            varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   ProjectID            varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   StruCode             varchar(255)         collate Chinese_PRC_CS_AS_KS_WS not null,
   ComProjectID         varchar(255)         collate Chinese_PRC_CS_AS_KS_WS null,
   FormCode             varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   NoteCode             varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   ColumnCode           varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   NumberField          decimal(20,2)        not null default 0,
   TextField            nvarchar(255)        null,
   DateField            datetime             null,
   constraint PK__T_ComNoteDataDetail___3214EC27E59FC68F primary key (GUID)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Index: Index_ComNoteDataDetail                               */
/*==============================================================*/
create index Index_ComNoteDataDetail on dbo.ComNoteDataDetail (
ProjectID ASC,
StruCode ASC,
ComProjectID ASC,
FormCode ASC,
NoteCode ASC,
ColumnCode ASC
)
go

/*==============================================================*/
/* Table: ComNoteMemo                                           */
/*==============================================================*/
create table dbo.ComNoteMemo (
   ProjectID            varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   StruCode             varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   FSCode               varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   FormCode             varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   Memo                 nvarchar(4000)       null,
   memohelp             varchar(Max)         null,
   constraint PK_COMNOTEMEMO primary key (ProjectID, StruCode, FormCode)
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: CombinationChangedReason                              */
/*==============================================================*/
create table CombinationChangedReason (
   GUID                 varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   ProjectID            varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   StruCode             varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   ComPID               varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   ChangeReason         varchar(max)         not null default '0',
   constraint PK_COMBINATIONCHANGEDREASON primary key (GUID)
)
go

/*==============================================================*/
/* Table: CombinationList                                       */
/*==============================================================*/
create table CombinationList (
   ProjectID            varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   ComCode              varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   ComName              varchar(500)         not null,
   constraint PK_COMBINATIONLIST primary key (ProjectID, ComCode)
)
go

/*==============================================================*/
/* Table: CombinationRange                                      */
/*==============================================================*/
create table CombinationRange (
   GUID                 varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   ProjectID            varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   StruCode             varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   ComPID               varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   IsForeign            int                  not null default 0,
   Rate                 decimal(10,4)        null,
   ComTime              datetime             not null,
   constraint PK_COMBINATIONRANGE primary key (GUID)
)
go

/*==============================================================*/
/* Table: EliminationAllocate                                   */
/*==============================================================*/
create table EliminationAllocate (
   GUID                 varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   ProjectID            varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   EliminationNO        varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   ComPID               varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   FsCode               varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   AccountCode          varchar(100)         collate Chinese_PRC_CS_AS_KS_WS null,
   AuxiliaryCode        varchar(100)         collate Chinese_PRC_CS_AS_KS_WS null,
   FormCode             varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   NoteCode             varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   ColumnCode           varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   CheckData            decimal(20,2)        not null default 0,
   ChildEliminationID   varchar(50)          not null,
   constraint PK_ELIMINATIONALLOCATE primary key (GUID)
)
go

/*==============================================================*/
/* Index: Index_EliminationAllocate                             */
/*==============================================================*/
create index Index_EliminationAllocate on EliminationAllocate (
ProjectID ASC,
EliminationNO ASC,
ComPID ASC,
FormCode ASC,
NoteCode ASC,
ColumnCode ASC,
ChildEliminationID ASC
)
go

/*==============================================================*/
/* Table: NoteAndTB                                             */
/*==============================================================*/
create table dbo.NoteAndTB (
   GUID                 VARCHAR(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   ProjectID            varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   NoteCode             varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   FormCode             varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   FSCode               varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AccountCode          varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   AuxiliaryCode        varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   TBType               int                  not null default 0,
   IDGrouping           varchar(50)          collate Chinese_PRC_CS_AS_KS_WS null,
   constraint PK__T_NoteAndTB primary key (GUID)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Index: Index_NoteAndTB                                       */
/*==============================================================*/
create index Index_NoteAndTB on dbo.NoteAndTB (
ProjectID ASC,
NoteCode ASC,
FormCode ASC,
AuxiliaryCode ASC,
TBType ASC
)
go

/*==============================================================*/
/* Table: NoteCheckRule                                         */
/*==============================================================*/
create table NoteCheckRule (
   ID                   varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   ProjectID            varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   FSCode               varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   FormType             int                  not null default 0,
   CheckPathOne         varchar(1000)        not null,
   CheckPathTwo         varchar(1000)        not null,
   Remark               varchar(2000)        not null,
   IsUseCom             int                  not null,
   IsUse                int                  not null default 0,
   SelectType           int                  not null,
   constraint PK_NOTECHECKRULE primary key (ID, ProjectID)
)
go

/*==============================================================*/
/* Table: NoteColumnAttribute                                   */
/*==============================================================*/
create table dbo.NoteColumnAttribute (
   ProjectID            varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   ColumnCode           varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   FSCode               varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   FormCode             varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   Title                varchar(255)         not null,
   SortID               int                  not null default 0,
   Type                 int                  not null default 0,
   IsConnect            int                  not null default 0,
   ConnectName          varchar(50)          null,
   IsCheckRow           int                  not null,
   IsMerge              int                  not null default 0,
   constraint PK_NOTECOLUMNATTRIBUTE primary key (ProjectID, ColumnCode, FormCode)
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: NoteComFormula                                        */
/*==============================================================*/
create table NoteComFormula (
   ProjectID            varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   StruCode             varchar(255)         collate Chinese_PRC_CS_AS_KS_WS not null,
   ColumnCode           varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   NoteCode             varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   FormCode             varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   FSCode               varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   Formula              Varchar(500)         not null,
   constraint PK_NOTECOMFORMULA primary key (ProjectID, StruCode, ColumnCode, NoteCode, FormCode)
)
go

/*==============================================================*/
/* Table: NoteConnectRule                                       */
/*==============================================================*/
create table NoteConnectRule (
   ID                   varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   ProjectID            varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   FSCode               varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   FormCode             varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   ColumnCodeOne        varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   ColumnCodeTwo        varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   IsUse                int                  not null default 0,
   constraint PK_NOTECONNECTRULE primary key (ID)
)
go

/*==============================================================*/
/* Table: NoteData                                              */
/*==============================================================*/
create table dbo.NoteData (
   ProjectID            varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   NoteCode             varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   FormCode             varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   Bth                  nvarchar(255)        not null,
   CheckData            decimal(20,2)        not null default 0,
   constraint PK__T_NoteData___3214EC27E59FC68F primary key (ProjectID, NoteCode, FormCode)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: NoteDataDetail                                        */
/*==============================================================*/
create table dbo.NoteDataDetail (
   ProjectID            varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   FormCode             varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   NoteCode             varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   ColumnCode           varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   NumberField          decimal(20,2)        not null default 0,
   TextField            nvarchar(255)        null,
   DateField            datetime             null,
   constraint PK__T_NoteDataDetail___3214EC27E59FC68F primary key (ProjectID, FormCode, NoteCode, ColumnCode)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: NoteForm                                              */
/*==============================================================*/
create table dbo.NoteForm (
   ProjectID            varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   FormCode             varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   FormName             nvarchar(255)        not null,
   SortID               int                  not null,
   IsUse                int                  not null default 0,
   FSCode               varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   FormType             int                  not null default 0,
   Remark               nvarchar(2000)       null,
   StructHash           varchar(100)         not null,
   DataHash             varchar(100)         not null,
   IsChangeRow          int                  not null,
   IsCombination        int                  not null default 0,
   constraint PK_NOTEFORM primary key (ProjectID, FormCode)
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: NoteFormula                                           */
/*==============================================================*/
create table NoteFormula (
   ProjectID            varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   ColumnCode           varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   NoteCode             varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   FormCode             varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   FSCode               varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   Formula              Varchar(500)         not null,
   constraint PK_NOTEFORMULA primary key (ProjectID, ColumnCode, NoteCode, FormCode)
)
go

/*==============================================================*/
/* Table: NoteMemo                                              */
/*==============================================================*/
create table dbo.NoteMemo (
   ProjectID            varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   FSCode               varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   FormCode             varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   Memo                 nvarchar(4000)       null,
   memohelp             varchar(Max)         null,
   constraint PK_NOTEMEMO primary key (ProjectID, FormCode)
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: NoteRowAttribute                                      */
/*==============================================================*/
create table dbo.NoteRowAttribute (
   ProjectID            varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   NoteCode             varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   FormCode             varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   FSCode               varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   UpperNoteCode        varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   SortID               int                  not null default 0,
   Bth                  nvarchar(255)        not null,
   IsQzh                int                  not null default 0,
   IsGdh                int                  not null default 1,
   IsCheckRow           int                  not null default 0,
   IsConnect            int                  not null default 1,
   constraint PK_NOTEROWATTRIBUTE primary key (ProjectID, NoteCode, FormCode)
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: SubComNoteData                                        */
/*==============================================================*/
create table dbo.SubComNoteData (
   GUID                 varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   ProjectID            varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   StruCode             varchar(255)         collate Chinese_PRC_CS_AS_KS_WS not null,
   EliminationNO        varchar(255)         null,
   ComProjectID         varchar(255)         collate Chinese_PRC_CS_AS_KS_WS not null,
   FormCode             varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   NoteCode             varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   IsGdh                int                  not null default 0,
   Bth                  nvarchar(255)        not null,
   CheckData            decimal(20,2)        not null default 0,
   constraint PK_SUBCOMNOTEDATA primary key (GUID)
)
on "PRIMARY"
go

/*==============================================================*/
/* Index: Index_SubComNoteData                                  */
/*==============================================================*/
create index Index_SubComNoteData on dbo.SubComNoteData (
ProjectID ASC,
StruCode ASC,
ComProjectID ASC,
FormCode ASC,
NoteCode ASC
)
go

/*==============================================================*/
/* Table: SubComNoteDataDetail                                  */
/*==============================================================*/
create table dbo.SubComNoteDataDetail (
   GUID                 varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   UpperGUID            varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   ProjectID            varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   StruCode             varchar(255)         collate Chinese_PRC_CS_AS_KS_WS not null,
   ComProjectID         varchar(255)         collate Chinese_PRC_CS_AS_KS_WS not null,
   FormCode             varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   NoteCode             varchar(100)         collate Chinese_PRC_CS_AS_KS_WS not null,
   ColumnCode           varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   NumberField          decimal(20,2)        not null default 0,
   TextField            nvarchar(255)        null,
   DateField            datetime             null,
   constraint PK__SubComNoteDataDetail___3214EC27E59FC68F primary key (GUID)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Index: Index_SubComNoteDataDetail                            */
/*==============================================================*/
create index Index_SubComNoteDataDetail on dbo.SubComNoteDataDetail (
ProjectID ASC,
StruCode ASC,
ComProjectID ASC,
FormCode ASC,
NoteCode ASC,
ColumnCode ASC
)
go

/*==============================================================*/
/* Table: SubTBCombination                                      */
/*==============================================================*/
create table SubTBCombination (
   GUID                 varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   ProjectID            varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   StruCode             varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   ComProjectID         varchar(255)         collate Chinese_PRC_CS_AS_KS_WS not null,
   FsCode               varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   Yefx                 int                  not null,
   FsName               nvarchar(50)         not null,
   Unchecked            decimal(20, 2)       not null default 0,
   UncheckedCeeJF       decimal(20, 2)       not null default 0,
   UncheckedCeeDF       decimal(20, 2)       not null default 0,
   UncheckedCFSData     decimal(20, 2)       not null default 0,
   Checked              decimal(20, 2)       not null default 0,
   CheckedCeeJF         decimal(20, 2)       not null default 0,
   CheckedCeeDF         decimal(20, 2)       not null default 0,
   CheckedCFSData       decimal(20, 2)       not null default 0,
   constraint PK_SUBTBCOMBINATION primary key (GUID)
)
go

/*==============================================================*/
/* Index: Index_SubTBCombination                                */
/*==============================================================*/
create index Index_SubTBCombination on SubTBCombination (
ProjectID ASC,
StruCode ASC,
ComProjectID ASC,
FsCode ASC
)
go

/*==============================================================*/
/* Table: TBCombination                                         */
/*==============================================================*/
create table TBCombination (
   ProjectID            varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   StruCode             varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   FsCode               varchar(50)          collate Chinese_PRC_CS_AS_KS_WS not null,
   Yefx                 int                  not null,
   FsName               nvarchar(50)         not null,
   FSType               int                  not null default 0,
   TBType               int                  not null default 0,
   Unchecked            decimal(20, 2)       not null default 0,
   UncheckedCeeJF       decimal(20, 2)       not null default 0,
   UncheckedCeeDF       decimal(20, 2)       not null default 0,
   UncheckedCFSData     decimal(20, 2)       not null default 0,
   Checked              decimal(20, 2)       not null default 0,
   CheckedCeeJF         decimal(20, 2)       not null default 0,
   CheckedCeeDF         decimal(20, 2)       not null default 0,
   CheckedCFSData       decimal(20, 2)       not null default 0,
   PY1                  decimal(20, 2)       not null default 0,
   PY2                  decimal(20, 2)       not null default 0,
   PY3                  decimal(20, 2)       not null default 0,
   PY4                  decimal(20, 2)       not null default 0,
   PY5                  decimal(20, 2)       not null default 0,
   TBGrouping           nvarchar(50)         collate Chinese_PRC_CS_AS_KS_WS null,
   constraint PK_TBCOMBINATION primary key (ProjectID, StruCode, FsCode)
)
go






/****** Object:  UserDefinedTableType [dbo].[FileScriptListType]    Script Date: 2018/10/16 15:57:49 ******/
CREATE TYPE [dbo].[FileScriptListType] AS TABLE(
	[ProjectID] [varchar](100) NOT NULL,
	[FileLibID] [varchar](128) NULL,
	[StruCode] [varchar](128) NOT NULL,
	[StruCodeText] [varchar](128) NULL,
	[StruName] [nvarchar](500) NOT NULL,
	[UpperStruCode] [varchar](128) NOT NULL,
	[StruType] [int] NOT NULL,
	[StruDescription] [nvarchar](1000) NULL,
	[StruCriticalYesNO] [bit] NOT NULL,
	[StruTarget] [varchar](500) NOT NULL,
	[BuildingType] [varchar](100) NULL,
	[Checkout] [int] NULL,
	[CheckedReviewer] [nvarchar](1000) NULL,
	[StruPreparer] [nvarchar](1000) NULL,
	[StruReviewer] [nvarchar](1000) NULL,
	[StruMasterORCarbon] [bit] NULL,
	[FlowExcutedState] [int] NULL,
	[OpenNotes] [int] NULL,
	[ClosedNotes] [int] NULL,
	[StruSize] [int] NULL,
	[StruCreateTime] [datetime] NULL,
	[StruLastEditTime] [datetime] NULL,
	[FlowID] [int] NULL,
	[FlowExcutedTime] [datetime] NULL,
	[Fsitem] [int] NULL,
	[FSCode] [varchar](50) NULL,
	[BCycleCode] [varchar](100) NULL,
	[AppScopeProject] [int] NULL,
	[NonAppScopeProject] [int] NULL,
	[AppCombineProject] [int] NULL,
	[BuildLevel] [int] NULL,
	[carrieddown] [int] NULL,
	[ConnectData] [int] NULL
)
GO


/****** Object:  UserDefinedTableType [dbo].[TBDetailType]    Script Date: 2018/11/6 10:24:22 ******/
CREATE TYPE [dbo].[TBDetailType] AS TABLE(
	[ID] [varchar](50) NOT NULL,
	[ProjectID] [varchar](100) NOT NULL,
	[FSCode] [varchar](50) NOT NULL,
	[AccountCode] [varchar](100) NOT NULL,
	[AuxiliaryCode] [varchar](100) NOT NULL,
	[AccAuxName] [varchar](100) NOT NULL,
	[DataType] [int] NOT NULL,
	[TBGrouping] [varchar](100) NOT NULL,
	[TBType] [int] NOT NULL,
	[IsAccMx] [int] NOT NULL,
	[IsMx] [int] NOT NULL,
	[IsAux] [int] NOT NULL,
	[kmsx] [varchar](100) NOT NULL,
	[Yefx] [int] NOT NULL,
	[SourceFSCode] [varchar](50) NOT NULL,
	[Sqqmye] [decimal](20, 2) NOT NULL,
	[jfje] [decimal](20, 2) NOT NULL,
	[dfje] [decimal](20, 2) NOT NULL,
	[addState] [bit] NULL
)
GO
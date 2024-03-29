IF OBJECT_ID (N'dbo.Accountclass') IS NOT NULL
	DROP TABLE dbo.Accountclass
GO

CREATE TABLE dbo.Accountclass
	(
	  Accountname VARCHAR (50) NOT NULL
	, syjz        INT NOT NULL
	, CONSTRAINT PK_Accountclass PRIMARY KEY (Accountname)
	)
 



GO
INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'保单红利支出'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'保费收入'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'本年利润'
	, 2
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'补贴收入'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'财务费用'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'分保费用'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'分出保费'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'公允价值变动损益'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'管理费用'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'汇兑损益'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'勘探费用'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'利润分配'
	, 2
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'利息收入'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'利息支出'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'赔付支出'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'赔付支出净额'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'其他收益'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'其他业务成本'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'其他业务收入'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'其他业务支出'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'手续费及佣金收入'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'手续费及佣金支出'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'税金及附加'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'所得税'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'所得税费用'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'摊回保险责任准备金'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'摊回分保费用'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'摊回赔付支出'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'提取保险合同准备金净额'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'提取保险责任准备金'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'提取未到期责任准备金'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'投资收益'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'退保金'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'销售费用'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'研发费用'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'已赚保费'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'以前年度损益调整'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'营业成本'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'营业费用'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'营业收入'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'营业税金及附加'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'营业外收入'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'营业外支出'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'营业务税金及附加'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'主营业务成本'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'主营业务收入'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'主营业务税金及附加'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'资产处置收益'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'资产处置损失'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'资产处置损益'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'资产减值损失'
	, 1
	)
GO

INSERT INTO dbo.Accountclass
	(
	Accountname
	, syjz
	)
VALUES
	(
	'租赁收入'
	, 1
	)
GO


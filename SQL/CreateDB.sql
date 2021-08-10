create database [OpenBroker]

use [OpenBroker]

/****** Object:  Table [dbo].[Authors]    Script Date: 10.08.2021 11:05:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Authors](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](150) NOT NULL,
	[first_name] [varchar](150) NULL,
 CONSTRAINT [PK_Authors] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Books]    Script Date: 10.08.2021 11:05:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Books](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](150) NOT NULL,
 CONSTRAINT [PK_Books] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Copies]    Script Date: 10.08.2021 11:05:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Copies](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_book] [int] NOT NULL,
	[publisher] [varchar](150) NOT NULL,
	[publication] [datetime] NOT NULL,
	[count] [int] NULL,
 CONSTRAINT [PK_Copies] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[History]    Script Date: 10.08.2021 11:05:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[History](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_storage] [int] NOT NULL,
	[date_of_issue] [datetime] NOT NULL,
	[return_date] [datetime] NULL,
 CONSTRAINT [PK_History] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LinkBooksAuthor]    Script Date: 10.08.2021 11:05:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LinkBooksAuthor](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_book] [int] NOT NULL,
	[id_author] [int] NOT NULL,
 CONSTRAINT [PK_LinkBooksAuthor] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Storage]    Script Date: 10.08.2021 11:05:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Storage](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_copy] [int] NOT NULL,
	[row_number] [int] NOT NULL,
	[shelf_number] [int] NOT NULL,
	[availability] [bit] NOT NULL,
 CONSTRAINT [PK_Storage] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Copies]  WITH CHECK ADD  CONSTRAINT [FK_Copies_Books] FOREIGN KEY([id_book])
REFERENCES [dbo].[Books] ([id])
GO
ALTER TABLE [dbo].[Copies] CHECK CONSTRAINT [FK_Copies_Books]
GO
ALTER TABLE [dbo].[History]  WITH CHECK ADD  CONSTRAINT [FK_History_Storage] FOREIGN KEY([id_storage])
REFERENCES [dbo].[Storage] ([id])
GO
ALTER TABLE [dbo].[History] CHECK CONSTRAINT [FK_History_Storage]
GO
ALTER TABLE [dbo].[LinkBooksAuthor]  WITH CHECK ADD  CONSTRAINT [FK_LinkBooksAuthor_Authors] FOREIGN KEY([id_author])
REFERENCES [dbo].[Authors] ([id])
GO
ALTER TABLE [dbo].[LinkBooksAuthor] CHECK CONSTRAINT [FK_LinkBooksAuthor_Authors]
GO
ALTER TABLE [dbo].[LinkBooksAuthor]  WITH CHECK ADD  CONSTRAINT [FK_LinkBooksAuthor_Books] FOREIGN KEY([id_book])
REFERENCES [dbo].[Books] ([id])
GO
ALTER TABLE [dbo].[LinkBooksAuthor] CHECK CONSTRAINT [FK_LinkBooksAuthor_Books]
GO
ALTER TABLE [dbo].[Storage]  WITH CHECK ADD  CONSTRAINT [FK_Storage_Copies] FOREIGN KEY([id_copy])
REFERENCES [dbo].[Copies] ([id])
GO
ALTER TABLE [dbo].[Storage] CHECK CONSTRAINT [FK_Storage_Copies]
GO
/****** Object:  StoredProcedure [dbo].[GetActualDataInfo]    Script Date: 10.08.2021 11:05:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		MD
-- Create date: 09.08.2021
-- Description:	Get Actual Data
-- =============================================
CREATE PROCEDURE [dbo].[GetActualDataInfo]
	@from_date datetime,
	@to_date datetime
AS
BEGIN
	declare @result table
	(id_book int,[name] varchar(150),authors varchar(150),count_item int, count_issue int, count_actual int)

	insert into @result
	select
		b.id,
		b.[name],
		STRING_AGG (a.[name]+' '+isnull(a.first_name,''), ', '),
		null,
		null,
		null
	from [dbo].[Books] b
	left join [dbo].[LinkBooksAuthor] lba on lba.[id_book] = b.id
	--left join [dbo].[Copies] c on c.id_book = b.id
	left join [dbo].[Authors] a on lba.id_author = a.id
	group by b.[id],b.[name]

	--Count Ex
	update res
		set count_item = T.c
		from @result res
		inner join (
	select res.id_book,count(c.id) c
	from @result res
	inner join [dbo].[Copies] c on c.id_book = res.id_book
	group by res.id_book) T on res.id_book = T.id_book

	--Count issue, return
	update res
		set count_issue = T.s,  count_actual = T.r
		from @result res
	inner join (
	select res.id_book,count(s.id) s,sum(
	case 
		when h.return_date is null then 1
		else 0
	end
	) r
	from @result res
	inner join [dbo].[Copies] c on c.id_book = res.id_book
	inner join [dbo].[Storage] s on s.id_copy = c.id
	inner join [dbo].[History] h on h.id_storage = s.id
	where h.[date_of_issue] between @from_date and @to_date
	group by res.id_book,c.id) T on res.id_book = T.id_book


	select 
		[name],
		authors,
		count_item,
		count_issue,
		count_actual,
		isnull(count_issue,0) issue,
		isnull(count_actual,count_item) actual 
	from @result


END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'List Authors' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Authors'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'List Books' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Books'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'name of the publisher' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Copies', @level2type=N'COLUMN',@level2name=N'publisher'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'year of publication' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Copies', @level2type=N'COLUMN',@level2name=N'publication'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Copies Book' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Copies'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'History Repository' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'History'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Link Book To Author' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LinkBooksAuthor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Storage Location' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Storage'
GO

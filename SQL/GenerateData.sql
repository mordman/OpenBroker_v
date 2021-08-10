USE [OpenBroker]

SET DATEFORMAT dmy;

--Clear All Data
delete from [dbo].[History]
delete from [dbo].[Storage]
delete from [dbo].[Copies]
delete from [dbo].[LinkBooksAuthor]
delete from [dbo].[Authors]
delete from [dbo].[Books]

--Declare
declare @ident_a int, @ident_b int, @ident_c int, @ident_s int

--Фримен Э., Робсон Э., Сьерра К., Бейтс Б. - Паттерны проектирования (Head First O’Reilly) - 2018
INSERT INTO [dbo].[Books] ([name]) VALUES ('Паттерны проектирования')
SELECT @ident_b = SCOPE_IDENTITY()

INSERT INTO [dbo].[Authors] ([name],[first_name]) VALUES ('Фримен','Э')
SELECT @ident_a = SCOPE_IDENTITY()
INSERT INTO [dbo].[LinkBooksAuthor] ([id_book],[id_author]) VALUES (@ident_b,@ident_a)

INSERT INTO [dbo].[Authors] ([name],[first_name]) VALUES ('Робсон','Э')
SELECT @ident_a = SCOPE_IDENTITY()
INSERT INTO [dbo].[LinkBooksAuthor] ([id_book],[id_author]) VALUES (@ident_b,@ident_a)

INSERT INTO [dbo].[Authors] ([name],[first_name]) VALUES ('Сьерра','К')
SELECT @ident_a = SCOPE_IDENTITY()
INSERT INTO [dbo].[LinkBooksAuthor] ([id_book],[id_author]) VALUES (@ident_b,@ident_a)

INSERT INTO [dbo].[Authors] ([name],[first_name]) VALUES ('Бейтс','Б')
SELECT @ident_a = SCOPE_IDENTITY()
INSERT INTO [dbo].[LinkBooksAuthor] ([id_book],[id_author]) VALUES (@ident_b,@ident_a)

INSERT INTO [dbo].[Copies] ([id_book],[publisher],[publication],[count]) VALUES (@ident_b,'O’Reilly','01.01.2018',1)
SELECT @ident_c = SCOPE_IDENTITY()

INSERT INTO [dbo].[Storage]([id_copy],[row_number],[shelf_number],[availability]) VALUES (@ident_c,1,1,1)
SELECT @ident_s = SCOPE_IDENTITY()

INSERT INTO [dbo].[History] ([id_storage],[date_of_issue],[return_date])  VALUES (@ident_s,'02.01.2018', '01.02.2018')
INSERT INTO [dbo].[History] ([id_storage],[date_of_issue],[return_date])  VALUES (@ident_s,'02.02.2018', '12.03.2018')
INSERT INTO [dbo].[History] ([id_storage],[date_of_issue],[return_date])  VALUES (@ident_s,'02.01.2019', '1.02.2019')
INSERT INTO [dbo].[History] ([id_storage],[date_of_issue],[return_date])  VALUES (@ident_s,'02.03.2019', null)


--Фридл Дж. - Регулярные выражения. 3-е изд. (Бестселлеры O'Reilly) - 2018
INSERT INTO [dbo].[Books] ([name]) VALUES ('Регулярные выражения. 3-е изд.')
SELECT @ident_b = SCOPE_IDENTITY()

INSERT INTO [dbo].[Authors] ([name],[first_name]) VALUES ('Фридл','Дж')
SELECT @ident_a = SCOPE_IDENTITY()
INSERT INTO [dbo].[LinkBooksAuthor] ([id_book],[id_author]) VALUES (@ident_b,@ident_a)

INSERT INTO [dbo].[Copies] ([id_book],[publisher],[publication],[count]) VALUES (@ident_b,'O’Reilly','01.01.2018',1)
SELECT @ident_c = SCOPE_IDENTITY()

INSERT INTO [dbo].[Storage]([id_copy],[row_number],[shelf_number],[availability]) VALUES (@ident_c,1,2,1)
SELECT @ident_s = SCOPE_IDENTITY()

INSERT INTO [dbo].[History] ([id_storage],[date_of_issue],[return_date])  VALUES (@ident_s,'12.04.2018', '03.05.2018')
INSERT INTO [dbo].[History] ([id_storage],[date_of_issue],[return_date])  VALUES (@ident_s,'02.12.2018', null)

--Скотт А. - Разработка на JavaScript (Бестселлеры O''Reilly) - 2021
INSERT INTO [dbo].[Books] ([name]) VALUES ('Разработка на JavaScript')
SELECT @ident_b = SCOPE_IDENTITY()

INSERT INTO [dbo].[Authors] ([name],[first_name]) VALUES ('Скотт','А')
SELECT @ident_a = SCOPE_IDENTITY()
INSERT INTO [dbo].[LinkBooksAuthor] ([id_book],[id_author]) VALUES (@ident_b,@ident_a)

INSERT INTO [dbo].[Copies] ([id_book],[publisher],[publication],[count]) VALUES (@ident_b,'O’Reilly','01.01.2021',1)
SELECT @ident_c = SCOPE_IDENTITY()

INSERT INTO [dbo].[Storage]([id_copy],[row_number],[shelf_number],[availability]) VALUES (@ident_c,1,3,1)
SELECT @ident_s = SCOPE_IDENTITY()

INSERT INTO [dbo].[History] ([id_storage],[date_of_issue],[return_date])  VALUES (@ident_s,'12.07.2021', '03.08.2021')


--Клири Стивен - Конкурентность в C#. Асинхронное, параллельное программирование (Для профессионалов)  - 2020
INSERT INTO [dbo].[Books] ([name]) VALUES ('Конкурентность в C#. Асинхронное, параллельное программирование (Для профессионалов)')
SELECT @ident_b = SCOPE_IDENTITY()

INSERT INTO [dbo].[Authors] ([name],[first_name]) VALUES ('Клири','Стивен')
SELECT @ident_a = SCOPE_IDENTITY()
INSERT INTO [dbo].[LinkBooksAuthor] ([id_book],[id_author]) VALUES (@ident_b,@ident_a)

INSERT INTO [dbo].[Copies] ([id_book],[publisher],[publication],[count]) VALUES (@ident_b,'Unknow','01.01.2020',1)
SELECT @ident_c = SCOPE_IDENTITY()

INSERT INTO [dbo].[Storage]([id_copy],[row_number],[shelf_number],[availability]) VALUES (@ident_c,1,4,1)
SELECT @ident_s = SCOPE_IDENTITY()

INSERT INTO [dbo].[History] ([id_storage],[date_of_issue],[return_date])  VALUES (@ident_s,'12.07.2020', '03.08.2021')


--Албахари Дж., Албахари Б. - C# 8.0. Карманный справочник - 2020
INSERT INTO [dbo].[Books] ([name]) VALUES ('C# 8.0. Карманный справочник')
SELECT @ident_b = SCOPE_IDENTITY()

INSERT INTO [dbo].[Authors] ([name],[first_name]) VALUES ('Албахари','Дж')
SELECT @ident_a = SCOPE_IDENTITY()
INSERT INTO [dbo].[LinkBooksAuthor] ([id_book],[id_author]) VALUES (@ident_b,@ident_a)

INSERT INTO [dbo].[Authors] ([name],[first_name]) VALUES ('Албахари','Б')
SELECT @ident_a = SCOPE_IDENTITY()
INSERT INTO [dbo].[LinkBooksAuthor] ([id_book],[id_author]) VALUES (@ident_b,@ident_a)

INSERT INTO [dbo].[Copies] ([id_book],[publisher],[publication],[count]) VALUES (@ident_b,'Unknow','01.01.2020',1)
SELECT @ident_c = SCOPE_IDENTITY()

INSERT INTO [dbo].[Storage]([id_copy],[row_number],[shelf_number],[availability]) VALUES (@ident_c,1,5,1)
SELECT @ident_s = SCOPE_IDENTITY()

INSERT INTO [dbo].[History] ([id_storage],[date_of_issue],[return_date])  VALUES (@ident_s,'12.09.2020', null)


CREATE DATABASE Kitabxana


CREATE TABLE Books
(
   ID int primary key identity,
   Name nvarchar(100) check(len(Name)>=2),
   PageCount int check(PageCount>=10),
   AuthorId int foreign key references Authors(ID),
)

CREATE TABLE Authors
(
   ID int primary key identity,
   Name nvarchar(100) not null,
   Surname nvarchar(100) not null,
)

CREATE VIEW usv_AuthorBook
As
Select A.Name+ ' '+A.Surname AS [Author],b.Name [Book name],b.PageCount  from Authors A
join Books B
on
A.ID=B.ID where PageCount>300

SELECT * FROM usv_AuthorBook


CREATE PROCEDURE usp_AuthorBookPageCount
(@PageCount int, @ID int,@Name nvarchar)
As
BEGIN
   Select A.Name+ ' '+A.Surname AS [Author],b.Name [Book name],b.PageCount  from Authors A
	join Books B
	on
	A.ID=B.ID where PageCount>@PageCount or A.ID=@ID or B.Name=@Name
END

exec usp_AuthorBookPageCount 100,1,'Sessizlik'


-- Insert
CREATE PROCEDURE usp_InsertAuthor
@Name NVARCHAR(100),
@Surname NVARCHAR(100)
AS
BEGIN
    INSERT INTO Authors (Name, Surname)
    VALUES (@Name, @Surname);
END;

-- Update
CREATE PROCEDURE usp_UpdateAuthor
@ID INT,
@Name NVARCHAR(100),
@Surname NVARCHAR(100)
AS
BEGIN
    UPDATE Authors
    SET Name = @Name, Surname = @Surname
    WHERE ID = @ID;
END;

-- Delete
CREATE PROCEDURE usp_DeleteAuthor
@ID INT
AS
BEGIN
    DELETE FROM Authors
    WHERE ID = @ID;
END;



CREATE VIEW usv_AuthorDetails AS
SELECT 
    A.ID AS Id,
    A.Name + ' ' + A.Surname AS FullName,
    COUNT(B.ID) AS BooksCount,
    MAX(B.PageCount) AS MaxPageCount
FROM 
    Authors A
 JOIN 
    Books B ON A.ID = B.AuthorId
GROUP BY 
    A.ID, A.Name, A.Surname;

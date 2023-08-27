
CREATE DATABASE KontaktHomes
use KontaktHomes

CREATE TABLE Brands
(
  ID int primary key identity,
  Name nvarchar(100) not null,
)
  

CREATE TABLE Notebooks 
(
  ID int primary key identity,
  Name nvarchar(100) not null,
  Price decimal(10,2) not null,
  BrandId int foreign key references Brands(ID)
)

CREATE TABLE Phones  
(
  ID int primary key identity,
  Name nvarchar(100) not null,
  Price decimal(10,2) not null,
  BrandId int foreign key references Brands(ID)
)

--3
select N.Name,B.Name [BrandName],N.Price from Brands B
join Notebooks N
on
B.ID=N.BrandId

---4
select P.Name,B.Name [BrandName],P.Price from Phones P
join Brands B
on
B.ID=P.BrandId

--Brand Adinin Terkibinde s Olan Butun Notebooklari Cixardan Query.

select N.Name,B.Name [BrandName],N.Price from Brands B
join Notebooks N
on
B.ID=N.BrandId where b.Name like '%s%'


--6 Qiymeti 2000 ve 5000 arasi ve ya 5000 den yuksek Notebooklari Cixardan Query.

select n.Name,N.Price from Notebooks N
where (N.Price>=2000 and N.Price<=5000) or (N.Price>=5000)

--7) Qiymeti 1000 ve 1500 arasi ve ya 1500 den yuksek Phonelari Cixardan Query.

	SELECT * FROM Phones p
	WHERE (P.Price>=1000 AND P.Price<=1500) OR P.Price >=1500


--8) Her Branda Aid Nece dene Notebook Varsa Brandin Adini Ve Yaninda Sayini Cixardan Query.

	SELECT B.Name , count(N.ID) [Notebook count] FROM Brands B
	JOIN Notebooks N
	on
	B.ID=N.BrandId
	group by b.Name

--9) Her Branda Aid Nece dene Phone Varsa Brandin Adini Ve Yaninda Sayini Cixardan Query.
     SELECT B.Name , count(P.ID) [Phone count] FROM Brands B
	JOIN Phones P
	on
	B.ID=P.BrandId
	group by B.Name

--10) Hem Phone Hem de Notebookda Ortaq Olan Name ve BrandId Datalarni Bir Cedvelde Cixardan Query.
    SELECT Name, BrandId
	FROM Notebooks
	UNION
	SELECT Name, BrandId
	FROM Phones;

--11) Phone ve Notebook da Id, Name, Price, ve BrandId Olan Butun Datalari Cixardan Query.
    SELECT ID, Name, Price, BrandId
	FROM Notebooks
	UNION ALL
	SELECT ID, Name, Price, BrandId
	FROM Phones;

--12) Phone ve Notebook da Id, Name, Price, ve Brandin Adini BrandName kimi Olan Butun Datalari Cixardan Query.
	SELECT n.ID, n.Name, n.Price, b.Name AS BrandName
	FROM Notebooks n
	INNER JOIN Brands b ON n.BrandId = b.ID
	UNION ALL
	SELECT p.ID, p.Name, p.Price, b.Name AS BrandName
	FROM Phones p
	INNER JOIN Brands b ON p.BrandId = b.ID;


--13) Phone ve Notebook da Id, Name, Price, ve Brandin Adini BrandName kimi Olan Butun Datalarin Icinden Price 1000-den Boyuk Olan Datalari Cixardan Query.
    SELECT n.ID, n.Name, n.Price, b.Name AS BrandName
	FROM Notebooks n
	INNER JOIN Brands b ON n.BrandId = b.ID
	WHERE n.Price > 1000
	UNION ALL
	SELECT p.ID, p.Name, p.Price, b.Name AS BrandName
	FROM Phones p
	INNER JOIN Brands b ON p.BrandId = b.ID
	WHERE p.Price > 1000;

--14) Phones Tabelenden Data Cixardacaqsiniz Amma Nece Olacaq Brandin Adi (BrandName kimi), Hemin Brandda Olan Telefonlarin Pricenin Cemi (TotalPrice Kimi) ve Hemin Branda Nece dene Telefon Varsa Sayini (ProductCount Kimi) Olan Datalari Cixardan Query.Misal

        SELECT b.Name AS BrandName, 
        SUM(p.Price) AS TotalPrice, 
        COUNT(p.ID) AS ProductCount
		FROM Phones p
		 JOIN Brands b ON p.BrandId = b.ID
		GROUP BY b.Name;
--

--15)Notebooks Tabelenden Data Cixardacaqsiniz Amma Nece Olacaq Brandin Adi (BrandName kimi),
--Hemin Brandda Olan Telefonlarin Pricenin Cemi (TotalPrice Kimi) , 
--Hemin Branda Nece dene Telefon Varsa Sayini (ProductCount Kimi)
--Olacaq ve Sayi 3-ve 3-den Cox Olan Datalari Cixardan Query.Misal

	SELECT b.Name [BrandName],SUM(N.Price) [TotalPrice],Count(N.ID) [ProductCount] FROM Notebooks N
	JOIN Brands B
	ON
	B.ID=N.BrandId
	group by b.Name
	HAVING Count(N.ID)>=2




















---Se�ilen database'in kullan�m�
use SQL_�al��malar�

--'SpaceTu�unaBas' >>>>>>Bo�luk demek

--yan yana iki adet tirnak yazdigimizda bu ifade tek tirnak yerine gecer.
-- tek tirnagin ozel bir anlami oldgundan dolayidir.

---Tabloyu �a��rmak
select*from TblProduct

---Bir tablodan sadece istedi�imiz s�tun bilgilerini getirmek
select ProductName,ProductStock from TblProduct

---INSERT >>> ekleme i�lemi i�in kullan�l�r
		/*
		> HATA ALINIYORSA>> Tabloda NULL ge�ilmeyen yerlere de�er atamas� yap�lmad��� i�in
		> �nsert i�lemi s�ras�nda mutlaka de�er atamal�y�z
		> �DENT�TY �zelli�i varsa(otomatik artan) bu s�tun de�eri sistem taraf�ndan atanaca�� i�in insert i�leminde belirtmeye gerek yok.
		*/
insert into TblOrder (Customer,ProductName) values ('AP �irketi', 'Buzdolab�')

---Product ablosundaki �r�nlere %5 zam yap ve kolon olarak ekle
select*into Zaml�Fiyat from  TblProduct 
	select ( (SalesPrice)*105/100 ) as KDV from Zaml�Fiyat	
		

---UPDATE KULLANIMI; 
		---update <TabloAd�> set <KolonAd�>=YeniDe�er
		---Bir kay�t �zerinden de�i�im yapacaksak ID �zerinden i�lem yap!
update TblEmployee set LastName='Vatansever' where EmployeeID=8 

---Tablodaki s�tun ba�l�klar�n� yeniden isimlendirip getirtmek
		/*
		Birden Fazla kelimeden olu�acak bir ismi k��eli parantezle ya da tek t�rnak i�inde belirtebiliriz.
		WHERE �LE KEND� �S�MLEND�RD���M�Z S�TUNLARI KULLANAMAYIZ!
		*/
select ProductName '�r�n Ad�', ProductPrice as �r�nFiyat�, ProductStock [Urun Sto�u] from TblProduct

---Tekil kay�tlar� listeleme
select City from TblEmployee

---D�ST�CT kullan�m�; 
	/*birden fazla olan ayn� �eyler bile tekil kay�ta d�n��erek listelenir. 
		�rne�in 2 tane �stanbul var; 1tane istanbul yazacak.*/
select distinct City from TblEmployee

---Bu kod �stteki kod ile ayn� mant�kta �al��t� fakat firstnameler farkl� oldu�u i�in 2 tane �stanbul olsa bile yazd�rd�. �unku ayn� isim ve ayn� �ehre sahip kay�tlar yok.
select firstname, city from TblEmployee

---Tablodaki birden fazla s�tunu birle�tirip tek bir s�tun i�inde yazmak
select (FirstName+' '+LastName+' '+City) as �al��anlar
from TblEmployee     

---WHERE yaz�lan sorgular� belli bir ko�ula g�re listeleme
select FirstName from TblEmployee where city='�stanbul'

---Tablodan se�ti�imi bir ProductName �a��rmak
select*from TblProduct where ProductName='Buzdolab�'

select*from TblProduct where 200>ProductPrice and ProductPrice>100

---YEAR() fonksiyonu bizden datetime tipinde de�er al�r ve o tarih bilgisini d�nd�r�r.
select FirstName,LastName,BirthDate from TblEmployee where YEAR(BirthDate)>1980

-----------�rnek. �stanbulda oturup 1980 sonras� do�umlu ki�iyi getir
           select FirstName as '�smi' from TblEmployee where YEAR(BirthDate)>1980 and City='�Stanbul'

---GETDATE() fonksiyonu g�ncel tarih bilgisini verir.
select FirstName,BirthDate from TblEmployee where (YEAR(GETDATE())- YEAR(BirthDate)>50 ) 


---NULL GELME DURUMU;
---is null yada is not null ifadeleri kullan�l�r
select* from TblEmployee where City is null

---SIRALAMA ��LEMLER�
--- 1) artan ve azalan s�ralama
select*from TblEmployee where EmployeeID>3 and EmployeeID<=6

--- 2) alfabetik artan ve azalan s�ralama ORDER BY KULLANIMI
       ---ASC >>> Say�sal ifadelerde k���kten b�y��e, metinsel ifadelerde A'dan Z'ye
      ---DESC >>> Tam Tersi
select*from TblEmployee order by FirstName asc

---�N KULLANIMI >>>> Belli tarihlerdeki �eyleri listeleme(�rnek bu y�lda do�an)
select FirstName,LastName,YEAR(BirthDate) 
	from TblEmployee
		where YEAR(BirthDate) in (1950,1972)

---TOP kullan�m� >>> Belli S�radakileri Getirir
      /* select top SAYI*from TabloAd�
	  > Top en son �al���r sorguda. �nce T�m sonu� k�mesi olu�ur; oradan istenilen say�daki k�s�m sonu� olarak d�ner*/
select top 3* from TblEmployee

---�al��anlar ya�lar�na g�re s�raland�ktan sonra olu�acak sonu� k�mesinin %25 lik k�sm�n� getir
select top 25 percent FirstName, YEAR(GETDATE())- YEAR( BirthDate) as Ya�
	from TblEmployee
		order by BirthDate asc

---L�KE kullan�m�
select FirstName from TblEmployee where FirstName='ali'
select FirstName from TblEmployee where FirstName!='ali'
select FirstName from TblEmployee where FirstName like 'ali'
select FirstName from TblEmployee where FirstName not like 'ali'

---Ad�n�n ilk harfi A olanlar
select FirstName from TblEmployee where FirstName like 'A%'

---Ad�n�n ilk harfi A veya T olanlar
select FirstName from TblEmployee where FirstName like 'A%' or FirstName like 'T%'
select FirstName from TblEmployee where FirstName like '[AT]%'

---Ad�n�n i�inde A veya T harfi bulunanlar
select FirstName from TblEmployee where FirstName like '%A%' or FirstName like '%T%'
		order by FirstName asc
select FirstName from TblEmployee where FirstName like '%[AT]%' order by FirstName asc

---Ad�n�n ilk harfi A ve K aras�nda bulunanlar ve bulunmayanlar
select FirstName from TblEmployee where FirstName like '[A-K]%'
select FirstName from TblEmployee where FirstName not like '[A-K]%'

---Ad�ndaki A ve E aras�nda tek bir arakter ve iki karakter olanlar
select FirstName from TblEmployee where FirstName like '%A_�%'
select FirstName from TblEmployee where FirstName like '%E__A%'

---Ad�n�n ilk harfi M olmayanlar
select FirstName from TblEmployee where FirstName not like 'M%'
select FirstName from TblEmployee where FirstName like '[^A]%' order by FirstName asc

---Ad� N harfi ile bitmeyenler
select FirstName from TblEmployee where FirstName like '%N'

--Ad�n�n ikinci harfi A olanlar ve olmayanlar
select FirstName from TblEmployee where FirstName like '_A%'
select FirstName from TblEmployee where FirstName not like '_A%'

		---Firstname'inden ikinci harfi E; be�inci harfi A olan� getir
		select FirstName from TblEmployee where FirstName like '_E__A%'

--DATEPART(): Bir tarih bilgisinin istenilen bolumunu size verir. 
 --Yila Gore
 select FirstName,LastName,  DATEPART (DY,BirthDate) as [Day of The Year] from TblEmployee
 --Aya gore
 select FirstName, LastName, DATEPART (M, BirthDate) AS [ay] from TblEmployee order by [ay]
 --Yilin kacinci haftasi
 select FirstName, LastName, DATEPART (WK, BirthDate) as [Week of Year] from TblEmployee order by [Week of Year] desc
 --haftanin kacinci gunu
 select FirstName, LastName, DATEPART (DW, BirthDate) as [Day of Week] from TblEmployee order by [Day of Week]
 --Saate gore
 select FirstName, LastName, DATEPART(HH, BirthDate) as [HOUR] from TblEmployee order by HOUR desc
 -- dakikaya gore
 select FirstName, LastName, DATEPART (MI, GETDATE()) AS [Minute] from TblEmployee order by Minute
 --Saliseye gore
 select FirstName, LastName, DATEPART (MI, GETDATE()) AS [Salise] from TblEmployee order by Salise

 select FirstName, LastName, DATEPART (MI, GETDATE()) as [Minute] from TblEmployee where EmployeeID=10

 --DATEDIFF KULLANIMI
 select FirstName, DATEDIFF(HOUR, BirthDate, GETDATE()) as [kac saat gecti]
 from TblEmployee

 --Sayisal islemler
 select 5+2 
 select 9 %2 --9"un 2"ye bolumunden kalani verir 
 select PI () -- Pi sayisi tanimlidir
 select power(2,3) --ust alir
 select ABS(-20) -- mutlak degeri alir
 select sqrt (36) --karekokler
 select RAND ()  --0 ile 1 arasinda deger uretir
 select Sin(60) --trigonometrik degerler tanimlidir
 select FLOOR (5.12) --belli bir sayiyi bir deger yuvarlama

 --STRING FONKSIYONLARI
 select 'Merhaba Burasi Begumun Dunyasi' as mesaj   --tabloda sonuc verir
 print 'C Egitimine Hosgeldiniz' --message kismina duser

 --ascii kodunu almak istersen bu sekilde kullanmak yeter
 select ASCII('A') as [Asci kodunu ver] 
 select ASCII('a') as [Asci kodunu ver] --bu varchar olarak aliyor
 select CHAR(65) as Karakter --bu da integer olarak aliyor

 --CHARINDEX
	--arama yapacagin karakter ve string veriyorsun bulundugu konumu veriyor
	--bulamazsa geriye sifir doner
 select CHARINDEX('@', 'test@gmail.com') as konumbilgisi


select LEFT ('Bilge Adam', 4) --soldan 4u donduruyor bu komut
select LEN ('Bilge Adam') as [Karakter sayisi] --uzunlugun sayisal degerini dondurur
select LOWER ('BEGUM') as [buyugu kucuge dondurmek]
select upper ('begum') as [kucugu buyuge dondurmek] 
select UPPER (ProductName) from TblProduct --productname kolonundaki verilerin hepsinin karakterini buyut
select LTRIM ('     Begum') as [Soldan bosluk siler]
select rtrim  ('Begum     ') as [sagdan bosluk siler]
select LTRIM(RTRIM('    Begum     ')) as [Bosluklari sil]
select REPLACE ('birbirlerine', 'bir', 'uc') as [metinlerin yerine yenilerini atar]
select SUBSTRING ('bilge adam akademi', 4, 6) --4. karakterden itibaren 6 karakter aldi, bosluk dahil
select reverse ('Bilgge adama hosgeldin') as [tersine cevirir]
select 'Bilge Adam' + space(30)+'Hosgeldin' as [belirtilen biktarda bosluk birakir]
select REPLICATE ('Bilge', 5) as 'Belirtilen metni belirtilen adette cogaltir'


--AGGREGATE() FONKS�YONLARI ; COUNT - SUM - AVG - M�N - MAX
	--(toplam fonks�yonlar�, gruplamal� fonks�yonlar�)
	/*
	Aggregate fonksiyonlar� null de�erleri dikkate almaz.
	Bu nedenle kay�t adetini ��renebilmek i�in * karakterini ya da null de�er ge�irmeyen s�tunlar�n
	birbiri ad�na kullanmam�z gerekir
	*/

--COUNT ([S�tunad�]) || *)
select count(*) from TblEmployee -- bir tablodaki kay�t adetinin ��renebiliriz
select COUNT (EmployeeID) from TblEmployee -- emploeedId s�tunundaki kay�t say�s�n� ver�r
select COUNT(city) from TblEmployee
select COUNT(distinct City) from TblEmployee --ka� farkl� �ehir var

--SUM DE�ERLER�N TOPLAMINI VER�R
select SUM (EmployeeID) from TblEmployee --bir s�tundaki de�erlerin toplam�n� verecektir

select sum (YEAR (GETDATE ())-YEAR(BirthDate)) 
	as [yaslar�n toplam�] from TblEmployee -- �al��anlar�n ya�lar�n�n toplam�n� bul
select SUM (DATEDIFF(year, birthdate, getdate())) 
	as [yaslar�n toplam�] from TblEmployee --cal�sanlar�n yaslar�n�n toplam� ikinci yol 

--AVG (S�TUN ADI) DE�ERLER�N ORTALAMASINI VER�R
		/*
		-- AVG hesaplamas�nda null olanlar i�leme kat�lm�yor, ki�ilerin say�s�na b�l�nmez
		--null olmayan ki�i adetine b�l�n�r.
		--avg say�sal s�tunlarda kullan�l�r
		*/
select AVG(EmployeeID) as [ID ortalamas�] from TblEmployee
select avg (YEAR (GETDATE ())-YEAR(BirthDate)) as [yas ortalamas�] from TblEmployee
select AVG (lastname) from TblEmployee --say�sal s�tun olmad��� i�in hata ald�k
 select top 5 AVG (ProductPrice) from TblProduct --en ucuz 5 urunun ortalama fiyati

--MAX ve M�N (s�TUN ADI) :S�TUNDAK� EN B�Y�K VE EN K���K DE�ER� VER�R
select max (EmployeeID) from TblEmployee
select max (FirstName) from TblEmployee  --alfabetik olarak en b�y�k de�eri verir.
select min (EmployeeID) from TblEmployee
select min (LastName) from TblEmployee

--CASE -WHEN -THEN KULLANIMI
select FirstName, LastName,
		case (city)
			when 'USA'
			then 'Amerika Birle�ik Devletleri'
			when 'UK'
			then '�ngiltere Birle�ik Krall���'
		else '�lke Belirtilmedi'
		end as Country --Yukar�daki d�ng� ile olu�an kolonun ismi Country olsun diye as eklemesi yapt�k
from TblEmployee

select EmployeeID, FirstName,
	case 
		when EmployeeID>5
		then 'ID 5den buyuktur'
		when EmployeeID<5
		then 'ID 5den kucuktur'
	else '5e esittir'
	end as Esitlik
from TblEmployee

select FirstName,
	case (EmployeeID)
	when 1
	then 'Bir'
	else 'yeterli'
	end
from TblEmployee

--GROUP BY
-- calisanlarin ulkelerine gore gruplandirilmasi;
select City as ulke, COUNT(*) as [kisi sayisi]
	from TblEmployee where City is not null group by City
--100 adetten fazla sat�lan �r�nleri getirin
select ProductName, SUM(AdetSay�s�) as 'Sat�� Miktar�'  from [TblOrder]
	 group by ProductName having SUM (AdetSay�s�)>10

--DELETE ��LEM�
insert into TblProduct (ProductName,ProductStock) values ('ali', 120)
select*from TblProduct
delete from TblProduct where ProductID=11

---Products tablosundan max fiyat� bulan sorgu 
        /*
		A�a��daki 2 sat�r sorgu beraber �al���r. 
		money=(select MAX(SalesPrice) from TblProduct) >>> �nce bu srogu �al���yor
		sonra bulunan de�er @maxfiyat �zerine atan�yor.
		sonra "select*from TblProduct where SalesPrice=@maxfiyat" sorgusu �al���yor ve bulunan de�er gidip
		@maxfiyat de�eri ile e�le�iyor
		*/
declare @maxfiyat money=(select MAX(SalesPrice) from TblProduct)
select*from TblProduct where SalesPrice=@maxfiyat

--fiyati ortalama fiyatin ustunde olan urunler
declare @ortfiyat money=(select AVG (SalesPrice) from TblProduct )
		select*from TblProduct where SalesPrice>@ortfiyat
     ---ikinci y�ntem
		select*from TblProduct
		where SalesPrice>(select AVG(SalesPrice) from TblProduct)

--50 dolar ile 100 dolar arasinda bulunan tum urunlerin adlari ve fiyatlari
select ProductName, SalesPrice from TblProduct
where SalesPrice between 3000 and 5000

---PR�MARY KEY:
  /* Benzersiz ID de�eri tutar
     Tablonun kimli�i oluyor primary key
	 Sat�r�n ID de�eri ba�ka sat�rda kullan�lm�yor
	 ili�kili tablolarda silme i�lemi olmaz active-passive ili�kisi kullan�l�r.
	 STATUS isminde s�tun eklersin; 0 ve 1 t�r�nde de�er al�r yani DataType'� bit oldu.
  */


---SUBQUERY : �� ��e Sorgular 
select*from TblProduct 
where SalesPrice=(select max (SalesPrice) from TblProduct )

--alt sorguda birden fazla de�er d�n�yorsa =() yerine in() kullan
select*from TblProduct where CategoryID in
	(
	select CategoryID from TblCategory 
	where CategoryName='Beyaz E�ya' or CategoryName= 'Mobilya'
	)

--�artl� sorgu yaz�yorsak (AND) =() kullan�lmal�
select* from TblProduct where CategoryID 
	=(
	select CategoryID from TblCategory 
	where CategoryName='Beyaz E�ya'
	)
	and SalesPrice>100

--�r�n listesindeki beyaz e�yalar�n stok say�s�na 10 ekleme yap
update TblProduct set ProductStock=ProductStock+10
	where CategoryID = (select CategoryID from TblCategory where CategoryName='Beyaz E�ya')
select* from TblProduct

--�r�n listesindeki k���k ev aletlerinin sat�� fiyat�-al�� fiyat�
select ProductName,SalesPrice-ProductPrice as 'Fiyat Fark�' from TblProduct 
	where CategoryID=(select CategoryID from TblCategory where CategoryName='K���k Ev Aletleri')

--�r�n tablosundaki beyaz e�yalar�n tamam� sat�l�rsa ne kadar para kazan�l�r
select ProductName, (SalesPrice-ProductPrice)*ProductStock as 'SAt�� Kar�' from TblProduct 
	where CategoryID =(select CategoryID from TblCategory 
			where CategoryName='Beyaz E�ya')

---JO�N YAPISI 
--�NNER JO�N (ortak k�me)
/*
select a,b,c from TABLE1 inner join TABLE 2
	on TABLE1.a=TABLE2.b

buradaki a ve b primary key/foreign key'e kar��l�k geliyor
*/

select*from TblOrder 
	inner join TblCustomer
	on TblOrder.OrderID=TblCustomer.OrderID
	inner join TblProduct
	on TblProduct.ProductID=TblOrder.ProductID

select CategoryName, COUNT(*) as 'Adet' from TblProduct inner join TblCategory
	on TblCategory.CategoryID=TblProduct.CategoryID
		group by CategoryName order by Adet

----V�EW: konttol tekrar�n� engeller birle�tirmeyi k�saca sunar.
---haz�rlad���m view1 sorgusu
SELECT        dbo.TblCustomer.CustomerName, dbo.TblOrder.ProductName, dbo.TblProduct.SalesPrice
FROM            dbo.TblCustomer INNER JOIN
                         dbo.TblOrder ON dbo.TblCustomer.OrderID = dbo.TblOrder.OrderID INNER JOIN
                         dbo.TblProduct ON dbo.TblOrder.ProductID = dbo.TblProduct.ProductID

select*from View_1 ----view ismi k�rm�z� olsa da kodu �al��t�r�nca �al���r.

/*
PROCEDURE
---C# daki metotlar gibi �al���yor.
---Procedure olu�tururken DDL komutlar� kullan�l�r. 
---DDL komutlar� nelerdir; 
		1.CREATE 
		2.ALTER 
		3.DROP
--- nerede bulunurlar?
	programmability-stored procedures alt�nda
*/

---bir procedure yazal�m
create procedure productlist
	as
		select ProductName, CategoryName from TblProduct inner join TblCategory
			on TblProduct.CategoryID=TblCategory.CategoryID
execute productlist

--ikinci bir procedure yazal�m
create procedure productlist2(@stock int) 
	as
		select ProductName,ProductStock from TblProduct inner join TblCategory
			on TblProduct.CategoryID=TblCategory.CategoryID
				where ProductStock>@stock

execute productlist2 120 ---burada d��ar�dan 120 yerine manuel de�er girip kontrol sa�layabiliyoruz.

/*
	TR�GGER: tetikleyici
	�al��t��n tablonun klas�r� i�indeki trigger klas�r�ne geliyor triggers'lar
*/

---T-SQL; 
---de�i�ken, karar yap�s� ve d�ng� kullan�l�yor

declare @say�1 int ---declare ile de�i�ken tan�mlan�yor


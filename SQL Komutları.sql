---Seçilen database'in kullanýmý
use SQL_Çalýþmalarý

--'SpaceTuþunaBas' >>>>>>Boþluk demek

--yan yana iki adet tirnak yazdigimizda bu ifade tek tirnak yerine gecer.
-- tek tirnagin ozel bir anlami oldgundan dolayidir.

---Tabloyu Çaðýrmak
select*from TblProduct

---Bir tablodan sadece istediðimiz sütun bilgilerini getirmek
select ProductName,ProductStock from TblProduct

---INSERT >>> ekleme iþlemi için kullanýlýr
		/*
		> HATA ALINIYORSA>> Tabloda NULL geçilmeyen yerlere deðer atamasý yapýlmadýðý için
		> Ýnsert iþlemi sýrasýnda mutlaka deðer atamalýyýz
		> ÝDENTÝTY özelliði varsa(otomatik artan) bu sütun deðeri sistem tarafýndan atanacaðý için insert iþleminde belirtmeye gerek yok.
		*/
insert into TblOrder (Customer,ProductName) values ('AP Þirketi', 'Buzdolabý')

---Product ablosundaki ürünlere %5 zam yap ve kolon olarak ekle
select*into ZamlýFiyat from  TblProduct 
	select ( (SalesPrice)*105/100 ) as KDV from ZamlýFiyat	
		

---UPDATE KULLANIMI; 
		---update <TabloAdý> set <KolonAdý>=YeniDeðer
		---Bir kayýt üzerinden deðiþim yapacaksak ID üzerinden iþlem yap!
update TblEmployee set LastName='Vatansever' where EmployeeID=8 

---Tablodaki sütun baþlýklarýný yeniden isimlendirip getirtmek
		/*
		Birden Fazla kelimeden oluþacak bir ismi köþeli parantezle ya da tek týrnak içinde belirtebiliriz.
		WHERE ÝLE KENDÝ ÝSÝMLENDÝRDÝÐÝMÝZ SÜTUNLARI KULLANAMAYIZ!
		*/
select ProductName 'Ürün Adý', ProductPrice as ÜrünFiyatý, ProductStock [Urun Stoðu] from TblProduct

---Tekil kayýtlarý listeleme
select City from TblEmployee

---DÝSTÝCT kullanýmý; 
	/*birden fazla olan ayný þeyler bile tekil kayýta dönüþerek listelenir. 
		Örneðin 2 tane Ýstanbul var; 1tane istanbul yazacak.*/
select distinct City from TblEmployee

---Bu kod üstteki kod ile ayný mantýkta çalýþtý fakat firstnameler farklý olduðu için 2 tane Ýstanbul olsa bile yazdýrdý. Çunku ayný isim ve ayný þehre sahip kayýtlar yok.
select firstname, city from TblEmployee

---Tablodaki birden fazla sütunu birleþtirip tek bir sütun içinde yazmak
select (FirstName+' '+LastName+' '+City) as Çalýþanlar
from TblEmployee     

---WHERE yazýlan sorgularý belli bir koþula göre listeleme
select FirstName from TblEmployee where city='Ýstanbul'

---Tablodan seçtiðimi bir ProductName çaðýrmak
select*from TblProduct where ProductName='Buzdolabý'

select*from TblProduct where 200>ProductPrice and ProductPrice>100

---YEAR() fonksiyonu bizden datetime tipinde deðer alýr ve o tarih bilgisini döndürür.
select FirstName,LastName,BirthDate from TblEmployee where YEAR(BirthDate)>1980

-----------örnek. Ýstanbulda oturup 1980 sonrasý doðumlu kiþiyi getir
           select FirstName as 'Ýsmi' from TblEmployee where YEAR(BirthDate)>1980 and City='ÝStanbul'

---GETDATE() fonksiyonu güncel tarih bilgisini verir.
select FirstName,BirthDate from TblEmployee where (YEAR(GETDATE())- YEAR(BirthDate)>50 ) 


---NULL GELME DURUMU;
---is null yada is not null ifadeleri kullanýlýr
select* from TblEmployee where City is null

---SIRALAMA ÝÞLEMLERÝ
--- 1) artan ve azalan sýralama
select*from TblEmployee where EmployeeID>3 and EmployeeID<=6

--- 2) alfabetik artan ve azalan sýralama ORDER BY KULLANIMI
       ---ASC >>> Sayýsal ifadelerde küçükten büyüðe, metinsel ifadelerde A'dan Z'ye
      ---DESC >>> Tam Tersi
select*from TblEmployee order by FirstName asc

---ÝN KULLANIMI >>>> Belli tarihlerdeki þeyleri listeleme(örnek bu yýlda doðan)
select FirstName,LastName,YEAR(BirthDate) 
	from TblEmployee
		where YEAR(BirthDate) in (1950,1972)

---TOP kullanýmý >>> Belli Sýradakileri Getirir
      /* select top SAYI*from TabloAdý
	  > Top en son çalýþýr sorguda. Önce Tüm sonuç kümesi oluþur; oradan istenilen sayýdaki kýsým sonuç olarak döner*/
select top 3* from TblEmployee

---çalýþanlar yaþlarýna göre sýralandýktan sonra oluþacak sonuç kümesinin %25 lik kýsmýný getir
select top 25 percent FirstName, YEAR(GETDATE())- YEAR( BirthDate) as Yaþ
	from TblEmployee
		order by BirthDate asc

---LÝKE kullanýmý
select FirstName from TblEmployee where FirstName='ali'
select FirstName from TblEmployee where FirstName!='ali'
select FirstName from TblEmployee where FirstName like 'ali'
select FirstName from TblEmployee where FirstName not like 'ali'

---Adýnýn ilk harfi A olanlar
select FirstName from TblEmployee where FirstName like 'A%'

---Adýnýn ilk harfi A veya T olanlar
select FirstName from TblEmployee where FirstName like 'A%' or FirstName like 'T%'
select FirstName from TblEmployee where FirstName like '[AT]%'

---Adýnýn içinde A veya T harfi bulunanlar
select FirstName from TblEmployee where FirstName like '%A%' or FirstName like '%T%'
		order by FirstName asc
select FirstName from TblEmployee where FirstName like '%[AT]%' order by FirstName asc

---Adýnýn ilk harfi A ve K arasýnda bulunanlar ve bulunmayanlar
select FirstName from TblEmployee where FirstName like '[A-K]%'
select FirstName from TblEmployee where FirstName not like '[A-K]%'

---Adýndaki A ve E arasýnda tek bir arakter ve iki karakter olanlar
select FirstName from TblEmployee where FirstName like '%A_Ý%'
select FirstName from TblEmployee where FirstName like '%E__A%'

---Adýnýn ilk harfi M olmayanlar
select FirstName from TblEmployee where FirstName not like 'M%'
select FirstName from TblEmployee where FirstName like '[^A]%' order by FirstName asc

---Adý N harfi ile bitmeyenler
select FirstName from TblEmployee where FirstName like '%N'

--Adýnýn ikinci harfi A olanlar ve olmayanlar
select FirstName from TblEmployee where FirstName like '_A%'
select FirstName from TblEmployee where FirstName not like '_A%'

		---Firstname'inden ikinci harfi E; beþinci harfi A olaný getir
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


--AGGREGATE() FONKSÝYONLARI ; COUNT - SUM - AVG - MÝN - MAX
	--(toplam fonksýyonlarý, gruplamalý fonksýyonlarý)
	/*
	Aggregate fonksiyonlarý null deðerleri dikkate almaz.
	Bu nedenle kayýt adetini öðrenebilmek iÇin * karakterini ya da null deðer geçirmeyen sütunlarýn
	birbiri adýna kullanmamýz gerekir
	*/

--COUNT ([Sütunadý]) || *)
select count(*) from TblEmployee -- bir tablodaki kayýt adetinin öðrenebiliriz
select COUNT (EmployeeID) from TblEmployee -- emploeedId sütunundaki kayýt sayýsýný verýr
select COUNT(city) from TblEmployee
select COUNT(distinct City) from TblEmployee --kaç farklý þehir var

--SUM DEÐERLERÝN TOPLAMINI VERÝR
select SUM (EmployeeID) from TblEmployee --bir sütundaki deðerlerin toplamýný verecektir

select sum (YEAR (GETDATE ())-YEAR(BirthDate)) 
	as [yaslarýn toplamý] from TblEmployee -- çalýþanlarýn yaþlarýnýn toplamýný bul
select SUM (DATEDIFF(year, birthdate, getdate())) 
	as [yaslarýn toplamý] from TblEmployee --calýsanlarýn yaslarýnýn toplamý ikinci yol 

--AVG (SÜTUN ADI) DEÐERLERÝN ORTALAMASINI VERÝR
		/*
		-- AVG hesaplamasýnda null olanlar iþleme katýlmýyor, kiþilerin sayýsýna bölünmez
		--null olmayan kiþi adetine bölünür.
		--avg sayýsal sütunlarda kullanýlýr
		*/
select AVG(EmployeeID) as [ID ortalamasý] from TblEmployee
select avg (YEAR (GETDATE ())-YEAR(BirthDate)) as [yas ortalamasý] from TblEmployee
select AVG (lastname) from TblEmployee --sayýsal sütun olmadýðý için hata aldýk
 select top 5 AVG (ProductPrice) from TblProduct --en ucuz 5 urunun ortalama fiyati

--MAX ve MÝN (sÜTUN ADI) :SÜTUNDAKÝ EN BÜYÜK VE EN KÜÇÜK DEÐERÝ VERÝR
select max (EmployeeID) from TblEmployee
select max (FirstName) from TblEmployee  --alfabetik olarak en büyük deðeri verir.
select min (EmployeeID) from TblEmployee
select min (LastName) from TblEmployee

--CASE -WHEN -THEN KULLANIMI
select FirstName, LastName,
		case (city)
			when 'USA'
			then 'Amerika Birleþik Devletleri'
			when 'UK'
			then 'Ýngiltere Birleþik Krallýðý'
		else 'Ülke Belirtilmedi'
		end as Country --Yukarýdaki döngü ile oluþan kolonun ismi Country olsun diye as eklemesi yaptýk
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
--100 adetten fazla satýlan ürünleri getirin
select ProductName, SUM(AdetSayýsý) as 'Satýþ Miktarý'  from [TblOrder]
	 group by ProductName having SUM (AdetSayýsý)>10

--DELETE ÝÞLEMÝ
insert into TblProduct (ProductName,ProductStock) values ('ali', 120)
select*from TblProduct
delete from TblProduct where ProductID=11

---Products tablosundan max fiyatý bulan sorgu 
        /*
		Aþaðýdaki 2 satýr sorgu beraber çalýþýr. 
		money=(select MAX(SalesPrice) from TblProduct) >>> önce bu srogu çalýþýyor
		sonra bulunan deðer @maxfiyat üzerine atanýyor.
		sonra "select*from TblProduct where SalesPrice=@maxfiyat" sorgusu çalýþýyor ve bulunan deðer gidip
		@maxfiyat deðeri ile eþleþiyor
		*/
declare @maxfiyat money=(select MAX(SalesPrice) from TblProduct)
select*from TblProduct where SalesPrice=@maxfiyat

--fiyati ortalama fiyatin ustunde olan urunler
declare @ortfiyat money=(select AVG (SalesPrice) from TblProduct )
		select*from TblProduct where SalesPrice>@ortfiyat
     ---ikinci yöntem
		select*from TblProduct
		where SalesPrice>(select AVG(SalesPrice) from TblProduct)

--50 dolar ile 100 dolar arasinda bulunan tum urunlerin adlari ve fiyatlari
select ProductName, SalesPrice from TblProduct
where SalesPrice between 3000 and 5000

---PRÝMARY KEY:
  /* Benzersiz ID deðeri tutar
     Tablonun kimliði oluyor primary key
	 Satýrýn ID deðeri baþka satýrda kullanýlmýyor
	 iliþkili tablolarda silme iþlemi olmaz active-passive iliþkisi kullanýlýr.
	 STATUS isminde sütun eklersin; 0 ve 1 türünde deðer alýr yani DataType'ý bit oldu.
  */


---SUBQUERY : Ýç Ýçe Sorgular 
select*from TblProduct 
where SalesPrice=(select max (SalesPrice) from TblProduct )

--alt sorguda birden fazla deðer dönüyorsa =() yerine in() kullan
select*from TblProduct where CategoryID in
	(
	select CategoryID from TblCategory 
	where CategoryName='Beyaz Eþya' or CategoryName= 'Mobilya'
	)

--þartlý sorgu yazýyorsak (AND) =() kullanýlmalý
select* from TblProduct where CategoryID 
	=(
	select CategoryID from TblCategory 
	where CategoryName='Beyaz Eþya'
	)
	and SalesPrice>100

--ürün listesindeki beyaz eþyalarýn stok sayýsýna 10 ekleme yap
update TblProduct set ProductStock=ProductStock+10
	where CategoryID = (select CategoryID from TblCategory where CategoryName='Beyaz Eþya')
select* from TblProduct

--ürün listesindeki küçük ev aletlerinin satýþ fiyatý-alýþ fiyatý
select ProductName,SalesPrice-ProductPrice as 'Fiyat Farký' from TblProduct 
	where CategoryID=(select CategoryID from TblCategory where CategoryName='Küçük Ev Aletleri')

--ürün tablosundaki beyaz eþyalarýn tamamý satýlýrsa ne kadar para kazanýlýr
select ProductName, (SalesPrice-ProductPrice)*ProductStock as 'SAtýþ Karý' from TblProduct 
	where CategoryID =(select CategoryID from TblCategory 
			where CategoryName='Beyaz Eþya')

---JOÝN YAPISI 
--ÝNNER JOÝN (ortak küme)
/*
select a,b,c from TABLE1 inner join TABLE 2
	on TABLE1.a=TABLE2.b

buradaki a ve b primary key/foreign key'e karþýlýk geliyor
*/

select*from TblOrder 
	inner join TblCustomer
	on TblOrder.OrderID=TblCustomer.OrderID
	inner join TblProduct
	on TblProduct.ProductID=TblOrder.ProductID

select CategoryName, COUNT(*) as 'Adet' from TblProduct inner join TblCategory
	on TblCategory.CategoryID=TblProduct.CategoryID
		group by CategoryName order by Adet

----VÝEW: konttol tekrarýný engeller birleþtirmeyi kýsaca sunar.
---hazýrladýðým view1 sorgusu
SELECT        dbo.TblCustomer.CustomerName, dbo.TblOrder.ProductName, dbo.TblProduct.SalesPrice
FROM            dbo.TblCustomer INNER JOIN
                         dbo.TblOrder ON dbo.TblCustomer.OrderID = dbo.TblOrder.OrderID INNER JOIN
                         dbo.TblProduct ON dbo.TblOrder.ProductID = dbo.TblProduct.ProductID

select*from View_1 ----view ismi kýrmýzý olsa da kodu çalýþtýrýnca çalýþýr.

/*
PROCEDURE
---C# daki metotlar gibi çalýþýyor.
---Procedure oluþtururken DDL komutlarý kullanýlýr. 
---DDL komutlarý nelerdir; 
		1.CREATE 
		2.ALTER 
		3.DROP
--- nerede bulunurlar?
	programmability-stored procedures altýnda
*/

---bir procedure yazalým
create procedure productlist
	as
		select ProductName, CategoryName from TblProduct inner join TblCategory
			on TblProduct.CategoryID=TblCategory.CategoryID
execute productlist

--ikinci bir procedure yazalým
create procedure productlist2(@stock int) 
	as
		select ProductName,ProductStock from TblProduct inner join TblCategory
			on TblProduct.CategoryID=TblCategory.CategoryID
				where ProductStock>@stock

execute productlist2 120 ---burada dýþarýdan 120 yerine manuel deðer girip kontrol saðlayabiliyoruz.

/*
	TRÝGGER: tetikleyici
	çalýþtðýn tablonun klasörü içindeki trigger klasörüne geliyor triggers'lar
*/

---T-SQL; 
---deðiþken, karar yapýsý ve döngü kullanýlýyor

declare @sayý1 int ---declare ile deðiþken tanýmlanýyor


USE Northwind
-- Yukarýdaki combobox kullanýlabilir.

-- DML => DATA MAP LANGUAGE

-- NORTHWÝND VERÝ TABANI ÜZERÝNDE SORGULAMALAR YAPACAÐIZ.
--

-- Tablolalarý sorgulamak
-- Select >sütun adlarý From <Tablo_adý>-- (sütun adalarý arasýnda virgül olacak)

select *
from Employees

select * from Region

-- emoloyees tablosundan istediðimiz sütun bilgilerini getirdik.
select FirstName, LastName, Title, BirthDate
from Employees

-- seçmek istediðimiz sütunlarý aralarýna virgül koyarak belirtiyoruz.
-- sütun isimleri intellisense menüsü ile gelmesi için kullanýlýr.
-- select ifadesinden sonra from <tablo adý > yazýp daha sonra select ile from arasýnda sütun isimleri konulabilir.

-- sütun isimlendirme, tablolardaki baþlýklarý deðiþtirme.
select firstname as isim, Lastname as soyisim, Title as baþlýk from Employees

-- sorgu sonucunda dönen sonuç kümesi (Result set) sütun isimleri deðiþtirilmesi durumu söz konusu deðildir.

-- 2. yol; birden fazla kelimeden oluþacak bir ismi oluþturduðumuzda köþeli parantez içerisinde
--tek týrnak ile belirtilir. AltGr+8 ve AltGR+9 köþeli parantezi saðlar.

--Metinsel ifadeler tek týrnak içerisinde belirtilir.

select Ad=FirstName, soyisim=LastName, baþlýk=Title,[Doðum Tarihi]=BirthDate 
from Employees

select ad=firstname , soyad=Lastname , baþlýk=title , 'Doðum Tarihi'=Birthdate
from Employees

-- 3. yol; as ve köþeli parantezi entegre ederek kullanmak

select FirstName as Ad, LastName as Soyad, Title as Baþlýk, Birthdate as [Doðum Tarihi]
from Employees

-- TEKÝL KAYITLARI LÝSTELEME

select City from Employees  -- Ayný þehirler listelenir.

select distinct City
from Employees -- farklý þehirler (tekil deðer) olarak listelenir.

select distinct
firstname, City
from
Employees  -- Bu kod üstteki kod ile ayný sonucu verir. ama bunu yazdýðýmýzda çýkan listede city'ler ayný olmasýna raðmen yazýldý çümkü
           -- firstname farklý
		   -- Üstteki ile ayný kodlarý döndürecek sebebi ise ayný ad ve þehir sahip kayýtlarýnýn olmamasýdýr.
		   -- Eðer listeleme firstname=steven , city = london olan baþka bir kayýt daha girilirse tabloya bu kayýtlardan sadece biri
		   -- listelenecektir.

select TitleOfCourtesy, Firstname, Lastname
from Employees

Select (TitleOfCourtesy+' '+Firstname+' '+Lastname) as Ýsim
from Employees  -- + operatörü ile metinleri birleþtirebiliriz. 'ile araya boþluk ekliyoruz. Eðer as isim demeseydik
                -- tablomuzda sorguda yazdýðýmýz gibi bir bütün sütün olmadýðý için sütun baþlýðý no columnname þeklinde görülürdü.

-- SORGULAMA FÝLTRELERÝ
-- Yazýlan sorgularý belirli koþullara göre filtreleme. Bunun için where keyword'ü kullanýlýr.

-- Ünvaný 'Mr olanlarý listeleme' ;
select Firstname, LastName, TitleOfCourtesy from Employees
where TitleOfCourtesy ='Mr.' ----Metinsel ifadelerde týrnaklarý unutma!!

--EmployeeID'si 5'den büyükleri getirmek;

select Firstname, Lastname from Employees
where EmployeeID > 5

--1960 yýlýnda doðanlarýn listlenmesi; 

select BirthDate from Employees
where BirthDate=1960 --bu þekilde yazdýðýnda anlamýyormuþ tarih formatý ayrý bir þeymiþ.

select firstname,LastName, BirthDate from Employees
where YEAR (Birthdate)=1960

-- YEAR fonksiyonu bizden datetime tipinden bir deðer alýr ve geriye o tarih bilgisinin yýlýný döndürür

--1950 ile 1961 yýllarý arasýnda doðanlarý listeleme.

select firstname, lastname, birthdate from Employees
where year(BirthDate)>=1950 and year(birthdate)<=1961 

-- ingilterede oturan bayanlarýn adý soyadý mesleði ünvaný ülkesi ve doðum tarihini listele.

select firstname, lastname, title, birthdate,TitleOfCourtesy from Employees
where Country='UK' and TitleOfCourtesy='Ms.' or TitleOfCourtesy='Mrs.'

select (TitleOfCourtesy+' '+ Firstname +' '+ Lastname) as isim from employees
where country= 'UK' and TitleofCourtesy='Ms.' or Titleofcourtesy='Mrs.' 


--ünvaný Mr. olanlar veya yaþý 60dan büyük olanlarýn listelenmesi

select firstname, lastname, BirthDate, TitleOfCourtesy from Employees
where TitleOfCourtesy= 'Mr.' or YEAR(BirthDate)>60

--yukarýki örneði hocanýn yaptýðý þekil;

select TitleofCourtesy as ünvan, firstname as isim, Lastname as soyad, 
YEAR (getdate()) - year (birthdate) as Yaþ
from Employees
where TitleOfCourtesy='Mr.' or (YEAR(getdate()) - Year(BirthDate) >60)

-- Getdate() fonksiyonu güncel tarih bilgisini verir. Year() fonksiyonu ile birlikte o tarihe ait olan yýl bilgilerini
-- öðreniyoruz bu þekilde. 
-- where ifadesi ile birlikte kendi isimlendirdiðimiz sütunlarý kullanamayýz.

-- NULL GELME DURUMU;

select Region from Employees where Region is null 

select TitleOfCourtesy, Firstname, Lastname, Region from Employees where Region is not null 
-- yukarýda null içermeyen durumlarýn gelmesi örneði
-- not: null deðer sorgulanýrkern = veya >< gibi operatörler kullanýlýr.
-- Bunun yerine is null veya is not null ifadeleri kullanýlýr. 

--------- CTRL+k+c SEÇTÝÐÝN ÝFADETÝ KOMUTA YA DA NOT VERSÝYONLU YAZIYA DÖNÜÞTÜRÜR.

-- SIRALAMA ÝÞLEMLERÝ;

select * from Employees
where EmployeeID > 2 and EmployeeID <=8
order by FirstName -- böyle býrakýrsan employeeide'ye artan þekilde sýralar

select * from Employees
where EmployeeID > 2 and EmployeeID <=8
order by firstname asc --böyle olunca employee'ye göre deðil de isimlere göre alfabeik sýralama yapar
                       -- ascending (artan sýrada)

select firstname, lastname, BirthDate, hiredate from Employees
order by LastName desc  -- tersten sýralama bu da
                        -- descending (azalan sýralama) 

-- asc ifadesi metini sayýsal sütunlarda küçükten büyüðe, metinsel sütunlarda a'dan z'ye doðru sýralar.
-- des ifadesi ise tam tersi

select firstname, lastname from Employees
order by FirstName, LastName desc;

-- elde ettiðimiz sonuç kümesini ada göre artan sýrada sýraladýk
-- eðer ayný ada sahip birden fazla kiþi olsaydý bunlarý da soyadýna göre azalan sýrada yapýyoruz.

 select firstname, lastname, title, birthdate,HireDate, TitleOfCourtesy  from Employees 
 order by 6,4 desc -- Sorguda yazýlan sütun sýrasýna göre sýralama iþlemi
                   -- Burada ilk önce 6. sýradaki sütuna (titleoofCourtesy)
				   -- artan sýrada sýralama, daha sonra ayný ünvan deðerine sahip kayýtlar içim
				   -- 4. sýradaki (hiredate) sütununa göre azalan sýralama iþlemi yaptýk.

--çalýþanlarý ünvanlarýna göre, ünvanlarý ayný ise yaþlarýna göre sýrala;
select firstname, lastname, title, birthdate,HireDate, TitleOfCourtesy, YEAR (getdate()) - year (birthdate) as year  from Employees
order by Title, year desc -- order by sýralamasýnda as m ile isimlendirdiðin kolon da kullanýlabilir


-- ders sonu uygulama;

select*from Products
order by ProductName asc

select*from Products
order by productname desc

select*from Products
where CategoryID=3
order by ProductName

select (Firstname+' '+Lastname) as adsoyad from Employees

select ((UnitPrice)*118/100) as KDV from Products

-- order by en sonda olmalýdýr

select TitleofCourtesy +''+ Firstname +''+ Lastname from Employees
where TitleofCourtesy In ('Dr.','Mr.')

--1950, 1955 ve 1960 arasýndaki doðanlarý listele
select FirstName, LastName, YEAR (BirthDate) as [DogumYýlý]
from Employees
where Year (BirthDate) in ( 1950,1955,1960)

-- TOP KULLANIMI
-- Sýralama için kullanýlýr. 

select * from Employees  -- tamami gelir
select top 3 * from Employees   --Ilk 3 kayiti almak 

--Employees tablosundan ad, soyad, ba; bilgisi; ek bilgilerinin ilk 5 satirini getir; bunu title of courtesy e gore sirala

select top 5 firstname, lastname, TitleOfCourtesy from Employees
order by TitleOfCourtesy desc

-- Top ifadesi sorguda en son calisan isimdir; yani oncelikle sorguda calistirilir ve olusacak olan sonuc kumesinin 
-- result set ilk 5 kaydi dondurulur.

--calisanlar yaslarina gore azalan sirada siralandiktan sonra olusacak olan sonuc kumesinin  %25lik kismini listeleyelim

select top 25 percent firstname, lastname, Title, YEAR (GETDATE ())-YEAR(BirthDate) as Yas
from Employees order by Yas asc 

--Eger beirtilen oran sonucu 3.2 gibi bir kayit sayisi var ise bu durumda bize ilk 4 kayit getirilir

--kullanicilarin ise giris tarihine gore ilk 3 unu getir

select top 3 firstname, lastname, hiredate
from Employees
order by HireDate asc

-- LIKE KULLANIMI

select firstname, lastname, title from Employees
where FirstName = 'michael'

select firstname, lastname, title from Employees
where FirstName like 'michael'      -- 2. YOL

--Adinin ilk harfi A ile baslayanlar;
select firstname, lastname, title from Employees where FirstName like 'A%'   --Filtreleme yapmak istiyorsan % kullan

--Soyadinin son harfi N olanlar
select firstname, lastname, title from Employees
where LastName like '%N'

--Adinin icinde E harfi gecenleri

select firstname, lastname, title from Employees
where firstname like '%E%'
order by 1 asc                      --burada 1 yazmasi birinci kolunu sirala anlamina geldi 

--Adinin ilk harfi A veya L olanlar;
-- 1. Yol
select firstname, lastname, title from Employees
where firstname like 'A%' or firstname like 'L%'
order by 1 asc 
--2. Yol
select firstname, LastName, title from Employees
where firstname like '[AL]%'

--Adinin icerisinde R veya T bulunanlar;
--1.yol
select firstname, lastname, title from Employees
where firstname like '%R%' or firstname like '%T%'
order by 1 asc 
--2.yol
select firstname, lastname, title from Employees
where firstname like '%[RT]%'
order by 1 asc 

--Adinin ilk harfi alfabetik olarak J ve R araliginda olanlar;
select firstname, lastname, title from Employees
where firstname like '[j-r]%'
order by FirstName

-- A ve E arasinda tek bir karakter olanlari alalim;
select firstname, lastname, title from Employees
where FirstName like '%A_E%'

-- A ve E arasinda iki karakter olanlari alalim;
select firstname, lastname, title from Employees
where FirstName like '%A__E%'

--Adinin ilk harfi M olmayanlar
select firstname, lastname, title from Employees
where FirstName not like 'M%'
order by FirstName

--2.yol;
select firstname, lastname, title from Employees
where FirstName like '[^M]%'
order by FirstName

--Adi T ile bitmeyenler
select firstname, lastname, title from Employees
where FirstName not like '%T'
order by FirstName 

--adinin ilk harfi a ile i araliginda bulunmayanlar 
select firstname, lastname, title from Employees
where FirstName not like '[A-I]%'

--adinin ikinci harfi a veya t olmayanlar
select firstname, lastname, title from Employees
where FirstName not like '_[AT]%'

--adinin ilk iki harfi LA, NA, AA, AN olanlar
select firstname from Employees
where FirstName like '[LA, NA, AA, AN]%'

-- Icerisinde _ gecen isimlerin listelenmesi;
-- Normalde _ karakterinin ozel bir anlami vardir ve tekbir karakter yerine gecer
-- ancak [] icerisinde belirtildiginde siradan bir karakter gibi aratilabilir

select firstname, lastname, title from Employees
where FirstName like '%\_%' escape '\'

select firstname, lastname, title from Employees
where FirstName like '%[_]%'

-- Custormers tablosundan costumers ýd'sýnýn 2. harfi A, 4. harfi T olanrýn %10luk kýsmýný getir.

select top 10 percent * from Customers
where CustomerID like '_A_T%' 

--VERITABANI ISLEMLERI 1) insert: Bir veri tabanindaki tablolarin birine yeni kayit eklemek icin kullanilir.
--Insert into <tablo adi> (<sutunisinleri>) values <sutunundegerleri> 

--use Northwind
insert into Categories (CategoryName, Description)
values ('baklagiller', 'Guzeldir bunlarin tadi:')
select * from Categories     --categoryname kisminin values'u baklagiller, description kisminin ki guzeldir bunlarin tadi

insert into Categories (Description)
values ('Kategorinin adi girilir.') ---Bu basarisiz oldu cunku kategori tablosundaki null gecilmeyen categoryname sutunu icin
                                    -- bir deger atamadik. Bir tablonun icindeki null icermeen degelere insert islemi 
									-- sirasinda mutlaka bir deger atamaliyiz eger Identity ozelliginde bir sutun varsa (otomatik artan)
									-- bu sutun degeri sistem tarafindan atanacagi icin insert isleminde belirtmeye gerek yoktur.


-- insert ile tabloya ekleme yapýlýyor.
-- insert into <tablo adi> (<sutun adlari)

insert into Categories (CategoryName, Description)
values ('ev eþyalarý', 'pahalý olur')

--Insert into  ile tablodaki sutunlarin hepsi ne geri verilecekse girilebilir.
-- ancak tabloyu olusturdugun sutunlarin siralamasina dikkat et

insert into Shippers (CompanyName, Phone)
values ('MNG Kargo','02163300338')

--Customers tablosuna 'Vodafone sirketini ekle'
Select*from Customers 
insert into Customers (CustomerID, CompanyName)
Values ('ASDF','Vodafone')
Select*from Customers 

--UPDATE SET WHERE
--Tablodaki kayitlari guncellemek icin 
-- Hangi kaydi guncellemek istiyorsan acikca belirtmen gerekiyor

--update <Tablo_Adi>
--Set <Kolon Adi> =Yeni Deger

select*into calisanlar from Employees --Employees tablosundaki tum degerleri calisanlar diye bir tablo
                                      -- olusturup ona ekledi

update calisanlar
set LastName='Vatansever'
select*from calisanlar  --LastName kolunun hepsinde Vatansever yaziyor
                        --bu yapilan isme geri gelmiyor bu arada

update calisanlar
	set FirstName='Mehmet', LastName='Tas'
	where EmployeeID=8  --Bir kayit degistieeksen ID uzerinden islem yap
select *from calisanlar
	where EmployeeID=8

-- Products tablosunda Urunler diye bir tablo olusturup %5 zam yaptim 
select*into Urunler from Products
select ((UnitPrice)*105/100) as KDV from Urunler

--ARASI YOK bende kaydetmeden program kapandi

select*into calisanlar from Employees
delete from calisanlar
drop table calisanlar

 select*into Calisans from Employees 
 where EmployeeID='Michael'

 --Dml Son--
 --TARIH FONKSIYONLARI
 --DATEPART(): Bir tarih bilgisinin istenilen bolumunu size verir. 

 --Yila Gore
 select FirstName, LastName, DATEPART (DY, BirthDate) as [Day of The Year]
 from Employees
 --Aya gore
 select FirstName, LastName, DATEPART (M, BirthDate) AS [ay]
 from Employees order by [ay]
 --Yilin kacinci haftasi
 select FirstName, LastName, DATEPART (WK, BirthDate) as [Week of Year]
 from Employees order by [Week of Year] desc
 --haftanin kacinci gunu
 select FirstName, LastName, DATEPART (DW, BirthDate) as [Day of Week]
 from Employees order by [Day of Week]
 --Saate gore
 select FirstName, LastName, DATEPART(HH, BirthDate) as [HOUR]
 from Employees order by HOUR desc
 -- dakikaya gore
 select FirstName, LastName, DATEPART (MI, GETDATE()) AS [Minute]
 from Employees order by Minute
 --Saliseye gore
  select FirstName, LastName, DATEPART (MI, GETDATE()) AS [Salise]
 from Employees order by Salise

 select FirstName, LastName, DATEPART (MI, GETDATE()) as [Minute]
 from Calisans where EmployeeID=10

 --DATEDIFF KULLANIMI
 select (Firstname+''+Lastname) as Isim, DATEDIFF (YEAR, BirthDate, GETDATE ())
 as yas, DATEDIFF(DAY, HireDate, GETDATE()) AS [Odenen Prim]
 from Employees

 select FirstName, DATEDIFF(HOUR, BirthDate, GETDATE()) as [kac saat gecti]
 from Employees

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
 select CHARINDEX('@', 'test@gmail.com') as konumbilgisi
--arama yapacagin karakter ve string veriyorsun bulundugu konumu veriyor
--bulamazsa geriye sifir doner

select LEFT ('Bilge Adam', 4) --soldan 4u donduruyor bu komut

select LEN ('Bilge Adam') as [KArakter sayisi] --uzunlugun sayisal degerini dondurur

select LOWER ('BEGUM') as [buyugu kucuge dondurmek]
select upper ('begum') as [kucugu buyuge dondurmek]

select LTRIM ('     Begum') as [Soldan bosluk siler]
select rtrim  ('Begum     ') as [sagdan bosluk siler]
select LTRIM(RTRIM('    Begum     ')) as [Bosluklari sil]

select REPLACE ('birbirlerine', 'bir', 'uc') as [metinlerin yerine yenilerini atar]

select SUBSTRING ('bilge adam akademi', 4, 6) --4. karakterden itibaren 6 karakter aldi, bosluk dahil

--yan yana iki adet tirnak yazdigimizda bu ifade tek tirnak yerine gecer.
-- tek tirnagin ozel bir anlami oldgundan dolayidir.

select reverse ('Bilgge adama hosgeldin') as [tersine cevirir]

select 'Bilge Adam' + space(30)+'Hosgeldin' as [belirtilen biktarda bosluk birakir]
select REPLICATE ('Bilge', 5) as 'Belirtilen metni belirtilen adette cogaltir'

--aggregate fonksýyonlarý
--(toplam fonksýyonlarý, gruplamalý fonksýyonlarý)

--COUNT ([Sütunadý]) || *)

select count(*)
from Employees -- bir tablodaki kayýt adetinin öðrenebiliriz

select COUNT (EmployeeID)
from Employees -- emploeedId sütunundaki kayýt sayýsýný verýr

select COUNT (Region)
from Employees

--regýon sütunundaki kayýt sayýsý (regýon sutununun null geçilebileceði için bir tablodaki kayýt sayýsýnýn 
-- bu sütundan yola çýkarak öðrenmek yanlýþ sonuçlar doðurabilir.
-- çünkü aggregate fonksiyonlarý null deðerleri dikkate almaz
--bu nedenle kayýt adetini öðrenebilmek iin * karakterini ya da null deðer geçirmeyen sütunlarýn
--birbiri adýna kullanmamýz gerekir

select COUNT(city)
from Employees
select COUNT(distinct City)
from Employees --kaç farklý þehir var

--SUM DEÐERLERÝN TOPLAMINI VERÝR
select SUM (EmployeeID)
from Employees --bir sütundaki deðerlerin toplamýný verecektir
select sum (YEAR (GETDATE ())-YEAR(BirthDate)) as [yaslarýn toplamý]
from Employees -- çalýþanlarýn yaþlarýnýn toplamýný bul
select SUM (DATEDIFF(year, birthdate, getdate())) as [yaslarýn toplamý]
from Employees --calýsanlarýn yaslarýnýn toplamý ikinci yol 

--AVG (SÜTUN ADI) DEÐERLERÝN ORTALAMASINI VERÝR

select AVG(EmployeeID) as [ID ortalamasý]
from Employees
select avg (YEAR (GETDATE ())-YEAR(BirthDate)) as [yas ortalamasý]
from Employees
-- AVG hesaplamasýnda null olanlar iþleme katýlmýyor, kiþilerin sayýsýna bölünmez
--null olmayan kiþi adetine bölünür.
select AVG (lastname)
from Employees --evg sayýsal sütunlarda kullanýlýr

--MAX (sÜTUN ADI) :SÜTUNDAKÝ EN BÜYÜK DEÐERÝ VERÝR
select max (EmployeeID) from Employees
select max (FirstName) from Employees  --alfabetik olarak en büyük deðeri verir.

select min (EmployeeID) from Employees
select min (LastName) from Employees

--CASE -WHEN -THEN KULLANIMI
select FirstName as ad, soyad=LastName, baslýk=Title, Country as ülke
from Employees
select FirstName, LastName,
		case (country)
			when 'USA'
			then 'Amerika Birleþik Devletleri'
			when 'UK'
			then 'Ýngiltere Birleþik Krallýðý'
		else 'Ülke Belirtilmedi'
		end as Country --Yukarýdaki döngü ile oluþan kolonun ismi Country olsun diye as eklemesi yaptýk
from Employees

select EmployeeID, FirstName,
	case 
		when EmployeeID>5
		then 'ID 5den buyuktur'
		when EmployeeID<5
		then 'ID 5den kucuktur'
	else '5e esittir'
	end as Esitlik
from Employees

select FirstName, LastName,
	case 
		when TitleOfCourtesy='Mr.'
		then 'Bay'
		when TitleOfCourtesy='Mrs.'
		then 'Bayan'
	else 'genc kadin'
	end
from Employees

select FirstName,
	case (EmployeeID)
	when 1
	then 'Bir'
	else 'yeterli'
	end
from Employees

--GROUP BY

-- calisanlarin ulkelerine gore gruplandirilmasi;
select Country as ulke, COUNT(*) as [kisi sayisi]
from Employees where Country is not null
group by Country

--calisanlarin yapmis oldugu siparis adeti
select EmployeeID, count (*) as [siparis adeti] from Orders
group by EmployeeID order by [siparis adeti] desc

select UnitPrice, COUNT(*) as [urun bedeli] 
from Products where UnitPrice<=35 group by UnitPrice 
order by [urun bedeli] 

--bas harfi a-k araliginda olan ve stok urun miktari 5 ile 50 arasinda olanlari
--kategorilerine gore listele
select CategoryID, count (*) as [adet]
from Products
where ( ProductName like '%[AK]%' and UnitsInStock between 5 and 50 )
group by CategoryID
order by [adet] asc

--herbir siparisteki toplam urun adeti
select OrderID, sum (Quantity)
from [Order Details]
group by OrderID

--herbir sipariþi tutarýna göre listele 
select OrderID, sum ((Quantity*UnitPrice)*(1-Discount)) as [siparis tutari]
from [Order Details]
group by OrderID order by [siparis tutari]

--HAVING KULLANIMI
-- kurgu sonucunda gelen sonuc kumesi uzerinde  Agg fonksiyonlarina bagli olacak
--sekilde filtreleme islemi yapilacaksa eger WHERE yerine HAVING kodu kullanilir/
--Bu sayede aggregate fonksiyonlarinda filtreleme islemine katabiliriz.
--Eger Aggregate fonksiyonlari sorgumuzda yoksa HAVING kullanimi WHERE ile ayni filtreleme
--islemi yapar.

--her bir siparisteki toplam urun sayisi 200 den az olanlar
select OrderID, SUM(Quantity) as [urun sayisi]
from [Order Details]
group by OrderID
having sum (Quantity)<200
order by [urun sayisi] asc

--fiyati 20den kucuk urunlerin basina tr ekleyerek 
select 'Tr-'+ ProductName, UnitPrice as urunad
from Products
where (UnitPrice)<20

--productname kolonundaki verilerin hepsinin karakterini buyut
select UPPER (ProductName)
from Products

--en ucuz 5 urunun ortalama fiyati 
select top 5 AVG (UnitPrice)
from Products

-- 1000 adetten fazla satýlan ürünleri getirin
select ProductID, sum (Quantity) as 'satýþ'
from [Order Details]
group by ProductID having sum (Quantity)>1000

--alt sorgular ic ice sorgular
declare @maxfiyat money=(select MAX(UnitPrice) from Products)  --products tablosuna gidiyor maxfiyat buluyor
select*from Products where UnitPrice=@maxfiyat  --bu iki satir bir kod beraber calitir
                                                -- select money=maxunitprice sorgusu calisiyor bulunan deger @degerine ataniyor sonra gidiyor 
												-- select*from Products where UnitPrice=@maxfiyat bu sorgu calisiyor ve atanan @ degeri geliyor

--SUBQUERY
select*from Products 
where UnitPrice=(select max (UnitPrice) from Products)

--fiyati ortalama fiyatin ustunde olan urunler
declare @ortfiyat money=(select AVG (UnitPrice) from products )
select*from Products where UnitPrice>@ortfiyat

select*from Products
where UnitPrice>(select AVG(UnitPrice) from Products)

--urunler tablosundaki urunlerin listesi
select *from Products
where ProductID in (select ProductID from [Order Details]  )

--urunler tablosunda satilmayanlar
select *from Products
where ProductID not in (select ProductID from [Order Details]  )

--kategori tablosundaki kategoryID kolonu ile urun tablosundaki CategoryID kolon bilgilerini
--birbirleri ile eslestirerek karsilikli degeri yazmis olduk;
--parantez icindeki iki seyin eslesmesi ile yeni bir kolon olusmus oldu categoriesdeki
-- ve products daki eslesmis yeni bir sutun olustu
select P.ProductName, P.UnitPrice, P.UnitsInStock,
(select CategoryName from Categories c where c.CategoryID=P.CategoryID )
from Products P

select FirstName, LastName 
from Employees 
where Title in 
(select Title from Employees where title is not null)

--kargo sirketlerinin tasidiklari siparis sayilarini
select
(select CompanyName from Shippers S 
where S.ShipperID=O.ShipVia) as [Kargo],
ShipVia, count(*)
from Orders O
group by ShipVia

--calisma sorulari
--brazilde bulunan musterilein sirket adi, temsilciadi, adre, sehir. ulke bilgisini
--getir ve sirala

select CompanyName,ContactTitle, Address, City, Country from Customers 
where Country='Brazil'
order by CompanyName asc

--brazilde olmayan musteriler
select CompanyName,ContactTitle, Address, City, Country from Customers 
where Country! = 'Brazil'
order by CompanyName asc

--ulkesi ya spain ya france ya da germany olan musterile alfabetik siralama ile gelsin
select CompanyName, City, Country 
from Customers where Country='France' or  Country='France' or Country='Germany'
order by CompanyName asc

--faks numarasi bilinmeyen musteriler nelerdir
select CompanyName,ContactTitle, Address, City, Country from Customers where Fax is null 
order by CompanyName asc

--londrada ya da pariste bulunan musterilerin 
select CompanyName, City, Country from Customers where Country='Londra' or  Country='Paris' 
order by CompanyName asc

--hem mexico da ikamet eden hem de contacttitle bilgisi owner olan musteriler
select CompanyName, City, Country  from Customers where Country='Mexico' and ContactTitle='Owner'
order by CompanyName asc

--C ile baslayan urunlerin isimleri ve fiyatlari
select ProductName  from Products where (ProductName like 'C%')
order by ProductName asc

--Adi 'A' ile baslayan calisanlarin ad soyad dogum tarihi
select FirstName, LastName, YEAR (GETDATE ())-YEAR(BirthDate) from Employees
where FirstName like 'A%'
order by FirstName asc

--isminde restaurant gecen musterilerin sirket adlarini
select CompanyName from Customers where CompanyName like '%Restaurant%'
order by CompanyName asc

--50 dolar ile 100 dolar arasinda bulunan tum urunlerin adlari ve fiyatlari
select ProductName, UnitPrice from Products
where UnitPrice between 50 and 100

---1 temmuz 1996 ile 31 aralik 1996 tarihleri arsinda siparislerin id,  siparis tarih bilgilerni
--getir
select OrderID, OrderDate from Orders
where OrderDate between '1996-07-01' and '1996-12-31'
order by OrderID asc

--musterileri ulkeye gore sirala , tekrar etmesin
select distinct country from Customers
order by Country asc

--urunlerin en pahalidan en ucuza dogru siralama sonuc olarak urun adi ve fiyati
select ProductName, UnitPrice from Products 
order by UnitPrice desc

--1 numarali kategoreide kac urun var
select count(*) productname  
from Products where CategoryID=1 

--kac farkli ulkeye ihracat yapiyor
select count (distinct Country) from Customers

--subquery tekrarý;
--declare ýle degýsken tanýmlýyoruz. verýnýn týpý onemlý. cekecegýmýz verýnýn týpý money
-- bu yuzden money yazdýk. parantez icinde istedigimiz seyi yazdik buradaki sonuc
--@x dedgimiz x e atandi sonra ozellikleri geldi. (Dunku koda bak)

--en pahali urunun adi
select ProductName
from  Products
where UnitPrice=(select max (UnitPrice) from Products)

--EXISTS YAPISI
-- Exists yapisi tablonun dolu ya da bos oldugunu dondurur. bu metot degil fonk degil keyword
--if() print (dogru)
--else 
-- print (Yanlis)

if exists (select * from Employees)
print 'Dolu'
else print 'Bos'  --print messege ile cikar

--siparis alan calisanlar 
select * from Employees e1
where exists
	(select EmployeeID from Orders e2 where e1.EmployeeID=e2.EmployeeID)

select * from Employees e1
where not exists
	(select EmployeeID from Orders e2 where e1.EmployeeID= e2.EmployeeID)

--ic yazilan alt sorgu donen tum kayitlar icinde eslesme yaptiktan sonra ana sorgu calismasini tamamlar.

-- Exists ile altsorguya eslesme yapilan tum kayitlara gore sonuclandirir ve ilave olarak gelen kayitlar icinde
-- eslesme yapmaya gerek kalmaz exists zaten altsorgu'dan ihtiyaci olan kayitlari getirir.
-- Exists condition (if-else) icerisinde kullanilabilir.

--JOINLER
--1) inner join: bir tablodaki her bir kaydin diger tabloda bir karsiligi olan kayitlari listeler.
-- Inner Join ifadesini yazarken inner kelimesini yazmasak da sadece join yazrsak da bu yine inner join olarak algilanir.

select ProductName, CategoryName
from Products inner join Categories --innerjoin ile birlesecek tablolari yazdik
on Categories.CategoryID=Products.CategoryID  --burada da her iki tablodaki ortak kolonlari aldik set ettik ve eslestirdik

select ProductName, ProductID, Products.CategoryID, CategoryName, [description]
from Categories inner join Products
on Categories.CategoryID=Products.CategoryID
--not:
--eger sectigimiz sutunlar her iki tabloda bulunuyorsa, o sutunun hangi tablodan sectigimizi acikca belirtmek gerekir
--(products.categoryID gibi)

--hangi siparis hangi calisan tarafindan hangi musteriye ulastirildi
select OrderID, OrderDate, CompanyName, ContactName, (Firstname+''+ LastName), Title 
from Orders 
		inner join Employees on Orders.EmployeeID=Employees.EmployeeID
		inner join Customers on Orders.CustomerID=Customers.CustomerID

select OrderID, OrderDate, CompanyName, ContactName, (Firstname+''+ LastName), Title 
from Customers as C inner join orders as O on C.CustomerID=O.CustomerID
					inner join Employees as E on E.EmployeeID=O.EmployeeID --iki sorgu da ayni sonucu verdi 

--sorguyu kisaltmak icin tablo isimlerine gore takma isim verilebilir.
--ancak erilen takma isimde dikkat edilmesi gereken nokta bir tabloya takma isim verdikten sonra artik
--her yerde o ismin kullanilmsai gerektigidir.

--Suppliers tablosundan CompanyName,ContactName  ;
--Product Tablosundn productName, Unitprice      ;
--Categories tablosundan CategoryName            ;
--Company Sutununa gore sirala. 
select CompanyName, ContactName, ProductName, UnitPrice, CategoryName
from Categories as C inner join Products as P on C.CategoryID=P.CategoryID
					 inner join Suppliers as S on S.SupplierID=P.SupplierID
order by CompanyName

select CompanyName, ContactName, ProductName, UnitPrice, CategoryName
from Categories inner join Products on Categories.CategoryID =Products.CategoryID
				inner join Suppliers on Suppliers.SupplierID=Products.SupplierID
order by CompanyName

--Kategorilere gore toplam stok miktarini bulunuz.
select CategoryName, SUM (UnitsInStock) as Stok from Products
	inner join Categories on Categories.CategoryID=Products.CategoryID
group by CategoryName
order by Stok desc

--herbir calisan toplam ne kadarlik satis yapti 
select (FirstName+''+LastName) as Calisan,
Cast (sum ((Quantity*UnitPrice)*(1-Discount)) as decimal (15,2))  as Toplam 
from Employees as E inner join Orders as O on E.EmployeeID=O.EmployeeID
					inner join [Order Details] as OD on O.OrderID=OD.OrderID
Group by (FirstName+''+LastName)
order by Toplam desc        -- virgulden sonraki kismi as decimal ile sinirlandirdik 2 yazdik virgulden 
							-- sonra 2 basamak geldi mesela. decimal ondalikli degerler icin kullanilan 
							-- bir fonksiyon.
							--unit price*quantitiy float ve int carpimiydi sonuc float cikacakti bu mat
							-- isleminden cikan sonucu cast ile decimal tipini cevirdi ki decimal ondalik
							-- degerleri ayarlar biz de virgulden sonra kaci gozuksun vs ayarlamis olduk 

-- en pahali 5 urun 
select top 5 * from Products order by UnitPrice desc

--ALFKI CustomerUD sine sahip musterilerin siparis sayisi 
select COUNT(*) as [Toplam Siparis Sayisi] from Orders 
where CustomerID='ALFKI'

--urunlerin toplam maliyeti.
select sum (UnitPrice*Quantity) as [Toplam urun maliyeti]
from [Order Details]

-- sirket simdiye kadar ne kadar ciro yapmis
select (Quantity*UnitPrice)*(1-Discount)  as [ Toplam Ciro]
from [Order Details]

--ortalama urun foyati
select avg (UnitPrice) from Products

--en pahali urunun adi
select ProductName, UnitPrice from Products 
where UnitPrice=(select max (UnitPrice) from Products)

-- en az kazandiran siparis
select top 1 OrderID, Sum (UnitPrice*Quantity) as [En karsiz siparis]
from [Order Details]
group by OrderID
order by [En karsiz siparis]

--musterilen icinde en uzun isimli olan kim 
select top 1  CompanyName, LEN(CompanyName) as [Uzunluk]
from Customers
order by Uzunluk desc

--hangi urunden toplam kac adet alinmis 
select OrderID, SUM(Quantity) as [Toplam satis miktari] from [Order Details]
group by OrderID
order by [Toplam satis miktari] desc

-- 1)INNER JOIN

--herbir kategori icin ortalama fiyati bulunuz. ortalama fiyat 20'den buyuk olan kategorileri getiriniz.

select CategoryName, UnitPrice from Products
	inner join  Categories on Categories.CategoryID=Products.CategoryID
group by Categories.CategoryName
having Avg (UnitPrice)>20 

--2) OUTER JOIN
--2.1) LEFT OUTER JOIN 
--Sorguda istenilen tablodaki soldaki tum kayitlari getirirkem sagdaki tablodaki sadece iliskili olan kayitlar getirilecektir.

select ProductName, CategoryName from Products as P
	left outer join Categories as C 
	on p.CategoryID=c.CategoryID

--Her bir calisanin rapor verdigi kisiyi listele

select (e1.FirstName+''+e1.LastName) as calisanbilgisi, (e2.FirstName+''+e2.LastName) as mudurbilgisi
from Employees as e1
	inner join Employees e2
	on e1.ReportsTo=e2.EmployeeID

--tum calisanlar ve eger varsa mudurleri ile birlikte listele
select (e1.FirstName+''+e1.LastName) as calisan, (e2.FirstName+''+e2.LastName) as Mudur
from Employees as e1
	left join Employees e2
	on e1.ReportsTo=e2.EmployeeID

--2.2) Right outer join: Sorguda katilan tablolarda sagdaki tum kayitlari getirirken, soldaki tabloda sadece iliskisi olan kayitlari getirmesi beklenir. (hicbir yazilimda kullanilmiyor sadece sinavlarda cikiyor)

select CategoryName, productName from Categories
right join Products on Categories.CategoryID=Products.ProductID

--2.3 FULL JOIN: LEFT+RIGHT BIRLESIMI
select CategoryName,ProductName from Categories 
	FULL JOIN Products on Categories.CategoryID=Products.CategoryID

--2.4: CROSS JOIN
select COUNT(*) from Categories --8 adet kayit dondu
select count(*) from Products   -- 77 kayit dondu

select CategoryName, ProductName from Categories cross join Products
		--her kategorinin product ile eslesen urunleri carpistiriyor

--100'den fazla olan urunler
select OrderID, sum (Quantity) as toplamsatis from [Order Details]
	group by OrderID
	having sum (Quantity)>100

--hangi musteriler siparis vermemis
select CompanyName, CustomerID from Customers
	where CustomerID not in (select distinct CustomerID from Orders)

--3) VIEW YAPISI
-- genellikle karmasik sorgularin tek bir sorgu uzerinden calistirilabilmesidir.
-- bu amac ile siklikla raporlama islemlerinde kullanilirlar.
--Ayni zamanda guvenlik oldugu durumlarda da herhangi bir sorgunun 2. veya 3. sahislara gizlenmesi amaciyla kullanilabilir.

--Herhangi bir sorgunun sonucunu tablo olarak ele alip uzerinde sorgu cekilebilmesine izin verir.
-- insert, delete, update gibi islemleri yapilir ve bu islemler fiziksel tablolara yansitilir.
-- View yapiari fiziksel olarak olusturulan yapilardir.

create VIEW PrdCtgSup as
select p.ProductName, p.UnitsInStock, C.CategoryName, S.CompanyName
from dbo.Products P
	inner join dbo.Categories C on P.CategoryID=C.CategoryID
	inner join dbo.Suppliers S on p.SupplierID=S.SupplierID

select * from PrdCtgSup  --duzenlemek istiyorsan CREATE yerine ALTER kullan
select CategoryName, CompanyName from PrdCtgSup

select*from PrdCtgSup where CategoryName='Beverages'

--Satis yapan calisanlarin satis numaralari ile birlikte ad-soyad bilgileri

alter VIEW EmpOrder as --basta create ile olusturmustum ama Title kismini eklemek istedim ve bu nedenle create kismini silip alter yazdigimda select*from kismi arasina ekleme yapabildim.
select FirstName+''+Lastname as [Ad Soyad], OrderID, E.EmployeeID, E.Title
from dbo.Employees E
	inner join dbo.Orders O on E.EmployeeID=O.EmployeeID

--==WITH ENCRYPTION KOMUTU==----
--Eger yazdiginiz view kodlarini object explorer penceresinden 'Views' kategorisine sag tiklarak goruntuleme yapmasini istemiyorsak gizlenmesini istiyorsak "With Encryption " komutu ile olusturmaliyiz.
--Bu islemden sonra View olusturan kiside dahil olmak uzere kimse komutlari goremez geri donusu olmayan bir druurm
--Bu nedenle view'lerin yedeginin bulunmasi gerekir
--With Encryption ifade 'AS' keyworddunden once yazilmali
--Bu islemden sonra design modu kapanir

Create View OrnekBirViewPersoneller
with Encryption as
select*from Employees

--Hangi urunun hangi kategoride oldugunu gosteren bir view yaz ve gizle
create view CatPro
with encryption 
as
select CategoryName, ProductName from Categories
	inner join Products on Categories.CategoryID=Products.CategoryID

--hangi tedarikci hangi urunu sagliyor 

create view SuppPro as
select CompanyName, ProductName from Suppliers
	inner join Products on Suppliers.SupplierID=Products.ProductID
order by ProductName asc

--Crud islemleri icin 
--tablo islemlerind delete update insert
--database yapilari icin drop, alter create
--kullan

--==STORED PROCEDURES===---
--(
--varsa parametreler bu alanda aliyor
--)as
-- yazilacak sorgu, kodlar. sartlar, fonksiyonlar, komutlar

alter proc sp_test
(
@Id int
)as
select*from Products where ProductID=@Id --programabilty system stored altinda olusturuldu
--create proc dedik ama degisim yaptik icinde bu yuzden alter yazdik basina

exec sp_test --geriye int dondurecek diye bir uyrari geldi ID tipinde bir deger istiyor
exec sp_test 3 --yazdik ve oldu 

--==STORED PROCEDURES==--
--Genek ozellikleri;
--normal sorgudan hizli calisirlar cunku normal sorgular Execute edilirken 'Execute plan' islemi gerceklestirilir.
--Bu islem hangi tablodan veri cekilecek hangi kolonlar gelecek, bunlar nerede sorgudaki keywordlerin sirasi vs gibi islemler yapar.
--Bir sorgu her calistiginda bu islemler aynen tekrar tekrar calistirilirsa surekli tekrarlanir execute islemi.
-- Fakat sorgu store procedure olarak calistirilirsa bu islem sadece bir kere yapilir.
--Diger calismalarda bu islemler yapilmaz.
--Bu nedenle performanslidir.
--Bu nedenle hiz performans artisi saglar.
--icerisinde select , insert, update islemleri gerceklestirilebiliyor.
--Dilerseniz ic ice kullanabilirsiniz.
--Disaridan deger alabilirsiniz. Bunlar Parametre olarak Stored procedure'lere gecirildiginden dolayi sorgularimizin 'SQL InJECTiON' yemelerinin onune gecebiliriz. Bu yonuyle guvenlidir.
--Fiziksel olarak ilgili veri tabaninin altinda "Programmability"nin altinda Store Procedure komninasyonlarini kullanarak erisilebilir.

--==TASLAK==--
--create proc yada Procedure [Isim]
--(
--varsa parametre
--)AS
--Yazilacak sorgular, kodlar, sartlar, fonksiyonlar, komutlar vs vs.....

--output icerden aldigi degerler input disaridan girilen degerler

create proc sp_ornek
(
@ID int --aksini belirtmedigimiz takdirde bu parametre yapisi input
)AS
select*from Employees where EmployeeID=@ID

-----DIKKAT!-----
--Procedure parametrelerini tanimlarken parantez kullanmak zorunlu degildir.
--Ama okunabilirligini arttirmak icin kullanilmasini oneririm.

--Stored procedures kullanimi----===
--Exec komudu ile oluyor ve parametre girmek zorundasin biz 3 girdi

--==ORNEK 1
create proc sp_ornek2
@ID int,
@parametre2 int,
@parametre3 nvarchar (max)
as
select*from Employees where EmployeeID=@ID

exec sp_ornek 3 

exec sp_ornek2 3, 8, 'Bilge Adam' 

--==ORNEK2
create proc sp_ornek3
@parametre nvarchar (max)
as
select*from Employees where country=@parametre
exec sp_ornek3 'usa'

--==ORNEK 3
Create Procedure [UrunEkle] --create proc [urunekle]
( 
@UrunAd nvarchar (20), @BirimFiyat money, @KatID int
)
as
insert Products (ProductName,UnitPrice, CategoryID)
values (@UrunAd, @BirimFiyat, @KatID )

exec UrunEkle 'Ananas', 3, 5

select*from Products ---Tablonun en son satirina insert edildigini gorebiliyoruz

exec UrunEkle 'Ananas', 3, 5
execute UrunEkle Elma, 7, 2
UrunEkle 'Test', 5, 6
select*from Products

--==GERIYE DEGER DONDUREN STORED PROCEDURE YAPISI==--

--==ORNEK 4==--
create proc UrunGetir
(
@fiyat money
)
as
select*from Products where UnitPrice>@fiyat

return @@RowCount  --yukarida yapilan islemde kac satir eklendigini bize dondurecek
exec UrunGetir 90  --unit price'i 90 ustunde olanlari getirdi

declare @sonuc int
exec @sonuc=UrunGetir 90
print cast(@sonuc as nvarchar (max) ) + 'Adet urun bu islemden etkilenmistir'
	--Bu sekilde geriye donulen deger elde edilerek kullanilabilir
	--Messege tablosuna basarak mesaj goruntulenir

--==ORNEK 5: 
--AYNI PARAMETRELERI ve product ID KULLANARAK URUNLERI UPDATE EDECEK SP YAZ==--

Create Procedure [Urun Guncelle]
( 
@UrunAd nvarchar (20),
@BirimFiyat money, 
@KatID int,
@UrunID int
)
as
update Products 
set ProductName=@UrunAd, UnitPrice=@BirimFiyat, CategoryID=@KatID
where ProductID=@UrunID

exec [Urun Guncelle] 'lale', 1, 2, 81

select * from Products where ProductID>77

--==ORNEK 6:
--KATEGORI TABLOSUNA BIR BILGI EKLE--

select*from Categories
insert Categories(CategoryName) values ('Others')
select*from Products

create proc [Yeni Kategori]
(
@Ad nvarchar (50),
@katID int
)
as
	declare @EnBuyukKatID int
	select @EnBuyukKatID=max (CategoryID) from Categories
	
	if @EnBuyukKatID<@katID
		begin 
			print 'Girdigin kategori yok IDsi 16 olana eklenecek'
			set @katID=16
	end

insert Products(ProductName, CategoryID)
values (@Ad, @katID)

exec [Yeni Kategori] 'Test',18



--==OUTPUT ILE DEGER DONDURME==--

create proc sp_ornek3
(
	@ID int,
	@Adi nvarchar (max) output, --output parametre icerdeki degeri disari gondermek icin kullanilir
	@soyadi nvarchar (max) output
)
as
select 
	@Adi=FirstName, 
	@soyadi=LastName
from Employees
where EmployeeID=@ID

--Kullanimi: 
declare 
	@Adi nvarchar (max), 
	@soyadi nvarchar (max) --degisken tanimlamak icin kullanilan keyword
Exec 
	sp_ornek3 1, 
	@Adi output, 
	@soyadi output 
select @Adi +''+@soyadi


---==Urun ID'sine gore isim getirme==----

                        --==Ornek 1==--
alter proc UrunIDDegerineGoreIsimGetirme
(
@UrunID int
)
with encryption 
as
select ProductName from Products
where
	ProductID=@UrunID

exec UrunIDDegerineGoreIsimGetirme 4
--Sp calismasi sonucu donen degeri bir degisken ile karsilamaya calisalim
declare 
	@UrunAd nvarchar(50),
	@ID int=4

exec @UrunAd= UrunIDDegerineGoreIsimGetirme 4

print 
	cast(@ID as nvarchar )+'deger'+@UrunAd

						
--====Ornek 2: Disaridan adligi isim, soyisim ve sehir bilgilerini personel tablosundaki ilgili kolonlara ekleyen store procedure yaz====------

create sp_PersonelEkle
(
@Ad nvarchar (max),
@Soyad nvarchar (max),
@Sehir nvarchar (max),
)
as
insert
	Employees (FirstName, LastName,City) 
	values
	(@Ad, @Soyad, @sehir )

exec sp_PersonelEkle 'test', 'test', 'test'

select * from Employees


--=====OUTPUT=====-------
create proc sp_Shipper
(
@cn nvarchar (50),
@p nvarchar (20),
@shipperid int output   --output datadan bir sey getiricez demek
)
as

insert sp_Shipper (CompanyName, Phone)
values ( @cn, @p )
set @shipperid=@@IDENTITY

declare @Shipper_Id int
exec sp_Shipper 'Aras', '123123', @shipperid= @Shipper_Id output
select @Shipper_Id


--Etkiyi gormek icin---
select*from Shippers

alter sp_PersonelEkle
(
@Ad nvarchar (max)='test1',
@Soyad nvarchar (max)='Test1',
@Sehir nvarchar (max)='Test1'
)
as

insert Employees (FirstName, LastName, City)
	values (@Ad, @Soyad, @Sehir)

exec sp_PersonelEkle 'Mehmet', 'Tas'


create view StoktaEksikOlanUrun
as
select ProductName, UnitsInStock, UnitsOnOrder, UnitsOnOrder-UnitsInStock as EksikMiktar
	from Products
where UnitsOnOrder>UnitsInStock

select*from StoktaEksikOlanUrun
order by 4 desc


-- Select top view yapisi ile kullanilir:
alter view StoktaEksikOlanUrun
as
select top 5 ProductName, UnitsInStock, UnitsOnOrder, UnitsOnOrder-UnitsInStock as EksikMiktar
	from Products
where UnitsOnOrder>UnitsInStock

select*from StoktaEksikOlanUrun

----===FUNCTION====---

--user defined function, kullanici tanimli fonksiyonlar
--1) ScalarF. 
--2) in -Line Valued F.
--3) mutlistatement table value F.

--Functions birer database objesi oldugundan dolayi DDL (crate, alter, drop) ile yonetilirler
--Functions parametre alabilirler veya almayabilirler istege bagli
--Functions Subquery icerisinde kullanilabilirler. Fakat stored procedur'ler herhangi bir sorgu icerisinde kullanilmazlar.
--Scaler ve Table Valued Function'larda sadece select sorgular kullanilabilirler. 

----------======1. Scaler Function=====------
--DBO'suz kullanlmazlar
--Tablo isimleri de dbo'suz olmaz 
		--DBO: Database Owner demek 
--Begin-End skoplari mutlaka kullanilmalidir.

---==ornek
create function KDVliFiyatHesapla
(
@Tutar money, 
@Oran float --ondalik bir deger girilirse diye float dedik--
)
returns money 
as
begin
return ( @tutar*( 1+@Oran ))
end

select dbo.KDVliFiyatHesapla (10,0.18)

--==ornek
select ProductID, ProductName, dbo.KDVliFiyatHesapla (UnitPrice, 0.08) as KDVliFiyat 
	from Products

---==Bugunun tarihini donduren function==--
create function Tarih
()
returns date
as
begin
return getdate()
end

select dbo.Tarih()

--==Kategory ID bilgisi alan, aldigi bu kategoriden kar ADETINI gosteren bir function yaz

create function KategorideSatilanUrunSayisi
(
@CatID int
)
returns int
as
	begin
		return
				(
				select SUM (od.Quantity)
				from [Order Details] OD
				join Products P on P.ProductID=OD.ProductID
				where P.CategoryID=@CatID
				)
	end
select dbo.KategorideSatilanUrunSayisi(2)

--Urun Eklenirken CategoryID bilgisi girilmemis ise default olarak other isimli kategoriye eklenmis olsun

create function IdDefault
()
returns int
as
	begin
	return
		(
		select CategoryName from Categories
		where CategoryName='Others'
		)
	end

--2 parametre alip toplama yapan bir fonksiyon
create function Toplama 
(
@A int,
@B int
)
returns int
as begin return
	(select SUM(@A+@B))
end

select dbo.Toplama (10,10)

create function TarihFormat
(
@tarih datetime, @ayrac char(1), @format char(1)
)
returns char(10)
as
	begin
		declare @yil nchar (4)=Year(@tarih)
		declare @ay nchar (2)=month(@tarih)
		declare @gun nchar (2)=day(@tarih)
		declare @formatlitarih nchar (10)

		if len (@gun)=1
			set @gun='0'+@gun
		if len (@ay)=1
			set @ay='0'+@ay

		if @format ='day'
			set @formatlitarih=@gun+@ayrac+@ay+@ayrac+@yil
		else if @format='mdy'
			set @formatlitarih=@ay+@ayrac+@gun+@ayrac+@yil
		else if @format='ydm'
			set @formatlitarih=@yil+@ayrac+@ay+@ayrac+@gun

	return @formatlitarih

end

select dbo.TarihFormat(GETDATE(),'-','dmy')



----=====IN LINE TABLE VALUED FUNC===------
--sadece select sorgularinda kullanilabilir
--geriye bir tablo doneceginden dolayi returns table denir. 
--begin-end skoplarina ve dbo part'ina ihtiyaciniz yoktur

create function KatUrunler
(@CatID int)
returns table 
	as
		return ( select ProductName, CategoryID from Productsj 
				where CategoryID=@CatID)

select*From dbo.KatUrunler (4)
select ProductName from KatUrunler (1) where ProductName like 'C%'

---Ornek: Parametre degeri verilen kategori ID sonucunda ProductName, CategoryName
--, CategoryId, Suppliers donduren sorgu 

alter function ProductTablo
(@KatID int)
returns table as return 
	(select ProductName, C.CategoryName, P.CategoryID, SupplierID 
	from Products P
	join Categories C on c.CategoryID=P.CategoryID 
	where c.CategoryID=@KatID)

select*from dbo.ProductTablo (1)

select k.ProductName, S.CompanyName 
	from dbo.ProductTablo (1)
	join Suppliers S on S.SupplierID=K.SupplierID 
	--==bu kisim bende calismiyor

--==MULTISTATEMENT TABLO VALUES FUNC==--
--- BUu fonksiyonlar icerisnde insert update ve delete statement'lari kullanilir
--yine geriye bir tablo doner. Fakat bu tabloyu tanimalama ve ram'e yerlestirme
--tanimladigim tablo local veya global bir degisken olabilir
--tanimlama

alter function Kisilerim (@tip nvarchar (7))
returns @tablom table
(
	ID int,
	Isim nvarchar (50)
)
as 
begin
	if @tip = 'ad'
		begin
			insert @tablom select EmployeeID, FirstName 
			from Employees
		end

	else if @tip='adsoyad'
		begin
			insert @tablom select EmployeeID, FirstName+''+LastName 
			from Employees
	delete from @tablom where ID=8 ----hoca bunu silme islemini gostermek icin sonra gosterdi 
		end

return
end

select*from Kisilerim ('ad')

select*from Kisilerim ('adsoyad')



-------TRANSACTION---------------
create database BankaDB
go
use BankaDB
go
create table Hesap
(
ID int primary key identity,
AdSoyad nvarchar (max) ,
Bakiye money,
TCKimlikNo char (11)
)

-------------------------
insert Hesap
values
('AliTas', 100, 12345678910),
('Mehmettas', 0, 12345678911),s
('AlperKaya', 200, 12345678912)

select*from Hesap
-------------------------


begin try
	update Hesap set Bakiye -=200 where TCKimlikNo='12345678912'
	raiserror ('Elektrik kesildi', 16, 2)
	update Hesap set Bakiye +=200 where TCKimlikNo='12345678911'
end try
	begin catch 
	PRINT 'beklenmedik bir hata oldu'
	end catch 

-------------------------------transaction kullanimi--------------------
begin try
	begin tran --transaction baslar 
	update Hesap set Bakiye -=200 where TCKimlikNo='12345678912'
	raiserror ('Elektrik kesildi', 16, 2)
	update Hesap set Bakiye +=200 where TCKimlikNo='12345678911'
	commit tran ----transaction basarili sekilde sonuclanacaktir
				--raise error kismini yazmasaydik bile commit kismini yazmasaydik hata verecekti
end try
begin catch 
	PRINT 'beklenmedik bir hata oldu'
	rollback tran --transcation bsarisiz bir sekilde sonlandirir ve yapilan islemler geriye alinir
				--rollback tran geri dondurecek bir yapi
end catch 

select*from Hesap
-------------------------------------------------------
--try catch bloklari hata yakalamak icin kullanilan bloklardir. try hata buldugu an gider catch kismini tetikler. catch icerisindeki kodlar calisir.
-- bizde burda transaction'imizi 




begin try
	begin tran 
	update Hesap set Bakiye -=50 where TCKimlikNo='12345678912'
	update Hesap set Bakiye +=50 where TCKimlikNo='12345678911'
	update Hesap set Bakiye -=50 where TCKimlikNo='12345678910'
	update Hesap set Bakiye +=50 where TCKimlikNo='12345678911'
	commit tran
end try
begin catch 
	PRINT 'hata oldu'
	rollback tran
end catch 

select*from Hesap

select*from BankaDB.dbo.Hesap --hesap tablosunu alt kisma getirdi

begin try
begin tran --tran burada basliyor
	update hesap set bakiye -=100 where TCKimlikNo='12345678910'
		raiserror ('Elektrik kesildi', 16, 2)
	update hesap set bakiye -=100 where TCKimlikNo='12345678912'
		commit tran
end try

begin catch
	PRINT 'beklenmedik bir hata oldu'
		rollback tran
end catch

select*from BankaDB.dbo.Hesap

------=====TRÝGGERS=====----------
--1) Dml. T (@nsert Update Delete)
--2) DDL .T (create, alter, drop)
--3) Logon T.

--1) After Trigger
--2) Instead of T

--Otomatik calisan store procedure'lerdir.
--C# deki event'lere benzer

--Bir tabloda inset update delete isimlerinde gerceklestiginde devreye giren yapilardir

--INSERTED TABLO
--eger bir tabloda insert islemi yapiliyorsa arka planda ilk once RAM'de olustururlur ve inserted isimli bir tablo yapilir. Eger islemde herhangi bir problem cikmazsa inserted tablosunda eklenen veri basarili bir sekilde fiziksel tabloya eklenir. islem tamamlandiginda RAM'de olusturulan inserted tablosu silinir.

--DELETED TABLE 
--Eger bir tabloda delete islemi yapiliyorsa arka planda islemler ilk once Ram'de olusuturulan deleted isimli bir tablo uzerinde yapilir. Eger islemde herhangi bir problem olmazsa verilr fiziksel tabloya basarili bir sekilde aktarilir.

--UPDATE ISLEMI
--Eger bir tabloda update islemi yapiliyorsa RAMde updated isimli bir tablo olusturulmaz !!!!!!!!!!
--SQL server'daki mantiga gore once silme (DELETE) ardindan INSERT islemi gerceklesecek sekilde yapilir/
--EGer update islemi yapiliyorsa arka tarafta hem inserted hem de deleted icin ayri ayri iki tablo olusturulur. islemler bu tablolar uzerinde gercekelstirilir.
--DIKKAT!!!!!!!!!
		--Update yaparken guncellenen kaydin orjinal deleted tablosundan guncellendikten sonraki hali inserted tablosuna aktarilir

--Deleted ve Inserted tablolari ilgili sorgu sonucu olusur.
--B,ylece delete ve inserted tablolarina ben select atabilirim.

----======TRIGGER TANIMLAMA====-----
--create trigger [Trigger Adi]
--on [islem yapilacak tablo adi]
--alter yada delete, update, insert
--as [kodlar]

---!!!!!!!!!DIKKAT : Tanimlanan triggerlara ilgili tablonun icindeki triggers sekmesinden erisim saglanabilir.

use NORTHWND
--------------------------
create trigger OrnekTrigger
	on Employees
	after insert
	as
select*from Employees

insert Employees (FirstName, LastName) values ('test', 'test')

---------------------------

--Ornek1: Tedarikciler (Suppliers) tablosundaki bir veri silindiginde urunlerin fiyati otomatik 10 artsin

create trigger OrnekTriggerSupp
	on Suppliers
	after delete 
	as
UPDATE Products SET UnitPrice=UnitPrice+10

select*from Products

--Tetikleme:
delete from Suppliers where SupplierID=30

------------------------

--Ornek2: CompanyName kolununda bir veri guncellendiginde kategoriler tablosnda Gidalar adinda bir kategori olussun
create trigger OrnekTriggerRegion
	ON Suppliers
	for update
	as
insert Categories (CategoryName) values ('Gidalar')

update Suppliers set CompanyName='Lenova' where SupplierID=30
select*from Categories
select*from Suppliers

--Ornek3: Personeller tablosundan bir kayit silindiginde silinen kayitin adi soyadi kim tarafindan silindigi ve hangi tarihte silindigi bilgisini baska bir tabloya kaydedelim

create table LogTablosu
(
ID int primary key identity (1,1),
rapor nvarchar (max)
)

alter trigger TrgPerson
on employees
after delete 
as
declare @Adi nvarchar (max),
		@Soyad nvarchar (max)
select	@Adi=Firstname, @soyad=Lastname
	from Employees

insert LogTablosu 
	values ('Ad+Soyad:' + @Adi + '' + @Soyad + 'Olan Personel' + SUSER_NAME()+ 'Tarafindan' + CAST (GetDate () as nvarchar(max) ) + 'Tarihinde Silinmistir.')

delete from Employees where EmployeeID=11

select*from NORTHWND.dbo.LogTablosu

----Ornek 4: personeller tablosunda update gerceklestigi anda devreye giren ve bir log tablosuna ''Adi..... olan personel yeni adiyla degistirilerek .... kullanicisi tarafindan ..... tarihinde guncellendi.''

alter trigger TrgPersonel
	on employees
	for update ---for after kullanilabilir.
	as
		declare @Adi nvarchar (max), @yeniadi nvarchar (max)
			select	@Adi=Firstname from deleted
			select @yeniadi=FirstName from inserted

		insert LogTablosu (rapor) ----Tek kolon oldugu icn rapor yazmaya gerek yok olsa da olur ama 
		values ('Adi:'+ @Adi+ 'Olan Personel' + @yeniadi + 'degistirilerek' + SUSER_NAME() + 'Kullanicisi Tarafindan' +CAST (GetDate () as nvarchar(max) ) + 'Tarihinde Guncellendi.')

update Employees set FirstName='Begum' where EmployeeID=10 

select*from NORTHWND.dbo.LogTablosu


--------======MULTIPLE ACTIONS TRIGGER=====-----
---Birden Fazla Aksiyonu Tetiklemek Icin kullanilir

create trigger
on employees
after delete, insert
as
print 'Trigger calismasini tamamladi'

insert Employees (FirstName, LastName) values ('Test', 'Test1')
delete from Employees where EmployeeID=12

--------------------------------------------------

Suser_name () =====>>>>>>> O anki server uzererindeki aktif kullanici bilgisini dondurur

----INSTEAD OF TRIGGERLAR-----=====
--- su ana kadar insert, delete, update islemleri yapilirken su islemleri su su ile yap mantiginda ilerledik. (yaninda yap)
-- burada ise insert update delete islemleri yerine su su islemleri yap mantigi ile calisir.

--CREATE TRIGGER [Trigger Adi]
--ON tablo adi
--INSTEAD OF DELETE, INSERT UPDATE
--AS
--KOMUTLAR


---ORNEK 5: Personeller tablosunda update islemi gerceklestigi anda yapilacak guncellestirme yerine bir tablosuna ''Adi .... Olan personel ... yeni adiyla degistirilerek .... kulanicisi tarafindan ..... tarihinde guncellenmek istendi. ''

create trigger TrgPerRapor
	on employees
	instead of update 
	as
		declare @eskiad nvarchar (max), @yeniad nvarchar (max)
			select @eskiad= FirstName from deleted
			select @yeniad= FirstName from inserted
		insert LogTablosu values 
			( 'Adi'+ @eskiad + 'Olan Personel' + @yeniad + 'Yeni Adi Ile Degistirilerek'+ SUSER_NAME() + 'Kullanicisi Tarafinfan' + CAST(GETDATE() as nvarchar (max)) + 'Tarihinde Guncellenmek Istendi')
				
--Employees tablosu trigger kismina yapisti yukaridaki kod simdi tetikleme yapilacak

update Employees set FirstName='BilgeAdam' where EmployeeID= 12

----------------------------------

--Ornek 6 : Personeller tablosunda adi 'Andrew' olan kaydin silinmesini engelleyen ama digerlerine izin veren triggeri yazin 

create trigger AndrewTrigger
on	employees
after delete
as
	declare @Ad nvarchar (max)
		select @Ad=FirstName from deleted
			if @Ad='Andrew'
				BEGIN
					print 'Bu Kaydi Silemezsin'
					rollback --YAPILAN TUM ISLEMLERI GERI ALACAKTIR
				END
DELETE from Employees where EmployeeID=12

--------------------------------------

----DDL TRIGGER
----CREATE, ALTER VE DROP ISLEMLERI SONUCUNDA VEYA SURECINDE DEVREYE GIRECEK OLAN YAPILARDIR

--CREATE TRIGGER  DDL_Trigger
--ON DATABASE 
--FOR 
--AS
--PRINT 'TEST'
--ROLLBACK
	
--Dikkat DDL triggerlar ile ilgili veritabaninin => programmability => Database Triggers sekmesi altindan erisim saglanmasi mumkun


----========---------------=======--------

--Tablo uzerinde veri aramasi yapildiginde,
-- Veritabaninda saklanan verilerin sayisi arttikca bu performans dusuklugune neden olur
--Daginij olarak duran veri uzerinde istenilen bir  arama yapilabilmesi icin komple tablo aramasi gerceklestirilir
--SQL Tablosundaki Kaydi bulmak Icm butun kayitlari tek tek dolasi
--Kadydi bulsa dahi belki tekrar eden baska bir kayit olabilir diye dolasmaya devam eder

create database indextest
go
use indextest
go
create table insan
(
ID int primary key identity,
Ad nvarchar (50),
Soyad nvarchar (50),
TelNo char (11)
)

declare @i int =1

while @i<10000

begin 
		insert insan
		Select Ad='Bilge' + CAST (@i as nvarchar(50)),
				soyad= 'Adam' + cast (@i as nvarchar (30) ),
				TelNo= cast (@i as char (11))
				set @i+=1
end

set statistics IO on
set statistics time on
select * from insan where ID=1
----LOGICAL READ YAPISINI GORUNTULUYORSUN

----------=============-----------------====================------------------------

--cLUSTRED INDEX
--cLUSTRED INDEX veriyi SQL'de fiziksel olarak siraya sokan yapidir.
--ASlinda hepimiz Clustred Index'i tablolarimizda kullaniyoruz.
--Tablolarimizda tanimladigimiz her bir PL (Primary Key) aslinda bir CLustred Index yapisindadir.
--Cunku Tablolarimiz bu PK'ya gore fiziksel olarak siralanir.

create Clustered index InsanIndexle
	on Insan (ID)
	---Clustered Index Degistirma
Create Clustered Index InsanIndexle
	on Insan (ID)
	with drop_existing,        ----VAr olan indexi tekrar olusturur
	FillFactor=60,             ----Doluluk Orani
	Pad_Index                  ----Intermediate level da duzenlenir 

--NON-cLUSTERED
--Bir Kolunu Non-Clustered index olarak indexlemeye kalktigimizda arka tarafta kendine ait yeni bir tablo olusturur ve bu tablo sizin indexlediginiz kolona karsilik degerleri tutar.
--YAni bir nevi pointer yapisi gibi dusunebiliriz.
--Non-Clustered Indextte verilere direk erisilemez.
--Elde edilen indexleme yapisina erismek icin kumelenmis index yapisi kullanilmis olur.

create nonclustered index TeleIndex on insan(TelNo)
	set statistics IO on
	set statistics time on

select Ad, Soyad from insan where TelNo='225' --char tipinde yazdigimiz icin tirnak icinde yaz
				--Yukarida execute yaninda display execution plan kismina bastiginda 

--Non-Cluster indexlemeyi soyle aciklayalim:
	--Kitap ornegini dusunun. Kitaplarin basinda icerik kismi vardir.
	--Bu icerik kisminda herhangi bir konu basliginin hangi sayfa numaralarinda veya numarasinda oldugunu gosterir.
	--Siz kitabi actiginizda once icerik sayfasina bakarsiniz/ Daha sonra aradiginiz icerigin ya da sayfa araligini ogrenip direk bu sayfalara gecersiniz.
	--Non-cluster indexte tam olarak bu isi yapmaktadir.

--Odev : INdex Bakimlari NAsil yapili

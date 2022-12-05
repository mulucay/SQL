-- Ankara’da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz
select *from markalar;
select *from calisanlar2;
Select marka_id,calisan_sayisi from markalar 
WHERE marka_isim IN(select isyeri from calisanlar2 WHERE sehir='Ankara');

--ALIASES
CREATE TABLE calisanlar3 (
calisan_id char(9),
calisan_isim varchar(50),
calisan_dogdugu_sehir varchar(50)
);
INSERT INTO calisanlar3 VALUES(123456789, 'Ali Can', 'Istanbul'); 
INSERT INTO calisanlar3 VALUES(234567890, 'Veli Cem', 'Ankara'); 
INSERT INTO calisanlar3 VALUES(345678901, 'Mine Bulut', 'Izmir');

select*from calisanlar3
--Eger iki sutunun verilerini birlestirmek istersek concat sembolğ || kullaniriz
select calisan_id as id, calisan_isim ||' '|| calisan_dogdugu_sehir as calisan_bilgisi from calisanlar3
--2.yol
select calisan_id as id, concat(calisan_isim,' ', calisan_dogdugu_sehir) as calisan_bilgisi from calisanlar3

--										IS NULL CONDITION
-- Arama yapilan field’da NULL degeri almis kayitlari getirir

CREATE TABLE insanlarr
(
ssn char(9),
isim varchar(50), 
adres varchar(50)
);
INSERT INTO insanlarr VALUES(123456789, 'Ali Can', 'Istanbul'); 
INSERT INTO insanlarr VALUES(234567890, 'Veli Cem', 'Ankara'); 
INSERT INTO insanlarr VALUES(345678901, 'Mine Bulut', 'Izmir'); 
INSERT INTO insanlarr (ssn, adres) VALUES(456789012, 'Bursa'); 
INSERT INTO insanlarr (ssn, adres) VALUES(567890123, 'Denizli');
 
 --isim sutundaki null olan degerleri listeleyin
 select isim from insanlarr where isim IS NULL;
  --isim sutundaki null olmayan degerleri listeleyin
  SELECT isim FROM insanlarr WHERE isim IS NOT NULL
  -- Insanlar toplasunda null değer almış verileri no name olarak değiştiriniz
UPDATE insanlarr
SET isim='No Name'
WHERE isim IS NULL

-- 								ORDER BY CLAUSE
/*
	ORDER BY komutu belli bir field’a gore NATURAL ORDER olarak siralama
	yapmak icin kullanilir
	ORDER BY komutu sadece SELECT komutu Ile kullanilir
*/
/*
Tablolardaki verileri sıralamak için ORDER BY komutu kullanırız
Büyükten küçüğe yada küçükten büyüğe sıralama yapabiliriz
Default olarak küçükten büyüğe sıralama yapar(ASC)
Eğer BÜYÜKTEN KÜÇÜĞE sıralmak istersek ORDER BY komutundan sonra DESC komutunu kullanırız
*/
CREATE TABLE insanlar2
(
ssn char(9),
isim varchar(50),
soyisim varchar(50),  
adres varchar(50)
);
INSERT INTO insanlar2 VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO insanlar2 VALUES(234567890, 'Veli','Cem', 'Ankara');  
INSERT INTO insanlar2 VALUES(345678901, 'Mine','Bulut', 'Ankara');  
INSERT INTO insanlar2 VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO insanlar2 VALUES (344678901, 'Mine','Yasa', 'Ankara');  
INSERT INTO insanlar2 VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');

select*from insanlar2

--Insanlar tablosundaki datalari adres’e gore siralayin
SELECT*FROM insanlar2 ORDER BY adres;
--Insanlar tablosundaki ismi Mine olanlari SSN sirali olarak listeleyin
SELECT *FROM insanlar2 WHERE isim='Mine' ORDER BY ssn;

--NOT : Order By komutundan sonra field ismi yerine field numarasi da kullanilabilir
--Insanlar tablosundaki soyismi Bulut olanlari isim sirali olarak listeleyin.4 adres oluyor

select*from insanlar2 where soyisim='Bulut' order by 4;

--Insanlar tablosundaki tum kayitlari SSN numarasi buyukten kucuge olarak siralayin
select*from insanlar2 order by ssn desc;

-- Insanlar tablosundaki tum kayitlari isimler Natural sirali, Soyisimler ters sirali olarak listeleyin
select*from insanlar2 order by isim asc, soyisim desc;

-- İsim ve soyisim değerlerini soyisim kelime uzunluklarına göre sıralayınız
SELECT isim, soyisim FROM insanlar2 ORDER BY LENGTH(soyisim);

-- Tüm isim ve soyisim değerlerini aynı sutunda çağırarak her bir sütun değerini uzunluğuna göre sıralayınız
SELECT isim || ' '||soyisim AS isim_soyisim FROM insanlar2 ORDER BY LENGTH(isim||soyisim);
SELECT CONCAT(isim,' ',soyisim) AS isim_soyisim FROM insanlar2 ORDER BY LENGTH(isim||soyisim);

-- 									GROUP BY CLAUSE
-- Group By komutu sonuçları bir veya daha fazla sütuna göre gruplamak için SELECT
-- komutuyla birlikte kullanılır

CREATE TABLE manav
(
isim varchar(50),
Urun_adi varchar(50),
Urun_miktar int
);
INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
INSERT INTO manav VALUES( 'Veli', 'Elma', 2);
INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);
INSERT INTO manav VALUES( 'Veli', 'Uzum', 5);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Veli', 'Elma', 3);
INSERT INTO manav VALUES( 'Ayse', 'Uzum', 2);

select*from manav

--Isme gore alinan toplam urunleri bulun
SELECT isim,sum(urun_miktar) FROM manav
GROUP BY isim;
--Isme gore alinan toplam urunleri bulun ve urunleri buyukten kucuge siralayiniz
SELECT isim,sum(urun_miktar) AS aldığı_toplam_urun FROM manav
GROUP BY isim
ORDER BY aldığı_toplam_urun DESC;

-- Urun ismine gore urunu alan toplam kisi sayisi--urunler kac defa alınmıs?
SELECT urun_adi, COUNT(isim) FROM manav
GROUP BY urun_adi;



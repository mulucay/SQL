CREATE TABLE sirketler  (
sirket_id int,  
sirket_isim varchar(20)
);
INSERT INTO sirketler VALUES(100, 'Toyota');  
INSERT INTO sirketler VALUES(101, 'Honda');  
INSERT INTO sirketler VALUES(102, 'Ford');  
INSERT INTO sirketler VALUES(103, 'Hyundai');

CREATE TABLE siparisler  (
siparis_id int,  
sirket_id int,  
siparis_tarihi date
);
INSERT INTO siparisler VALUES(11, 101, '2020-04-17');  
INSERT INTO siparisler VALUES(22, 102, ' 2020-04-18');  
INSERT INTO siparisler VALUES(33, 103, ' 2020-04-19');  
INSERT INTO siparisler VALUES(44, 104, ' 2020-04-20');  
INSERT INTO siparisler VALUES(55,  105, ' 2020-04-21');

select*from sirketler
select*from siparisler
--Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
--siparis_tarihleri ile yeni bir tablo olusturun

SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi 
FROM sirketler
INNER JOIN siparisler
ON sirketler.sirket_id=siparisler.sirket_id

--LEFT JOIN
--Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
--siparis_tarihleri ile yeni bir tablo olusturun
SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi 
FROM sirketler
LEFT JOIN siparisler
ON sirketler.sirket_id=siparisler.sirket_id

--RIGHT JOIN
SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi 
FROM sirketler
RIGHT JOIN siparisler
ON sirketler.sirket_id=siparisler.sirket_id

--FULL JOIN
SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi 
FROM sirketler
FULL JOIN siparisler
ON sirketler.sirket_id=siparisler.sirket_id

--SELF JOIN
CREATE TABLE personel  (
id int,
isim varchar(20),  
title varchar(60),  yonetici_id int
);
INSERT INTO personel VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO personel VALUES(2, 'Veli Cem', 'QA', 3);
INSERT INTO personel VALUES(3, 'Ayse Gul', 'QA Lead', 4);  
INSERT INTO personel VALUES(4, 'Fatma Can', 'CEO', 5);

--Her personelin yanina yonetici ismini yazdiran bir tablo olusturun
SELECT p1.isim AS personel_isim,p2.isim AS yonetici_ismi
FROM personel p1 INNER JOIN personel p2
ON p1.yonetici_id=p2.id

--LİKE CONDITION
CREATE TABLE musterilerr  (
id int UNIQUE,
isim varchar(50) NOT NULL,
gelir int
);
INSERT INTO musterilerr (id, isim, gelir) VALUES (1001, 'Ali', 62000);  
INSERT INTO musterilerr (id, isim, gelir) VALUES (1002, 'Ayse', 57500);  
INSERT INTO musterilerr (id, isim, gelir) VALUES (1003, 'Feride', 71000);
INSERT INTO musterilerr (id, isim, gelir) VALUES (1004, 'Fatma', 42000);  
INSERT INTO musterilerr (id, isim, gelir) VALUES (1005, 'Kasim', 44000);
INSERT INTO musterilerr (id, isim, gelir) VALUES (1006, 'ahmet', 82000);  

-- 1) % => 0 veya birden fazla karakter belirtir
-- SORU : Ismi A harfi ile baslayan musterilerin tum bilgilerini yazdiran QUERY yazin

SELECT *FROM musterilerr WHERE isim ILIKE 'A%';
--kuck buyuk harfe duyarlı olmasını istemiyorsak "LIKE" ın başına "I"
--harfi koyarız "ILIKE" olarak yazariz-- sembolerini de kullanabiliriz
--LIKE yerine ~~ sembolerini de kullanabiliriz
--kucuk buyuk harf gözetmesin istemiyorsak ~~* kullanırız
SELECT *FROM musterilerr WHERE isim ~~ 'A%';
SELECT *FROM musterilerr WHERE isim ~~* 'A%';

--SORU : Ismi e harfi ile biten musterilerin isimlerini ve gelir’lerini yazdiran QUERY yazin
SELECT isim,gelir FROM musterilerr 
WHERE isim LIKE '%e'

--Isminin icinde er olan musterilerin isimlerini ve gelir’lerini yazdiran QUERYyazin
SELECT isim,gelir FROM musterilerr
WHERE isim LIKE '%er%'

--2)_ => sadece bir karakterigosterir.
-- SORU : Ismi 5 harfli olup son 4 harfi atma olan musterilerin tum bilgilerini yazdiran QUERY yazin
SELECT *FROM musterilerr
WHERE isim LIKE '_atma'

--SORU: Ikinci harfi a olan musterilerin tum bilgilerini yazdiran QUERYyazin
SELECT *FROM musterilerr
WHERE isim LIKE '_a%'

--Ucuncu harfi s olan musterilerin tum bilgilerini yazdiran QUERYyazin
SELECT*FROM musterilerr
WHERE isim LIKE '__s%'

--3)REGEXP_LIKE =>Daha karmaşık sorgular için herhangi bir kod, metin icerisinde istenilen yazi
--veya kod parcasinin aranip bulunmasini saglayan kendine ait soz dizimi olan bir yapidir.
--(REGEXP_LIKE) PostgreSQL de ‘’ ~ ‘’ karekteri ile kullanilir

CREATE TABLE kelimeler  (
id int UNIQUE,
kelime varchar(50) NOT NULL,  Harf_sayisi int
);
INSERT INTO kelimeler VALUES (1001, 'hot', 3);  
INSERT INTO kelimeler VALUES (1002, 'hat', 3);  
INSERT INTO kelimeler VALUES (1003, 'hit', 3);  
INSERT INTO kelimeler VALUES (1004, 'hbt', 3);  
INSERT INTO kelimeler VALUES (1008, 'hct', 3);  
INSERT INTO kelimeler VALUES (1005, 'adem', 4);  
INSERT INTO kelimeler VALUES (1006, 'selim', 5);  
INSERT INTO kelimeler VALUES (1007, 'yusuf', 5);


--SORU: Ilk harfi h,son harfi t olup 2.harfi a veya i olan
--3 harfli kelimelerin tum bilgilerini yazdiran QUERYyazin
SELECT*FROM kelimeler
WHERE kelime ~ 'h[ai]t'

--Ilk harfi h,son harfi t olup 2.harfi a ile k arasinda olan 3 harfli kelimelerin 
--tumbilgilerini yazdiran QUERYyazin
SELECT*FROM kelimeler
WHERE kelime ~'h[a-k]t'

--a veya s ile baslayan kelimelerin 
--tum bilgilerini yazdiran QUERYyazin
SELECT*FROM kelimeler
WHERE kelime ~'^[as]'

--m veya f ile biten kelimelerin tum bilgilerini yazdiran QUERYyazin
SELECT*FROM kelimeler
WHERE kelime ~'[mf]$'
-- UPPER – LOWER - INITCAP
SELECT UPPER(kelime) as büyükkelime FROM kelimeler
SELECT LOWER(kelime) as kelime FROM kelimeler
SELECT INITCAP(kelime) as kelime FROM kelimeler 
-- INITCAP istediğimiz sutundaki verilerin ilk harfini büyük yazar
/*
Eğer birden fazla sütundaki verileri büyük küçük harf yapmak istersek
select lower(title),UPPER(isim) from personel şekilde yapabiliriz
*/










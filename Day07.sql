-- DISTINCT
-- DISTINCT clause, çağrılan terimlerden tekrarlı olanların sadece birincisini alır.

CREATE TABLE musteri_urun 
(
urun_id int, 
musteri_isim varchar(50),
urun_isim varchar(50) 
);
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (20, 'Veli', 'Elma'); 
INSERT INTO musteri_urun VALUES (30, 'Ayse', 'Armut'); 
INSERT INTO musteri_urun VALUES (20, 'Ali', 'Elma'); 
INSERT INTO musteri_urun VALUES (10, 'Adem', 'Portakal'); 
INSERT INTO musteri_urun VALUES (40, 'Veli', 'Kaysi'); 
INSERT INTO musteri_urun VALUES (20, 'Elif', 'Elma');

SELECT * FROM musteri_urun

-- Musteri urun tablosundan urun isimlerini tekrarsız(grup) listeleyiniz
SELECT DISTINCT urun_isim
FROM musteri_urun

-- Tabloda kac farkli meyve vardir ?
SELECT COUNT(DISTINCT urun_isim) FROM musteri_urun
GROUP BY urun_isim

--group by ile cozum
SELECT urun_isim, COUNT(urun_isim) FROM musteri_urun
GROUP BY urun_isim
--group by ile yaptığımızda meyvelerin kaç tane olduğunu görebiliyoruz
--ama distinct ile yaptığımızda her meyve için bir tane gösteriyor.count gibi

-- FETCH NEXT (SAYI) ROW ONLY- OFFSET

--musteri_urun tablosundan ilk 3 kaydi listeleyin
SELECT * FROM musteri_urun
ORDER BY urun_id
FETCH NEXT(3) ROW ONLY

--LIMIT İLE COZUM
SELECT * FROM musteri_urun
ORDER BY urun_id
LIMIT 3

--Musteri urun tablosundan ilk kaydı listeleyiniz
SELECT * FROM musteri_urun
ORDER BY urun_id
LIMIT 1

--musteri urun tablosundan son üç kaydı listeleyiniz
SELECT * FROM musteri_urun
ORDER BY urun_id DESC
LIMIT 3

CREATE TABLE maas
(
id int,
musteri_isim varchar(50),
maas int
);
INSERT INTO maas VALUES (10, 'Ali', 5000);
INSERT INTO maas VALUES (10, 'Ali', 7500);
INSERT INTO maas VALUES (20, 'Veli', 10000);
INSERT INTO maas VALUES (30, 'Ayse', 9000);
INSERT INTO maas VALUES (20, 'Ali', 6500);
INSERT INTO maas VALUES (10, 'Adem', 8000);
INSERT INTO maas VALUES (40, 'Veli', 8500);
INSERT INTO maas VALUES (20, 'Elif', 5500);

--en yüksek maaşı alan musteriyi listeleyiniz
SELECT * FROM maas
ORDER BY maas DESC
LIMIT 1

--maaş tablosundan en yüksek ikinci maaşı listeleyiniz
SELECT * FROM maas
ORDER BY maas DESC
OFFSET 1 LIMIT 1 --Bir satır atla birinciyi al demek

--OFFSET--- Satır atlamak istediğimizde kullanırız
SELECT*FROM maas ORDER BY maas DESC
OFFSET 1 ROW
FETCH NEXT 1 ROW ONLY

--Maaş tablosundan en düşük 4. maaşı listeleyiniz
SELECT * FROM maas
ORDER BY maas 
OFFSET 3 LIMIT 1
/*
					ALTER TABLE STATEMENT
					
	ALTER TABLE statement tabloda add, Type(modify)/Set, Rename veya drop columns
	islemleri icin kullanilir.
	ALTER TABLE statement tablolari yeniden isimlendirmek icin de kullanilir.
 */
 drop table personel
 CREATE TABLE personel  (
id int,
isim varchar(50),  sehir varchar(50),  maas int,  
sirket varchar(20),
CONSTRAINT personel_pk PRIMARY KEY (id)
);
INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

--1) ADD default deger ile tabloya bir field ekleme

ALTER TABLE personel
ADD ulke_isim varchar(20) DEFAULT 'Turkiye'--ulke isminde sütun ekledik
                                           --default ile eklediğimiz sütunun hepsine ekleme yapariz
ALTER TABLE personel
ADD zipcode varchar(10)

ALTER TABLE personel
DROP COLUMN zipcode  --zipcode sütununu sildik

ALTER TABLE personel
RENAME COLUMN ulke_isim TO ulke; --ulke_ismi tablo ismini ulke olarak değiştirdik

ALTER TABLE personel
RENAME TO isciler

ALTER TABLE isciler
ALTER COLUMN ulke TYPE varchar(30),
ALTER COLUMN ulke SET NOT NULL;

ALTER TABLE isciler
ALTER COLUMN maas
TYPE varchar(30) USING(maas::varchar(30))

/*
			TRANSACTION (BEGIN - SAVEPOINT - ROLLBACK - COMMIT
	Transaction veritabani sistemlerinde bir islem basladiginda baslar ve bitince sona erer. Bu
	islemler veritabani olusturma, veri silme, veri guncelleme, veriyi geri getirme gibi islemler olabilir.
 */
 drop table ogrenciler2
 CREATE TABLE ogrenciler2
(
id serial,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real       
);
BEGIN;
INSERT INTO ogrenciler2 VALUES(default, 'Ali Can', 'Hasan',75.5);
INSERT INTO ogrenciler2 VALUES(default, 'Merve Gul', 'Ayse',85.3);
savepoint x;
INSERT INTO ogrenciler2 VALUES(default, 'Kemal Yasa', 'Hasan',85.6);
INSERT INTO ogrenciler2 VALUES(default, 'Nesibe Yilmaz', 'Ayse',95.3);
savepoint y;
INSERT INTO ogrenciler2 VALUES(default, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler2 VALUES(default, 'Can Bak', 'Ali', 67.5);
ROLLBACK to y;
COMMIT;
 


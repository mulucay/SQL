CREATE TABLE ogrenciler3
(
ogrenci_no char(7),
isim varchar(20),
soyisim varchar(25),
not_ort real,
kayit_tarih date);

--VAR OLAN BİR TABLODAN YENİ BİR TABLO OLUSTURMA
CREATE TABLE NOTLAR
AS
SELECT isim,not_ort FROM ogrenciler3;

select * FROM notlar;

--INSERT -TABLO İCİNE VERİ EKLEME
INSERT INTO NOTLAR VALUES('Erol',75.5);
INSERT INTO NOTLAR VALUES('Mustafa',90.5);
INSERT INTO NOTLAR VALUES('Ali',60.5);
INSERT INTO NOTLAR VALUES('Can',50.5);

create table talebeler(
isim varchar(10),
notlar real);	

INSERT INTO talebeler VALUES('Erol',75.5);
INSERT INTO talebeler VALUES('Mustafa',90.5);
INSERT INTO talebeler VALUES('Ali',60.5);
INSERT INTO talebeler VALUES('Can',50.5);

select * FROM talebeler;

--CONSTRAINT
--UNIQUE
CREATE TABLE ogrenciler5
(
ogrenci_no char(7)UNIQUE,
isim varchar(20)NOT NULL,
soyisim varchar(25),
not_ort real,
kayit_tarih date);

select * FROM ogrenciler4;
INSERT INTO ogrenciler5 VALUES('1234567','Mustafa','Ulucay',75.5,now());
INSERT INTO ogrenciler5 VALUES('1234568','Ali','Veli',75.5,now());

select * FROM ogrenciler5;
INSERT INTO ogrenciler5(ogrenci_no,soyisim,not_ort) VALUES('1234569','Evren',85.5);
--not null kısıtlaması oldugu icin bu veri eklenemez

--PRIMARY KEY OLUSTURMA
CREATE TABLE ogrenciler6
(
ogrenci_no char(7)PRIMARY KEY,
isim varchar(20),
soyisim varchar(25),
not_ort real,
kayit_tarih date);

--PRIMARY KEY ATAMASI 2.YOL
--Eger Constraint isimini kendimiz vermek istersek bu yolu kullaniriz
CREATE TABLE ogrenciler7
(
ogrenci_no char(7),
isim varchar(20),
soyisim varchar(25),
not_ort real,
kayit_tarih date,
CONSTRAINT ogr PRIMARY KEY(ogrenci_no) 
);

/*“tedarikciler3” isimli bir tablo olusturun. 
--Tabloda “tedarikci_id”, “tedarikci_ismi”, “iletisim_isim” field’lari olsun ve “tedarikci_id” yi Primary Key yapin.
--“urunler” isminde baska bir tablo olusturun “tedarikci_id” ve “urun_id” field’lari olsun ve
--“tedarikci_id” yi Foreign Key yapin.*/
CREATE TABLE tedarikciler3
(
tedarikci_id char(5) PRIMARY KEY,
tedarikci_ismi varchar(20),
iletisim_isim varchar(20)
);

CREATE TABLE urunler
(
tedarikci_id char(5),
urun_id char(5),
FOREIGN KEY (tedarikci_id) REFERENCES tedarikciler3(tedarikci_id)
);
select * from tedarikciler3;
select * from urunler;

/*
“calisanlar” isimli bir Tablo olusturun. Icinde “id”, “isim”, “maas”, “ise_baslama” field’lari olsun. 
“id” yi Primary Key yapin, “isim” i Unique, “maas” i Not Null yapın.
“adresler” isminde baska bir tablo olusturun.Icinde “adres_id”, “sokak”, 
“cadde” ve “sehir” fieldlari olsun. “adres_id” field‘i ile Foreign Key oluşturun.
*/
CREATE TABLE calisanlar
(
id varchar(15) PRIMARY KEY,
isim varchar(20) UNIQUE,
maas int NOT NULL,
ise_baslama date
);
CREATE TABLE adresler
(
adres_id char(5),
sokak varchar(30),
cadde varchar(20),
sehir varchar(15),
FOREIGN KEY (adres_id) REFERENCES calisanlar(id)
);
INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', 'Mehmet Yılmaz', 5000, '2018-04-14');--UNIQUE CONS. OLDUGU İCİN KABUL ETMEDİ
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12');--NOT NULL CONS. KABUL ETMEZ
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14');--UNIQUE CONS. OLDUGU İCİN KABUL ETMEDİ
INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14');--ınt yerine string girilmez
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14');--PRIMARY KEY İKİNCİ HİCLİGİ KABUL ETMİYOR
INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14');--PRIMARY KEY İKİNCİ HİCLİGİ KABUL ETMİYOR
INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14');--PRIMARY KEY null kabul etmez

INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');
-- Parent tabloda olmayan id ile child a ekleme yapamayiz
INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep');
-- FK'ye null değeri atanabilir.
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Maraş');

select*from calisanlar;
select*from adresler;

--CHECK CONSTRAINT
CREATE TABLE calisanlar1
(
id varchar(15) PRIMARY KEY,
isim varchar(20) UNIQUE,
maas int CHECK(maas>10000),
ise_baslama date
);
INSERT INTO calisanlar1 VALUES('10002','Mehmet Yılmaz',19000,'2018-04-14');
select*from calisanlar1;

--DQL-- WHERE KULLANIMI

SELECT*FROM calisanlar;
select isim from calisanlar;

--calisanlar tablosundan maasi 5000 den buyuk olan isimleri listeleyiniz

select isim,maas from calisanlar WHERE maas>5000;

--calisanlar tablosundan ismi veli han olan tum veriyi listeleyiniz
select*from calisanlar where isim= 'Veli Han';
--calisanlar tablosundan maasi 5000  olan tum verileri listeleyiniz
select*from calisanlar where maas=5000;

--DML-- DELETE KULLANIMI-tablo adı yazdıgımızda tablo icindeki tum bilgileri siler
                        --where komutuyla ise tablo icindeki istedigimiz yerdeki bilgiyi siler

DELETE FROM calisanlar;--eger paretn tablo baska bir tablo ile iliskili ise once child table silinmelidir.
delete from adresler;
select*from adresler;

--adresler tablosundan sehri antep olan verileri silelim
delete from adresler where sehir='Antep';

CREATE TABLE ogrenciler8
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);
INSERT INTO ogrenciler8 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler8 VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler8 VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler8 VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler8 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler8 VALUES(127, 'Mustafa Bak', 'Ali', 99);

-- ismi Nesibe Yilmaz veya Mustafa Bak olan kayıtları silelim.

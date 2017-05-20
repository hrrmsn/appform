CREATE TABLE regions (
  regionid  INTEGER PRIMARY KEY AUTOINCREMENT,
  region    VARCHAR
);

CREATE TABLE cities (
  cityid    INTEGER PRIMARY KEY AUTOINCREMENT,
  city      VARCHAR,
  regionid  INTEGER,
  FOREIGN KEY(regionid) REFERENCES regions(regionid)
);

CREATE TABLE persons (
  personid    INTEGER PRIMARY KEY AUTOINCREMENT,
  firstname   VARCHAR,
  lastname    VARCHAR,
  middlename  VARCHAR,
  regionid    INTEGER,
  cityid      INTEGER,
  phone       VARCHAR,
  email       VARCHAR,
  comment     TEXT,
  FOREIGN KEY(regionid) REFERENCES regions(regionid),
  FOREIGN KEY(cityid)   REFERENCES cities(cityid)
);


BEGIN TRANSACTION;

INSERT INTO regions(region) VALUES('Altai Krai');
INSERT INTO regions(region) VALUES('Amur Oblast');
INSERT INTO regions(region) VALUES('Arkhangelsk Oblast');
INSERT INTO regions(region) VALUES('Astrakhan Oblast');
INSERT INTO regions(region) VALUES('Belgorod Oblast');
INSERT INTO regions(region) VALUES('Bryansk Oblast');
INSERT INTO regions(region) VALUES('Chechen Republic');
INSERT INTO regions(region) VALUES('Chelyabinsk Oblast');
INSERT INTO regions(region) VALUES('Chukotka Autonomous Okrug');
INSERT INTO regions(region) VALUES('Chuvash Republic');
INSERT INTO regions(region) VALUES('Dagestan');
INSERT INTO regions(region) VALUES('Ingushetia');
INSERT INTO regions(region) VALUES('Irkutsk Oblast');
INSERT INTO regions(region) VALUES('Ivanovo Oblast');
INSERT INTO regions(region) VALUES('Jewish Autonomous Oblast');
INSERT INTO regions(region) VALUES('Kabardino-Balkar Republic');
INSERT INTO regions(region) VALUES('Kaliningrad Oblast');
INSERT INTO regions(region) VALUES('Kalmykia');
INSERT INTO regions(region) VALUES('Kaluga Oblast');
INSERT INTO regions(region) VALUES('Kamchatka Krai');
INSERT INTO regions(region) VALUES('Karachay-Cherkessia');
INSERT INTO regions(region) VALUES('Karelia');
INSERT INTO regions(region) VALUES('Kemerovo Oblast');
INSERT INTO regions(region) VALUES('Khabarovsk Krai');
INSERT INTO regions(region) VALUES('Khanty-Mansi Autonomous Okrug');
INSERT INTO regions(region) VALUES('Kirov Oblast');
INSERT INTO regions(region) VALUES('Komi Republic');
INSERT INTO regions(region) VALUES('Kostroma Oblast');
INSERT INTO regions(region) VALUES('Krasnodar Krai');
INSERT INTO regions(region) VALUES('Krasnoyarsk Krai');
INSERT INTO regions(region) VALUES('Kurgan Oblast');
INSERT INTO regions(region) VALUES('Kursk Oblast');
INSERT INTO regions(region) VALUES('Leningrad Oblast');
INSERT INTO regions(region) VALUES('Lipetsk Oblast');
INSERT INTO regions(region) VALUES('Magadan Oblast');
INSERT INTO regions(region) VALUES('Mari El');
INSERT INTO regions(region) VALUES('Moscow');
INSERT INTO regions(region) VALUES('Moscow Oblast');
INSERT INTO regions(region) VALUES('Murmansk Oblast');
INSERT INTO regions(region) VALUES('Nizhny Novgorod Oblast');
INSERT INTO regions(region) VALUES('Novgorod Oblast');
INSERT INTO regions(region) VALUES('Novosibirsk Oblast');
INSERT INTO regions(region) VALUES('Omsk Oblast');
INSERT INTO regions(region) VALUES('Orenburg Oblast');
INSERT INTO regions(region) VALUES('Oryol Oblast');
INSERT INTO regions(region) VALUES('Penza Oblast');
INSERT INTO regions(region) VALUES('Perm Krai');
INSERT INTO regions(region) VALUES('Primorsky Krai');
INSERT INTO regions(region) VALUES('Pskov Oblast');
INSERT INTO regions(region) VALUES('Republic of Adygea');
INSERT INTO regions(region) VALUES('Republic of Bashkortostan');
INSERT INTO regions(region) VALUES('Republic of Buryatia');
INSERT INTO regions(region) VALUES('Republic of Khakassia');
INSERT INTO regions(region) VALUES('Republic of Mordovia');
INSERT INTO regions(region) VALUES('Republic of North Ossetia–Alania');
INSERT INTO regions(region) VALUES('Republic of Tatarstan');
INSERT INTO regions(region) VALUES('Rostov Oblast');
INSERT INTO regions(region) VALUES('Ryazan Oblast');
INSERT INTO regions(region) VALUES('Saint Petersburg');
INSERT INTO regions(region) VALUES('Sakha Republic');
INSERT INTO regions(region) VALUES('Sakhalin Oblast');
INSERT INTO regions(region) VALUES('Samara Oblast');
INSERT INTO regions(region) VALUES('Saratov Oblast');
INSERT INTO regions(region) VALUES('Smolensk Oblast');
INSERT INTO regions(region) VALUES('Stavropol Krai');
INSERT INTO regions(region) VALUES('Sverdlovsk Oblast');
INSERT INTO regions(region) VALUES('Tambov Oblast');
INSERT INTO regions(region) VALUES('Tomsk Oblast');
INSERT INTO regions(region) VALUES('Tula Oblast');
INSERT INTO regions(region) VALUES('Tuva Republic');
INSERT INTO regions(region) VALUES('Tver Oblast');
INSERT INTO regions(region) VALUES('Tyumen Oblast');
INSERT INTO regions(region) VALUES('Udmurtia');
INSERT INTO regions(region) VALUES('Ulyanovsk Oblast');
INSERT INTO regions(region) VALUES('Vladimir Oblast');
INSERT INTO regions(region) VALUES('Volgograd Oblast');
INSERT INTO regions(region) VALUES('Vologda Oblast');
INSERT INTO regions(region) VALUES('Voronezh Oblast');
INSERT INTO regions(region) VALUES('Yamalo-Nenets Autonomous Okrug');
INSERT INTO regions(region) VALUES('Yaroslavl Oblast');
INSERT INTO regions(region) VALUES('Zabaykalsky Krai');

COMMIT;


BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Barnaul', 1);
INSERT INTO cities(city, regionid) VALUES('Belokurikha', 1);
INSERT INTO cities(city, regionid) VALUES('Biysk', 1);
INSERT INTO cities(city, regionid) VALUES('Gornyak', 1);
INSERT INTO cities(city, regionid) VALUES('Kamen-na-Obi', 1);
INSERT INTO cities(city, regionid) VALUES('Novoaltaysk', 1);
INSERT INTO cities(city, regionid) VALUES('Rubtsovsk', 1);
INSERT INTO cities(city, regionid) VALUES('Slavgorod', 1);
INSERT INTO cities(city, regionid) VALUES('Yarovoye', 1);
INSERT INTO cities(city, regionid) VALUES('Zarinsk', 1);
INSERT INTO cities(city, regionid) VALUES('Zmeinogorsk', 1);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Blagoveshchensk', 2);
INSERT INTO cities(city, regionid) VALUES('Raychikhinsk', 2);
INSERT INTO cities(city, regionid) VALUES('Shimanovsk', 2);
INSERT INTO cities(city, regionid) VALUES('Skovorodino', 2);
INSERT INTO cities(city, regionid) VALUES('Svobodny', 2);
INSERT INTO cities(city, regionid) VALUES('Tynda', 2);
INSERT INTO cities(city, regionid) VALUES('Zavitinsk', 2);
INSERT INTO cities(city, regionid) VALUES('Zeya', 2);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Kargopol', 3);
INSERT INTO cities(city, regionid) VALUES('Koryazhma', 3);
INSERT INTO cities(city, regionid) VALUES('Kotlas', 3);
INSERT INTO cities(city, regionid) VALUES('Mezen', 3);
INSERT INTO cities(city, regionid) VALUES('Mirny', 3);
INSERT INTO cities(city, regionid) VALUES('Novodvinsk', 3);
INSERT INTO cities(city, regionid) VALUES('Nyandoma', 3);
INSERT INTO cities(city, regionid) VALUES('Onega', 3);
INSERT INTO cities(city, regionid) VALUES('Severodvinsk', 3);
INSERT INTO cities(city, regionid) VALUES('Shenkursk', 3);
INSERT INTO cities(city, regionid) VALUES('Solvychegodsk', 3);
INSERT INTO cities(city, regionid) VALUES('Velsk', 3);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Astrakhan', 4);
INSERT INTO cities(city, regionid) VALUES('Kamyzyak', 4);
INSERT INTO cities(city, regionid) VALUES('Kharabali', 4);
INSERT INTO cities(city, regionid) VALUES('Narimanov', 4);
INSERT INTO cities(city, regionid) VALUES('Znamensk', 4);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Belgorod', 5);
INSERT INTO cities(city, regionid) VALUES('Biryuch', 5);
INSERT INTO cities(city, regionid) VALUES('Grayvoron', 5);
INSERT INTO cities(city, regionid) VALUES('Gubkin', 5);
INSERT INTO cities(city, regionid) VALUES('Korocha', 5);
INSERT INTO cities(city, regionid) VALUES('Novy Oskol', 5);
INSERT INTO cities(city, regionid) VALUES('Shebekino', 5);
INSERT INTO cities(city, regionid) VALUES('Stary Oskol', 5);
INSERT INTO cities(city, regionid) VALUES('Stroitel', 5);
INSERT INTO cities(city, regionid) VALUES('Valuyki', 5);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Dyatkovo', 6);
INSERT INTO cities(city, regionid) VALUES('Fokino', 6);
INSERT INTO cities(city, regionid) VALUES('Karachev', 6);
INSERT INTO cities(city, regionid) VALUES('Klintsy', 6);
INSERT INTO cities(city, regionid) VALUES('Mglin', 6);
INSERT INTO cities(city, regionid) VALUES('Novozybkov', 6);
INSERT INTO cities(city, regionid) VALUES('Pochep', 6);
INSERT INTO cities(city, regionid) VALUES('Seltso', 6);
INSERT INTO cities(city, regionid) VALUES('Sevsk', 6);
INSERT INTO cities(city, regionid) VALUES('Starodub', 6);
INSERT INTO cities(city, regionid) VALUES('Surazh', 6);
INSERT INTO cities(city, regionid) VALUES('Trubchevsk', 6);
INSERT INTO cities(city, regionid) VALUES('Unecha', 6);
INSERT INTO cities(city, regionid) VALUES('Zhukovka', 6);
INSERT INTO cities(city, regionid) VALUES('Zlynka', 6);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Grozny', 7);
INSERT INTO cities(city, regionid) VALUES('Gudermes', 7);
INSERT INTO cities(city, regionid) VALUES('Shali', 7);
INSERT INTO cities(city, regionid) VALUES('Urus-Martan', 7);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Bakal', 8);
INSERT INTO cities(city, regionid) VALUES('Chebarkul', 8);
INSERT INTO cities(city, regionid) VALUES('Chelyabinsk', 8);
INSERT INTO cities(city, regionid) VALUES('Karabash', 8);
INSERT INTO cities(city, regionid) VALUES('Kartaly', 8);
INSERT INTO cities(city, regionid) VALUES('Kasli', 8);
INSERT INTO cities(city, regionid) VALUES('Katav-Ivanovsk', 8);
INSERT INTO cities(city, regionid) VALUES('Kopeysk', 8);
INSERT INTO cities(city, regionid) VALUES('Korkino', 8);
INSERT INTO cities(city, regionid) VALUES('Kusa', 8);
INSERT INTO cities(city, regionid) VALUES('Kyshtym', 8);
INSERT INTO cities(city, regionid) VALUES('Magnitogorsk', 8);
INSERT INTO cities(city, regionid) VALUES('Miass', 8);
INSERT INTO cities(city, regionid) VALUES('Minyar', 8);
INSERT INTO cities(city, regionid) VALUES('Nyazepetrovsk', 8);
INSERT INTO cities(city, regionid) VALUES('Ozyorsk', 8);
INSERT INTO cities(city, regionid) VALUES('Plast', 8);
INSERT INTO cities(city, regionid) VALUES('Satka', 8);
INSERT INTO cities(city, regionid) VALUES('Sim', 8);
INSERT INTO cities(city, regionid) VALUES('Snezhinsk', 8);
INSERT INTO cities(city, regionid) VALUES('Troitsk', 8);
INSERT INTO cities(city, regionid) VALUES('Tryokhgorny', 8);
INSERT INTO cities(city, regionid) VALUES('Ust-Katav', 8);
INSERT INTO cities(city, regionid) VALUES('Verkhneuralsk', 8);
INSERT INTO cities(city, regionid) VALUES('Verkhny Ufaley', 8);
INSERT INTO cities(city, regionid) VALUES('Yemanzhelinsk', 8);
INSERT INTO cities(city, regionid) VALUES('Yuryuzan', 8);
INSERT INTO cities(city, regionid) VALUES('Yuzhnouralsk', 8);
INSERT INTO cities(city, regionid) VALUES('Zlatoust', 8);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Bilibino', 9);
INSERT INTO cities(city, regionid) VALUES('Pevek', 9);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Cheboksary', 10);
INSERT INTO cities(city, regionid) VALUES('Kanash', 10);
INSERT INTO cities(city, regionid) VALUES('Kozlovka', 10);
INSERT INTO cities(city, regionid) VALUES('Mariinsky Posad', 10);
INSERT INTO cities(city, regionid) VALUES('Novocheboksarsk', 10);
INSERT INTO cities(city, regionid) VALUES('Shumerlya', 10);
INSERT INTO cities(city, regionid) VALUES('Tsivilsk', 10);
INSERT INTO cities(city, regionid) VALUES('Yadrin', 10);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Dagestanskiye Ogni', 11);
INSERT INTO cities(city, regionid) VALUES('Derbent', 11);
INSERT INTO cities(city, regionid) VALUES('Izberbash', 11);
INSERT INTO cities(city, regionid) VALUES('Kaspiysk', 11);
INSERT INTO cities(city, regionid) VALUES('Khasavyurt', 11);
INSERT INTO cities(city, regionid) VALUES('Kizilyurt', 11);
INSERT INTO cities(city, regionid) VALUES('Kizlyar', 11);
INSERT INTO cities(city, regionid) VALUES('Makhachkala', 11);
INSERT INTO cities(city, regionid) VALUES('Yuzhno-Sukhokumsk', 11);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Magas', 12);
INSERT INTO cities(city, regionid) VALUES('Malgobek', 12);
INSERT INTO cities(city, regionid) VALUES('Nazran', 12);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Angarsk', 13);
INSERT INTO cities(city, regionid) VALUES('Baykalsk', 13);
INSERT INTO cities(city, regionid) VALUES('Biryusinsk', 13);
INSERT INTO cities(city, regionid) VALUES('Bodaybo', 13);
INSERT INTO cities(city, regionid) VALUES('Bratsk', 13);
INSERT INTO cities(city, regionid) VALUES('Cheremkhovo', 13);
INSERT INTO cities(city, regionid) VALUES('Irkutsk', 13);
INSERT INTO cities(city, regionid) VALUES('Kirensk', 13);
INSERT INTO cities(city, regionid) VALUES('Nizhneudinsk', 13);
INSERT INTO cities(city, regionid) VALUES('Sayansk', 13);
INSERT INTO cities(city, regionid) VALUES('Shelekhov', 13);
INSERT INTO cities(city, regionid) VALUES('Slyudyanka', 13);
INSERT INTO cities(city, regionid) VALUES('Svirsk', 13);
INSERT INTO cities(city, regionid) VALUES('Tayshet', 13);
INSERT INTO cities(city, regionid) VALUES('Tulun', 13);
INSERT INTO cities(city, regionid) VALUES('Usolye-Sibirskoye', 13);
INSERT INTO cities(city, regionid) VALUES('Ust-Ilimsk', 13);
INSERT INTO cities(city, regionid) VALUES('Ust-Kut', 13);
INSERT INTO cities(city, regionid) VALUES('Vikhorevka', 13);
INSERT INTO cities(city, regionid) VALUES('Zheleznogorsk-Ilimsky', 13);
INSERT INTO cities(city, regionid) VALUES('Zima', 13);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Gavrilov Posad', 14);
INSERT INTO cities(city, regionid) VALUES('Ivanovo', 14);
INSERT INTO cities(city, regionid) VALUES('Kineshma', 14);
INSERT INTO cities(city, regionid) VALUES('Kokhma', 14);
INSERT INTO cities(city, regionid) VALUES('Komsomolsk', 14);
INSERT INTO cities(city, regionid) VALUES('Navoloki', 14);
INSERT INTO cities(city, regionid) VALUES('Plyos', 14);
INSERT INTO cities(city, regionid) VALUES('Privolzhsk', 14);
INSERT INTO cities(city, regionid) VALUES('Puchezh', 14);
INSERT INTO cities(city, regionid) VALUES('Rodniki', 14);
INSERT INTO cities(city, regionid) VALUES('Shuya', 14);
INSERT INTO cities(city, regionid) VALUES('Teykovo', 14);
INSERT INTO cities(city, regionid) VALUES('Vichuga', 14);
INSERT INTO cities(city, regionid) VALUES('Yuryevets', 14);
INSERT INTO cities(city, regionid) VALUES('Yuzha', 14);
INSERT INTO cities(city, regionid) VALUES('Zavolzhsk', 14);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Obluchye', 15);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Chegem', 16);
INSERT INTO cities(city, regionid) VALUES('Maysky', 16);
INSERT INTO cities(city, regionid) VALUES('Nalchik', 16);
INSERT INTO cities(city, regionid) VALUES('Nartkala', 16);
INSERT INTO cities(city, regionid) VALUES('Prokhladny', 16);
INSERT INTO cities(city, regionid) VALUES('Terek', 16);
INSERT INTO cities(city, regionid) VALUES('Tyrnyauz', 16);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Baltiysk', 17);
INSERT INTO cities(city, regionid) VALUES('Chernyakhovsk', 17);
INSERT INTO cities(city, regionid) VALUES('Guryevsk', 17);
INSERT INTO cities(city, regionid) VALUES('Gusev', 17);
INSERT INTO cities(city, regionid) VALUES('Gvardeysk', 17);
INSERT INTO cities(city, regionid) VALUES('Kaliningrad', 17);
INSERT INTO cities(city, regionid) VALUES('Krasnoznamensk', 17);
INSERT INTO cities(city, regionid) VALUES('Ladushkin', 17);
INSERT INTO cities(city, regionid) VALUES('Mamonovo', 17);
INSERT INTO cities(city, regionid) VALUES('Neman', 17);
INSERT INTO cities(city, regionid) VALUES('Nesterov', 17);
INSERT INTO cities(city, regionid) VALUES('Ozyorsk', 17);
INSERT INTO cities(city, regionid) VALUES('Pionersky', 17);
INSERT INTO cities(city, regionid) VALUES('Polessk', 17);
INSERT INTO cities(city, regionid) VALUES('Pravdinsk', 17);
INSERT INTO cities(city, regionid) VALUES('Slavsk', 17);
INSERT INTO cities(city, regionid) VALUES('Sovetsk', 17);
INSERT INTO cities(city, regionid) VALUES('Svetlogorsk', 17);
INSERT INTO cities(city, regionid) VALUES('Svetly', 17);
INSERT INTO cities(city, regionid) VALUES('Zelenogradsk', 17);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Gorodovikovsk', 18);
INSERT INTO cities(city, regionid) VALUES('Lagan', 18);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Belousovo', 19);
INSERT INTO cities(city, regionid) VALUES('Borovsk', 19);
INSERT INTO cities(city, regionid) VALUES('Kaluga', 19);
INSERT INTO cities(city, regionid) VALUES('Kirov', 19);
INSERT INTO cities(city, regionid) VALUES('Kondrovo', 19);
INSERT INTO cities(city, regionid) VALUES('Kozelsk', 19);
INSERT INTO cities(city, regionid) VALUES('Kremyonki', 19);
INSERT INTO cities(city, regionid) VALUES('Lyudinovo', 19);
INSERT INTO cities(city, regionid) VALUES('Maloyaroslavets', 19);
INSERT INTO cities(city, regionid) VALUES('Medyn', 19);
INSERT INTO cities(city, regionid) VALUES('Meshchovsk', 19);
INSERT INTO cities(city, regionid) VALUES('Mosalsk', 19);
INSERT INTO cities(city, regionid) VALUES('Obninsk', 19);
INSERT INTO cities(city, regionid) VALUES('Sosensky', 19);
INSERT INTO cities(city, regionid) VALUES('Spas-Demensk', 19);
INSERT INTO cities(city, regionid) VALUES('Sukhinichi', 19);
INSERT INTO cities(city, regionid) VALUES('Tarusa', 19);
INSERT INTO cities(city, regionid) VALUES('Yermolino', 19);
INSERT INTO cities(city, regionid) VALUES('Yukhnov', 19);
INSERT INTO cities(city, regionid) VALUES('Zhizdra', 19);
INSERT INTO cities(city, regionid) VALUES('Zhukov', 19);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Vilyuchinsk', 20);
INSERT INTO cities(city, regionid) VALUES('Yelizovo', 20);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Karachayevsk', 21);
INSERT INTO cities(city, regionid) VALUES('Teberda', 21);
INSERT INTO cities(city, regionid) VALUES('Ust-Dzheguta', 21);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Kem', 22);
INSERT INTO cities(city, regionid) VALUES('Kondopoga', 22);
INSERT INTO cities(city, regionid) VALUES('Kostomuksha', 22);
INSERT INTO cities(city, regionid) VALUES('Lakhdenpokhya', 22);
INSERT INTO cities(city, regionid) VALUES('Medvezhyegorsk', 22);
INSERT INTO cities(city, regionid) VALUES('Olonets', 22);
INSERT INTO cities(city, regionid) VALUES('Petrozavodsk', 22);
INSERT INTO cities(city, regionid) VALUES('Pitkyaranta', 22);
INSERT INTO cities(city, regionid) VALUES('Pudozh', 22);
INSERT INTO cities(city, regionid) VALUES('Segezha', 22);
INSERT INTO cities(city, regionid) VALUES('Sortavala', 22);
INSERT INTO cities(city, regionid) VALUES('Suoyarvi', 22);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Belovo', 23);
INSERT INTO cities(city, regionid) VALUES('Berezovsky', 23);
INSERT INTO cities(city, regionid) VALUES('Guryevsk', 23);
INSERT INTO cities(city, regionid) VALUES('Kaltan', 23);
INSERT INTO cities(city, regionid) VALUES('Kemerovo', 23);
INSERT INTO cities(city, regionid) VALUES('Kiselyovsk', 23);
INSERT INTO cities(city, regionid) VALUES('Leninsk-Kuznetsky', 23);
INSERT INTO cities(city, regionid) VALUES('Mariinsk', 23);
INSERT INTO cities(city, regionid) VALUES('Mezhdurechensk', 23);
INSERT INTO cities(city, regionid) VALUES('Myski', 23);
INSERT INTO cities(city, regionid) VALUES('Novokuznetsk', 23);
INSERT INTO cities(city, regionid) VALUES('Osinniki', 23);
INSERT INTO cities(city, regionid) VALUES('Polysayevo', 23);
INSERT INTO cities(city, regionid) VALUES('Prokopyevsk', 23);
INSERT INTO cities(city, regionid) VALUES('Salair', 23);
INSERT INTO cities(city, regionid) VALUES('Tashtagol', 23);
INSERT INTO cities(city, regionid) VALUES('Tayga', 23);
INSERT INTO cities(city, regionid) VALUES('Topki', 23);
INSERT INTO cities(city, regionid) VALUES('Yurga', 23);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Bikin', 24);
INSERT INTO cities(city, regionid) VALUES('Khabarovsk', 24);
INSERT INTO cities(city, regionid) VALUES('Komsomolsk-on-Amur', 24);
INSERT INTO cities(city, regionid) VALUES('Nikolayevsk-on-Amur', 24);
INSERT INTO cities(city, regionid) VALUES('Sovetskaya Gavan', 24);
INSERT INTO cities(city, regionid) VALUES('Vyazemsky', 24);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Khanty-Mansiysk', 25);
INSERT INTO cities(city, regionid) VALUES('Kogalym', 25);
INSERT INTO cities(city, regionid) VALUES('Langepas', 25);
INSERT INTO cities(city, regionid) VALUES('Lyantor', 25);
INSERT INTO cities(city, regionid) VALUES('Megion', 25);
INSERT INTO cities(city, regionid) VALUES('Nefteyugansk', 25);
INSERT INTO cities(city, regionid) VALUES('Nizhnevartovsk', 25);
INSERT INTO cities(city, regionid) VALUES('Nyagan', 25);
INSERT INTO cities(city, regionid) VALUES('Pokachi', 25);
INSERT INTO cities(city, regionid) VALUES('Pyt-Yakh', 25);
INSERT INTO cities(city, regionid) VALUES('Raduzhny', 25);
INSERT INTO cities(city, regionid) VALUES('Sovetsky', 25);
INSERT INTO cities(city, regionid) VALUES('Surgut', 25);
INSERT INTO cities(city, regionid) VALUES('Uray', 25);
INSERT INTO cities(city, regionid) VALUES('Yugorsk', 25);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Kirov', 26);
INSERT INTO cities(city, regionid) VALUES('Kirovo-Chepetsk', 26);
INSERT INTO cities(city, regionid) VALUES('Kirs', 26);
INSERT INTO cities(city, regionid) VALUES('Kotelnich', 26);
INSERT INTO cities(city, regionid) VALUES('Luza', 26);
INSERT INTO cities(city, regionid) VALUES('Malmyzh', 26);
INSERT INTO cities(city, regionid) VALUES('Murashi', 26);
INSERT INTO cities(city, regionid) VALUES('Nolinsk', 26);
INSERT INTO cities(city, regionid) VALUES('Omutninsk', 26);
INSERT INTO cities(city, regionid) VALUES('Orlov', 26);
INSERT INTO cities(city, regionid) VALUES('Slobodskoy', 26);
INSERT INTO cities(city, regionid) VALUES('Sosnovka', 26);
INSERT INTO cities(city, regionid) VALUES('Sovetsk', 26);
INSERT INTO cities(city, regionid) VALUES('Urzhum', 26);
INSERT INTO cities(city, regionid) VALUES('Vyatskiye Polyany', 26);
INSERT INTO cities(city, regionid) VALUES('Yaransk', 26);
INSERT INTO cities(city, regionid) VALUES('Zuyevka', 26);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Mikun', 27);
INSERT INTO cities(city, regionid) VALUES('Pechora', 27);
INSERT INTO cities(city, regionid) VALUES('Sosnogorsk', 27);
INSERT INTO cities(city, regionid) VALUES('Syktyvkar', 27);
INSERT INTO cities(city, regionid) VALUES('Ukhta', 27);
INSERT INTO cities(city, regionid) VALUES('Usinsk', 27);
INSERT INTO cities(city, regionid) VALUES('Vorkuta', 27);
INSERT INTO cities(city, regionid) VALUES('Vuktyl', 27);
INSERT INTO cities(city, regionid) VALUES('Yemva', 27);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Chukhloma', 28);
INSERT INTO cities(city, regionid) VALUES('Galich', 28);
INSERT INTO cities(city, regionid) VALUES('Kologriv', 28);
INSERT INTO cities(city, regionid) VALUES('Kostroma', 28);
INSERT INTO cities(city, regionid) VALUES('Makaryev', 28);
INSERT INTO cities(city, regionid) VALUES('Manturovo', 28);
INSERT INTO cities(city, regionid) VALUES('Nerekhta', 28);
INSERT INTO cities(city, regionid) VALUES('Neya', 28);
INSERT INTO cities(city, regionid) VALUES('Sharya', 28);
INSERT INTO cities(city, regionid) VALUES('Soligalich', 28);
INSERT INTO cities(city, regionid) VALUES('Volgorechensk', 28);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Anapa', 29);
INSERT INTO cities(city, regionid) VALUES('Apsheronsk', 29);
INSERT INTO cities(city, regionid) VALUES('Armavir', 29);
INSERT INTO cities(city, regionid) VALUES('Belorechensk', 29);
INSERT INTO cities(city, regionid) VALUES('Gelendzhik', 29);
INSERT INTO cities(city, regionid) VALUES('Goryachy Klyuch', 29);
INSERT INTO cities(city, regionid) VALUES('Gulkevichi', 29);
INSERT INTO cities(city, regionid) VALUES('Khadyzhensk', 29);
INSERT INTO cities(city, regionid) VALUES('Korenovsk', 29);
INSERT INTO cities(city, regionid) VALUES('Krasnodar', 29);
INSERT INTO cities(city, regionid) VALUES('Kropotkin', 29);
INSERT INTO cities(city, regionid) VALUES('Krymsk', 29);
INSERT INTO cities(city, regionid) VALUES('Kurganinsk', 29);
INSERT INTO cities(city, regionid) VALUES('Labinsk', 29);
INSERT INTO cities(city, regionid) VALUES('Novokubansk', 29);
INSERT INTO cities(city, regionid) VALUES('Novorossiysk', 29);
INSERT INTO cities(city, regionid) VALUES('Primorsko-Akhtarsk', 29);
INSERT INTO cities(city, regionid) VALUES('Slavyansk-na-Kubani', 29);
INSERT INTO cities(city, regionid) VALUES('Sochi', 29);
INSERT INTO cities(city, regionid) VALUES('Temryuk', 29);
INSERT INTO cities(city, regionid) VALUES('Tikhoretsk', 29);
INSERT INTO cities(city, regionid) VALUES('Timashyovsk', 29);
INSERT INTO cities(city, regionid) VALUES('Tuapse', 29);
INSERT INTO cities(city, regionid) VALUES('Ust-Labinsk', 29);
INSERT INTO cities(city, regionid) VALUES('Yeysk', 29);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Artyomovsk', 30);
INSERT INTO cities(city, regionid) VALUES('Bogotol', 30);
INSERT INTO cities(city, regionid) VALUES('Borodino', 30);
INSERT INTO cities(city, regionid) VALUES('Divnogorsk', 30);
INSERT INTO cities(city, regionid) VALUES('Dudinka', 30);
INSERT INTO cities(city, regionid) VALUES('Igarka', 30);
INSERT INTO cities(city, regionid) VALUES('Ilansky', 30);
INSERT INTO cities(city, regionid) VALUES('Kansk', 30);
INSERT INTO cities(city, regionid) VALUES('Kodinsk', 30);
INSERT INTO cities(city, regionid) VALUES('Krasnoyarsk', 30);
INSERT INTO cities(city, regionid) VALUES('Lesosibirsk', 30);
INSERT INTO cities(city, regionid) VALUES('Minusinsk', 30);
INSERT INTO cities(city, regionid) VALUES('Nazarovo', 30);
INSERT INTO cities(city, regionid) VALUES('Norilsk', 30);
INSERT INTO cities(city, regionid) VALUES('Sharypovo', 30);
INSERT INTO cities(city, regionid) VALUES('Sosnovoborsk', 30);
INSERT INTO cities(city, regionid) VALUES('Uyar', 30);
INSERT INTO cities(city, regionid) VALUES('Uzhur', 30);
INSERT INTO cities(city, regionid) VALUES('Yeniseysk', 30);
INSERT INTO cities(city, regionid) VALUES('Zaozyorny', 30);
INSERT INTO cities(city, regionid) VALUES('Zelenogorsk', 30);
INSERT INTO cities(city, regionid) VALUES('Zheleznogorsk', 30);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Kataysk', 31);
INSERT INTO cities(city, regionid) VALUES('Kurgan', 31);
INSERT INTO cities(city, regionid) VALUES('Kurtamysh', 31);
INSERT INTO cities(city, regionid) VALUES('Makushino', 31);
INSERT INTO cities(city, regionid) VALUES('Petukhovo', 31);
INSERT INTO cities(city, regionid) VALUES('Shadrinsk', 31);
INSERT INTO cities(city, regionid) VALUES('Shchuchye', 31);
INSERT INTO cities(city, regionid) VALUES('Shumikha', 31);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Fatezh', 32);
INSERT INTO cities(city, regionid) VALUES('Kurchatov', 32);
INSERT INTO cities(city, regionid) VALUES('Kursk', 32);
INSERT INTO cities(city, regionid) VALUES('Lgov', 32);
INSERT INTO cities(city, regionid) VALUES('Oboyan', 32);
INSERT INTO cities(city, regionid) VALUES('Rylsk', 32);
INSERT INTO cities(city, regionid) VALUES('Shchigry', 32);
INSERT INTO cities(city, regionid) VALUES('Sudzha', 32);
INSERT INTO cities(city, regionid) VALUES('Zheleznogorsk', 32);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Gatchina', 33);
INSERT INTO cities(city, regionid) VALUES('Ivangorod', 33);
INSERT INTO cities(city, regionid) VALUES('Kamennogorsk', 33);
INSERT INTO cities(city, regionid) VALUES('Kingisepp', 33);
INSERT INTO cities(city, regionid) VALUES('Kirishi', 33);
INSERT INTO cities(city, regionid) VALUES('Kirovsk', 33);
INSERT INTO cities(city, regionid) VALUES('Kommunar', 33);
INSERT INTO cities(city, regionid) VALUES('Lodeynoye Pole', 33);
INSERT INTO cities(city, regionid) VALUES('Luga', 33);
INSERT INTO cities(city, regionid) VALUES('Lyuban', 33);
INSERT INTO cities(city, regionid) VALUES('Nikolskoye', 33);
INSERT INTO cities(city, regionid) VALUES('Novaya Ladoga', 33);
INSERT INTO cities(city, regionid) VALUES('Otradnoye', 33);
INSERT INTO cities(city, regionid) VALUES('Pikalyovo', 33);
INSERT INTO cities(city, regionid) VALUES('Podporozhye', 33);
INSERT INTO cities(city, regionid) VALUES('Primorsk', 33);
INSERT INTO cities(city, regionid) VALUES('Priozersk', 33);
INSERT INTO cities(city, regionid) VALUES('Sertolovo', 33);
INSERT INTO cities(city, regionid) VALUES('Shlisselburg', 33);
INSERT INTO cities(city, regionid) VALUES('Slantsy', 33);
INSERT INTO cities(city, regionid) VALUES('Sosnovy Bor', 33);
INSERT INTO cities(city, regionid) VALUES('Svetogorsk', 33);
INSERT INTO cities(city, regionid) VALUES('Syasstroy', 33);
INSERT INTO cities(city, regionid) VALUES('Tikhvin', 33);
INSERT INTO cities(city, regionid) VALUES('Tosno', 33);
INSERT INTO cities(city, regionid) VALUES('Volkhov', 33);
INSERT INTO cities(city, regionid) VALUES('Volosovo', 33);
INSERT INTO cities(city, regionid) VALUES('Vsevolozhsk', 33);
INSERT INTO cities(city, regionid) VALUES('Vyborg', 33);
INSERT INTO cities(city, regionid) VALUES('Vysotsk', 33);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Dankov', 34);
INSERT INTO cities(city, regionid) VALUES('Gryazi', 34);
INSERT INTO cities(city, regionid) VALUES('Lebedyan', 34);
INSERT INTO cities(city, regionid) VALUES('Lipetsk', 34);
INSERT INTO cities(city, regionid) VALUES('Usman', 34);
INSERT INTO cities(city, regionid) VALUES('Yelets', 34);
INSERT INTO cities(city, regionid) VALUES('Zadonsk', 34);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Susuman', 35);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Volzhsk', 36);
INSERT INTO cities(city, regionid) VALUES('Yoshkar-Ola', 36);
INSERT INTO cities(city, regionid) VALUES('Zvenigovo', 36);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Moscow', 37);
INSERT INTO cities(city, regionid) VALUES('Troitsk', 37);
INSERT INTO cities(city, regionid) VALUES('Zelenograd', 37);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Balashikha', 38);
INSERT INTO cities(city, regionid) VALUES('Bronnitsy', 38);
INSERT INTO cities(city, regionid) VALUES('Chekhov', 38);
INSERT INTO cities(city, regionid) VALUES('Chernogolovka', 38);
INSERT INTO cities(city, regionid) VALUES('Dedovsk', 38);
INSERT INTO cities(city, regionid) VALUES('Dmitrov', 38);
INSERT INTO cities(city, regionid) VALUES('Dolgoprudny', 38);
INSERT INTO cities(city, regionid) VALUES('Domodedovo', 38);
INSERT INTO cities(city, regionid) VALUES('Drezna', 38);
INSERT INTO cities(city, regionid) VALUES('Dubna', 38);
INSERT INTO cities(city, regionid) VALUES('Dzerzhinsky', 38);
INSERT INTO cities(city, regionid) VALUES('Elektrogorsk', 38);
INSERT INTO cities(city, regionid) VALUES('Elektrostal', 38);
INSERT INTO cities(city, regionid) VALUES('Elektrougli', 38);
INSERT INTO cities(city, regionid) VALUES('Fryazino', 38);
INSERT INTO cities(city, regionid) VALUES('Golitsyno', 38);
INSERT INTO cities(city, regionid) VALUES('Istra', 38);
INSERT INTO cities(city, regionid) VALUES('Ivanteyevka', 38);
INSERT INTO cities(city, regionid) VALUES('Kashira', 38);
INSERT INTO cities(city, regionid) VALUES('Khimki', 38);
INSERT INTO cities(city, regionid) VALUES('Khotkovo', 38);
INSERT INTO cities(city, regionid) VALUES('Klimovsk', 38);
INSERT INTO cities(city, regionid) VALUES('Klin', 38);
INSERT INTO cities(city, regionid) VALUES('Kolomna', 38);
INSERT INTO cities(city, regionid) VALUES('Korolyov', 38);
INSERT INTO cities(city, regionid) VALUES('Kotelniki', 38);
INSERT INTO cities(city, regionid) VALUES('Krasnoarmeysk', 38);
INSERT INTO cities(city, regionid) VALUES('Krasnogorsk', 38);
INSERT INTO cities(city, regionid) VALUES('Krasnozavodsk', 38);
INSERT INTO cities(city, regionid) VALUES('Krasnoznamensk', 38);
INSERT INTO cities(city, regionid) VALUES('Kubinka', 38);
INSERT INTO cities(city, regionid) VALUES('Kurovskoye', 38);
INSERT INTO cities(city, regionid) VALUES('Likino-Dulyovo', 38);
INSERT INTO cities(city, regionid) VALUES('Lobnya', 38);
INSERT INTO cities(city, regionid) VALUES('Losino-Petrovsky', 38);
INSERT INTO cities(city, regionid) VALUES('Lukhovitsy', 38);
INSERT INTO cities(city, regionid) VALUES('Lytkarino', 38);
INSERT INTO cities(city, regionid) VALUES('Lyubertsy', 38);
INSERT INTO cities(city, regionid) VALUES('Mozhaysk', 38);
INSERT INTO cities(city, regionid) VALUES('Mytishchi', 38);
INSERT INTO cities(city, regionid) VALUES('Naro-Fominsk', 38);
INSERT INTO cities(city, regionid) VALUES('Noginsk', 38);
INSERT INTO cities(city, regionid) VALUES('Odintsovo', 38);
INSERT INTO cities(city, regionid) VALUES('Orekhovo-Zuyevo', 38);
INSERT INTO cities(city, regionid) VALUES('Ozherelye', 38);
INSERT INTO cities(city, regionid) VALUES('Ozyory', 38);
INSERT INTO cities(city, regionid) VALUES('Pavlovsky Posad', 38);
INSERT INTO cities(city, regionid) VALUES('Peresvet', 38);
INSERT INTO cities(city, regionid) VALUES('Podolsk', 38);
INSERT INTO cities(city, regionid) VALUES('Protvino', 38);
INSERT INTO cities(city, regionid) VALUES('Pushchino', 38);
INSERT INTO cities(city, regionid) VALUES('Pushkino', 38);
INSERT INTO cities(city, regionid) VALUES('Ramenskoye', 38);
INSERT INTO cities(city, regionid) VALUES('Reutov', 38);
INSERT INTO cities(city, regionid) VALUES('Roshal', 38);
INSERT INTO cities(city, regionid) VALUES('Ruza', 38);
INSERT INTO cities(city, regionid) VALUES('Sergiyev Posad', 38);
INSERT INTO cities(city, regionid) VALUES('Serpukhov', 38);
INSERT INTO cities(city, regionid) VALUES('Shatura', 38);
INSERT INTO cities(city, regionid) VALUES('Shcherbinka', 38);
INSERT INTO cities(city, regionid) VALUES('Shchyolkovo', 38);
INSERT INTO cities(city, regionid) VALUES('Solnechnogorsk', 38);
INSERT INTO cities(city, regionid) VALUES('Staraya Kupavna', 38);
INSERT INTO cities(city, regionid) VALUES('Stupino', 38);
INSERT INTO cities(city, regionid) VALUES('Taldom', 38);
INSERT INTO cities(city, regionid) VALUES('Vereya', 38);
INSERT INTO cities(city, regionid) VALUES('Vidnoye', 38);
INSERT INTO cities(city, regionid) VALUES('Volokolamsk', 38);
INSERT INTO cities(city, regionid) VALUES('Voskresensk', 38);
INSERT INTO cities(city, regionid) VALUES('Vysokovsk', 38);
INSERT INTO cities(city, regionid) VALUES('Yakhroma', 38);
INSERT INTO cities(city, regionid) VALUES('Yegoryevsk', 38);
INSERT INTO cities(city, regionid) VALUES('Yubileyny', 38);
INSERT INTO cities(city, regionid) VALUES('Zaraysk', 38);
INSERT INTO cities(city, regionid) VALUES('Zheleznodorozhny', 38);
INSERT INTO cities(city, regionid) VALUES('Zhukovsky', 38);
INSERT INTO cities(city, regionid) VALUES('Zvenigorod', 38);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Gadzhiyevo', 39);
INSERT INTO cities(city, regionid) VALUES('Kandalaksha', 39);
INSERT INTO cities(city, regionid) VALUES('Kirovsk', 39);
INSERT INTO cities(city, regionid) VALUES('Kola', 39);
INSERT INTO cities(city, regionid) VALUES('Kovdor', 39);
INSERT INTO cities(city, regionid) VALUES('Monchegorsk', 39);
INSERT INTO cities(city, regionid) VALUES('Murmansk', 39);
INSERT INTO cities(city, regionid) VALUES('Olenegorsk', 39);
INSERT INTO cities(city, regionid) VALUES('Ostrovnoy', 39);
INSERT INTO cities(city, regionid) VALUES('Polyarny', 39);
INSERT INTO cities(city, regionid) VALUES('Polyarnye Zori', 39);
INSERT INTO cities(city, regionid) VALUES('Severomorsk', 39);
INSERT INTO cities(city, regionid) VALUES('Snezhnogorsk', 39);
INSERT INTO cities(city, regionid) VALUES('Zaozyorsk', 39);
INSERT INTO cities(city, regionid) VALUES('Zapolyarny', 39);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Balakhna', 40);
INSERT INTO cities(city, regionid) VALUES('Bogorodsk', 40);
INSERT INTO cities(city, regionid) VALUES('Bor', 40);
INSERT INTO cities(city, regionid) VALUES('Chkalovsk', 40);
INSERT INTO cities(city, regionid) VALUES('Dzerzhinsk', 40);
INSERT INTO cities(city, regionid) VALUES('Gorbatov', 40);
INSERT INTO cities(city, regionid) VALUES('Gorodets', 40);
INSERT INTO cities(city, regionid) VALUES('Knyaginino', 40);
INSERT INTO cities(city, regionid) VALUES('Kstovo', 40);
INSERT INTO cities(city, regionid) VALUES('Kulebaki', 40);
INSERT INTO cities(city, regionid) VALUES('Lukoyanov', 40);
INSERT INTO cities(city, regionid) VALUES('Lyskovo', 40);
INSERT INTO cities(city, regionid) VALUES('Navashino', 40);
INSERT INTO cities(city, regionid) VALUES('Nizhny Novgorod', 40);
INSERT INTO cities(city, regionid) VALUES('Pavlovo', 40);
INSERT INTO cities(city, regionid) VALUES('Perevoz', 40);
INSERT INTO cities(city, regionid) VALUES('Pervomaysk', 40);
INSERT INTO cities(city, regionid) VALUES('Sarov', 40);
INSERT INTO cities(city, regionid) VALUES('Semyonov', 40);
INSERT INTO cities(city, regionid) VALUES('Sergach', 40);
INSERT INTO cities(city, regionid) VALUES('Shakhunya', 40);
INSERT INTO cities(city, regionid) VALUES('Uren', 40);
INSERT INTO cities(city, regionid) VALUES('Vetluga', 40);
INSERT INTO cities(city, regionid) VALUES('Volodarsk', 40);
INSERT INTO cities(city, regionid) VALUES('Vorsma', 40);
INSERT INTO cities(city, regionid) VALUES('Vyksa', 40);
INSERT INTO cities(city, regionid) VALUES('Zavolzhye', 40);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Chudovo', 41);
INSERT INTO cities(city, regionid) VALUES('Kholm', 41);
INSERT INTO cities(city, regionid) VALUES('Malaya Vishera', 41);
INSERT INTO cities(city, regionid) VALUES('Okulovka', 41);
INSERT INTO cities(city, regionid) VALUES('Pestovo', 41);
INSERT INTO cities(city, regionid) VALUES('Soltsy', 41);
INSERT INTO cities(city, regionid) VALUES('Staraya Russa', 41);
INSERT INTO cities(city, regionid) VALUES('Valday', 41);
INSERT INTO cities(city, regionid) VALUES('Veliky Novgorod', 41);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Berdsk', 42);
INSERT INTO cities(city, regionid) VALUES('Bolotnoye', 42);
INSERT INTO cities(city, regionid) VALUES('Cherepanovo', 42);
INSERT INTO cities(city, regionid) VALUES('Chulym', 42);
INSERT INTO cities(city, regionid) VALUES('Iskitim', 42);
INSERT INTO cities(city, regionid) VALUES('Karasuk', 42);
INSERT INTO cities(city, regionid) VALUES('Kargat', 42);
INSERT INTO cities(city, regionid) VALUES('Kupino', 42);
INSERT INTO cities(city, regionid) VALUES('Kuybyshev', 42);
INSERT INTO cities(city, regionid) VALUES('Novosibirsk', 42);
INSERT INTO cities(city, regionid) VALUES('Ob', 42);
INSERT INTO cities(city, regionid) VALUES('Tatarsk', 42);
INSERT INTO cities(city, regionid) VALUES('Toguchin', 42);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Kalachinsk', 43);
INSERT INTO cities(city, regionid) VALUES('Nazyvayevsk', 43);
INSERT INTO cities(city, regionid) VALUES('Omsk', 43);
INSERT INTO cities(city, regionid) VALUES('Tara', 43);
INSERT INTO cities(city, regionid) VALUES('Tyukalinsk', 43);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Buguruslan', 44);
INSERT INTO cities(city, regionid) VALUES('Buzuluk', 44);
INSERT INTO cities(city, regionid) VALUES('Gay', 44);
INSERT INTO cities(city, regionid) VALUES('Kuvandyk', 44);
INSERT INTO cities(city, regionid) VALUES('Mednogorsk', 44);
INSERT INTO cities(city, regionid) VALUES('Novotroitsk', 44);
INSERT INTO cities(city, regionid) VALUES('Orenburg', 44);
INSERT INTO cities(city, regionid) VALUES('Orsk', 44);
INSERT INTO cities(city, regionid) VALUES('Sol-Iletsk', 44);
INSERT INTO cities(city, regionid) VALUES('Sorochinsk', 44);
INSERT INTO cities(city, regionid) VALUES('Yasny', 44);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Dmitrovsk', 45);
INSERT INTO cities(city, regionid) VALUES('Livny', 45);
INSERT INTO cities(city, regionid) VALUES('Maloarkhangelsk', 45);
INSERT INTO cities(city, regionid) VALUES('Mtsensk', 45);
INSERT INTO cities(city, regionid) VALUES('Novosil', 45);
INSERT INTO cities(city, regionid) VALUES('Oryol', 45);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Gorodishche', 46);
INSERT INTO cities(city, regionid) VALUES('Kamenka', 46);
INSERT INTO cities(city, regionid) VALUES('Kuznetsk', 46);
INSERT INTO cities(city, regionid) VALUES('Nikolsk', 46);
INSERT INTO cities(city, regionid) VALUES('Nizhny Lomov', 46);
INSERT INTO cities(city, regionid) VALUES('Penza', 46);
INSERT INTO cities(city, regionid) VALUES('Serdobsk', 46);
INSERT INTO cities(city, regionid) VALUES('Spassk', 46);
INSERT INTO cities(city, regionid) VALUES('Sursk', 46);
INSERT INTO cities(city, regionid) VALUES('Zarechny', 46);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Berezniki', 47);
INSERT INTO cities(city, regionid) VALUES('Chaykovsky', 47);
INSERT INTO cities(city, regionid) VALUES('Cherdyn', 47);
INSERT INTO cities(city, regionid) VALUES('Chernushka', 47);
INSERT INTO cities(city, regionid) VALUES('Chusovoy', 47);
INSERT INTO cities(city, regionid) VALUES('Chyormoz', 47);
INSERT INTO cities(city, regionid) VALUES('Dobryanka', 47);
INSERT INTO cities(city, regionid) VALUES('Gornozavodsk', 47);
INSERT INTO cities(city, regionid) VALUES('Gremyachinsk', 47);
INSERT INTO cities(city, regionid) VALUES('Gubakha', 47);
INSERT INTO cities(city, regionid) VALUES('Kizel', 47);
INSERT INTO cities(city, regionid) VALUES('Krasnokamsk', 47);
INSERT INTO cities(city, regionid) VALUES('Krasnovishersk', 47);
INSERT INTO cities(city, regionid) VALUES('Kudymkar', 47);
INSERT INTO cities(city, regionid) VALUES('Kungur', 47);
INSERT INTO cities(city, regionid) VALUES('Lysva', 47);
INSERT INTO cities(city, regionid) VALUES('Nytva', 47);
INSERT INTO cities(city, regionid) VALUES('Ochyor', 47);
INSERT INTO cities(city, regionid) VALUES('Okhansk', 47);
INSERT INTO cities(city, regionid) VALUES('Osa', 47);
INSERT INTO cities(city, regionid) VALUES('Perm', 47);
INSERT INTO cities(city, regionid) VALUES('Solikamsk', 47);
INSERT INTO cities(city, regionid) VALUES('Usolye', 47);
INSERT INTO cities(city, regionid) VALUES('Vereshchagino', 47);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Artyom', 48);
INSERT INTO cities(city, regionid) VALUES('Bolshoy Kamen', 48);
INSERT INTO cities(city, regionid) VALUES('Dalnegorsk', 48);
INSERT INTO cities(city, regionid) VALUES('Dalnerechensk', 48);
INSERT INTO cities(city, regionid) VALUES('Fokino', 48);
INSERT INTO cities(city, regionid) VALUES('Lesozavodsk', 48);
INSERT INTO cities(city, regionid) VALUES('Nakhodka', 48);
INSERT INTO cities(city, regionid) VALUES('Partizansk', 48);
INSERT INTO cities(city, regionid) VALUES('Spassk-Dalny', 48);
INSERT INTO cities(city, regionid) VALUES('Ussuriysk', 48);
INSERT INTO cities(city, regionid) VALUES('Vladivostok', 48);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Gdov', 49);
INSERT INTO cities(city, regionid) VALUES('Nevel', 49);
INSERT INTO cities(city, regionid) VALUES('Novorzhev', 49);
INSERT INTO cities(city, regionid) VALUES('Novosokolniki', 49);
INSERT INTO cities(city, regionid) VALUES('Opochka', 49);
INSERT INTO cities(city, regionid) VALUES('Ostrov', 49);
INSERT INTO cities(city, regionid) VALUES('Pechory', 49);
INSERT INTO cities(city, regionid) VALUES('Porkhov', 49);
INSERT INTO cities(city, regionid) VALUES('Pskov', 49);
INSERT INTO cities(city, regionid) VALUES('Pustoshka', 49);
INSERT INTO cities(city, regionid) VALUES('Pytalovo', 49);
INSERT INTO cities(city, regionid) VALUES('Sebezh', 49);
INSERT INTO cities(city, regionid) VALUES('Velikiye Luki', 49);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Maykop', 50);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Baymak', 51);
INSERT INTO cities(city, regionid) VALUES('Belebey', 51);
INSERT INTO cities(city, regionid) VALUES('Beloretsk', 51);
INSERT INTO cities(city, regionid) VALUES('Birsk', 51);
INSERT INTO cities(city, regionid) VALUES('Blagoveshchensk', 51);
INSERT INTO cities(city, regionid) VALUES('Davlekanovo', 51);
INSERT INTO cities(city, regionid) VALUES('Dyurtyuli', 51);
INSERT INTO cities(city, regionid) VALUES('Ishimbay', 51);
INSERT INTO cities(city, regionid) VALUES('Kumertau', 51);
INSERT INTO cities(city, regionid) VALUES('Meleuz', 51);
INSERT INTO cities(city, regionid) VALUES('Mezhgorye', 51);
INSERT INTO cities(city, regionid) VALUES('Neftekamsk', 51);
INSERT INTO cities(city, regionid) VALUES('Oktyabrsky', 51);
INSERT INTO cities(city, regionid) VALUES('Salavat', 51);
INSERT INTO cities(city, regionid) VALUES('Sibay', 51);
INSERT INTO cities(city, regionid) VALUES('Sterlitamak', 51);
INSERT INTO cities(city, regionid) VALUES('Tuymazy', 51);
INSERT INTO cities(city, regionid) VALUES('Uchaly', 51);
INSERT INTO cities(city, regionid) VALUES('Ufa', 51);
INSERT INTO cities(city, regionid) VALUES('Yanaul', 51);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Gusinoozyorsk', 52);
INSERT INTO cities(city, regionid) VALUES('Kyakhta', 52);
INSERT INTO cities(city, regionid) VALUES('Severobaykalsk', 52);
INSERT INTO cities(city, regionid) VALUES('Ulan-Ude', 52);
INSERT INTO cities(city, regionid) VALUES('Zakamensk', 52);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Abaza', 53);
INSERT INTO cities(city, regionid) VALUES('Chernogorsk', 53);
INSERT INTO cities(city, regionid) VALUES('Sayanogorsk', 53);
INSERT INTO cities(city, regionid) VALUES('Sorsk', 53);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Insar', 54);
INSERT INTO cities(city, regionid) VALUES('Kovylkino', 54);
INSERT INTO cities(city, regionid) VALUES('Krasnoslobodsk', 54);
INSERT INTO cities(city, regionid) VALUES('Ruzayevka', 54);
INSERT INTO cities(city, regionid) VALUES('Saransk', 54);
INSERT INTO cities(city, regionid) VALUES('Temnikov', 54);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Ardon', 55);
INSERT INTO cities(city, regionid) VALUES('Beslan', 55);
INSERT INTO cities(city, regionid) VALUES('Digora', 55);
INSERT INTO cities(city, regionid) VALUES('Mozdok', 55);
INSERT INTO cities(city, regionid) VALUES('Vladikavkaz', 55);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Almetyevsk', 56);
INSERT INTO cities(city, regionid) VALUES('Aznakayevo', 56);
INSERT INTO cities(city, regionid) VALUES('Bavly', 56);
INSERT INTO cities(city, regionid) VALUES('Bolgar', 56);
INSERT INTO cities(city, regionid) VALUES('Bugulma', 56);
INSERT INTO cities(city, regionid) VALUES('Buinsk', 56);
INSERT INTO cities(city, regionid) VALUES('Chistopol', 56);
INSERT INTO cities(city, regionid) VALUES('Innopolis', 56);
INSERT INTO cities(city, regionid) VALUES('Kazan', 56);
INSERT INTO cities(city, regionid) VALUES('Laishevo', 56);
INSERT INTO cities(city, regionid) VALUES('Leninogorsk', 56);
INSERT INTO cities(city, regionid) VALUES('Mamadysh', 56);
INSERT INTO cities(city, regionid) VALUES('Mendeleyevsk', 56);
INSERT INTO cities(city, regionid) VALUES('Menzelinsk', 56);
INSERT INTO cities(city, regionid) VALUES('Naberezhnye Chelny', 56);
INSERT INTO cities(city, regionid) VALUES('Nizhnekamsk', 56);
INSERT INTO cities(city, regionid) VALUES('Nurlat', 56);
INSERT INTO cities(city, regionid) VALUES('Tetyushi', 56);
INSERT INTO cities(city, regionid) VALUES('Yelabuga', 56);
INSERT INTO cities(city, regionid) VALUES('Zainsk', 56);
INSERT INTO cities(city, regionid) VALUES('Zelenodolsk', 56);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Azov', 57);
INSERT INTO cities(city, regionid) VALUES('Bataysk', 57);
INSERT INTO cities(city, regionid) VALUES('Belaya Kalitva', 57);
INSERT INTO cities(city, regionid) VALUES('Donetsk', 57);
INSERT INTO cities(city, regionid) VALUES('Gukovo', 57);
INSERT INTO cities(city, regionid) VALUES('Kamensk-Shakhtinsky', 57);
INSERT INTO cities(city, regionid) VALUES('Konstantinovsk', 57);
INSERT INTO cities(city, regionid) VALUES('Krasny Sulin', 57);
INSERT INTO cities(city, regionid) VALUES('Millerovo', 57);
INSERT INTO cities(city, regionid) VALUES('Morozovsk', 57);
INSERT INTO cities(city, regionid) VALUES('Novocherkassk', 57);
INSERT INTO cities(city, regionid) VALUES('Novoshakhtinsk', 57);
INSERT INTO cities(city, regionid) VALUES('Proletarsk', 57);
INSERT INTO cities(city, regionid) VALUES('Rostov-on-Don', 57);
INSERT INTO cities(city, regionid) VALUES('Salsk', 57);
INSERT INTO cities(city, regionid) VALUES('Semikarakorsk', 57);
INSERT INTO cities(city, regionid) VALUES('Shakhty', 57);
INSERT INTO cities(city, regionid) VALUES('Taganrog', 57);
INSERT INTO cities(city, regionid) VALUES('Tsimlyansk', 57);
INSERT INTO cities(city, regionid) VALUES('Volgodonsk', 57);
INSERT INTO cities(city, regionid) VALUES('Zernograd', 57);
INSERT INTO cities(city, regionid) VALUES('Zverevo', 57);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Korablino', 58);
INSERT INTO cities(city, regionid) VALUES('Mikhaylov', 58);
INSERT INTO cities(city, regionid) VALUES('Novomichurinsk', 58);
INSERT INTO cities(city, regionid) VALUES('Ryazan', 58);
INSERT INTO cities(city, regionid) VALUES('Ryazhsk', 58);
INSERT INTO cities(city, regionid) VALUES('Rybnoye', 58);
INSERT INTO cities(city, regionid) VALUES('Sasovo', 58);
INSERT INTO cities(city, regionid) VALUES('Shatsk', 58);
INSERT INTO cities(city, regionid) VALUES('Skopin', 58);
INSERT INTO cities(city, regionid) VALUES('Spas-Klepiki', 58);
INSERT INTO cities(city, regionid) VALUES('Spassk-Ryazansky', 58);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Krasnoye Selo', 59);
INSERT INTO cities(city, regionid) VALUES('Kronstadt', 59);
INSERT INTO cities(city, regionid) VALUES('Lomonosov', 59);
INSERT INTO cities(city, regionid) VALUES('Pavlovsk', 59);
INSERT INTO cities(city, regionid) VALUES('Petergof', 59);
INSERT INTO cities(city, regionid) VALUES('Pushkin', 59);
INSERT INTO cities(city, regionid) VALUES('Saint Petersburg', 59);
INSERT INTO cities(city, regionid) VALUES('Sestroretsk', 59);
INSERT INTO cities(city, regionid) VALUES('Zelenogorsk', 59);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Lensk', 60);
INSERT INTO cities(city, regionid) VALUES('Mirny', 60);
INSERT INTO cities(city, regionid) VALUES('Neryungri', 60);
INSERT INTO cities(city, regionid) VALUES('Nyurba', 60);
INSERT INTO cities(city, regionid) VALUES('Olyokminsk', 60);
INSERT INTO cities(city, regionid) VALUES('Pokrovsk', 60);
INSERT INTO cities(city, regionid) VALUES('Srednekolymsk', 60);
INSERT INTO cities(city, regionid) VALUES('Tommot', 60);
INSERT INTO cities(city, regionid) VALUES('Udachny', 60);
INSERT INTO cities(city, regionid) VALUES('Verkhoyansk', 60);
INSERT INTO cities(city, regionid) VALUES('Vilyuysk', 60);
INSERT INTO cities(city, regionid) VALUES('Yakutsk', 60);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Aniva', 61);
INSERT INTO cities(city, regionid) VALUES('Dolinsk', 61);
INSERT INTO cities(city, regionid) VALUES('Kholmsk', 61);
INSERT INTO cities(city, regionid) VALUES('Korsakov', 61);
INSERT INTO cities(city, regionid) VALUES('Kurilsk', 61);
INSERT INTO cities(city, regionid) VALUES('Makarov', 61);
INSERT INTO cities(city, regionid) VALUES('Nevelsk', 61);
INSERT INTO cities(city, regionid) VALUES('Okha', 61);
INSERT INTO cities(city, regionid) VALUES('Poronaysk', 61);
INSERT INTO cities(city, regionid) VALUES('Severo-Kurilsk', 61);
INSERT INTO cities(city, regionid) VALUES('Shakhtyorsk', 61);
INSERT INTO cities(city, regionid) VALUES('Tomari', 61);
INSERT INTO cities(city, regionid) VALUES('Uglegorsk', 61);
INSERT INTO cities(city, regionid) VALUES('Yuzhno-Sakhalinsk', 61);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Kinel', 62);
INSERT INTO cities(city, regionid) VALUES('Neftegorsk, Samara Oblast', 62);
INSERT INTO cities(city, regionid) VALUES('Novokuybyshevsk', 62);
INSERT INTO cities(city, regionid) VALUES('Oktyabrsk', 62);
INSERT INTO cities(city, regionid) VALUES('Otradny', 62);
INSERT INTO cities(city, regionid) VALUES('Pokhvistnevo', 62);
INSERT INTO cities(city, regionid) VALUES('Samara', 62);
INSERT INTO cities(city, regionid) VALUES('Syzran', 62);
INSERT INTO cities(city, regionid) VALUES('Tolyatti', 62);
INSERT INTO cities(city, regionid) VALUES('Zhigulyovsk', 62);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Atkarsk', 63);
INSERT INTO cities(city, regionid) VALUES('Balakovo', 63);
INSERT INTO cities(city, regionid) VALUES('Balashov', 63);
INSERT INTO cities(city, regionid) VALUES('Engels', 63);
INSERT INTO cities(city, regionid) VALUES('Kalininsk', 63);
INSERT INTO cities(city, regionid) VALUES('Khvalynsk', 63);
INSERT INTO cities(city, regionid) VALUES('Krasnoarmeysk', 63);
INSERT INTO cities(city, regionid) VALUES('Krasny Kut', 63);
INSERT INTO cities(city, regionid) VALUES('Marks', 63);
INSERT INTO cities(city, regionid) VALUES('Novouzensk', 63);
INSERT INTO cities(city, regionid) VALUES('Petrovsk', 63);
INSERT INTO cities(city, regionid) VALUES('Pugachyov', 63);
INSERT INTO cities(city, regionid) VALUES('Rtishchevo', 63);
INSERT INTO cities(city, regionid) VALUES('Saratov', 63);
INSERT INTO cities(city, regionid) VALUES('Shikhany', 63);
INSERT INTO cities(city, regionid) VALUES('Volsk', 63);
INSERT INTO cities(city, regionid) VALUES('Yershov', 63);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Desnogorsk', 64);
INSERT INTO cities(city, regionid) VALUES('Dorogobuzh', 64);
INSERT INTO cities(city, regionid) VALUES('Dukhovshchina', 64);
INSERT INTO cities(city, regionid) VALUES('Gagarin', 64);
INSERT INTO cities(city, regionid) VALUES('Pochinok', 64);
INSERT INTO cities(city, regionid) VALUES('Roslavl', 64);
INSERT INTO cities(city, regionid) VALUES('Rudnya', 64);
INSERT INTO cities(city, regionid) VALUES('Safonovo', 64);
INSERT INTO cities(city, regionid) VALUES('Smolensk', 64);
INSERT INTO cities(city, regionid) VALUES('Sychyovka', 64);
INSERT INTO cities(city, regionid) VALUES('Velizh', 64);
INSERT INTO cities(city, regionid) VALUES('Vyazma', 64);
INSERT INTO cities(city, regionid) VALUES('Yartsevo', 64);
INSERT INTO cities(city, regionid) VALUES('Yelnya', 64);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Budyonnovsk', 65);
INSERT INTO cities(city, regionid) VALUES('Georgiyevsk', 65);
INSERT INTO cities(city, regionid) VALUES('Ipatovo', 65);
INSERT INTO cities(city, regionid) VALUES('Izobilny', 65);
INSERT INTO cities(city, regionid) VALUES('Kislovodsk', 65);
INSERT INTO cities(city, regionid) VALUES('Lermontov', 65);
INSERT INTO cities(city, regionid) VALUES('Mikhaylovsk', 65);
INSERT INTO cities(city, regionid) VALUES('Mineralnye Vody', 65);
INSERT INTO cities(city, regionid) VALUES('Neftekumsk', 65);
INSERT INTO cities(city, regionid) VALUES('Nevinnomyssk', 65);
INSERT INTO cities(city, regionid) VALUES('Novoalexandrovsk', 65);
INSERT INTO cities(city, regionid) VALUES('Novopavlovsk', 65);
INSERT INTO cities(city, regionid) VALUES('Pyatigorsk', 65);
INSERT INTO cities(city, regionid) VALUES('Stavropol', 65);
INSERT INTO cities(city, regionid) VALUES('Svetlograd', 65);
INSERT INTO cities(city, regionid) VALUES('Yessentuki', 65);
INSERT INTO cities(city, regionid) VALUES('Zelenokumsk', 65);
INSERT INTO cities(city, regionid) VALUES('Zheleznovodsk', 65);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Aramil', 66);
INSERT INTO cities(city, regionid) VALUES('Artyomovsky', 66);
INSERT INTO cities(city, regionid) VALUES('Asbest', 66);
INSERT INTO cities(city, regionid) VALUES('Berezovsky', 66);
INSERT INTO cities(city, regionid) VALUES('Bogdanovich', 66);
INSERT INTO cities(city, regionid) VALUES('Degtyarsk', 66);
INSERT INTO cities(city, regionid) VALUES('Irbit', 66);
INSERT INTO cities(city, regionid) VALUES('Ivdel', 66);
INSERT INTO cities(city, regionid) VALUES('Kachkanar', 66);
INSERT INTO cities(city, regionid) VALUES('Kamensk-Uralsky', 66);
INSERT INTO cities(city, regionid) VALUES('Kamyshlov', 66);
INSERT INTO cities(city, regionid) VALUES('Karpinsk', 66);
INSERT INTO cities(city, regionid) VALUES('Kirovgrad', 66);
INSERT INTO cities(city, regionid) VALUES('Krasnoturyinsk', 66);
INSERT INTO cities(city, regionid) VALUES('Krasnoufimsk', 66);
INSERT INTO cities(city, regionid) VALUES('Krasnouralsk', 66);
INSERT INTO cities(city, regionid) VALUES('Kushva', 66);
INSERT INTO cities(city, regionid) VALUES('Lesnoy', 66);
INSERT INTO cities(city, regionid) VALUES('Mikhaylovsk', 66);
INSERT INTO cities(city, regionid) VALUES('Nevyansk', 66);
INSERT INTO cities(city, regionid) VALUES('Nizhniye Sergi', 66);
INSERT INTO cities(city, regionid) VALUES('Nizhny Tagil', 66);
INSERT INTO cities(city, regionid) VALUES('Nizhnyaya Salda', 66);
INSERT INTO cities(city, regionid) VALUES('Nizhnyaya Tura', 66);
INSERT INTO cities(city, regionid) VALUES('Novaya Lyalya', 66);
INSERT INTO cities(city, regionid) VALUES('Novouralsk', 66);
INSERT INTO cities(city, regionid) VALUES('Pervouralsk', 66);
INSERT INTO cities(city, regionid) VALUES('Polevskoy', 66);
INSERT INTO cities(city, regionid) VALUES('Revda', 66);
INSERT INTO cities(city, regionid) VALUES('Rezh', 66);
INSERT INTO cities(city, regionid) VALUES('Serov', 66);
INSERT INTO cities(city, regionid) VALUES('Severouralsk', 66);
INSERT INTO cities(city, regionid) VALUES('Sredneuralsk', 66);
INSERT INTO cities(city, regionid) VALUES('Sukhoy Log', 66);
INSERT INTO cities(city, regionid) VALUES('Sysert', 66);
INSERT INTO cities(city, regionid) VALUES('Talitsa', 66);
INSERT INTO cities(city, regionid) VALUES('Tavda', 66);
INSERT INTO cities(city, regionid) VALUES('Turinsk', 66);
INSERT INTO cities(city, regionid) VALUES('Verkhny Tagil', 66);
INSERT INTO cities(city, regionid) VALUES('Verkhnyaya Pyshma', 66);
INSERT INTO cities(city, regionid) VALUES('Verkhnyaya Salda', 66);
INSERT INTO cities(city, regionid) VALUES('Verkhnyaya Tura', 66);
INSERT INTO cities(city, regionid) VALUES('Verkhoturye', 66);
INSERT INTO cities(city, regionid) VALUES('Volchansk', 66);
INSERT INTO cities(city, regionid) VALUES('Yekaterinburg', 66);
INSERT INTO cities(city, regionid) VALUES('Zarechny', 66);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Kotovsk', 67);
INSERT INTO cities(city, regionid) VALUES('Michurinsk', 67);
INSERT INTO cities(city, regionid) VALUES('Morshansk', 67);
INSERT INTO cities(city, regionid) VALUES('Rasskazovo', 67);
INSERT INTO cities(city, regionid) VALUES('Tambov', 67);
INSERT INTO cities(city, regionid) VALUES('Uvarovo', 67);
INSERT INTO cities(city, regionid) VALUES('Zherdevka', 67);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Kedrovy', 68);
INSERT INTO cities(city, regionid) VALUES('Kolpashevo', 68);
INSERT INTO cities(city, regionid) VALUES('Seversk', 68);
INSERT INTO cities(city, regionid) VALUES('Strezhevoy', 68);
INSERT INTO cities(city, regionid) VALUES('Tomsk', 68);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Belyov', 69);
INSERT INTO cities(city, regionid) VALUES('Bogoroditsk', 69);
INSERT INTO cities(city, regionid) VALUES('Bolokhovo', 69);
INSERT INTO cities(city, regionid) VALUES('Chekalin', 69);
INSERT INTO cities(city, regionid) VALUES('Donskoy', 69);
INSERT INTO cities(city, regionid) VALUES('Kimovsk', 69);
INSERT INTO cities(city, regionid) VALUES('Kireyevsk', 69);
INSERT INTO cities(city, regionid) VALUES('Lipki', 69);
INSERT INTO cities(city, regionid) VALUES('Novomoskovsk', 69);
INSERT INTO cities(city, regionid) VALUES('Plavsk', 69);
INSERT INTO cities(city, regionid) VALUES('Shchyokino', 69);
INSERT INTO cities(city, regionid) VALUES('Sokolniki', 69);
INSERT INTO cities(city, regionid) VALUES('Sovetsk', 69);
INSERT INTO cities(city, regionid) VALUES('Suvorov', 69);
INSERT INTO cities(city, regionid) VALUES('Tula', 69);
INSERT INTO cities(city, regionid) VALUES('Uzlovaya', 69);
INSERT INTO cities(city, regionid) VALUES('Venyov', 69);
INSERT INTO cities(city, regionid) VALUES('Yasnogorsk', 69);
INSERT INTO cities(city, regionid) VALUES('Yefremov', 69);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Chadan', 70);
INSERT INTO cities(city, regionid) VALUES('Kyzyl', 70);
INSERT INTO cities(city, regionid) VALUES('Shagonar', 70);
INSERT INTO cities(city, regionid) VALUES('Turan', 70);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Bely', 71);
INSERT INTO cities(city, regionid) VALUES('Bezhetsk', 71);
INSERT INTO cities(city, regionid) VALUES('Bologoye', 71);
INSERT INTO cities(city, regionid) VALUES('Kalyazin', 71);
INSERT INTO cities(city, regionid) VALUES('Kashin', 71);
INSERT INTO cities(city, regionid) VALUES('Kimry', 71);
INSERT INTO cities(city, regionid) VALUES('Konakovo', 71);
INSERT INTO cities(city, regionid) VALUES('Krasny Kholm', 71);
INSERT INTO cities(city, regionid) VALUES('Kuvshinovo', 71);
INSERT INTO cities(city, regionid) VALUES('Likhoslavl', 71);
INSERT INTO cities(city, regionid) VALUES('Nelidovo', 71);
INSERT INTO cities(city, regionid) VALUES('Ostashkov', 71);
INSERT INTO cities(city, regionid) VALUES('Rzhev', 71);
INSERT INTO cities(city, regionid) VALUES('Staritsa', 71);
INSERT INTO cities(city, regionid) VALUES('Toropets', 71);
INSERT INTO cities(city, regionid) VALUES('Torzhok', 71);
INSERT INTO cities(city, regionid) VALUES('Tver', 71);
INSERT INTO cities(city, regionid) VALUES('Udomlya', 71);
INSERT INTO cities(city, regionid) VALUES('Vesyegonsk', 71);
INSERT INTO cities(city, regionid) VALUES('Vyshny Volochyok', 71);
INSERT INTO cities(city, regionid) VALUES('Zapadnaya Dvina', 71);
INSERT INTO cities(city, regionid) VALUES('Zubtsov', 71);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Tobolsk', 72);
INSERT INTO cities(city, regionid) VALUES('Tyumen', 72);
INSERT INTO cities(city, regionid) VALUES('Yalutorovsk', 72);
INSERT INTO cities(city, regionid) VALUES('Zavodoukovsk', 72);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Izhevsk', 73);
INSERT INTO cities(city, regionid) VALUES('Kambarka', 73);
INSERT INTO cities(city, regionid) VALUES('Mozhga', 73);
INSERT INTO cities(city, regionid) VALUES('Sarapul', 73);
INSERT INTO cities(city, regionid) VALUES('Votkinsk', 73);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Dimitrovgrad', 74);
INSERT INTO cities(city, regionid) VALUES('Inza', 74);
INSERT INTO cities(city, regionid) VALUES('Novoulyanovsk', 74);
INSERT INTO cities(city, regionid) VALUES('Sengiley', 74);
INSERT INTO cities(city, regionid) VALUES('Ulyanovsk', 74);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Gorokhovets', 75);
INSERT INTO cities(city, regionid) VALUES('Gus-Khrustalny', 75);
INSERT INTO cities(city, regionid) VALUES('Kameshkovo', 75);
INSERT INTO cities(city, regionid) VALUES('Karabanovo', 75);
INSERT INTO cities(city, regionid) VALUES('Kirzhach', 75);
INSERT INTO cities(city, regionid) VALUES('Kolchugino', 75);
INSERT INTO cities(city, regionid) VALUES('Kosteryovo', 75);
INSERT INTO cities(city, regionid) VALUES('Kovrov', 75);
INSERT INTO cities(city, regionid) VALUES('Kurlovo', 75);
INSERT INTO cities(city, regionid) VALUES('Lakinsk', 75);
INSERT INTO cities(city, regionid) VALUES('Melenki', 75);
INSERT INTO cities(city, regionid) VALUES('Murom', 75);
INSERT INTO cities(city, regionid) VALUES('Petushki', 75);
INSERT INTO cities(city, regionid) VALUES('Pokrov', 75);
INSERT INTO cities(city, regionid) VALUES('Raduzhny', 75);
INSERT INTO cities(city, regionid) VALUES('Sobinka', 75);
INSERT INTO cities(city, regionid) VALUES('Strunino', 75);
INSERT INTO cities(city, regionid) VALUES('Sudogda', 75);
INSERT INTO cities(city, regionid) VALUES('Suzdal', 75);
INSERT INTO cities(city, regionid) VALUES('Vladimir', 75);
INSERT INTO cities(city, regionid) VALUES('Vyazniki', 75);
INSERT INTO cities(city, regionid) VALUES('Yuryev-Polsky', 75);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Frolovo', 76);
INSERT INTO cities(city, regionid) VALUES('Kalach-na-Donu', 76);
INSERT INTO cities(city, regionid) VALUES('Kamyshin', 76);
INSERT INTO cities(city, regionid) VALUES('Kotelnikovo', 76);
INSERT INTO cities(city, regionid) VALUES('Kotovo', 76);
INSERT INTO cities(city, regionid) VALUES('Krasnoslobodsk', 76);
INSERT INTO cities(city, regionid) VALUES('Leninsk', 76);
INSERT INTO cities(city, regionid) VALUES('Mikhaylovka', 76);
INSERT INTO cities(city, regionid) VALUES('Nikolayevsk', 76);
INSERT INTO cities(city, regionid) VALUES('Novoanninsky', 76);
INSERT INTO cities(city, regionid) VALUES('Pallasovka', 76);
INSERT INTO cities(city, regionid) VALUES('Petrov Val', 76);
INSERT INTO cities(city, regionid) VALUES('Serafimovich', 76);
INSERT INTO cities(city, regionid) VALUES('Surovikino', 76);
INSERT INTO cities(city, regionid) VALUES('Uryupinsk', 76);
INSERT INTO cities(city, regionid) VALUES('Volgograd', 76);
INSERT INTO cities(city, regionid) VALUES('Volzhsky', 76);
INSERT INTO cities(city, regionid) VALUES('Zhirnovsk', 76);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Belozersk', 77);
INSERT INTO cities(city, regionid) VALUES('Cherepovets', 77);
INSERT INTO cities(city, regionid) VALUES('Gryazovets', 77);
INSERT INTO cities(city, regionid) VALUES('Kadnikov', 77);
INSERT INTO cities(city, regionid) VALUES('Kharovsk', 77);
INSERT INTO cities(city, regionid) VALUES('Kirillov', 77);
INSERT INTO cities(city, regionid) VALUES('Krasavino', 77);
INSERT INTO cities(city, regionid) VALUES('Nikolsk', 77);
INSERT INTO cities(city, regionid) VALUES('Sokol', 77);
INSERT INTO cities(city, regionid) VALUES('Totma', 77);
INSERT INTO cities(city, regionid) VALUES('Ustyuzhna', 77);
INSERT INTO cities(city, regionid) VALUES('Veliky Ustyug', 77);
INSERT INTO cities(city, regionid) VALUES('Vologda', 77);
INSERT INTO cities(city, regionid) VALUES('Vytegra', 77);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Boguchar', 78);
INSERT INTO cities(city, regionid) VALUES('Borisoglebsk', 78);
INSERT INTO cities(city, regionid) VALUES('Buturlinovka', 78);
INSERT INTO cities(city, regionid) VALUES('Ertil', 78);
INSERT INTO cities(city, regionid) VALUES('Kalach', 78);
INSERT INTO cities(city, regionid) VALUES('Liski', 78);
INSERT INTO cities(city, regionid) VALUES('Novokhopyorsk', 78);
INSERT INTO cities(city, regionid) VALUES('Novovoronezh', 78);
INSERT INTO cities(city, regionid) VALUES('Ostrogozhsk', 78);
INSERT INTO cities(city, regionid) VALUES('Pavlovsk', 78);
INSERT INTO cities(city, regionid) VALUES('Povorino', 78);
INSERT INTO cities(city, regionid) VALUES('Rossosh', 78);
INSERT INTO cities(city, regionid) VALUES('Semiluki', 78);
INSERT INTO cities(city, regionid) VALUES('Voronezh', 78);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Labytnangi', 79);
INSERT INTO cities(city, regionid) VALUES('Muravlenko', 79);
INSERT INTO cities(city, regionid) VALUES('Nadym', 79);
INSERT INTO cities(city, regionid) VALUES('Novy Urengoy', 79);
INSERT INTO cities(city, regionid) VALUES('Noyabrsk', 79);
INSERT INTO cities(city, regionid) VALUES('Salekhard', 79);
INSERT INTO cities(city, regionid) VALUES('Tarko-Sale', 79);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Gavrilov-Yam', 80);
INSERT INTO cities(city, regionid) VALUES('Lyubim', 80);
INSERT INTO cities(city, regionid) VALUES('Myshkin', 80);
INSERT INTO cities(city, regionid) VALUES('Pereslavl-Zalessky', 80);
INSERT INTO cities(city, regionid) VALUES('Poshekhonye', 80);
INSERT INTO cities(city, regionid) VALUES('Rostov', 80);
INSERT INTO cities(city, regionid) VALUES('Rybinsk', 80);
INSERT INTO cities(city, regionid) VALUES('Tutayev', 80);
INSERT INTO cities(city, regionid) VALUES('Uglich', 80);
INSERT INTO cities(city, regionid) VALUES('Yaroslavl', 80);

COMMIT;

BEGIN TRANSACTION;

INSERT INTO cities(city, regionid) VALUES('Borzya', 81);
INSERT INTO cities(city, regionid) VALUES('Chita', 81);
INSERT INTO cities(city, regionid) VALUES('Khilok', 81);
INSERT INTO cities(city, regionid) VALUES('Krasnokamensk', 81);
INSERT INTO cities(city, regionid) VALUES('Mogocha', 81);
INSERT INTO cities(city, regionid) VALUES('Nerchinsk', 81);
INSERT INTO cities(city, regionid) VALUES('Petrovsk-Zabaykalsky', 81);
INSERT INTO cities(city, regionid) VALUES('Shilka', 81);
INSERT INTO cities(city, regionid) VALUES('Sretensk', 81);

COMMIT;
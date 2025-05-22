CREATE TABLE "Uzytkownicy" (
  "UzytkownikID" INT PRIMARY KEY,
  "Login" VARCHAR(50) UNIQUE NOT NULL,
  "Haslo" VARCHAR(255) NOT NULL,
  "Email" VARCHAR(100),
  "Nazwisko" VARCHAR(100),
  "Telefon" VARCHAR(20),
  "RolaID" INT
);

CREATE TABLE "Role" (
  "RolaID" INT PRIMARY KEY,
  "Nazwa" VARCHAR(50) NOT NULL
);

CREATE TABLE "AutomatyPrzesylkowe" (
  "AutomatPrzesylkowyID" INT PRIMARY KEY,
  "Nazwa" VARCHAR(100) NOT NULL,
  "Miasto" VARCHAR(100),
  "KodPocztowy" VARCHAR(10),
  "Ulica" VARCHAR(100),
  "NumerBudynku" VARCHAR(10),
  "KodAutomatu" VARCHAR(20)
);

CREATE TABLE "Skrytki" (
  "SkrytkaID" INT,
  "AutomatPrzesylkowyID" INT,
  "KodSkrytki" VARCHAR(20),
  "GabarytID" INT,
  "CzyPusta" BOOLEAN,
  PRIMARY KEY ("SkrytkaID", "AutomatPrzesylkowyID")
);

CREATE TABLE "Gabaryty" (
  "GabarytID" INT PRIMARY KEY,
  "Nazwa" VARCHAR(50),
  "Wysokosc_CM" INT,
  "Szerokosc_CM" INT,
  "Glebokosc_CM" INT
);

CREATE TABLE "Oddzialy" (
  "OddzialID" INT PRIMARY KEY,
  "Nazwa" VARCHAR(100),
  "Miasto" VARCHAR(100),
  "KodPocztowy" VARCHAR(10),
  "Ulica" VARCHAR(100),
  "NumerBudynku" VARCHAR(10)
);

CREATE TABLE "Sortownie" (
  "SortowniaID" INT PRIMARY KEY,
  "Nazwa" VARCHAR(100),
  "Lokalizacja" VARCHAR(255)
);

CREATE TABLE "Flota" (
  "PojazdID" INT PRIMARY KEY,
  "NumerRejestracyjny" VARCHAR(20),
  "Typ" VARCHAR(50),
  "Pojemnosc_M3" INT,
  "PrzypisanyOddzialID" INT
);

CREATE TABLE "Kurierzy" (
  "KurierID" INT PRIMARY KEY,
  "UzytkownikID" INT,
  "OddzialID" INT,
  "GodzinyPracy" VARCHAR(100),
  "Wynagrodzenie_MSC" DECIMAL(10,2)
);

CREATE TABLE "Przesylki" (
  "PrzesylkaID" INT PRIMARY KEY,
  "NadawcaID" INT,
  "OdbiorcaImie" VARCHAR(50),
  "OdbiorcaNazwisko" VARCHAR(50),
  "OdbiorcaTelefon" VARCHAR(20),
  "NadanieAutomatID" INT,
  "NadanieSkrytkaID" INT,
  "OdbiorAutomatID" INT,
  "OdbiorSkrytkaID" INT,
  "GabarytID" INT,
  "WartoscUbezpieczenia" DECIMAL(10,2),
  "KodSledzenia" VARCHAR(100) UNIQUE NOT NULL,
  "StatusAktualnyID" INT
);

CREATE TABLE "StatusPrzesylki" (
  "StatusID" INT PRIMARY KEY,
  "Nazwa" VARCHAR(50)
);

CREATE TABLE "HistoriaStatusow" (
  "HistoriaID" INT PRIMARY KEY,
  "PrzesylkaID" INT,
  "StatusID" INT,
  "DataZmiany" TIMESTAMP,
  "Lokalizacja" VARCHAR(255),
  "Komentarz" TEXT,
  "KurierID" INT
);

CREATE TABLE "Metody" (
  "MetodaID" INT PRIMARY KEY,
  "Nazwa" VARCHAR(50)
);

CREATE TABLE "Platnosci" (
  "PlatnoscID" INT PRIMARY KEY,
  "PrzesylkaID" INT,
  "UzytkownikID" INT,
  "MetodaID" INT,
  "Kwota" DECIMAL(10,2)
);

CREATE TABLE "Zwroty" (
  "ZwrotID" INT PRIMARY KEY,
  "PrzesylkaID" INT,
  "DataZgloszenia" DATE,
  "Powod" VARCHAR(255),
  "StatusZwrotu" VARCHAR(50)
);

CREATE TABLE "Reklamacje" (
  "ReklamacjaID" INT PRIMARY KEY,
  "PrzesylkaID" INT,
  "DataZgloszenia" DATE,
  "Powod" VARCHAR(255),
  "StatusReklamacji" VARCHAR(50),
  "Rozwiazanie" TEXT,
  "OperatorID" INT
);

CREATE TABLE "PrzesylkiKurierskie" (
  "PrzesylkaID" INT PRIMARY KEY,
  "KurierID" INT,
  "SortowniaPoczatkowaID" INT,
  "SortowniaKoncowaID" INT,
  "DataNadania" TIMESTAMP,
  "DataDostarczenia" TIMESTAMP
);

ALTER TABLE "Uzytkownicy" ADD FOREIGN KEY ("RolaID") REFERENCES "Role" ("RolaID");

ALTER TABLE "Skrytki" ADD FOREIGN KEY ("AutomatPrzesylkowyID") REFERENCES "AutomatyPrzesylkowe" ("AutomatPrzesylkowyID");

ALTER TABLE "Skrytki" ADD FOREIGN KEY ("GabarytID") REFERENCES "Gabaryty" ("GabarytID");

ALTER TABLE "Flota" ADD FOREIGN KEY ("PrzypisanyOddzialID") REFERENCES "Oddzialy" ("OddzialID");

ALTER TABLE "Kurierzy" ADD FOREIGN KEY ("UzytkownikID") REFERENCES "Uzytkownicy" ("UzytkownikID");

ALTER TABLE "Kurierzy" ADD FOREIGN KEY ("OddzialID") REFERENCES "Oddzialy" ("OddzialID");

ALTER TABLE "Przesylki" ADD FOREIGN KEY ("NadawcaID") REFERENCES "Uzytkownicy" ("UzytkownikID");

ALTER TABLE "Przesylki" ADD FOREIGN KEY ("NadanieAutomatID") REFERENCES "AutomatyPrzesylkowe" ("AutomatPrzesylkowyID");

ALTER TABLE "Przesylki" ADD FOREIGN KEY ("OdbiorAutomatID") REFERENCES "AutomatyPrzesylkowe" ("AutomatPrzesylkowyID");

ALTER TABLE "Przesylki" ADD FOREIGN KEY ("GabarytID") REFERENCES "Gabaryty" ("GabarytID");

ALTER TABLE "Przesylki" ADD FOREIGN KEY ("StatusAktualnyID") REFERENCES "StatusPrzesylki" ("StatusID");

ALTER TABLE "HistoriaStatusow" ADD FOREIGN KEY ("PrzesylkaID") REFERENCES "Przesylki" ("PrzesylkaID");

ALTER TABLE "HistoriaStatusow" ADD FOREIGN KEY ("StatusID") REFERENCES "StatusPrzesylki" ("StatusID");

ALTER TABLE "HistoriaStatusow" ADD FOREIGN KEY ("KurierID") REFERENCES "Kurierzy" ("KurierID");

ALTER TABLE "Platnosci" ADD FOREIGN KEY ("PrzesylkaID") REFERENCES "Przesylki" ("PrzesylkaID");

ALTER TABLE "Platnosci" ADD FOREIGN KEY ("UzytkownikID") REFERENCES "Uzytkownicy" ("UzytkownikID");

ALTER TABLE "Platnosci" ADD FOREIGN KEY ("MetodaID") REFERENCES "Metody" ("MetodaID");

ALTER TABLE "Zwroty" ADD FOREIGN KEY ("PrzesylkaID") REFERENCES "Przesylki" ("PrzesylkaID");

ALTER TABLE "Reklamacje" ADD FOREIGN KEY ("PrzesylkaID") REFERENCES "Przesylki" ("PrzesylkaID");

ALTER TABLE "Reklamacje" ADD FOREIGN KEY ("OperatorID") REFERENCES "Uzytkownicy" ("UzytkownikID");

ALTER TABLE "PrzesylkiKurierskie" ADD FOREIGN KEY ("PrzesylkaID") REFERENCES "Przesylki" ("PrzesylkaID");

ALTER TABLE "PrzesylkiKurierskie" ADD FOREIGN KEY ("KurierID") REFERENCES "Kurierzy" ("KurierID");

ALTER TABLE "PrzesylkiKurierskie" ADD FOREIGN KEY ("SortowniaPoczatkowaID") REFERENCES "Sortownie" ("SortowniaID");

ALTER TABLE "PrzesylkiKurierskie" ADD FOREIGN KEY ("SortowniaKoncowaID") REFERENCES "Sortownie" ("SortowniaID");

CREATE TABLE Kafejnica (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nosaukums TEXT,
    adrese TEXT
);

INSERT INTO Kafejnica (nosaukums, adrese) VALUES
('Pie Jāņa', 'Brīvības iela 10'),
('Cafe 2','Rīgas iela 5'),
('Kafijas Stūris', 'Valdemāra iela 12');

CREATE TABLE Darbinieks (
   id INTEGER PRIMARY KEY AUTOINCREMENT,
   vards TEXT,
   uzvards TEXT,
   talrunis TEXT,
   amats TEXT,
   kafejnica_id INTEGER,
   atvalinajums INTEGER,
   FOREIGN KEY (kafejnica_id) REFERENCES Kafejnica(id)
);

INSERT INTO Darbinieks (vards, uzvards, talrunis, amats, kafejnica_id, atvalinajums) VALUES
('Jānis', 'Bērziņš', '+37120000001', 'viesmīlis', 1, 1),
('Anna', 'Zariņš', '+37120000002', 'viesmīlis', 1, 0),
('Mārtiņš', 'Ozoliņš', '+37120000003', 'pavārs', 2, 0);

CREATE TABLE Pasutijums (
   id INTEGER PRIMARY KEY AUTOINCREMENT,
   summa REAL,
   datums TEXT,
   apraksts TEXT
);
INSERT INTO Pasutijums (summa, datums, apraksts) VALUES
(249.99, '2024-04-01', 'Produkti atvēršanai'),
(120.50, '2024-03-20', 'Izejvielas dienai'),
(310.00, '2024-04-10', 'Konditorejas izstrādājumi');

CREATE TABLE Darbinieks_Pasutijums (
   darbinieks_id INTEGER,
   pasutijums_id INTEGER,
   PRIMARY KEY (darbinieks_id, pasutijums_id),
   FOREIGN KEY (darbinieks_id) REFERENCES Darbinieks(id),
   FOREIGN KEY (pasutijums_id) REFERENCES Pasutijums(id)
);
INSERT INTO Darbinieks_Pasutijums VALUES
(1, 1),
(2, 2),
(1, 3);

SELECT * FROM Darbinieks
WHERE atvalinajums = 1;

SELECT * FROM Darbinieks
WHERE uzvards ='Zariņš' AND amats = 'viesmīlis';

SELECT d.*
FROM Darbinieks d
Join Kafejnica k ON d.kafejnica_id = k.id
WHERE d.amats = 'viesmīlis' AND k.nosaukums = 'Pie Jāņa';

SELECT d.vards, d.uzvards, MAX(p.summa) AS max_summa
FROM Darbinieks d
Join Darbinieks_Pasutijums dp ON d.id = dp.darbinieks_id
JOIN Pasutijums p ON dp.pasutijums_id = p.id
GROUP BY d.id;

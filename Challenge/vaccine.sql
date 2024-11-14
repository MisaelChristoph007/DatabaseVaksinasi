-- Drop tables if they already exist
DROP TABLE IF EXISTS masyarakat;
DROP TABLE IF EXISTS petugas;
DROP TABLE IF EXISTS vaksin;
DROP TABLE IF EXISTS vaksinasi;

-- Create table masyarakat
CREATE TABLE masyarakat (
    nik VARCHAR(50) PRIMARY KEY,
    nama VARCHAR(255) NOT NULL,
    umur INT NOT NULL,
    no_telpn VARCHAR(15) NOT NULL,
    alamat VARCHAR(255) NOT NULL
);

-- Create table petugas
CREATE TABLE petugas (
    id_petugas VARCHAR(50) PRIMARY KEY,
    nama_petugas VARCHAR(255) NOT NULL,
    umur_petugas INT NOT NULL,
    no_telpn VARCHAR(15) NOT NULL
);

-- Create table vaksin
CREATE TABLE vaksin (
    id_vaksin VARCHAR(50) PRIMARY KEY,
    nama_vaksin VARCHAR(255) NOT NULL,
    dosis_vaksin VARCHAR(50) NOT NULL,
    jeda_vaksin INT NOT NULL
);

-- Create table vaksinasi
CREATE TABLE vaksinasi (
    id_vaksinasi INT PRIMARY KEY,
    nik VARCHAR(50) NOT NULL,
    id_petugas VARCHAR(50) NOT NULL,
    id_vaksin VARCHAR(50) NOT NULL,
    vaksin_ke INT NOT NULL,
    tempat_vaksin VARCHAR(255) NOT NULL,
    status VARCHAR(255) NOT NULL,
    FOREIGN KEY (nik) REFERENCES masyarakat(nik),
    FOREIGN KEY (id_petugas) REFERENCES petugas(id_petugas),
    FOREIGN KEY (id_vaksin) REFERENCES vaksin(id_vaksin)
);

-- Insert data into masyarakat
INSERT INTO masyarakat (nik, nama, umur, no_telpn, alamat) VALUES 
('1101', 'Alya Ghaida', 20, '0811', 'Karawang'),
('1102', 'Anindya', 21, '0812', 'Bandung'),
('1103', 'Anisyah', 19, '0813', 'Bogor'),
('1104', 'Aripin', 21, '0814', 'Cianjur'),
('1105', 'Arya', 20, '0815', 'Karawang'),
('1106', 'Asofi', 18, '0816', 'Bogor'),
('1107', 'Clara', 22, '0817', 'Jakarta');

-- Insert data into petugas
INSERT INTO petugas (id_petugas, nama_petugas, umur_petugas, no_telpn) VALUES
('A01', 'Faiq', 30, '0810'),
('A02', 'Naurah', 27, '0809'),
('A03', 'Satiah', 23, '0808'),
('A04', 'Serli', 22, '0807'),
('A05', 'Nanang', 29, '0806');

-- Insert data into vaksin
INSERT INTO vaksin (id_vaksin, nama_vaksin, dosis_vaksin, jeda_vaksin) VALUES
('V1', 'Sinovac', '0,5 ml', 30),
('V2', 'Astra Zeneca', '0,5 ml', 60),
('V3', 'Moderna', '0,5 ml', 14),
('V4', 'Moderna', '0,5 ml', 28);

-- Insert data into vaksinasi
INSERT INTO vaksinasi (id_vaksinasi, nik, id_petugas, id_vaksin, vaksin_ke, tempat_vaksin, status) VALUES
(1, '1101', 'A01', 'V1', 1, 'Puskesmas', 'Belum Komplit'),
(2, '1102', 'A02', 'V1', 2, 'Rs Lira', 'Belum Komplit'),
(3, '1103', 'A03', 'V1', 2, 'Rs Lira', 'Belum Komplit'),
(4, '1104', 'A04', 'V1', 3, 'Rs Lira', 'Komplit'),
(5, '1105', 'A01', 'V1', 3, 'Puskesmas', 'Komplit'),
(6, '1106', 'A02', 'V2', 1, 'Puskesmas', 'Belum Komplit'),
(7, '1107', 'A05', 'V2', 1, 'RSUD', 'Belum Komplit'),
(8, '1107', 'A03', 'V2', 3, 'RSUD', 'Komplit'),
(9, '1105', 'A04', 'V2', 3, 'Rs Lira', 'Komplit'),
(10, '1101', 'A01', 'V2', 2, 'RSUD', 'Belum Komplit'),
(11, '1102', 'A02', 'V3', 2, 'RSUD', 'Belum Komplit'),
(12, '1103', 'A03', 'V3', 2, 'Puskesmas', 'Belum Komplit'),
(13, '1104', 'A04', 'V3', 1, 'Puskesmas', 'Belum Komplit'),
(14, '1105', 'A01', 'V4', 2, 'Puskesmas', 'Belum Komplit'),
(15, '1106', 'A02', 'V4', 3, 'RSUD', 'Komplit');

-- Query to display vaccination data where status contains "komplit" but tempat_vaksin does not contain any numbers
SELECT *
FROM vaksinasi
WHERE 
    status = 'Komplit' 
    AND tempat_vaksin NOT LIKE '%0%'
    AND tempat_vaksin NOT LIKE '%1%'
    AND tempat_vaksin NOT LIKE '%2%'
    AND tempat_vaksin NOT LIKE '%3%'
    AND tempat_vaksin NOT LIKE '%4%'
    AND tempat_vaksin NOT LIKE '%5%'
    AND tempat_vaksin NOT LIKE '%6%'
    AND tempat_vaksin NOT LIKE '%7%'
    AND tempat_vaksin NOT LIKE '%8%'
    AND tempat_vaksin NOT LIKE '%9%';

-- Query to display vactination data when required at Karawang & Bogor address
SELECT nama, umur, alamat
FROM masyarakat
WHERE alamat IN ('Karawang', 'Bogor');

-- Query to display vactination data when civil received vactination with "Complete" status but not at "Puskesmas" and "RS Lira" use NOT operator
SELECT m.nama
FROM masyarakat m
JOIN vaksinasi v ON m.nik = v.nik
WHERE v.status = 'Komplit'
    AND v.tempat_vaksin NOT IN ('Puskesmas', 'Rs Lira');
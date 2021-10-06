USE [4lab_21var]

--3.1 INSERT
--a. ��� �������� ������ �����
INSERT INTO Doctor VALUES ('������','��������', 20, '����������');
--b. � ��������� ������ �����
INSERT INTO Doctor ([name], surname, age, position) VALUES ('����','��������', 20, '������');
--c. � ������� �������� �� ������ �������
INSERT INTO Doctor ([name], surname, age) SELECT [name], surname, age FROM Patient;

--3.2. DELETE
--a. ���� �������
DELETE FROM Doctor
--b. �� �������
DELETE FROM Doctor WHERE age = 20

--3.3. UPDATE
--a. ���� �������
UPDATE Doctor SET age = age + 1
--b. �� ������� �������� ���� �������
UPDATE Doctor SET position = '����������-������' WHERE position = '����������';
--c. �� ������� �������� ��������� ���������
UPDATE Doctor SET [name] = '���', surname = '�����' WHERE position = '����������-������';

--3.4. SELECT
--a. � ������� ����������� ��������� 
SELECT [name], surname FROM Doctor
--b. �� ����� ����������
SELECT * FROM Doctor
--c. � �������� �� ��������
SELECT * FROM Doctor WHERE age = 22

--3.5. SELECT ORDER BY + TOP (LIMIT)
--a. � ����������� �� ����������� ASC + ����������� ������ ���������� �������
SELECT TOP (4) [name] FROM Doctor ORDER BY [name] ASC 
--b. � ����������� �� �������� DESC
SELECT [name] FROM Doctor ORDER BY [name] DESC
--c. � ����������� �� ���� ��������� + ����������� ������ ���������� �������
SELECT TOP (4) [name], age FROM Doctor ORDER BY [name] ASC, age DESC
--d. � ����������� �� ������� ��������, �� ������ �����������
SELECT * FROM Doctor ORDER BY id_doctor

--3.6. ������ � ������
--����������, ����� ���� �� ������ ��������� ������� � ����� DATETIME. ��������,
--������� ������� ����� ��������� ���� �������� ������.
--a. WHERE �� ����
SELECT valid_until FROM Drug WHERE valid_until !> '20210520'
--b. WHERE ���� � ���������
SELECT valid_until FROM Drug WHERE valid_until BETWEEN '20200520' AND '20210520'
--c. ������� �� ������� �� ��� ����, � ������ ���. ��������, ��� �������� ������. ��� ����� ������������ ������� YEAR ( https://docs.microsoft.com/en-us/sql/t-sql/functions/year-transact-sql?view=sql-server-2017 )
SELECT name, YEAR(valid_until) FROM Drug

--3.7. ������� ���������
--a. ��������� ���������� ������� � �������
SELECT COUNT(*) FROM Doctor
--b. ��������� ���������� ���������� ������� � �������
SELECT DISTINCT COUNT(*) FROM Doctor
--c. ������� ���������� �������� �������
SELECT DISTINCT [name], surname FROM Doctor
--d. ����� ������������ �������� �������
SELECT MAX(age) FROM Doctor
--e. ����� ����������� �������� �������
SELECT MIN(age) FROM Doctor
--f. �������� ������ COUNT() + GROUP BY
SELECT DISTINCT TOP(COUNT(age)-1) age FROM Doctor GROUP BY [name], age --������� ���, ����� ������ ���������� ������� ����� �������� ����� �� (��� - �������)

--3.8. SELECT GROUP BY + HAVING
--a. �������� 3 ������ ������� � �������������� GROUP BY + HAVING. ��� ������� ������� �������� ����������� � ����������, ����� ���������� ��������� ������. ������ ������ ���� �����������, �.�. �������� ����������, ������� ����� ������������.
SELECT COUNT(*) AS [count], [name], valid_until FROM Drug GROUP BY [name] HAVING valid_until >= FORMAT(GetDate(), 'yyyy-MM-dd') --������� �����������, �������� � ���� �������� ��������� �������������� �� �������� ��� ���� �������� ��� ����� 
SELECT COUNT(*) AS [count], age  FROM Patient GROUP BY age HAVING age < 18-- ������� ����������� � ������� ��������, ��������� �� �������� � �������� ������ ��� � ���� ������� ������ 18 ��� ����� ������� ������� ����� ������������ ������� ����� ������ �������� (�� 18 ���) ������
SELECT COUNT(*) AS [count], age FROM Doctor GROUP BY age HAVING age >= 30 ORDER BY age DESC --������ ������� ������ ������ ��������� �� 30 ��� �� ����������� ����������� ������� �� �������

--3.9. SELECT JOIN
--a. LEFT JOIN ���� ������ � WHERE �� ������ �� ���������
SELECT Assignment.comment, Drug.[name] FROM Assignment LEFT JOIN Drug 
ON Assignment.id_drug = Drug.id_drug 
WHERE Assignment.comment is not null
--b. RIGHT JOIN. �������� ����� �� �������, ��� � � 3.9 a
SELECT Assignment.comment, Drug.name FROM Drug RIGHT JOIN Assignment 
ON Assignment.id_drug = Drug.id_drug 
WHERE Assignment.comment is not null
--c. LEFT JOIN ���� ������ + WHERE �� �������� �� ������ �������
SELECT Doctor.[name] FROM Doctor 
LEFT JOIN Medical_prescription ON (Doctor.id_doctor = Medical_prescription.id_doctor)
LEFT JOIN Patient ON (Patient.id_patient = Medical_prescription.id_patient)
WHERE Doctor.age > 35 AND Medical_prescription.valid_until < FORMAT(GetDate(), 'yyyy-MM-dd') AND Patient.gender = '���'
--d. INNER JOIN ���� ������
SELECT Patient.[name], Medical_prescription.id_doctor FROM Medical_prescription INNER JOIN Patient
ON Medical_prescription.id_patient = Patient.id_patient

--3.10. ����������
--a. �������� ������ � �������� WHERE IN (���������)
SELECT * FROM Doctor WHERE id_doctor IN (SELECT id_doctor FROM Doctor WHERE age < 30)
--b. �������� ������ SELECT atr1, atr2, (���������) FROM ...
SELECT [name], age, (SELECT id_medical_prescription FROM Medical_prescription
WHERE Medical_prescription.id_doctor = Doctor.id_doctor) 
AS ID_recipe FROM Doctor
--c. �������� ������ ���� SELECT * FROM (���������)
SELECT * FROM (SELECT Medical_prescription.valid_until FROM Patient LEFT JOIN Medical_prescription
ON Patient.id_patient = Medical_prescription.id_patient 
WHERE Patient.gender != '���' AND Patient.age > 30) AS [Table]
--d. �������� ������ ���� SELECT * FROM table JOIN (���������) ON �
SELECT * FROM Drug JOIN (SELECT comment, id_drug FROM Assignment) AS [Row_comment] ON Drug.id_drug = Row_comment.id_drug
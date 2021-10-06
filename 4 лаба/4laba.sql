USE [4lab_21var]

--3.1 INSERT
--a. Без указания списка полей
INSERT INTO Doctor VALUES ('Андрей','Шестаков', 20, 'Стоматолог');
--b. С указанием списка полей
INSERT INTO Doctor ([name], surname, age, position) VALUES ('Рома','Мухлыгин', 20, 'Акушер');
--c. С чтением значения из другой таблицы
INSERT INTO Doctor ([name], surname, age) SELECT [name], surname, age FROM Patient;

--3.2. DELETE
--a. Всех записей
DELETE FROM Doctor
--b. По условию
DELETE FROM Doctor WHERE age = 20

--3.3. UPDATE
--a. Всех записей
UPDATE Doctor SET age = age + 1
--b. По условию обновляя один атрибут
UPDATE Doctor SET position = 'Стоматолог-хирург' WHERE position = 'Стоматолог';
--c. По условию обновляя несколько атрибутов
UPDATE Doctor SET [name] = 'Дим', surname = 'Димыч' WHERE position = 'Стоматолог-хирург';

--3.4. SELECT
--a. С набором извлекаемых атрибутов 
SELECT [name], surname FROM Doctor
--b. Со всеми атрибутами
SELECT * FROM Doctor
--c. С условием по атрибуту
SELECT * FROM Doctor WHERE age = 22

--3.5. SELECT ORDER BY + TOP (LIMIT)
--a. С сортировкой по возрастанию ASC + ограничение вывода количества записей
SELECT TOP (4) [name] FROM Doctor ORDER BY [name] ASC 
--b. С сортировкой по убыванию DESC
SELECT [name] FROM Doctor ORDER BY [name] DESC
--c. С сортировкой по двум атрибутам + ограничение вывода количества записей
SELECT TOP (4) [name], age FROM Doctor ORDER BY [name] ASC, age DESC
--d. С сортировкой по первому атрибуту, из списка извлекаемых
SELECT * FROM Doctor ORDER BY id_doctor

--3.6. Работа с датами
--Необходимо, чтобы одна из таблиц содержала атрибут с типом DATETIME. Например,
--таблица авторов может содержать дату рождения автора.
--a. WHERE по дате
SELECT valid_until FROM Drug WHERE valid_until !> '20210520'
--b. WHERE дата в диапазоне
SELECT valid_until FROM Drug WHERE valid_until BETWEEN '20200520' AND '20210520'
--c. Извлечь из таблицы не всю дату, а только год. Например, год рождения автора. Для этого используется функция YEAR ( https://docs.microsoft.com/en-us/sql/t-sql/functions/year-transact-sql?view=sql-server-2017 )
SELECT name, YEAR(valid_until) FROM Drug

--3.7. Функции агрегации
--a. Посчитать количество записей в таблице
SELECT COUNT(*) FROM Doctor
--b. Посчитать количество уникальных записей в таблице
SELECT DISTINCT COUNT(*) FROM Doctor
--c. Вывести уникальные значения столбца
SELECT DISTINCT [name], surname FROM Doctor
--d. Найти максимальное значение столбца
SELECT MAX(age) FROM Doctor
--e. Найти минимальное значение столбца
SELECT MIN(age) FROM Doctor
--f. Написать запрос COUNT() + GROUP BY
SELECT DISTINCT TOP(COUNT(age)-1) age FROM Doctor GROUP BY [name], age --выбираю все, кроме одного уникальный возраст врача групируя вывод по (имя - возраст)

--3.8. SELECT GROUP BY + HAVING
--a. Написать 3 разных запроса с использованием GROUP BY + HAVING. Для каждого запроса написать комментарий с пояснением, какую информацию извлекает запрос. Запрос должен быть осмысленным, т.е. находить информацию, которую можно использовать.
SELECT COUNT(*) AS [count], [name], valid_until FROM Drug GROUP BY [name] HAVING valid_until >= FORMAT(GetDate(), 'yyyy-MM-dd') --Выбираю колличества, названия и срок годности лекарства сгрупированные по названию где срок годности уже вышел 
SELECT COUNT(*) AS [count], age  FROM Patient GROUP BY age HAVING age < 18-- Выбираю колличество и возраст поциента, группирую по возрасту и оставляю только тех у кого возраст меньше 18 тем самым получаю таблицу детей показывающую сколько детей какого возраста (до 18 лет) болеют
SELECT COUNT(*) AS [count], age FROM Doctor GROUP BY age HAVING age >= 30 ORDER BY age DESC --Смотрю сколько врачей разных возрастов до 30 лет по колличеству преобладает начиная со старших

--3.9. SELECT JOIN
--a. LEFT JOIN двух таблиц и WHERE по одному из атрибутов
SELECT Assignment.comment, Drug.[name] FROM Assignment LEFT JOIN Drug 
ON Assignment.id_drug = Drug.id_drug 
WHERE Assignment.comment is not null
--b. RIGHT JOIN. Получить такую же выборку, как и в 3.9 a
SELECT Assignment.comment, Drug.name FROM Drug RIGHT JOIN Assignment 
ON Assignment.id_drug = Drug.id_drug 
WHERE Assignment.comment is not null
--c. LEFT JOIN трех таблиц + WHERE по атрибуту из каждой таблицы
SELECT Doctor.[name] FROM Doctor 
LEFT JOIN Medical_prescription ON (Doctor.id_doctor = Medical_prescription.id_doctor)
LEFT JOIN Patient ON (Patient.id_patient = Medical_prescription.id_patient)
WHERE Doctor.age > 35 AND Medical_prescription.valid_until < FORMAT(GetDate(), 'yyyy-MM-dd') AND Patient.gender = 'жен'
--d. INNER JOIN двух таблиц
SELECT Patient.[name], Medical_prescription.id_doctor FROM Medical_prescription INNER JOIN Patient
ON Medical_prescription.id_patient = Patient.id_patient

--3.10. Подзапросы
--a. Написать запрос с условием WHERE IN (подзапрос)
SELECT * FROM Doctor WHERE id_doctor IN (SELECT id_doctor FROM Doctor WHERE age < 30)
--b. Написать запрос SELECT atr1, atr2, (подзапрос) FROM ...
SELECT [name], age, (SELECT id_medical_prescription FROM Medical_prescription
WHERE Medical_prescription.id_doctor = Doctor.id_doctor) 
AS ID_recipe FROM Doctor
--c. Написать запрос вида SELECT * FROM (подзапрос)
SELECT * FROM (SELECT Medical_prescription.valid_until FROM Patient LEFT JOIN Medical_prescription
ON Patient.id_patient = Medical_prescription.id_patient 
WHERE Patient.gender != 'муж' AND Patient.age > 30) AS [Table]
--d. Написать запрос вида SELECT * FROM table JOIN (подзапрос) ON …
SELECT * FROM Drug JOIN (SELECT comment, id_drug FROM Assignment) AS [Row_comment] ON Drug.id_drug = Row_comment.id_drug
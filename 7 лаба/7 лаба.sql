USE university;

--(1). Добавить внешние ключи.

ALTER TABLE lesson
	ADD FOREIGN KEY (id_teacher) REFERENCES teacher(id_teacher);

ALTER TABLE lesson
	ADD FOREIGN KEY (id_subject) REFERENCES [subject](id_subject);

ALTER TABLE lesson
	ADD FOREIGN KEY (id_group) REFERENCES [group](id_group);

ALTER TABLE student
	ADD FOREIGN KEY (id_group) REFERENCES [group](id_group);

ALTER TABLE mark
	ADD FOREIGN KEY (id_lesson) REFERENCES lesson(id_lesson);

ALTER TABLE mark
	ADD FOREIGN KEY (id_student) REFERENCES student(id_student);


--(2). Выдать оценки студентов по информатике если они обучаются данному предмету. Оформить выдачу данных с использованием view.

GO
CREATE VIEW mark_student_satisfying
AS SELECT student.[name] AS student_name, [group].[name] AS group_name, mark.mark
FROM student
	JOIN mark ON mark.id_student = student.id_student
	JOIN lesson ON lesson.id_lesson = mark.id_lesson
	JOIN [subject] ON [subject].id_subject = lesson.id_subject
	JOIN [group] ON [group].id_group = student.id_group
WHERE [subject].[name] = 'Информатика';
GO

SELECT * FROM mark_student_satisfying
ORDER BY student_name;

GO

--(3). Дать информацию о должниках с указанием фамилии студента и названия предмета. Должниками считаются студенты, не имеющие оценки по предмету, который ведется в группе. Оформить в виде процедуры, на входе идентификатор группы.

GO
CREATE PROCEDURE arrears
	@group INT
AS
BEGIN
	SELECT student.[name], [subject].[name] FROM student
		JOIN [group] ON [group].id_group = student.id_group
		JOIN lesson ON lesson.id_group = [group].id_group
		JOIN [subject] ON [subject].id_subject = lesson.id_subject
	FULL OUTER JOIN mark ON mark.id_student = student.id_student
	WHERE mark.id_student IS NULL AND [group].id_group = @group
	GROUP BY student.[name], [subject].[name];
END;

EXECUTE arrears 1;

DROP PROCEDURE arrears
GO

--(4). Дать среднюю оценку студентов по каждому предмету для тех предметов, по которым занимается не менее 35 студентов.

SELECT [subject].[name], AVG(mark.mark) FROM (
	SELECT quantity_students.subject_name, COUNT(quantity_students.student_name) AS quantity_students FROM (
		SELECT student.[name] AS student_name, [subject].[name] AS subject_name FROM [subject]
			JOIN lesson ON lesson.id_subject= [subject].id_subject
			JOIN [group] ON [group].id_group = lesson.id_group
			JOIN student ON student.id_group = [group].id_group
		GROUP BY student.[name], [subject].[name] ) AS quantity_students
	GROUP BY quantity_students.subject_name
	HAVING COUNT(quantity_students.subject_name) >= 35) AS quantity_arrears_students
		JOIN [subject] ON quantity_arrears_students.subject_name = [subject].[name]
		JOIN lesson ON lesson.id_subject = [subject].id_subject
		JOIN mark ON mark.id_lesson = lesson.id_lesson
	GROUP BY [subject].[name];


--(5). Дать оценки студентов специальности ВМ по всем проводимым предметам с указанием группы, фамилии, предмета, даты. При отсутствии оценки заполнить значениями NULL поля оценки.

SELECT student.[name] AS studentName, [group].[name] AS groupName, [subject].[name] AS subjectName, lesson.[date] AS lessionDate, mark.mark FROM [subject]
	JOIN lesson ON lesson.id_subject = [subject].id_subject
	JOIN [group] ON [group].id_group = lesson.id_group
	JOIN student ON [group].id_group = student.id_group
FULL OUTER JOIN mark ON mark.id_student = student.id_student
WHERE [group].[name] = 'ВМ'
ORDER BY student.[name]


--(6). Всем студентам специальности ПС, получившим оценки меньшие 5 по предмету БД до 12.05, повысить эти оценки на 1 балл.

UPDATE mark
SET mark.mark = mark.mark + 1
FROM (
	SELECT student.id_student, lesson.id_lesson, mark.mark FROM student
		JOIN [group] ON [group].id_group = student.id_group
		JOIN lesson ON lesson.id_group = [group].id_group
		JOIN [subject] ON [subject].id_subject = lesson.id_subject
		JOIN mark ON lesson.id_lesson = mark.id_lesson
	WHERE [group].[name] = 'ПС' AND [subject].[name] = 'БД' AND lesson.[date] < '2019-05-12' AND mark.mark < 5
) AS student_add_mark
WHERE mark.id_student = student_add_mark.id_student AND mark.id_lesson = student_add_mark.id_lesson;


--(7). Добавить необходимые индексы.

CREATE UNIQUE INDEX [index_group_name] ON [group]
(
	[name] ASC
);

CREATE INDEX [index_lesson_id_subject] ON lesson
(
	[id_subject] ASC
);

CREATE INDEX [index_lesson_id_group] ON lesson
(
	[id_group] ASC
);

CREATE INDEX [index_mark_id_lesson] ON mark
(
	[id_lesson] ASC
);

CREATE INDEX [index_mark_id_student] ON mark
(
	[id_student] ASC
);

CREATE INDEX [index_student_id_group] ON student
(
	[id_group] ASC
);

CREATE UNIQUE INDEX [index_subject_name] ON [subject]
(
	[name] ASC
);

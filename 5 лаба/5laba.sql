--(1): �������� ������� �����

ALTER TABLE booking
	ADD FOREIGN KEY (id_client) REFERENCES client(id_client);

ALTER TABLE room
	ADD FOREIGN KEY (id_hotel) REFERENCES hotel(id_hotel);

ALTER TABLE room
	ADD FOREIGN KEY (id_room_category) REFERENCES room_category(id_room_category);

ALTER TABLE room_in_booking
	ADD FOREIGN KEY (id_booking) REFERENCES booking(id_booking);

ALTER TABLE room_in_booking
	ADD FOREIGN KEY (id_room) REFERENCES room(id_room);

--(2): ������ ���������� � �������� ��������� �������, ����������� � ������� ��������� ����� �� 1 ������ 2019�.

SELECT client.[name], client.phone FROM client
JOIN booking ON client.id_client = booking.id_client
JOIN room_in_booking ON booking.id_booking = room_in_booking.id_booking
JOIN room ON room_in_booking.id_room = room.id_room
JOIN hotel ON room.id_hotel = hotel.id_hotel
JOIN room_category ON room.id_room_category = room_category.id_room_category
WHERE hotel.[name] = '������' AND room_category.[name] = '����' AND (room_in_booking.checkin_date = '2019-04-01' OR ('2019-04-01' BETWEEN room_in_booking.checkin_date AND room_in_booking.checkout_date));

--(3). ���� ������ ��������� ������� ���� �������� �� 22 ������

SELECT hotel.[name], room.number FROM hotel
JOIN room ON room.id_hotel = hotel.id_hotel
JOIN room_in_booking ON room.id_room = room_in_booking.id_room
WHERE (room_in_booking.checkin_date != '2019-04-22' OR ('2019-04-22' NOT BETWEEN room_in_booking.checkin_date AND room_in_booking.checkout_date))
ORDER BY hotel.[name] ASC;


--(4). ���� ���������� ����������� � ��������� ������� �� 23 ����� �� ������ ��������� �������

SELECT room_category.[name], COUNT(room.id_room) FROM room_in_booking
JOIN room ON room_in_booking.id_room = room.id_room
JOIN hotel ON hotel.id_hotel = room.id_hotel
JOIN room_category ON room_category.id_room_category = room.id_room_category
WHERE hotel.[name] = '������' AND ('23.03.2019' BETWEEN room_in_booking.checkin_date AND room_in_booking.checkout_date)
GROUP BY room_category.[name]
ORDER BY room_category.[name] ASC;


--(5). ���� ������ ��������� ����������� �������� �� ���� �������� ��������� �������, ��������� � ������ � ��������� ���� ������.

SELECT client.[name], client.phone, room_in_booking.checkout_date FROM client
JOIN booking ON client.id_client = booking.id_client
JOIN room_in_booking ON room_in_booking.id_booking = booking.id_booking
JOIN room ON room.id_room = room_in_booking.id_room
JOIN hotel ON hotel.id_hotel = room.id_hotel
WHERE hotel.[name] = '������' AND MONTH(room_in_booking.checkout_date) = 4
ORDER BY room_in_booking.checkout_date ASC;


--(6). �������� �� 2 ��� ���� ���������� � ��������� ������� ���� �������� ������ ��������� �������, ������� ���������� 10 ���.

UPDATE room_in_booking
SET room_in_booking.checkout_date = DATEADD(day, 2, room_in_booking.checkout_date)
FROM (SELECT room_in_booking.checkout_date, room_in_booking.id_room FROM room_in_booking
	  JOIN room ON room.id_room = room_in_booking.id_room
	  JOIN hotel ON room.id_hotel = hotel.id_hotel
	  JOIN room_category ON room.id_room_category = room_category.id_room_category
	  WHERE hotel.[name] = '������' AND room_category.[name] = '������' AND room_in_booking.checkin_date = '10.05.2019') AS extend_for_two_days
WHERE extend_for_two_days.id_room = room_in_booking.id_room;


/* (7). ����� ��� "��������������" �������� ����������. ���������� ���������: ��
����� ���� ������������ ���� ����� �� ���� ���� ��������� ���, �.�. ������
���������� ���������� �������� � ���� �����. ������ � �������
room_in_booking � id_room_in_booking = 5 � 2154 �������� ��������
������������� ���������, ������� ���������� �����. �������������� ������
������� ������ ��������� ���������� � ���� ������������� �������. */

SELECT * FROM room_in_booking [first], room_in_booking [second]
	WHERE ([first].id_room = [second].id_room) AND
		  ([first].checkin_date BETWEEN [second].checkin_date AND [second].checkout_date) AND
		  ([first].checkout_date BETWEEN [second].checkin_date AND [second].checkout_date) AND
		  ([second].checkout_date BETWEEN [first].checkin_date AND [first].checkout_date) AND
		  ([second].checkout_date BETWEEN [first].checkin_date AND [first].checkout_date) AND
		  ([first].id_room_in_booking != [second].id_room_in_booking) 
ORDER BY [first].id_room_in_booking, [second].id_room_in_booking;


--(8). ������� ������������ � ����������.

BEGIN TRANSACTION

INSERT INTO client([name], phone)
VALUES ('������', '+79024304000');

INSERT INTO booking(id_client, booking_date)
VALUES (SCOPE_IDENTITY(), CONVERT(date, GETDATE()));
DECLARE @id_booking Int;
SET @id_booking = SCOPE_IDENTITY();

INSERT INTO room(id_hotel, id_room_category, number, price)
VALUES (1, 1, 25, 5000);

INSERT INTO room_in_booking(id_booking, id_room, checkin_date, checkout_date)
VALUES (@id_booking, SCOPE_IDENTITY(), '05.10.2021', '06.10.2021');

COMMIT TRANSACTION


--(9). �������� ����������� ������� ��� ���� ������.

CREATE INDEX [index_booking_id_client] ON booking
(
	[id_client] ASC
);

CREATE INDEX [index_room_in_booking_id_booking] ON room_in_booking
(
	[id_booking] ASC
);

CREATE INDEX [index_room_in_booking_id_room] ON room_in_booking
(
	[id_room] ASC
);

CREATE INDEX [index_room_id_hotel] ON room
(
	[id_hotel] ASC
);

CREATE INDEX [index_room_id_room_category] ON room
(
	[id_room_category] ASC
);

CREATE UNIQUE INDEX [index_room_category_name] ON room_category
(
	[name] ASC
);

CREATE UNIQUE INDEX [index_hotel_name] ON hotel
(
	[name] ASC
);

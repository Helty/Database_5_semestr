--(1). Добавить внешние ключи.

ALTER TABLE dealer
	ADD FOREIGN KEY (id_company) REFERENCES company(id_company);

ALTER TABLE [order]
	ADD FOREIGN KEY (id_production) REFERENCES production(id_production);

ALTER TABLE [order]
	ADD FOREIGN KEY (id_pharmacy) REFERENCES pharmacy(id_pharmacy);

ALTER TABLE [order]
	ADD FOREIGN KEY (id_dealer) REFERENCES dealer(id_dealer);

ALTER TABLE production
	ADD FOREIGN KEY (id_company) REFERENCES company(id_company);

ALTER TABLE production
	ADD FOREIGN KEY (id_medicine) REFERENCES medicine(id_medicine);


--(2). Выдать информацию по всем заказам лекарства “Кордерон” компании “Аргус” с указанием названий аптек, дат, объема заказов.

SELECT medicine.[name], company.[name], pharmacy.[name], [order].[date], [order].quantity FROM medicine
	JOIN production ON medicine.id_medicine = production.id_medicine
	JOIN company ON production.id_company = company.id_company
	JOIN [order] ON [order].id_production = production.id_production
	JOIN pharmacy ON pharmacy.id_pharmacy = [order].id_pharmacy
WHERE medicine.[name] = 'Кордерон' AND company.[name] = 'Аргус';


--(3).  Дать список лекарств компании “Фарма”, на которые не были сделаны заказы до 25 января.

SELECT medicine.[name] FROM medicine
WHERE medicine.[name] NOT IN(
	SELECT medicine.[name] FROM [order]
		JOIN dealer ON dealer.id_dealer = [order].id_dealer
		JOIN production ON production.id_production = [order].id_production
		JOIN company ON company.id_company = production.id_company
		JOIN medicine ON medicine.id_medicine = production.id_medicine
	WHERE company.[name] = 'Фарма' AND [order].[date] < '2021-01-25' 
	GROUP BY medicine.[name]);


--(4). Дать минимальный и максимальный баллы лекарств каждой фирмы, которая оформила не менее 120 заказов.SELECT company.[name], MIN(production.rating) AS minimum_rating, MAX(production.rating) AS maximum_rating FROM (	SELECT company.[name], COUNT(*) AS count_order  FROM production		JOIN [order] ON [order].id_production = production.id_production		JOIN medicine ON medicine.id_medicine = production.id_medicine		JOIN company ON company.id_company = production.id_company	GROUP BY company.[name]	HAVING COUNT(*) >= 120) AS appropriate_company		JOIN company ON company.[name] = appropriate_company.[name]		JOIN production ON production.id_company = company.id_company	GROUP BY company.[name];--(5). Дать списки сделавших заказы аптек по всем дилерам компании “AstraZeneca”. Если у дилера нет заказов, в названии аптеки проставить NULL.SELECT DISTINCT dealer.[name] AS dealer_name, company.[name] AS company_name, pharmacy.[name] AS pharmacy_name FROM dealer	JOIN company ON company.id_company = dealer.id_company	LEFT JOIN [order] ON [order].id_dealer = dealer.id_dealer	LEFT JOIN pharmacy ON pharmacy.id_pharmacy = [order].id_pharmacyWHERE company.[name] = 'AstraZeneca'ORDER BY dealer.[name];--(6). Уменьшить на 20% стоимость всех лекарств, если она превышает 3000, а длительность лечения не более 7 дней.UPDATE productionSET production.price = production.price * 0.8FROM (	SELECT production.price FROM medicine		JOIN production ON production.id_medicine = medicine.id_medicine	WHERE production.price > 3000 AND medicine.cure_duration <= 7) AS medicine_update;--(7). Добавить необходимые индексы.CREATE INDEX [index_medicine_id_medicine] ON medicine
(
	[id_medicine] ASC
);

CREATE UNIQUE INDEX [index_medicine_name] ON medicine
(
	[name] ASC
);

CREATE INDEX [index_production_id_company] ON production
(
	[id_company] ASC
);

CREATE INDEX [index_production_id_medicine] ON production
(
	[id_medicine] ASC
);

CREATE INDEX [index_dealer_id_company] ON dealer
(
	[id_company] ASC
);

CREATE INDEX [index_dealer_name] ON dealer
(
	[name] ASC
);

CREATE UNIQUE INDEX [index_company_name] ON company
(
	[name] ASC
);

CREATE INDEX [index_order_id_production] ON [order]
(
	[id_production] ASC
);

CREATE INDEX [index_order_id_dealer] ON [order]
(
	[id_dealer] ASC
);

CREATE INDEX [index_order_id_pharmacy] ON [order]
(
	[id_pharmacy] ASC
);


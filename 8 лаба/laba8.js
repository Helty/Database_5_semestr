//8 Лабораторная работа. Вариант 21. Шестаков Андрей Би-31
//Версия MangoDB 5.0.5

/*3.1 Отображение коллекций в базе данных.*/

use Laba8

db.createCollection("Drug")
db.createCollection("Purpose")
db.createCollection("PrescriptionForTreatment")
db.createCollection("Sick")
db.createCollection("Doctor")

show collections

/*3.2 Вставка записей*/
// Вставка одной записи:
{
db.Drug.insertOne
(
    {
        "name": "Ервой",
        "modeApplication": "Для мозгов",
        "validUntill": "2021-12-30"
    }
)
db.Purpose.insertOne
(
    {
        "comment": ["Концентрат для приготовления раствора для инфузий"]
    }
)
db.PrescriptionForTreatment.insertOne
(
    {
        "validUntill": "2022-06-15"
    }
)
db.Sick.insertOne
(
    {
        "name": {first: "Андрей", second: "Андреич"},
        "age": 18,
        "gender": ["мужчина"]
    }
)
db.Doctor.insertOne
(
    {
        "name": {first: "Егор", second: "Егоров"},
        "age": 38,
        "position": "Главный  Врач"
        
    }
)
}
// Вставка нескольких записей:
{
db.Drug.insertMany
([
    {
        "name": "Терафлю",
        "modeАpplication": "От гриппа и простуды",
        "validUntill": "2023-12-30"
    },
    {
        "name": "Акридерм",
        "modeАpplication": "От зуда",
        "validUntill": "2022-12-30"
    },
    {
        "name": "АкваДетрим",
        "modeАpplication": "Для иммунитета и мышц",
        "validUntill": "2025-12-30"
    }
])
db.Purpose.insertMany
([
    {
        "comment": ["Для профилактики Д3-гиповитаминоза у детей", "Для профилактики Д3-гиповитаминоза у взрослых"]
    },
    {
        "comment": ["Применяется при хроническом воспалении, лихенификации", "От гемороя"]
    },
    {
        "comment": ["Концентрат для приготовления раствора для инфузий"]
    }
])
db.PrescriptionForTreatment.insertMany
([
    {
        "validUntill": "2021-12-17"
    },
    {
        "validUntill": "2021-12-19"
    },
    {
        "validUntill": "2021-12-20"
    }
])
db.Sick.insertMany
([
    {
        "name": {first: "Копыт", second: "Копытыч"},
        "age": 20,
        "gender": [{"Пансексуал": 100}]
    },
    {
        "name": {first: "Копыт", second: "Копытыч"},
        "age": 23,
        "gender": [{"Кэтгендер":100}]
    },
    {
        "name": {first: "Копыт", second: "Копытыч"},
        "age": 21,
        "gender": [{"мужчина": 100}]
    },
    {
        "name": {first: "Евган", second: "Евганович"},
        "age": 16,
        "gender": [{"мужчина": 50}, {"женщина": 30}, {"Пансексуал":10}, {"Кэтгендер":10}]
    }
])
db.Doctor.insertMany
([
    {
        "name": "Егор",
        "surname": "Егоров",
        "age": 38,
        "position": "Главный  Врач",
    },
    {
        "name": "Андрей",
        "surname": "Андреич",
        "age": 25,
        "position": "Аспирант"
    },
    {
        "name": "Михал",
        "surname": "Михалыч",
        "age": 43,
        "position": "Старший хирург"
    }
])
}
/*3.3 Удаление записей*/
// Удаление одной записи:
{
    db.Sick.deleteOne
    (
        {
            "name": "Копыт" //удалит первого больного с этим именем (всего их 3)
        }
    )
}

// Удаление нескольких записей:

{
    db.Sick.deleteMany
    (
        {
            "name": "Копыт" //удалит двух оставшихся больных с этим именем (всего их 2 осталось)
        }
    )
}

/*3.4 Поиск записей*/

// Поиск по ID

db.Sick.find( { _id: ObjectId("61b4b1c4cc10aae3351e397f") } ) //нахожу больного по сгенерированному ему специальному id.

// Поиск записи по атрибуту первого уровня
db.PrescriptionForTreatment.find({"validUntill": "2021-12-17"}) //поиск рецептов, которые истекают 2021-12-17

// Поиск записи по вложенному атрибуту
db.Sick.find({"name.first": "Евган"}) //поиск по вложенному атрибуту, к которому обращаюсь через точку.

// Поиск записи по нескольким атрибутам (логический оператор AND)
db.Doctor.find ({$and : [{"position": "Старший хирург"}, {age: {$gte: 30}}]}) //поиск среди докторов старших хирургов чей возраст от 30 и выше

// Поиск записи по одному из условий (логический оператор OR)
db.Drug.find({$or: [{"name": "Терафлю", "mode application": "Для мозгов"}]}) //поиск лекарства Терафлю или поиск лекарства, которое помогает мозгу думать

// Поиск с использованием оператора сравнения
db.Sick.find({"age": {$lt : 30}}) //поиск среди больных тех, кому меньше 30 лет

// Поиск с использованием двух операторов сравнения
db.Doctor.find({"age": {$gt : 25, $lt : 40}}) //поиск всех докторов чей возраст от 25 до 40 лет 

// Поиск по значению в массиве
db.Sick.find({"gender": { $elemMatch: {$ne: {"Кэтгендер" : 100}}}}) //поиск среди всех больных которые 100% чувствуют себя не кэтгендерами

// Поиск по колличеству элементов в массиве
db.Purpose.find({"comment": {$size: 2}}) // поиск всех комментариев к лекарствам, где их колличество равно 2

// Поиск записей без атрибута
db.Doctor.find({"position": {$exists: false}}) // поиск всех документов из коллекции докторов у кторых не прописана позиция.

/*3.5 Обновление записей*/
// Изменить значение атрибута у записи
db.Doctor.updateOne({"position": "Главный  Врач"}, {$inc: 1}) //увеличиваю возраст врача на 1
db.Drug.updateMany({"name": "Терафлю"}, {$set: {"name": "ТерафлюPlusPlus"}}) //обновляю название для Терафлю.

// Удалить атрибут у записи
db.Drug.updateOne({"name": "Ервой"}, {$unset: {"mode application": 1}}) // удаляю для лекарства Ервой удалил атрибут mode application

// Добавить атрибут записи
db.Doctor.updateMany({}, {$set: {"Вакцинирован": true}}) //добавляю атрибут вакцинирован для всех докторов
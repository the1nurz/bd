# Звіт до лабораторної роботи №2

**Тема:** Перетворення ER-діаграми на схему PostgreSQL.

**Мета:** реалізувати бібліотечну ER-модель у PostgreSQL за допомогою DDL, обмежень і тестових INSERT.

## Предметна область та перехід від ERD

За основу взято всі п'ять файлів lab1: README.md, requirements.md, er-diagram.md, er-diagram.png та DEFENSE.md. Кожна сутність стала однойменною таблицею. FK з боку «багато» представляють зв'язки 1:N; складений PK book_author представляє M:N. Модель не розширюється.

## Стовпці, типи та ключі

| Таблиця | Стовпці |
| --- | --- |
| member | member_id INTEGER PK; first_name VARCHAR(100) NOT NULL; last_name VARCHAR(100) NOT NULL; email VARCHAR(254); phone VARCHAR(20) |
| author | author_id INTEGER PK; first_name VARCHAR(100) NOT NULL; last_name VARCHAR(100) NOT NULL |
| book | book_id INTEGER PK; title VARCHAR(255) NOT NULL; isbn VARCHAR(13); publication_year INTEGER |
| book_author | book_id INTEGER PK/FK NOT NULL → book(book_id); author_id INTEGER PK/FK NOT NULL → author(author_id); один PK на пару |
| loan | loan_id INTEGER PK; member_id INTEGER NOT NULL FK → member(member_id); book_id INTEGER NOT NULL FK → book(book_id); loan_date DATE NOT NULL; due_date DATE NOT NULL; return_date DATE |

INTEGER відповідає цілим ключам і року. VARCHAR зберігає текст, початкові нулі ISBN та + телефону. DATE достатньо для дат позик із lab1. NUMERIC, TEXT і TIMESTAMP не вводилися, бо відповідних атрибутів у моделі немає.

## Обмеження

PK забезпечують унікальність та обов'язковість ідентифікаторів; FK забороняють посилання на відсутні записи. ON DELETE RESTRICT зберігає пов'язані дані. CHECK не дозволяє порожні обов'язкові назви й імена, недодатний рік, неправильний формат контактів/ISBN і дати повернення або строку раніше видачі. NULL дозволений лише в необов'язкових атрибутах.

Частковий унікальний індекс на loan(book_id) з умовою return_date IS NULL забороняє дві незавершені позики книги. Звичайний UNIQUE(book_id) був би неправильним, бо заборонив би історію позик.

Обмеження «книга має хоча б одного автора» потребує контролю операції додавання/видалення авторства; сама DDL його не гарантує. У queries.sql є контрольний SELECT. Формати введення і точні межі перевірки пояснено в README.md.

## SQL та дані

Повні оператори CREATE TABLE у порядку залежностей: [schema.sql](schema.sql). Повні INSERT INTO: [data.sql](data.sql). Ці два файли є SQL-додатками до звіту; додайте їх разом зі звітом при здачі.

Порядок створення й заповнення: member, author, book, book_author, loan. Вставлено в текст скрипту по 5 рядків у member, author, book, loan та 6 у book_author. Книга 4 має двох авторів, автор 2 — дві книги; книга 1 має завершену та відкриту позики у різний час. Є повернення після строку, необов'язкові NULL та читач без позик. Роки відповідають першим виданням; ISBN конкретних видань невідомі, тому NULL.

## Перевірка

[queries.sql](queries.sql) містить SELECT * для всіх таблиць, підрахунок рядків, перевірку M:N, доступності й авторства, перегляд системних обмежень. [constraint-tests.sql](constraint-tests.sql) містить позитивні та негативні сценарії з відкочуванням.

Студент виконав ручне тестування в PostgreSQL через pgAdmin 4 та повідомив результати. schema.sql, data.sql і queries.sql виконалися успішно. Підтверджено кількості: member — 5, author — 5, book — 5, book_author — 6, loan — 5.

Ручні тести студента: PRIMARY KEY — PASS (23505), складений PRIMARY KEY — PASS (23505), FOREIGN KEY — PASS (23503), NOT NULL — PASS (23502), CHECK — PASS (23514). Решта тестів обмежень, за його повідомленням, також працюють. Окремого журналу кожного тесту та скриншотів не надано.

Codex перевірив файли й узгодженість документації, але сам SQL у PostgreSQL не запускав. Джерело результатів та зауваження наведено в [AUDIT.md](AUDIT.md). Правило B9 про обов'язкового автора книги автоматично не гарантується схемою.

## Висновок

Підготовлено реляційну схему бібліотеки, ключі, обмеження та приклади даних. Збережено сутності й атрибути lab1. Практичне виконання SQL та роботу обмежень підтвердив студент під час ручного тестування в pgAdmin 4. Робота готова до здачі з відомим обмеженням B9: авторство кожної книги потрібно контролювати окремо.

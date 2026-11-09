BEGIN;

INSERT INTO clients (company, contact_name, email, phone, country) VALUES
('Дніпро Софт', 'Олена Коваль', 'office@dnipro.example', '+380501111111', 'Україна'),
('Baltic Studio', 'Anna Nowak', 'hello@baltic.example', '+48500111222', 'Польща'),
('Berlin Market', 'Max Weber', 'info@berlin.example', '+49301112233', 'Німеччина');

INSERT INTO freelancers (full_name, email, skills, daily_rate) VALUES
('Іван Мельник', 'ivan@example.com', 'PostgreSQL, Python', 120),
('Марія Бондар', 'maria@example.com', 'Figma, UI/UX', 100),
('Андрій Шевченко', 'andrii@example.com', 'JavaScript, HTML, CSS', 110),
('Софія Ткач', 'sofia@example.com', 'Редагування текстів, SEO', 80);

INSERT INTO projects (client_id, title, description, country, category, budget,
                     created_at, deadline, status) VALUES
(1, 'Каталог товарів', 'База даних каталогу', 'Україна', 'Розробка', 2400,
 CURRENT_DATE - 50, CURRENT_DATE - 20, 'completed'),
(2, 'Дизайн магазину', 'Макети сторінок магазину', 'Польща', 'Дизайн', 1600,
 CURRENT_DATE - 40, CURRENT_DATE - 10, 'completed'),
(3, 'Кабінет клієнта', 'Вебінтерфейс кабінету', 'Німеччина', 'Розробка', 3000,
 CURRENT_DATE - 20, CURRENT_DATE + 20, 'in_progress'),
(1, 'Імпорт даних', 'Перенесення каталогу', 'Україна', 'Розробка', 1200,
 CURRENT_DATE - 30, CURRENT_DATE + 5, 'cancelled'),
(1, 'Лендінг події', 'Сторінка реєстрації', 'Україна', 'Розробка', 900,
 CURRENT_DATE - 2, CURRENT_DATE + 15, 'open'),
(2, 'Новий логотип', 'Логотип студії', 'Польща', 'Дизайн', 600,
 CURRENT_DATE - 3, CURRENT_DATE + 14, 'open'),
(1, 'Тексти для сайту', 'Підготувати описи послуг', 'Україна', 'Тексти', 400,
 CURRENT_DATE - 1, CURRENT_DATE + 10, 'open'),
(3, 'Тестовий проєкт для видалення', 'Навчальний запис', 'Німеччина', 'Тексти', 100,
 CURRENT_DATE - 1, CURRENT_DATE + 7, 'open'),
(2, 'Старе оголошення', 'Проєкт поза останнім тижнем', 'Польща', 'Тексти', 300,
 CURRENT_DATE - 15, CURRENT_DATE + 15, 'open');

INSERT INTO proposals (project_id, freelancer_id, price, cover_letter, submitted_at) VALUES
(1, 1, 2200, 'Розроблю схему та запити', CURRENT_DATE - 48),
(2, 2, 1500, 'Підготую макети у Figma', CURRENT_DATE - 38),
(3, 3, 2800, 'Реалізую адаптивний інтерфейс', CURRENT_DATE - 18),
(4, 1, 1100, 'Перенесу дані з перевірками', CURRENT_DATE - 28),
(5, 3, 850, 'Створю сторінку події', CURRENT_DATE - 1),
(5, 1, 880, 'Тестова пропозиція для видалення', CURRENT_DATE - 1);

INSERT INTO contracts (proposal_id, status, started_at, completed_at, paid_amount) VALUES
(1, 'completed', CURRENT_DATE - 45, CURRENT_DATE - 25, 2200),
(2, 'completed', CURRENT_DATE - 35, CURRENT_DATE - 15, 1500),
(3, 'active', CURRENT_DATE - 15, NULL, 500),
(4, 'cancelled', CURRENT_DATE - 25, NULL, 0);

COMMIT;

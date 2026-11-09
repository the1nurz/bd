-- Виконуйте весь файл разом: демонстраційні зміни відкочуються.
BEGIN;

-- 1. Додати клієнта. Окремий ID зарезервований для демонстрації.
INSERT INTO clients (client_id, company, contact_name, email, country)
VALUES (1001, 'Навчальна компанія', 'Тестовий клієнт', 'demo@example.com', 'Україна');

-- 2. Додати проєкт цього клієнта.
INSERT INTO projects (project_id, client_id, title, description, country, category,
                     budget, deadline)
VALUES (1001, 1001, 'Навчальний сайт', 'Простий сайт компанії', 'Україна',
        'Розробка', 700, CURRENT_DATE + 30);

-- 3. Змінити бюджет конкретного проєкту.
UPDATE projects SET budget = 1000 WHERE project_id = 5;

-- 4. Оновити статус контракту без суперечності з датою завершення.
UPDATE contracts SET status = 'cancelled' WHERE contract_id = 3;

-- 5. Видалити лише тестову пропозицію, на яку немає контракту.
DELETE FROM proposals p
WHERE p.proposal_id = 6
  AND NOT EXISTS (SELECT 1 FROM contracts c WHERE c.proposal_id = p.proposal_id);

-- 6. Видалити тестовий проєкт без залежних пропозицій.
DELETE FROM projects p
WHERE p.project_id = 8
  AND NOT EXISTS (SELECT 1 FROM proposals r WHERE r.project_id = p.project_id);

-- 7. Відкриті проєкти в Україні.
SELECT project_id, title, budget, deadline
FROM projects WHERE status = 'open' AND country = 'Україна'
ORDER BY project_id;

-- 8. Виконані проєкти фрілансера з ID 1.
SELECT p.project_id, p.title, c.completed_at
FROM projects p
JOIN proposals r ON r.project_id = p.project_id
JOIN contracts c ON c.proposal_id = r.proposal_id
WHERE r.freelancer_id = 1 AND c.status = 'completed' AND p.status = 'completed'
ORDER BY p.project_id;

ROLLBACK;

-- 1. Середній бюджет у кожній категорії.
SELECT category, ROUND(AVG(budget), 2) AS average_budget
FROM projects GROUP BY category ORDER BY category;

-- 2. Середня тривалість виконання завершених контрактів у днях.
SELECT ROUND(AVG(completed_at - started_at), 2) AS average_days
FROM contracts WHERE status = 'completed';

-- 3. Успішність = 100 * завершені контракти / усі контракти.
-- За відсутності контрактів результат NULL, місце в рейтингу не надається.
WITH success AS (
    SELECT f.freelancer_id, f.full_name, COUNT(c.contract_id) AS total_contracts,
           COUNT(c.contract_id) FILTER (WHERE c.status = 'completed') AS completed_contracts,
           100.0 * COUNT(c.contract_id) FILTER (WHERE c.status = 'completed')
               / NULLIF(COUNT(c.contract_id), 0) AS success_percent
    FROM freelancers f
    LEFT JOIN proposals p ON p.freelancer_id = f.freelancer_id
    LEFT JOIN contracts c ON c.proposal_id = p.proposal_id
    GROUP BY f.freelancer_id, f.full_name
)
SELECT freelancer_id, full_name, total_contracts, completed_contracts,
       ROUND(success_percent, 2) AS success_percent,
       CASE WHEN total_contracts > 0 THEN
           DENSE_RANK() OVER (ORDER BY success_percent DESC NULLS LAST)
       END AS success_rank
FROM success ORDER BY success_percent DESC NULLS LAST, freelancer_id;

-- 4. Проєкти, створені за останні 7 днів, без жодної пропозиції.
WITH recent_projects AS (
    SELECT project_id, title, created_at FROM projects
    WHERE created_at > CURRENT_DATE - 7 AND created_at <= CURRENT_DATE
)
SELECT p.project_id, p.title, p.created_at
FROM recent_projects p
WHERE NOT EXISTS (SELECT 1 FROM proposals r WHERE r.project_id = p.project_id)
ORDER BY p.project_id;

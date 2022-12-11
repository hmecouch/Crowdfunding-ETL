-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
SELECT cp.cf_id, SUM(cp.backers_count)
FROM campaign as cp
WHERE cp.outcome = 'live'
GROUP BY cp.cf_id
ORDER BY SUM DESC;


-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
SELECT bi.cf_id, COUNT(bi.backer_id)
FROM backer_info AS bi
GROUP BY bi.cf_id
ORDER BY COUNT DESC;


-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 
SELECT cs.first_name,
		cs.last_name,
		cs.email,
		(cp.goal - cp.pledged) AS remaining_goal_amount
INTO email_contacts_remaining_goal_amount
FROM campaign AS cp
INNER JOIN contacts AS cs
ON (cp.contact_id = cs.contact_id)
WHERE cp.outcome = 'live'
ORDER BY remaining_goal_amount DESC;



-- Check the table
SELECT * FROM email_contacts_remaining_goal_amount;

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 
SELECT bi.email,
		bi.first_name,
		bi.last_name,
		bi.cf_id,
		cp.company_name,
		cp.description,
		cp.end_date,
		(cp.goal - cp.pledged) AS left_of_goal
INTO email_backers_remaining_goal_amount
FROM backer_info AS bi
INNER JOIN campaign AS cp
ON (bi.cf_id = cp.cf_id)
ORDER BY bi.email DESC;


-- Check the table

SELECT * FROM email_backers_remaining_goal_amount;


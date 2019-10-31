-- 1) Go back to the dvdrental database, and get the average, standard deviation, and count
-- of each customer's lifetime spending. (This is a lot like yesterday's warmup).

SELECT 
ROUND(AVG(amount),2),
ROUND(stddev_samp(amount),2),
COUNT(amount)
FROM payment
GROUP BY customer_id

-- 2) Your boss is absolutely certain (like 99%) that his new marketing strategy will increase
-- average customer spending by more than 10%, making the company an extra $100,000+ next year.
-- This is based on the fact that our company has about 10,000 customers, and his assumption
-- is that each customer is currently worth at least $100 in yearly spending. 
-- Your boss has already made this promise to the CEO.

-- Given our data (which is only a sample out of all of our customers), and that we want to be 99%
-- confident that our plan is going to work, we want compelling evidence that the TRUE customer 
-- average spending per year is more than $100. 
-- (USE at least 2 significant digits for your analysis)

Null Hypothesis: The average customer spending is less than or equal to $100/year
Alternate Hypothesis: The average customer spending is more than $100/year

WITH lifetime_spending_by_customer AS (
	SELECT 
	ROUND(AVG(amount),2) AS average,
	ROUND(stddev_samp(amount),2) AS standard_deviation,
	COUNT(amount) AS sample
	FROM payment
	GROUP BY customer_id
)

SELECT 
ROUND(AVG(average),2) AS sample_mean,
ROUND(STDDEV_SAMP(standard_deviation),2) AS sample_std,
SUM(sample) AS sample_size
FROM lifetime_spending_by_customer lts

sample size = 599
sample standard deviation = 25.23
sample mean = 102.36
standard error = 1.03



-- Is the plan going to work? 
Yes, p-value is greater than alpha
-- If not at 99% confidence, what about 95%?
No, the boss' claim starts to waiver
-- If yes at 99%, what about 99.5%?
-- At which level of confidence can he tell the CEO that the plan is going to work?
99%

-- BONUS:
-- If you still have time, get the count, average, and standard deviation of customer spending
-- for each store. Can you set up a hypothesis test to say if there's a statistically meaningful
-- difference between the two stores? Check chapter 12.
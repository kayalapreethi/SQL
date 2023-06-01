DROP TABLE calls;
CREATE TABLE calls(
	user_id INT,
    mobile_no BIGINT,
    msg_type VARCHAR(10),
    time_stamp TIMESTAMP);

INSERT INTO calls (user_id,mobile_no,msg_type,time_stamp)
VALUES (123456,8890011111,'Outgoing','2021-01-01'),
(123457,8811111111,'Outgoing','2021-01-01'),
(123458,9990011111,'INCOMING','2021-01-01'),
(123459,1190011111,'Outgoing','2021-01-01'),
(123456,8890011111,'Outgoing','2021-02-01'),
(123457,8811111111,'Outgoing','2021-02-01'),
(123458,9990011111,'INCOMING','2021-02-01'),
(123459,1190011111,'Outgoing','2021-02-01');
SELECT * FROM calls;
-- Figure out the customers who sent more msgs compare to previous month.
with temp as(
select user_id , time_stamp , count(1) as cnt_num
from calls
group by user_id , time_stamp 
order by 1,2 desc
),temp_2 as(
select *, lead(cnt_num) over(partition by user_id order by time_stamp desc) as lag_value 
from temp
) select * from temp_2
select *, case when cnt_num - lag_value > 0 THEN 'sent more messages'
ELSE 'sent less messages' end as higher_messages
from temp_2
where lag_value is not null;

SELECT user_id FROM(
	SELECT * FROM(
		SELECT *,DENSE_RANK() OVER(PARTITION BY user_id ORDER BY msg_type_count DESC) AS msg_type_count_rank  FROM(
			SELECT user_id,msg_type,COUNT(msg_type) AS msg_type_count,MONTH(time_stamp) AS msg_month FROM calls
            WHERE msg_type = 'Outgoing'
            GROUP BY user_id,MONTH(time_stamp)
            ) AS highest
		HAVING msg_month = 2
        ) AS msgmonth
	HAVING msg_type_count_rank = 1
) AS highest_rank;

SELECT user_id,YEAR(time_stamp) AS Year,MONTH(time_stamp) AS Month,COUNT(msg_type) AS count_msg     
FROM calls 
GROUP BY user_id,YEAR(time_stamp),MONTH(time_stamp);
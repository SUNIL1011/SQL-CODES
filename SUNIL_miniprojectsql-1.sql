create database icc;
use icc;

# QUESTION 1.	Import the csv file to a table in the database.
SELECT * FROM `icc_test_ batting_ figures`;

# QUESTION 2.	Remove the column 'Player Profile' from the table.
ALTER TABLE `icc_test_ batting_ figures` DROP COLUMN `Player Profile`;
commit;
 # QUESTION 3.Extract the country name and player names from the given data and store it in seperate columns for further usage.
SELECT player , substring_index(PLAYER,'(',1) player_name , substring_index(substring_index(substring_index(PLAYER,'(',-1),')',1),'/',-1) country_name FROM `icc_test_ batting_ figures`;

# QUESTION 4.	From the column 'Span' extract the start_year and end_year and store them in seperate columns for further usage
select span,substring_index(span,'-',1) start_year,substring_index(span,'-',-1) end_year FROM `icc_test_ batting_ figures`; 
select * from `icc_test_ batting_ figures`;

-- QUESTION 5.  The column 'HS' has the highest score scored by the player so far in any given match. 
-- The column also has details if the player had completed the match in a NOT OUT status. 
-- Extract the data and store the highest runs and the NOT OUT status in different columns.
select hs,substring_index(hs,'*',1) high_score, 
case when length(hs)-LENGTH(REPLACE(HS,'*', ''))>0 then 'not_out' else 'out' end player_out
from `icc_test_ batting_ figures`;

-- QUESTION 6.	Using the data given, considering the players who were active in the year of 2019, 
-- create a set of batting order of best 6 players using the selection criteria of those who have a good average score across all matches for India.
select * from(SELECT * , substring_index(PLAYER,'(',1) player_name , substring_index(substring_index(substring_index(PLAYER,'(',-1),')',1),'/',-1) country_name,
			substring_index(span,'-',1) start_year,substring_index(span,'-',-1) end_year
            from `icc_test_ batting_ figures`) t  where upper(country_name) = 'INDIA' and 2019 between start_year and end_year order by avg desc limit  6;
            
-- QUESTION 7.	Using the data given, considering the players who were active in the year of 2019, 
-- create a set of batting order of best 6 players using the selection criteria of those who have highest number of 100s across all matches for India.
select * from(SELECT * , substring_index(PLAYER,'(',1) player_name , substring_index(substring_index(substring_index(PLAYER,'(',-1),')',1),'/',-1) country_name,
			substring_index(span,'-',1) start_year,substring_index(span,'-',-1) end_year
            from `icc_test_ batting_ figures`) t  where upper(country_name) = 'INDIA' and 2019 between start_year and end_year order by `100` desc limit  6;
            

-- QUESTION 8.	Using the data given, considering the players who were active in the year of 2019,
-- create a set of batting order of best 6 players using 2 selection criterias of your own for India.
select * from(SELECT * , substring_index(PLAYER,'(',1) player_name , substring_index(substring_index(substring_index(PLAYER,'(',-1),')',1),'/',-1) country_name,
			substring_index(span,'-',1) start_year,substring_index(span,'-',-1) end_year
            from `icc_test_ batting_ figures`) t  where upper(country_name) = 'INDIA' and 2019 between start_year and end_year order by `0`asc,`100` desc limit  6;
            
-- QUESTION 9.	Create a View named ‘Batting_Order_GoodAvgScorers_SA’ using the data given, 
-- considering the players who were active in the year of 2019, create a set of batting order of best 6 players using the selection criteria of 
-- those who have a good average score across all matches for South Africa.
create or replace view Batting_Order_Good_Avg_Scorers_SA as select * from(SELECT * , substring_index(PLAYER,'(',1) player_name , substring_index(substring_index(substring_index(PLAYER,'(',-1),')',1),'/',-1) country_name,
			substring_index(span,'-',1) start_year,substring_index(span,'-',-1) end_year
            from `icc_test_ batting_ figures`) t where upper(country_name) = 'SA' and 2019 between start_year and end_year order by Avg desc limit 6;
            
-- QUESTION 10.	Create a View named ‘Batting_Order_HighestCenturyScorers_SA’ Using the data given, 
-- considering the players who were active in the year of 2019, create a set of batting order of best 6 players using the selection criteria of 
-- those who have highest number of 100s across all matches for South Africa.

create or replace view Batting_Order_HighestCenturyScorers_SA as select * from(SELECT * , substring_index(PLAYER,'(',1) player_name , substring_index(substring_index(substring_index(PLAYER,'(',-1),')',1),'/',-1) country_name,
			substring_index(span,'-',1) start_year,substring_index(span,'-',-1) end_year
            from `icc_test_ batting_ figures`) t where upper(country_name) = 'SA' and 2019 between start_year and end_year order by `100` desc limit 6;
            





create database project;
use project;
/*1.	Import the csv file to a table in the database.**/
select * from `icc test batting figures`;
/*2.	Remove the column 'Player Profile' from the table.*/
ALTER TABLE `icc test batting figures`
DROP COLUMN `Player Profile`;

/*3.	Extract the country name and player names from the given data 
and store it in seperate columns for further usage.*/
ALTER TABLE `icc test batting figures`
	ADD `player name` varchar(30),
	ADD country varchar(30);
update `icc test batting figures`
set `player name`=SUBSTR(Player, 1,INSTR(Player, "(")); 
update `icc test batting figures`
set `country`=SUBSTR(Player,INSTR(Player,"(")-1); 


select * from `icc test batting figures`;


/*4.	From the column 'Span' extract the start_year and end_year and store them in seperate columns for further usage.*/
ALTER TABLE `icc test batting figures` ADD `start_year` varchar(30)
                 , ADD `end_year` varchar(30);
update `icc test batting figures`
set `start_year`=SUBSTR(Span, 1,INSTR(Span, "-")); 
update `icc test batting figures`
set `end_year`=SUBSTR(Span,6,INSTR(Span,"-")) ;

/*5.	The column 'HS' has the highest score scored by the player so far in any given match. 
The column also has details if the player had completed the match in a NOT OUT status.
 Extract the data and store the highest runs and the NOT OUT status in different columns.
*/

SELECT Player, HS
FROM `icc test batting figures` where HS in
(select HS from  `icc test batting figures` where HS like '%*');

/*6.	Using the data given, considering the players who were active in the year of 2019,
 create a set of batting order of best 6 players using the selection criteria
 of those who have a good average score across all matches for India.*/
select * from (
	select row_number() over(order by `Avg` desc) rn, Player ,`Avg`, span
	from `icc test batting figures`
	where Player like '%INDIA%' and Span like '%2019%') t
where rn <= 6;


/* 7.	Using the data given, considering the players who were active in the year of 2019, 
create a set of batting order of best 6 players using the selection criteria of those who
 have highest number of 100s across all matches for India.*/

select * from(
	select Player , `Avg`,`100`, span , min(`100`) over(order by `100` desc ) century,
	row_number() over(order by `100` desc) top_6
	from `icc test batting figures`
	where Player like '%INDIA%' and Span like '%2019%' ) t
where top_6 <= 6;


/*8.	Using the data given, considering the players who were active in the year of 2019,
 create a set of batting order of best 6 players
 using 2 selection criterias of your own for India.*/
 
 select Player ,Inn, `Avg`, span , `100` 
from `icc test batting figures`
where Player like '%INDIA%' and Span like '%2019%' and avg>40
order by `Inn` desc limit 6 ;

 /* 9.	Create a View named ‘Batting_Order_GoodAvgScorers_SA’ using the data given,
 considering the players who were active in the year of 2019, create a set of batting order of best 6 players using the selection criteria of those 
 who have a good average score across all matches for South Africa.*/
 
 
create view Batting_Order_GoodAvgScorers_SA as 
select Player , `Avg`, span
from `icc test batting figures`
where Player like '%(SA)%' and Span like '%2019%'
order by `Avg` desc limit 6 ;

 
 
  /* 10.	Create a View named ‘Batting_Order_HighestCenturyScorers_SA’ Using the data given, considering the players
  who were active in the year of 2019, create a set of batting order of best 6 players using the selection criteria of
  those who have highest number of 100s across all matches for South Africa.
*/
 
 create view Batting_Order_HighestCenturyScorers_SA as 
 select Player , `Avg`, span , `100`
from `icc test batting figures`
where Player like '%(SA)%' and Span like '%2019%'
order by `100` desc limit 6 ;

  /* */
 

 
 
 
 




create database P259;
use P259;
select * from stock_market_dataset;

---------- kpi 1 --------
select Ticker,
avg(volume) as avg_volume 
from stock_market_dataset 
group by Ticker 
order by avg_volume desc;

---------- kpi 2 --------
select Ticker,
avg(beta) as avg_beat, 
max(beta) as max_beat, 
min(beta) as min_beta 
from stock_market_dataset 
group by Ticker;

---------- kpi 3 --------
select Ticker,
sum(Dividend_Amount) as total_Dividend_Amount 
from stock_market_dataset 
group by Ticker 
order by total_Dividend_Amount desc;

---------- kpi 4 --------
select Ticker,
max(PE_Ratio) as maximum_PE_Ratio,
min(PE_Ratio) as minimum_PE_Ratio 
from stock_market_dataset 
group by Ticker;

---------- kpi 5 --------
select Ticker,
avg(Market_Cap) as average_market_cap 
from stock_market_dataset 
group by Ticker;

---------- kpi 6 --------
alter table stock_market_dataset add column sell_buy text default null;
set sql_safe_updates = 0;
update stock_market_dataset set sell_buy =
case
when macd < 0 and rsi14days > 69 then 'sell'
when macd > 0 and rsi14days < 69 then 'buy'
else 'hold'
end;
select Date,
Ticker,
MACD, 
RSI14days,
sell_buy
from stock_market_dataset
where sell_buy ='hold'
order by Date ;
select * from road_accident

select sum(number_of_casualties) as CY_Casualties
from road_accident
where YEAR(accident_date)='2022'-- and road_surface_conditions='Dry'


select count(distinct accident_index)as CY_Accidents
from road_accident
where year(accident_date)='2022'


select sum(number_of_casualties) as Fatal_Casualties
from road_accident
where YEAR(accident_date)='2022' and  accident_severity='Fatal'

select sum(number_of_casualties) as CY_Serious_Casualties
from road_accident
where YEAR(accident_date)='2022'and accident_severity='Serious'

select sum(number_of_casualties) as CY_Slight_Casualties
from road_accident
where YEAR(accident_date)='2022'and accident_severity='Slight'

--To calaculate the percentage of Slight from total
select cast(sum(number_of_casualties) as decimal(10,2)) *100/
(select CAST(sum(number_of_casualties) as decimal(10,2)) from road_accident)as pct
from road_accident
where  accident_severity='Slight'

--simillarly for others we can calculate
select cast(sum(number_of_casualties) as decimal(10,2)) *100/
(select CAST(sum(number_of_casualties) as decimal(10,2)) from road_accident)as pct
from road_accident
where  accident_severity='Fatal'

--Serious
select cast(sum(number_of_casualties) as decimal(10,2)) *100/
(select CAST(sum(number_of_casualties) as decimal(10,2)) from road_accident)as pct
from road_accident
where  accident_severity='Serious'


--Secondary KPIs

select * from road_accident

select 
  CASE
      WHEN vehicle_type in ('Agricultural vehicle') then 'Agricultural'
      when vehicle_type in ('Car','Taxi/Private hire car') then 'Cars'
      when vehicle_type in ('Motorcycle 125cc and under','Motorcycle 50cc and under','Motorcycle over 125cc and up to 500cc','Motorcycle over 500cc','Pedal cycle')then 'Bike'
      when vehicle_type in ('Bus or coach (17 or more pass seats)','Minibus(8-16 passenger seats)') then 'Bus'
      when vehicle_type in('Goods 7.5 tonnes mgw and over','Goods over 3.5t. and under 7.5t','Van/Goods 3.5 tonnes mgw or under') then 'Van'
      else 'Other'
    end as vehicle_group,
    sum(number_of_casualties)as CY_Casualties
from road_accident
where year(accident_date)='2022'
group by 
     CASE
      WHEN vehicle_type in('Agricultural vehicle') then 'Agricultural'
      when vehicle_type in ('Car','Taxi/Private hire car') then 'Cars'
      when vehicle_type in ('Motorcycle 125cc and under','Motorcycle 50cc and under','Motorcycle over 125cc and up to 500cc','Motorcycle over 500cc','Pedal cycle')then 'Bike'
      when vehicle_type in ('Bus or coach (17 or more pass seats)','Minibus(8-16 passenger seats)' )then 'Bus'
      when vehicle_type in('Goods 7.5 tonnes mgw and over','Goods over 3.5t. and under 7.5t','Van/Goods 3.5 tonnes mgw or under') then 'Van'
      else 'Other'
    end 


select datename(month,accident_date)as Month_Name,sum(number_of_casualties) as CY_Casualties
from road_accident
where year(accident_date)='2022'
group by  DATENAME(month,accident_date)

select road_type,sum(number_of_casualties)as CY_Casualties
 from road_accident
 where year (accident_date)='2022'
 group by road_type

select urban_or_rural_area ,sum(number_of_casualties) *100/
(select sum(number_of_casualties)from road_accident where year(accident_date)='2022')
from road_accident 
where year(accident_date)='2022'
group by urban_or_rural_area

select top 10  local_authority ,sum(number_of_casualties) as Total_Casualities
from road_accident
group by local_authority 
order by Total_Casualities desc 
# How to create function for search nearest street of generic points

# Try Closest

```sql
SELECT mypt.pid,myline.pid,ST_ClosestPoint(mypt.geom,myline.geom) AS cp_pt_line
FROM 
	ran_points mypt,
	street_mi myline
```  

```sql
select 
  --st_distance(st_closestpoint(r.geom, wa.geom), wa.geom::geometry) as cp,
  --wa.pid::integer as point_id,
  r.pid::integer as street_id
from ran_points2m wa, street_mi r
where wa.pid = p_pid
  --and (r.name is not null or r.ref is not null)
  AND ST_DWithin(ST_TRANSFORM(r.geom,32632), ST_TRANSFORM(wa.geom,32632), 100)
order by st_distance(st_closestpoint(r.geom, wa.geom), wa.geom::geometry) asc
limit 1;
```

## The function
```sql
create or replace function aaa_test4 (
  p_pid integer
) 
	returns table (
		--point_id integer,
		street_id integer
	) 
	language plpgsql
as $$
begin
	return query 
		select 
			--st_distance(st_closestpoint(r.geom, wa.geom), wa.geom::geometry) as cp,
			--wa.pid::integer as point_id,
			r.pid::integer as street_id
		from ran_points2m wa, street_mi r
		where wa.pid = p_pid
		  --and (r.name is not null or r.ref is not null)
		  AND ST_DWithin(ST_TRANSFORM(r.geom,32632), ST_TRANSFORM(wa.geom,32632), 100)
		order by st_distance(st_closestpoint(r.geom, wa.geom), wa.geom::geometry) asc
		limit 1;

end;$$
```

## Test function
```sql
SELECT aaa_test4 (
  1
)
```
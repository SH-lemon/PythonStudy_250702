select film_id from film
union
select film_id from inventory;

select film_id from film
union all
select film_id from inventory;

select film_id from film
intersect
select film_id from inventory;

select film_id
from film
where film_id in (
	select film_id
    from inventory
);

select film_id from film
except
select film_id from inventory;

# film 테이블과 film_category 테이블에서 각각 중복없이 film_id를 조회하는 SQL문을 작성해주세요!

select film_id from film
union
select film_id from film_category;

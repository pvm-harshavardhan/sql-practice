USE sql_practice;


-- Create a stored procedure to return all orders for a customer
delimiter //
create procedure get_customer_orders(in cust_id int)
begin
    select * from orders where customer_id = cust_id;
end;
//
delimiter ;


-- Create a stored procedure to insert a new product
delimiter //
create procedure insert_product(
    in pname varchar(100),
    in descr text,
    in cat_id int,
    in price decimal(10,2),
    in stock int,
    in supplier_id int
)
begin
    insert into products(product_name, description, category_id, price, stock_quantity, supplier_id)
    values(pname, descr, cat_id, price, stock, supplier_id);
end;
//
delimiter ;


-- Call a stored procedure with multiple inputs
call insert_product('Keyboard', 'Wireless', 2, 999.99, 50, 3);


-- Create a stored procedure that calculates discount based on total
delimiter //
create procedure calculate_discount(in order_total decimal(10,2), out discount decimal(10,2))
begin
    if order_total >= 5000 then
        set discount = order_total * 0.15;
    elseif order_total >= 2000 then
        set discount = order_total * 0.10;
    else
        set discount = order_total * 0.05;
    end if;
end;
//
delimiter ;


-- Use a loop in a stored procedure
delimiter //
create procedure loop_example()
begin
    declare i int default 1;
    while i <= 5 do
        insert into log_table(message) values (concat('Loop iteration: ', i));
        set i = i + 1;
    end while;
end;
//
delimiter ;


-- Create a stored procedure to update product stock
delimiter //
create procedure update_stock(in pid int, in quantity int)
begin
    update products
    set stock_quantity = stock_quantity - quantity
    where product_id = pid;
end;
//
delimiter ;


-- Log each procedure execution into a log table
create table if not exists log_table (
    id int auto_increment primary key,
    procedure_name varchar(100),
    run_time datetime,
    message text
);

delimiter //
create procedure log_execution(in pname varchar(100), in msg text)
begin
    insert into log_table(procedure_name, run_time, message)
    values (pname, now(), msg);
end;
//
delimiter ;


-- Drop a stored procedure
drop procedure if exists update_stock;


-- Handle NULL values inside a procedure
delimiter //
create procedure check_email(in email_input varchar(100))
begin
    if email_input is null then
        select 'Email cannot be NULL' as warning;
    else
        select * from customers where email = email_input;
    end if;
end;
//
delimiter ;


-- Use cursors in a stored procedure (if applicable)
delimiter //
create procedure cursor_demo()
begin
    declare done int default false;
    declare cust_name varchar(100);
    declare cur cursor for select concat(first_name, ' ', last_name) from customers;
    declare continue handler for not found set done = true;

    open cur;
    read_loop: loop
        fetch cur into cust_name;
        if done then
            leave read_loop;
        end if;
        insert into log_table(procedure_name, run_time, message)
        values ('cursor_demo', now(), cust_name);
    end loop;
    close cur;
end;
//
delimiter ;


-- Create procedure to archive old orders
create table if not exists orders_archive like orders;

delimiter //
create procedure archive_old_orders(in days_old int)
begin
    insert into orders_archive
    select * from orders where datediff(curdate(), order_date) > days_old;

    delete from orders where datediff(curdate(), order_date) > days_old;
end;
//
delimiter ;


-- Create nested procedure calls
delimiter //
create procedure parent_proc()
begin
    call log_execution('parent_proc', 'Calling child_proc now...');
    call child_proc();
end;
//

create procedure child_proc()
begin
    insert into log_table(procedure_name, run_time, message)
    values ('child_proc', now(), 'This is the child procedure.');
end;
//
delimiter ;


-- Handle errors inside procedure (TRY/CATCH-like using DECLARE HANDLER)
delimiter //
create procedure safe_insert()
begin
    declare continue handler for sqlexception 
    begin
        insert into log_table(procedure_name, run_time, message)
        values ('safe_insert', now(), 'Error occurred');
    end;

    insert into some_non_existing_table values (1); -- will trigger error
end;
//
delimiter ;


-- Grant execute permission on a procedure to a user
grant execute on procedure get_customer_orders to 'user_name'@'localhost';
	-- by default user_name is 'root'

-- Schedule procedure execution (using event)
delimiter //
create event archive_event
on schedule every 1 day
do
  call archive_old_orders(90);
//
delimiter ;
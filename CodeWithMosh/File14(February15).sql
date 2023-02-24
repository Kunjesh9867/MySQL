# Designing Databases
USE sql_store;

SHOW ENGINES;

-- To change the engine of a table (the table should be free from foreign key)
ALTER TABLE order_item_notes
ENGINE = InnoDB;

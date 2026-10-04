CREATE TABLE IF NOT EXISTS player_inventory (
    id INT AUTO_INCREMENT PRIMARY KEY,
    identifier VARCHAR(50) NOT NULL,
    item_name VARCHAR(50) NOT NULL,
    item_label VARCHAR(50) NOT NULL,
    item_count INT NOT NULL
);

INSERT INTO player_inventory (identifier, item_name, item_label, item_count) VALUES
('default', 'pants', 'Pants', 1),
('default', 'shirt', 'Shirt', 1),
('default', 'gun', 'Gun', 1);
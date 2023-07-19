CREATE TABLE meals (
  id INTEGER PRIMARY KEY,
  name TEXT UNIQUE NOT NULL,
  color INTEGER,
  image_url TEXT
);

INSERT INTO meals (name, color, image_url)
VALUES ('Café da manhã', 4294951175, 'https://cdn-icons-png.flaticon.com/512/17/17007.png'),
       ('Almoço', 4283215696, 'https://cdn-icons-png.flaticon.com/512/6540/6540381.png'),
       ('Jantar', 4282339765, 'https://cdn-icons-png.flaticon.com/512/637/637129.png');

CREATE TABLE availabilities (
  id INTEGER PRIMARY KEY,
  name TEXT UNIQUE NOT NULL
);

INSERT INTO availabilities (id, name)
VALUES (0, 'available'), (1, 'consumed'), (2, 'exhausted');

CREATE TABLE meal_availability (
  id INTEGER PRIMARY KEY,
  availability_id INTEGER,
  meal_id INTEGER,
  FOREIGN KEY (availability_id) REFERENCES availabilities (id),
  FOREIGN KEY (meal_id) REFERENCES meals (id)
);

CREATE TABLE items (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  quantity INTEGER NOT NULL,
  image_url TEXT,
  meal_id INTEGER,
  machine_position INTEGER NOT NULL,
  FOREIGN KEY (meal_id) REFERENCES meals (id)
);

CREATE TABLE users (
  id string PRIMARY KEY
);

INSERT INTO users (id) VALUES ('41:9A:DA:0E'), ('E1:95:D0:0E');

CREATE TABLE restrictions (
  id INTEGER PRIMARY KEY,
  name TEXT UNIQUE NOT NULL
);

INSERT INTO restrictions (name)
VALUES ('Glúten'), ('Lactose'), ('Sódio'), ('Vegano');

CREATE TABLE item_restrictions (
  id INTEGER PRIMARY KEY,
  item_id INTEGER,
  restriction_id INTEGER,
  FOREIGN KEY (item_id) REFERENCES items (id),
  FOREIGN KEY (restriction_id) REFERENCES restrictions (id)
);

CREATE TABLE user_restrictions (
  id INTEGER PRIMARY KEY,
  user_id INTEGER,
  restriction_id INTEGER,
  FOREIGN KEY (user_id) REFERENCES users (id),
  FOREIGN KEY (restriction_id) REFERENCES restrictions (id)
);

INSERT INTO user_restrictions (user_id, restriction_id)
VALUES ('41:9A:DA:0E', 1),
       ('41:9A:DA:0E', 2),
       ('E1:95:D0:0E', 4);

CREATE TABLE retrievals (
  id INTEGER PRIMARY KEY,
  user_id TEXT,
  item_id INTEGER,
  timestamp TEXT,
  FOREIGN KEY (user_id) REFERENCES users (id),
  FOREIGN KEY (item_id) REFERENCES items (id)
);

INSERT INTO items (name, quantity, image_url, meal_id, machine_position)
VALUES ('Bife', 4, 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/001_Tacos_de_carnitas%2C_carne_asada_y_al_pastor.jpg/800px-001_Tacos_de_carnitas%2C_carne_asada_y_al_pastor.jpg', 3, 1),
       ('Sanduíche de frango', 2, 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/001_Tacos_de_carnitas%2C_carne_asada_y_al_pastor.jpg/800px-001_Tacos_de_carnitas%2C_carne_asada_y_al_pastor.jpg', 1, 1),
       ('Hamburger', 3, 'https://upload.wikimedia.org/wikipedia/commons/e/e8/Gobi_manchurian.jpg', 2, 0),
       ('Croissant', 2, 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/81/Pasta_e_fagioli_rapida.jpg/800px-Pasta_e_fagioli_rapida.jpg', 3, 1),
       ('Bife', 4, 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/001_Tacos_de_carnitas%2C_carne_asada_y_al_pastor.jpg/800px-001_Tacos_de_carnitas%2C_carne_asada_y_al_pastor.jpg', 3, 0),
       ('Sanduíche de frango', 5, 'https://upload.wikimedia.org/wikipedia/commons/e/e8/Gobi_manchurian.jpg', 2, 0),
       ('Croissant', 2, 'https://upload.wikimedia.org/wikipedia/commons/1/13/Uszka-aasica.jpg', 2, 0),
       ('Sanduíche de frango', 5, 'https://upload.wikimedia.org/wikipedia/commons/1/13/Uszka-aasica.jpg', 1, 0),
       ('Salmão grelhado', 4, 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/001_Tacos_de_carnitas%2C_carne_asada_y_al_pastor.jpg/800px-001_Tacos_de_carnitas%2C_carne_asada_y_al_pastor.jpg', 3, 0),
       ('Panqueca', 1, 'https://upload.wikimedia.org/wikipedia/commons/1/13/Uszka-aasica.jpg', 2, 0),
       ('Salada César', 2, 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/81/Pasta_e_fagioli_rapida.jpg/800px-Pasta_e_fagioli_rapida.jpg', 3, 1),
       ('Salada César', 2, 'https://upload.wikimedia.org/wikipedia/commons/1/13/Uszka-aasica.jpg', 3, 0),
       ('Ovo', 2, 'https://upload.wikimedia.org/wikipedia/commons/1/13/Uszka-aasica.jpg', 2, 1),
       ('Salmão grelhado', 5, 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/81/Pasta_e_fagioli_rapida.jpg/800px-Pasta_e_fagioli_rapida.jpg', 2, 0),
       ('Macarrão', 2, 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/81/Pasta_e_fagioli_rapida.jpg/800px-Pasta_e_fagioli_rapida.jpg', 2, 1),
       ('Salmão grelhado', 5, 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/81/Pasta_e_fagioli_rapida.jpg/800px-Pasta_e_fagioli_rapida.jpg', 2, 1),
       ('Bife', 4, 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/81/Pasta_e_fagioli_rapida.jpg/800px-Pasta_e_fagioli_rapida.jpg', 1, 1),
       ('Ovo', 5, 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/001_Tacos_de_carnitas%2C_carne_asada_y_al_pastor.jpg/800px-001_Tacos_de_carnitas%2C_carne_asada_y_al_pastor.jpg', 2, 1),
       ('Panqueca', 1, 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/81/Pasta_e_fagioli_rapida.jpg/800px-Pasta_e_fagioli_rapida.jpg', 1, 0),
       ('Panqueca', 4, 'https://upload.wikimedia.org/wikipedia/commons/1/13/Uszka-aasica.jpg', 3, 0),
       ('Panqueca', 5, 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/001_Tacos_de_carnitas%2C_carne_asada_y_al_pastor.jpg/800px-001_Tacos_de_carnitas%2C_carne_asada_y_al_pastor.jpg', 1, 1),
       ('Sanduíche de frango', 2, 'https://upload.wikimedia.org/wikipedia/commons/1/13/Uszka-aasica.jpg', 2, 1),
       ('Salmão grelhado', 2, 'https://upload.wikimedia.org/wikipedia/commons/1/13/Uszka-aasica.jpg', 2, 1),
       ('Salmão grelhado', 4, 'https://upload.wikimedia.org/wikipedia/commons/1/13/Uszka-aasica.jpg', 2, 1),
       ('Sanduíche de frango', 3, 'https://upload.wikimedia.org/wikipedia/commons/e/e8/Gobi_manchurian.jpg', 1, 0),
       ('Salmão grelhado', 3, 'https://upload.wikimedia.org/wikipedia/commons/1/13/Uszka-aasica.jpg', 1, 1),
       ('Salada César', 4, 'https://upload.wikimedia.org/wikipedia/commons/1/13/Uszka-aasica.jpg', 2, 1),
       ('Ovo', 1, 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/001_Tacos_de_carnitas%2C_carne_asada_y_al_pastor.jpg/800px-001_Tacos_de_carnitas%2C_carne_asada_y_al_pastor.jpg', 1, 1),
       ('Sanduíche de frango', 2, 'https://upload.wikimedia.org/wikipedia/commons/1/13/Uszka-aasica.jpg', 3, 0),
       ('Ovo', 3, 'https://upload.wikimedia.org/wikipedia/commons/1/13/Uszka-aasica.jpg', 3, 1);

INSERT INTO item_restrictions (item_id, restriction_id)
VALUES (1, 3),
       (1, 4),
       (1, 1),
       (1, 2),
       (2, 4),
       (2, 1),
       (3, 3),
       (3, 4),
       (4, 1),
       (5, 4),
       (5, 3),
       (7, 2),
       (8, 2),
       (8, 3),
       (8, 1),
       (8, 4),
       (9, 1),
       (9, 3),
       (10, 3),
       (10, 4),
       (11, 4),
       (11, 1),
       (11, 2),
       (11, 3),
       (12, 2),
       (12, 4),
       (12, 3),
       (13, 1),
       (13, 4),
       (14, 2),
       (14, 3),
       (15, 2),
       (15, 3),
       (15, 1),
       (15, 4),
       (16, 2),
       (16, 1),
       (18, 2),
       (18, 3),
       (18, 4),
       (18, 1),
       (19, 1),
       (20, 2),
       (21, 2),
       (21, 1),
       (21, 4),
       (22, 4),
       (22, 3),
       (22, 1),
       (23, 4),
       (23, 1),
       (23, 3),
       (24, 2),
       (27, 4),
       (27, 3),
       (27, 2),
       (27, 1),
       (28, 4),
       (28, 1),
       (28, 3),
       (29, 1),
       (29, 4),
       (29, 3),
       (29, 2);

INSERT INTO retrievals (user_id, item_id, timestamp)
VALUES ('41:9A:DA:0E', 28, DATETIME('now')), -- breakfast
       ('41:9A:DA:0E', 3, DATETIME('now')),  -- lunch
       -- ('41:9A:DA:0E', 29, DATE('now')), -- dinner
       ('E1:95:D0:0E', 25, DATETIME('now')); -- breakfast

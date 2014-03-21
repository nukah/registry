CREATE OR REPLACE function update_building_space_on_level_update () RETURNS trigger AS $update_total_space$
DECLARE
  new_total_space INTEGER;
BEGIN
  SELECT SUM(space) into new_total_space FROM levels WHERE levels.building_id = OLD.building_id;
  UPDATE buildings SET total_space = new_total_space WHERE id = OLD.building_id;
  RETURN NULL;
END;
$update_total_space$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS update_total_space ON levels;
CREATE TRIGGER update_total_space AFTER UPDATE
  ON levels FOR EACH ROW
  WHEN(OLD.* IS DISTINCT FROM NEW.*)
  EXECUTE PROCEDURE update_building_space_on_level_update ();
--

CREATE OR REPLACE function update_building_free_space_on_level_update () RETURNS trigger AS $update_free_space$
DECLARE
  new_free_space INTEGER;
BEGIN
  SELECT SUM(space) into new_free_space FROM levels WHERE levels.building_id = OLD.building_id;
  UPDATE buildings SET free_space = new_free_space WHERE id = OLD.building_id;
  RETURN NULL;
END;
$update_free_space$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS update_free_space ON levels;
CREATE TRIGGER update_free_space AFTER UPDATE
  ON levels FOR EACH ROW
  WHEN(OLD.* IS DISTINCT FROM NEW.*)
  EXECUTE PROCEDURE update_building_free_space_on_level_update ();
--

CREATE OR REPLACE function update_building_income_on_contract_update () RETURNS trigger AS $update_building_income$
DECLARE
  new_income INTEGER;
BEGIN
  SELECT SUM(contracts.income) into new_income FROM contracts LEFT JOIN rooms ON contracts.room_id = rooms.id WHERE contracts.id = OLD.id;
  UPDATE buildings SET income = new_income WHERE id = (SELECT rooms.building_id FROM rooms LEFT JOIN contracts on contracts.room_id = rooms.id WHERE contracts.id = OLD.id);
  RETURN NULL;
END;
$update_building_income$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS update_building_income ON contracts;
CREATE TRIGGER update_building_income AFTER UPDATE
  ON contracts FOR EACH ROW
  WHEN(OLD.income IS DISTINCT FROM NEW.income)
  EXECUTE PROCEDURE update_building_income_on_contract_update ();
--

CREATE OR REPLACE function update_contract_income_on_contract_rate_update () RETURNS trigger AS $update_contract_income_on_rate$
DECLARE
  new_contract_income INTEGER;
BEGIN
  SELECT (contracts.rate*rooms.space) into new_contract_income FROM rooms LEFT JOIN contracts on contracts.room_id = rooms.id WHERE contracts.id = OLD.id LIMIT(1);
  UPDATE contracts SET income = new_contract_income WHERE id = OLD.id;
  RETURN NULL;
END;
$update_contract_income_on_rate$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS update_contract_income_on_rate ON contracts;
CREATE TRIGGER update_contract_income_on_rate AFTER UPDATE
  ON contracts FOR EACH ROW
  WHEN(OLD.rate IS DISTINCT FROM NEW.rate)
  EXECUTE PROCEDURE update_contract_income_on_contract_rate_update ();


CREATE OR REPLACE function update_contract_income_on_rooms_space_update () RETURNS trigger AS $update_contract_income_on_space$
DECLARE
  new_contract_income INTEGER;
BEGIN
  SELECT (contracts.rate*rooms.space) into new_contract_income FROM rooms LEFT JOIN contracts on contracts.room_id = rooms.id WHERE rooms.id = OLD.id;
  UPDATE contracts SET income = new_contract_income WHERE room_id = OLD.id;
  RETURN NULL;
END;
$update_contract_income_on_space$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS update_contract_income_on_space ON rooms;
CREATE TRIGGER update_contract_income_on_space AFTER UPDATE
  ON rooms FOR EACH ROW
  EXECUTE PROCEDURE update_contract_income_on_rooms_space_update ();
--

CREATE OR REPLACE function update_level_free_space_on_update () RETURNS trigger AS $update_rooms_space$
DECLARE
  rooms_space INTEGER;
  free_space_i INTEGER;
BEGIN
  SELECT SUM(space) into rooms_space FROM rooms WHERE level_id = OLD.level_id;
  IF FOUND THEN
    free_space_i = NEW.space - rooms_space;
    UPDATE levels SET free_space = free_space_i WHERE id = OLD.level_id;
  END IF;
  RETURN NULL;
END;
$update_rooms_space$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS update_rooms_space ON rooms;
CREATE TRIGGER update_rooms_space AFTER UPDATE
  ON rooms FOR EACH ROW
  WHEN(OLD.* IS DISTINCT FROM NEW.*)
  EXECUTE PROCEDURE update_level_free_space_on_update ();
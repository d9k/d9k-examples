CREATE TABLE IF NOT EXISTS demo_packages (
  id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  name VARCHAR(30),
  code INT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS demo_entities (
   created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- INSERT INTO demo_packages (id, name, code, created_at) VALUES
-- (100, 'banana', 100, NOW()),
-- (200, 'manana', 200, NOW());

-- ALTER TABLE demo_packages INHERIT demo_entities;

-- won't allow
-- ALTER TABLE demo_packages DROP COLUMN created_at;

-- ALTER TABLE demo_packages NO INHERIT demo_entities;

-- ALTER TABLE demo_packages RENAME COLUMN created_at TO _created_at;


-- ALTER TABLE demo_packages INHERIT demo_entities;

-- ALTER TABLE demo_packages ADD COLUMN created_at TIMESTAMPTZ NOT NULL DEFAULT NOW();

-- To be added as a child, the target table must already contain all the same columns as the parent (it could have additional columns, too). The columns must have matching data types, and if they have NOT NULL constraints in the parent then they must also have NOT NULL constraints in the child.
-- ALTER TABLE demo_packages INHERIT demo_entities;

-- UPDATE demo_packages SET created_at = _created_at;
-- ALTER TABLE demo_packages DROP COLUMN _created_at;

-- ALTER TABLE demo_entities ADD COLUMN updated_at TIMESTAMPTZ;
-- ALTER TABLE demo_entities DROP COLUMN updated_at;

-- ALTER TABLE demo_packages ADD COLUMN updated_at TIMESTAMPTZ;
-- ALTER TABLE demo_entities ADD COLUMN updated_at TIMESTAMPTZ;

-- ALTER TABLE demo_entities ADD COLUMN id INT;

-- ALTER TABLE demo_packages ADD COLUMN table_name TEXT NOT NULL DEFAULT 'demo_packages';
-- ALTER TABLE demo_entities ADD COLUMN table_name TEXT NOT NULL;

-- ALTER TABLE demo_entities ADD PRIMARY KEY (table_name, id);
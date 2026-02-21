#!/bin/bash
# This script creates cactus-admin user dynamically using password from CACTUS_ADMIN_PASSWORD env var

set -e

# Use environment variable (it's already passed by docker-compose)
PASSWORD="${CACTUS_ADMIN_PASSWORD:-guacadmin}"

# Generate password hash using openssl (same method as guacamole)
# Hash algorithm: SHA256(password + base16_encoded_salt)
PASSWORD_SALT=$(openssl rand -hex 32)
# Append base16-encoded salt to password, then hash
STRING_TO_HASH="${PASSWORD}${PASSWORD_SALT^^}"  # Convert salt to uppercase for base16
PASSWORD_HASH=$(echo -n "$STRING_TO_HASH" | openssl dgst -sha256 -binary | od -An -tx1 | tr -d ' ')

# Create the SQL and execute it
PGPASSWORD="$POSTGRES_PASSWORD" psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" <<EOSQL
-- Create cactus-admin user with password from environment

-- Get or create cactus-admin entity
WITH cactus_entity AS (
  INSERT INTO guacamole_entity (name, type)
  VALUES ('cactus-admin', 'USER')
  ON CONFLICT (type, name) DO UPDATE SET name = EXCLUDED.name RETURNING entity_id
)
-- Create user record with hashed password
INSERT INTO guacamole_user (entity_id, password_hash, password_salt, password_date, disabled, expired)
SELECT 
  entity_id,
  decode('${PASSWORD_HASH}', 'hex'),
  decode('${PASSWORD_SALT}', 'hex'),
  CURRENT_TIMESTAMP,
  FALSE,
  FALSE
FROM cactus_entity
ON CONFLICT (entity_id) DO NOTHING;

-- Grant all system permissions 
INSERT INTO guacamole_system_permission (entity_id, permission)
SELECT (SELECT entity_id FROM guacamole_entity WHERE name = 'cactus-admin' AND type = 'USER'), 'CREATE_CONNECTION'::guacamole_system_permission_type UNION
SELECT (SELECT entity_id FROM guacamole_entity WHERE name = 'cactus-admin' AND type = 'USER'), 'CREATE_CONNECTION_GROUP'::guacamole_system_permission_type UNION
SELECT (SELECT entity_id FROM guacamole_entity WHERE name = 'cactus-admin' AND type = 'USER'), 'CREATE_SHARING_PROFILE'::guacamole_system_permission_type UNION
SELECT (SELECT entity_id FROM guacamole_entity WHERE name = 'cactus-admin' AND type = 'USER'), 'CREATE_USER'::guacamole_system_permission_type UNION
SELECT (SELECT entity_id FROM guacamole_entity WHERE name = 'cactus-admin' AND type = 'USER'), 'CREATE_USER_GROUP'::guacamole_system_permission_type UNION
SELECT (SELECT entity_id FROM guacamole_entity WHERE name = 'cactus-admin' AND type = 'USER'), 'AUDIT'::guacamole_system_permission_type UNION
SELECT (SELECT entity_id FROM guacamole_entity WHERE name = 'cactus-admin' AND type = 'USER'), 'ADMINISTER'::guacamole_system_permission_type
ON CONFLICT (entity_id, permission) DO NOTHING;

-- Grant user self-permissions
INSERT INTO guacamole_user_permission (entity_id, affected_user_id, permission)
SELECT
  (SELECT entity_id FROM guacamole_entity WHERE name = 'cactus-admin' AND type = 'USER'),
  (SELECT user_id FROM guacamole_user WHERE entity_id = (SELECT entity_id FROM guacamole_entity WHERE name = 'cactus-admin' AND type = 'USER')),
  'READ'::guacamole_object_permission_type
UNION
SELECT
  (SELECT entity_id FROM guacamole_entity WHERE name = 'cactus-admin' AND type = 'USER'),
  (SELECT user_id FROM guacamole_user WHERE entity_id = (SELECT entity_id FROM guacamole_entity WHERE name = 'cactus-admin' AND type = 'USER')),
  'UPDATE'::guacamole_object_permission_type
UNION
SELECT
  (SELECT entity_id FROM guacamole_entity WHERE name = 'cactus-admin' AND type = 'USER'),
  (SELECT user_id FROM guacamole_user WHERE entity_id = (SELECT entity_id FROM guacamole_entity WHERE name = 'cactus-admin' AND type = 'USER')),
  'DELETE'::guacamole_object_permission_type
UNION
SELECT
  (SELECT entity_id FROM guacamole_entity WHERE name = 'cactus-admin' AND type = 'USER'),
  (SELECT user_id FROM guacamole_user WHERE entity_id = (SELECT entity_id FROM guacamole_entity WHERE name = 'cactus-admin' AND type = 'USER')),
  'ADMINISTER'::guacamole_object_permission_type
ON CONFLICT (entity_id, affected_user_id, permission) DO NOTHING;
EOSQL



#  ------------------------------------------------------------------------
#
# Title : Initialize Database Schema for a PostgreSQL Database
#    By : Jimmy Briggs
#  Date : 2021-04-29
#
#  ------------------------------------------------------------------------


# config ------------------------------------------------------------------

# Sys.setenv("R_CONFIG_ACTIVE" = "default")
# Sys.setenv("R_CONFIG_ACTIVE" = "production")

db_config <- config::get()$db


# connect -----------------------------------------------------------------
conn <- DBI::dbConnect(
  RPostgres::Postgres(),
  host = db_config$host,
  dbname = db_config$dbname,
  user = db_config$user,
  password = db_config$password
)

# create schema -----------------------------------------------------------
DBI::dbExecute(conn, "CREATE SCHEMA IF NOT EXISTS auth;")

# extensions --------------------------------------------------------------
DBI::dbExecute(conn, 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp";')
DBI::dbExecute(conn, 'CREATE EXTENSION IF NOT EXISTS pgcrypto;')

# accounts ----------------------------------------------------------------

create_accounts_table_query <- "CREATE TABLE auth.accounts (
  uid                            UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  email                          TEXT UNIQUE,
  polished_key                   TEXT,
  hashed_polished_key            TEXT,
  created_at                     TIMESTAMPTZ NOT NULL DEFAULT NOW()
)"


# users -------------------------------------------------------------------

create_users_table_query <- "CREATE TABLE auth.users (
  uid                            UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  account_uid                    UUID REFERENCES polished.accounts(uid) ON DELETE CASCADE,
  email                          TEXT,
  email_verification_code        TEXT,
  email_verified                 BOOLEAN DEFAULT FALSE,
  hashed_password                TEXT,
  created_by                     TEXT NOT NULL,
  created_at                     TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  modified_by                    TEXT NOT NULL,
  modified_at                    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (account_uid, email)
)"


# apps --------------------------------------------------------------------

create_apps_table_query <- "CREATE TABLE auth.apps (
  uid                   UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  account_uid           UUID REFERENCES polished.accounts(uid) ON DELETE CASCADE,
  app_name              TEXT,
  app_url               TEXT,
  created_at            TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  modified_at           TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (account_uid, app_name)
)"


# app_users ---------------------------------------------------------------


create_app_users_table_query <- "CREATE TABLE auth.app_users (
  uid                        UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  account_uid                UUID REFERENCES polished.accounts(uid),
  app_uid                    UUID REFERENCES polished.apps(uid) ON DELETE CASCADE,
  user_uid                   UUID REFERENCES polished.users(uid) ON DELETE CASCADE,
  is_admin                   BOOLEAN NOT NULL,
  is_invite_accepted         BOOLEAN NOT NULL DEFAULT false,
  created_by                 TEXT NOT NULL,
  created_at                 TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  modified_by                TEXT NOT NULL,
  modified_at                TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (account_uid, app_uid, user_uid)
)"


# sessions ----------------------------------------------------------------

create_sessions_table_query <- "CREATE TABLE auth.sessions (
  uid                   UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  account_uid           UUID REFERENCES polished.accounts(uid) ON DELETE CASCADE,
  user_uid              UUID REFERENCES polished.users(uid) ON DELETE CASCADE,
  email                 TEXT,
  email_verified        BOOLEAN,
  hashed_cookie         TEXT,
  signed_in_as          TEXT,
  app_uid               TEXT,
  is_active             BOOLEAN DEFAULT true,
  is_signed_in          BOOLEAN DEFAULT true,
  created_at            TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  modified_at           TIMESTAMPTZ NOT NULL DEFAULT NOW()
)"


# daily sessions ----------------------------------------------------------

create_daily_sessions_table_query <- "CREATE TABLE auth.daily_sessions (
  uid                     UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  account_uid             UUID,
  app_uid                 UUID,
  date_                   DATE,
  user_uid                UUID,
  n_sessions              INTEGER
);"


# roles -------------------------------------------------------------------

create_roles_table_query <- "CREATE TABLE auth.roles (
  uid                     UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  account_uid             UUID REFERENCES polished.accounts(uid) ON DELETE CASCADE,
  role_name               TEXT,
  created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  created_by              UUID,
  modified_at             TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  modified_by             UUID,
  UNIQUE (account_uid, role_name)
)"


# user_roles --------------------------------------------------------------

create_user_roles_table_query <- "CREATE TABLE auth.user_roles (
  uid                     UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  account_uid             UUID REFERENCES polished.accounts(uid) ON DELETE CASCADE,
  user_uid                UUID REFERENCES polished.users(uid) ON DELETE CASCADE,
  role_uid                UUID REFERENCES polished.roles(uid) ON DELETE CASCADE,
  created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  created_by              UUID,
  UNIQUE (account_uid, user_uid, role_uid)
)"


# subscriptions -----------------------------------------------------------

create_subscriptions_table_query <- "CREATE TABLE auth.subscriptions (
  uid                                   UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  account_uid                           UUID REFERENCES polished.accounts(uid) ON DELETE CASCADE,
  app_uid                               UUID REFERENCES polished.apps(uid) ON DELETE CASCADE,
  user_uid                              UUID REFERENCES polished.users(uid) ON DELETE CASCADE,
  stripe_customer_id                    TEXT,
  stripe_subscription_id                TEXT,
  free_trial_days_remaining_at_cancel   REAL,
  created_at                            TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (account_uid, app_uid, user_uid)
)"


# billings ----------------------------------------------------------------

create_billings_table_query <- "CREATE TABLE public.billings (
  uid                             UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  account_uid                     UUID UNIQUE,
  stripe_customer_id              TEXT,
  payment_method_id               TEXT,
  discount_pct                    REAL,
  created_at                      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  modified_at                     TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  payment_method_first_enabled_at TIMESTAMPTZ
)"


# email_templates ---------------------------------------------------------

create_email_templates_table_query <- "CREATE TABLE public.email_templates (
  uid                             UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  account_uid                     UUID,
  template_type                   TEXT,
  sender                          TEXT,
  subject                         TEXT,
  body                            TEXT,
  font                            TEXT,
  font_size                       INTEGER,
  line_height                     REAL,
  enable_markdown                 BOOLEAN,
  alignment                       TEXT,
  created_at                      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  modified_at                     TIMESTAMPTZ NOT NULL DEFAULT NOW()
)"

# drop tables if exist ---------------------------------------------------

DBI::dbExecute(conn, "DROP TABLE IF EXISTS auth.accounts CASCADE")
DBI::dbExecute(conn, "DROP TABLE IF EXISTS auth.users CASCADE")
DBI::dbExecute(conn, "DROP TABLE IF EXISTS auth.apps CASCADE")
DBI::dbExecute(conn, "DROP TABLE IF EXISTS auth.app_users CASCADE")
DBI::dbExecute(conn, "DROP TABLE IF EXISTS auth.sessions CASCADE")
DBI::dbExecute(conn, "DROP TABLE IF EXISTS auth.daily_sessions CASCADE")
DBI::dbExecute(conn, "DROP TABLE IF EXISTS auth.roles CASCADE")
DBI::dbExecute(conn, "DROP TABLE IF EXISTS auth.user_roles CASCADE")
DBI::dbExecute(conn, "DROP TABLE IF EXISTS auth.subscriptions CASCADE")
DBI::dbExecute(conn, "DROP TABLE IF EXISTS public.billings CASCADE")
DBI::dbExecute(conn, "DROP TABLE IF EXISTS public.email_templates CASCASE")

# create tables -----------------------------------------------------------

DBI::dbExecute(conn, create_accounts_table_query)
DBI::dbExecute(conn, create_users_table_query)
DBI::dbExecute(conn, create_apps_table_query)
DBI::dbExecute(conn, create_app_users_table_query)
DBI::dbExecute(conn, create_sessions_table_query)
DBI::dbExecute(conn, create_daily_sessions_table_query)
DBI::dbExecute(conn, create_roles_table_query)
DBI::dbExecute(conn, create_user_roles_table_query)
DBI::dbExecute(conn, create_subscriptions_table_query)
DBI::dbExecute(conn, create_billings_table_query)
DBI::dbExecute(conn, create_email_templates_table_query)

# disconnect --------------------------------------------------------------

DBI::dbDisconnect(conn)

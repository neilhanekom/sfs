--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.2
-- Dumped by pg_dump version 9.5.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: payment_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE payment_status AS ENUM (
    'outstanding',
    'complete',
    'late'
);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: addresses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE addresses (
    id integer NOT NULL,
    addressline1 character varying NOT NULL,
    addressline2 character varying,
    suburb character varying NOT NULL,
    town character varying NOT NULL,
    city character varying NOT NULL,
    province character varying NOT NULL,
    postcode character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    customer_id integer
);


--
-- Name: addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE addresses_id_seq OWNED BY addresses.id;


--
-- Name: customers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE customers (
    id integer NOT NULL,
    f_name character varying NOT NULL,
    l_name character varying NOT NULL,
    rsaid character varying NOT NULL,
    neigbour character varying,
    phone character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE customers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE customers_id_seq OWNED BY customers.id;


--
-- Name: loans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE loans (
    id integer NOT NULL,
    loan_date date NOT NULL,
    agreement_no character varying NOT NULL,
    salesrep_id integer NOT NULL,
    customer_id integer NOT NULL,
    loan_amount numeric(8,2),
    admin_fee character varying,
    total_amount character varying,
    balance numeric(8,2),
    installments integer NOT NULL,
    final_payment_date date NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: loans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE loans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: loans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE loans_id_seq OWNED BY loans.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE payments (
    id integer NOT NULL,
    customer_id integer NOT NULL,
    loan_id integer NOT NULL,
    receipt_no character varying NOT NULL,
    date_paid date NOT NULL,
    date_due date NOT NULL,
    amount_due numeric(8,2),
    amount_paid numeric(8,2),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    payment_status payment_status
);


--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE payments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE payments_id_seq OWNED BY payments.id;


--
-- Name: salesreps; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE salesreps (
    id integer NOT NULL,
    f_name character varying NOT NULL,
    l_name character varying NOT NULL
);


--
-- Name: salesreps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE salesreps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: salesreps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE salesreps_id_seq OWNED BY salesreps.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    id integer NOT NULL,
    f_name character varying DEFAULT ''::character varying NOT NULL,
    l_name character varying DEFAULT ''::character varying NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    role integer
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY addresses ALTER COLUMN id SET DEFAULT nextval('addresses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY customers ALTER COLUMN id SET DEFAULT nextval('customers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY loans ALTER COLUMN id SET DEFAULT nextval('loans_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY payments ALTER COLUMN id SET DEFAULT nextval('payments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY salesreps ALTER COLUMN id SET DEFAULT nextval('salesreps_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: customers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: loans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY loans
    ADD CONSTRAINT loans_pkey PRIMARY KEY (id);


--
-- Name: payments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: salesreps_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY salesreps
    ADD CONSTRAINT salesreps_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: customers_lower_f_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX customers_lower_f_name ON customers USING btree (lower((f_name)::text) varchar_pattern_ops);


--
-- Name: customers_lower_l_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX customers_lower_l_name ON customers USING btree (lower((l_name)::text) varchar_pattern_ops);


--
-- Name: index_customers_on_rsaid; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_customers_on_rsaid ON customers USING btree (rsaid);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: fk_rails_ba3831bab8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY loans
    ADD CONSTRAINT fk_rails_ba3831bab8 FOREIGN KEY (customer_id) REFERENCES customers(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO schema_migrations (version) VALUES ('20160422060608');

INSERT INTO schema_migrations (version) VALUES ('20160422070418');

INSERT INTO schema_migrations (version) VALUES ('20160423083345');

INSERT INTO schema_migrations (version) VALUES ('20160424153227');

INSERT INTO schema_migrations (version) VALUES ('20160425175317');

INSERT INTO schema_migrations (version) VALUES ('20160425195208');

INSERT INTO schema_migrations (version) VALUES ('20160427063619');

INSERT INTO schema_migrations (version) VALUES ('20160427063645');

INSERT INTO schema_migrations (version) VALUES ('20160427094104');

INSERT INTO schema_migrations (version) VALUES ('20160428194202');

INSERT INTO schema_migrations (version) VALUES ('20160429091039');


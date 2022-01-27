-- Table Definition ----------------------------------------------

CREATE TABLE brand (
    id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
    name text NOT NULL
);

-- Indices -------------------------------------------------------

CREATE UNIQUE INDEX brand_pkey ON brand(id uuid_ops);

-- Table Definition ----------------------------------------------

CREATE TABLE car (
    id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
    model text NOT NULL,
    brand_id uuid NOT NULL,
    image_url text NOT NULL,
    start_day_price_euro_excl_vat double precision NOT NULL,
    seats integer NOT NULL,
    doors integer NOT NULL,
    year integer NOT NULL,
    horsepower integer NOT NULL,
    wltp_range_km integer NOT NULL,
    battery_capacity_kwh double precision NOT NULL
);

-- Indices -------------------------------------------------------

CREATE UNIQUE INDEX "Car_pkey" ON car(id uuid_ops);

-- Table Definition ----------------------------------------------

CREATE TABLE country (
    id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
    name text NOT NULL
);

-- Indices -------------------------------------------------------

CREATE UNIQUE INDEX "Country_pkey" ON country(id uuid_ops);

-- Table Definition ----------------------------------------------

CREATE TABLE city (
    id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
    name text NOT NULL,
    country_id uuid REFERENCES country(id)
);

-- Indices -------------------------------------------------------

CREATE UNIQUE INDEX "City_pkey" ON city(id uuid_ops);

-- Table Definition ----------------------------------------------

CREATE TABLE location (
    id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
    name text NOT NULL,
    city_id uuid NOT NULL REFERENCES city(id),
    latitude text NOT NULL,
    longitude text NOT NULL
);

-- Indices -------------------------------------------------------

CREATE UNIQUE INDEX "Location_pkey" ON location(id uuid_ops);


-- Table Definition ----------------------------------------------

CREATE TABLE client (
    id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
    first_name text,
    last_name text,
    phone_number text,
    email_address text NOT NULL,
    auth0_id text NOT NULL
);

-- Indices -------------------------------------------------------

CREATE UNIQUE INDEX "Client_pkey" ON client(id uuid_ops);

-- Table Definition ----------------------------------------------

CREATE TABLE reservation (
    id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
    client_id uuid REFERENCES client(id),
    car_id uuid REFERENCES car(id),
    location_id uuid REFERENCES location(id),
    date_time_start timestamp without time zone NOT NULL,
    date_time_stop timestamp without time zone NOT NULL,
    total_price_euro_excl_vat double precision NOT NULL
);

-- Indices -------------------------------------------------------

CREATE UNIQUE INDEX reservation_pkey ON reservation(id uuid_ops);

-- Table Definition ----------------------------------------------

CREATE TABLE reservation_option (
    id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
    name text NOT NULL,
    description text,
    day_price_euro_excl_vat double precision NOT NULL
);

-- Indices -------------------------------------------------------

CREATE UNIQUE INDEX reservation_option_pkey ON reservation_option(id uuid_ops);

-- Table Definition ----------------------------------------------

CREATE TABLE reservation_reservation_option (
    reservation_id uuid REFERENCES reservation(id),
    reservation_option_id uuid REFERENCES reservation_option(id)
);

-- Table Definition ----------------------------------------------

CREATE TABLE car_location (
    car_id uuid REFERENCES car(id),
    location_id uuid REFERENCES location(id)
);

-- Table Definition ----------------------------------------------

CREATE TABLE car_option (
    id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
    name text NOT NULL
);

-- Indices -------------------------------------------------------

CREATE UNIQUE INDEX "carOption_pkey" ON car_option(id uuid_ops);

-- Table Definition ----------------------------------------------

CREATE TABLE car_car_option (
    car_id uuid REFERENCES car(id),
    car_option_id uuid REFERENCES car_option(id)
);


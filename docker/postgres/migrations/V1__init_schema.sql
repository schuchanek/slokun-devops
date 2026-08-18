CREATE TABLE IF NOT EXISTS public.cities (
    id SERIAL PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    country VARCHAR(80) NOT NULL,
    geom GEOGRAPHY(Point, 4326)
);

CREATE TABLE IF NOT EXISTS public.saunas (
    id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    city_id INTEGER REFERENCES public.cities(id),
    location GEOGRAPHY(Point, 4326),
    rating NUMERIC(3, 2) DEFAULT 0,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

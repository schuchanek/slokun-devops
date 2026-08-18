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

INSERT INTO public.cities (name, country, geom)
VALUES
    ('Budapest', 'Hungary', ST_GeogFromText('POINT(19.0402 47.4979)')),
    ('Szeged', 'Hungary', ST_GeogFromText('POINT(20.1472 46.2530)')),
    ('Pécs', 'Hungary', ST_GeogFromText('POINT(18.2323 46.0711)'))
ON CONFLICT DO NOTHING;

INSERT INTO public.saunas (name, city_id, location, rating)
VALUES
    ('Széchenyi Gyógyfürdő', 1, ST_GeogFromText('POINT(19.0402 47.4979)'), 4.8),
    ('Rudas Baths', 1, ST_GeogFromText('POINT(19.0411 47.4958)'), 4.7),
    ('Szolnok Wellness', 2, ST_GeogFromText('POINT(20.1472 46.2530)'), 4.6)
ON CONFLICT DO NOTHING;

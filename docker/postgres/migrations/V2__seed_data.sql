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
    ('Szegedi Fürdő', 2, ST_GeogFromText('POINT(20.1472 46.2530)'), 4.6),
    ('Pécsi Fürdő', 3, ST_GeogFromText('POINT(18.2323 46.0711)'), 4.5)
ON CONFLICT DO NOTHING;

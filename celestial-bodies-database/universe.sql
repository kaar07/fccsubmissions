--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ambigious; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.ambigious (
    ambigious_id integer NOT NULL,
    name character varying(30),
    galaxy_id integer NOT NULL,
    is_asteroid boolean,
    is_recurring boolean
);


ALTER TABLE public.ambigious OWNER TO freecodecamp;

--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    star_count integer NOT NULL,
    age numeric(4,2),
    is_spiral boolean,
    name character varying(30)
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    planet_id integer NOT NULL,
    only_moon boolean,
    name character varying(30),
    radius numeric(6,1)
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    star_id integer NOT NULL,
    diameter numeric(6,0),
    description text,
    moon_count integer,
    name character varying(30)
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    galaxy_id integer NOT NULL,
    is_milkyway boolean,
    name character varying(30),
    distfromearth numeric(6,2)
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Data for Name: ambigious; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

COPY public.ambigious (ambigious_id, name, galaxy_id, is_asteroid, is_recurring) FROM stdin;
1	Halley comet	1	f	t
2	Ceres	1	t	t
3	Shoemaker Levy 9	1	f	f
\.


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

COPY public.galaxy (galaxy_id, star_count, age, is_spiral, name) FROM stdin;
1	250	13.61	t	Milky Way
2	1000	10.01	f	Andromeda
3	1	0.25	f	Canis Major
4	100	13.28	t	Black Eye
6	100	0.43	t	Whirlpool
5	30	13.20	f	Messier 82
\.


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

COPY public.moon (moon_id, planet_id, only_moon, name, radius) FROM stdin;
1	3	t	Moon	1737.0
2	5	f	Europa	1560.0
3	5	f	Ganymede	2634.0
4	6	f	Titan	2574.0
5	5	f	Calistor	2410.0
6	5	f	Lo	1827.0
7	8	f	Triton	1353.0
8	6	f	Mimus	198.0
9	6	f	Enceladus	252.0
10	4	f	Phobos	11.0
11	6	f	Lapetus	734.0
12	9	f	Charon	606.0
13	6	f	Epimethus	58.0
14	6	f	Hyperion	135.0
15	5	f	Carme	23.0
16	5	f	Himalia	85.0
17	6	f	Tethys	531.0
18	6	f	Dione	561.0
19	4	f	Deimos	6.2
20	7	f	Miranda	237.0
\.


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

COPY public.planet (planet_id, star_id, diameter, description, moon_count, name) FROM stdin;
1	7	4879	Smallest planet	0	Mercury
2	7	12104	Visible on mornings	0	Venus
3	7	12756	Blue Planet of life	1	Earth
4	7	6792	Red planet	2	Mars
5	7	142984	Largest planet	79	Jupiter
6	7	120536	Ring planet	82	Saturn
7	7	51118	Cool blue	27	Uranus
8	7	49528	Farthest from sun,officially	14	Neptune
9	7	2376	Dwarf planet	5	Pluto
10	1	10300	Possible planet	0	Proxima d
11	1	16500	Exo planet	0	Proxima b
12	7	3210	Dwarf planet	1	Eris
\.


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

COPY public.star (star_id, galaxy_id, is_milkyway, name, distfromearth) FROM stdin;
1	1	t	Proxima Centauri	4.20
2	1	t	Alpha Centauri	4.30
4	1	t	Vega	25.00
5	2	f	Nembus 51	177.00
3	1	t	Sirius	8.60
6	1	t	Altair	16.73
7	1	t	Sun	0.00
\.


--
-- Name: ambigious ambigious_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.ambigious
    ADD CONSTRAINT ambigious_name_key UNIQUE (name);


--
-- Name: ambigious ambigious_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.ambigious
    ADD CONSTRAINT ambigious_pkey PRIMARY KEY (ambigious_id);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: ambigious ambigious_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.ambigious
    ADD CONSTRAINT ambigious_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--


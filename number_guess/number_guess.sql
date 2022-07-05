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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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
-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.games (
    user_id integer NOT NULL,
    guesses integer NOT NULL
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    name character varying(30) NOT NULL
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (1, 3);
INSERT INTO public.games VALUES (1, 2);
INSERT INTO public.games VALUES (1, 1);
INSERT INTO public.games VALUES (1, 6);
INSERT INTO public.games VALUES (2, 6);
INSERT INTO public.games VALUES (2, 10);
INSERT INTO public.games VALUES (1, 9);
INSERT INTO public.games VALUES (3, 939);
INSERT INTO public.games VALUES (3, 890);
INSERT INTO public.games VALUES (4, 820);
INSERT INTO public.games VALUES (4, 877);
INSERT INTO public.games VALUES (3, 857);
INSERT INTO public.games VALUES (3, 673);
INSERT INTO public.games VALUES (3, 126);
INSERT INTO public.games VALUES (5, 382);
INSERT INTO public.games VALUES (5, 788);
INSERT INTO public.games VALUES (6, 248);
INSERT INTO public.games VALUES (6, 517);
INSERT INTO public.games VALUES (5, 173);
INSERT INTO public.games VALUES (5, 248);
INSERT INTO public.games VALUES (5, 891);
INSERT INTO public.games VALUES (7, 433);
INSERT INTO public.games VALUES (7, 623);
INSERT INTO public.games VALUES (8, 50);
INSERT INTO public.games VALUES (8, 728);
INSERT INTO public.games VALUES (7, 112);
INSERT INTO public.games VALUES (7, 327);
INSERT INTO public.games VALUES (7, 335);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (1, 'kaarthik');
INSERT INTO public.users VALUES (2, 'wayne');
INSERT INTO public.users VALUES (3, 'user_1657043053849');
INSERT INTO public.users VALUES (4, 'user_1657043053848');
INSERT INTO public.users VALUES (5, 'user_1657043102058');
INSERT INTO public.users VALUES (6, 'user_1657043102057');
INSERT INTO public.users VALUES (7, 'user_1657043168808');
INSERT INTO public.users VALUES (8, 'user_1657043168807');


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 8, true);


--
-- Name: users users_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_name_key UNIQUE (name);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: games games_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--



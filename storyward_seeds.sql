--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: nodes; Type: TABLE; Schema: public; Owner: sethgrotelueschen; Tablespace: 
--

CREATE TABLE nodes (
    id integer NOT NULL,
    user_id integer,
    title character varying(255),
    content text,
    parent_node integer,
    children_nodes integer[] DEFAULT '{}'::integer[],
    terminal boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    parent_path integer[] DEFAULT '{}'::integer[]
);


ALTER TABLE public.nodes OWNER TO sethgrotelueschen;

--
-- Name: nodes_id_seq; Type: SEQUENCE; Schema: public; Owner: sethgrotelueschen
--

CREATE SEQUENCE nodes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nodes_id_seq OWNER TO sethgrotelueschen;

--
-- Name: nodes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sethgrotelueschen
--

ALTER SEQUENCE nodes_id_seq OWNED BY nodes.id;


--
-- Name: nodes_stories; Type: TABLE; Schema: public; Owner: sethgrotelueschen; Tablespace: 
--

CREATE TABLE nodes_stories (
    id integer NOT NULL,
    node_id integer,
    story_id integer
);


ALTER TABLE public.nodes_stories OWNER TO sethgrotelueschen;

--
-- Name: nodes_stories_id_seq; Type: SEQUENCE; Schema: public; Owner: sethgrotelueschen
--

CREATE SEQUENCE nodes_stories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nodes_stories_id_seq OWNER TO sethgrotelueschen;

--
-- Name: nodes_stories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sethgrotelueschen
--

ALTER SEQUENCE nodes_stories_id_seq OWNED BY nodes_stories.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: sethgrotelueschen; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO sethgrotelueschen;

--
-- Name: stars; Type: TABLE; Schema: public; Owner: sethgrotelueschen; Tablespace: 
--

CREATE TABLE stars (
    id integer NOT NULL,
    story_id integer,
    user_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.stars OWNER TO sethgrotelueschen;

--
-- Name: stars_id_seq; Type: SEQUENCE; Schema: public; Owner: sethgrotelueschen
--

CREATE SEQUENCE stars_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stars_id_seq OWNER TO sethgrotelueschen;

--
-- Name: stars_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sethgrotelueschen
--

ALTER SEQUENCE stars_id_seq OWNED BY stars.id;


--
-- Name: stories; Type: TABLE; Schema: public; Owner: sethgrotelueschen; Tablespace: 
--

CREATE TABLE stories (
    id integer NOT NULL,
    title character varying(255),
    user_id integer,
    node_id integer
);


ALTER TABLE public.stories OWNER TO sethgrotelueschen;

--
-- Name: stories_id_seq; Type: SEQUENCE; Schema: public; Owner: sethgrotelueschen
--

CREATE SEQUENCE stories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stories_id_seq OWNER TO sethgrotelueschen;

--
-- Name: stories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sethgrotelueschen
--

ALTER SEQUENCE stories_id_seq OWNED BY stories.id;


--
-- Name: taggings; Type: TABLE; Schema: public; Owner: sethgrotelueschen; Tablespace: 
--

CREATE TABLE taggings (
    id integer NOT NULL,
    tag_id integer,
    taggable_id integer,
    taggable_type character varying(255),
    tagger_id integer,
    tagger_type character varying(255),
    context character varying(128),
    created_at timestamp without time zone
);


ALTER TABLE public.taggings OWNER TO sethgrotelueschen;

--
-- Name: taggings_id_seq; Type: SEQUENCE; Schema: public; Owner: sethgrotelueschen
--

CREATE SEQUENCE taggings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.taggings_id_seq OWNER TO sethgrotelueschen;

--
-- Name: taggings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sethgrotelueschen
--

ALTER SEQUENCE taggings_id_seq OWNED BY taggings.id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: sethgrotelueschen; Tablespace: 
--

CREATE TABLE tags (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE public.tags OWNER TO sethgrotelueschen;

--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: sethgrotelueschen
--

CREATE SEQUENCE tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tags_id_seq OWNER TO sethgrotelueschen;

--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sethgrotelueschen
--

ALTER SEQUENCE tags_id_seq OWNED BY tags.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: sethgrotelueschen; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    provider character varying(255),
    uid character varying(255),
    name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    image_url character varying(255)
);


ALTER TABLE public.users OWNER TO sethgrotelueschen;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: sethgrotelueschen
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO sethgrotelueschen;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sethgrotelueschen
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sethgrotelueschen
--

ALTER TABLE ONLY nodes ALTER COLUMN id SET DEFAULT nextval('nodes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sethgrotelueschen
--

ALTER TABLE ONLY nodes_stories ALTER COLUMN id SET DEFAULT nextval('nodes_stories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sethgrotelueschen
--

ALTER TABLE ONLY stars ALTER COLUMN id SET DEFAULT nextval('stars_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sethgrotelueschen
--

ALTER TABLE ONLY stories ALTER COLUMN id SET DEFAULT nextval('stories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sethgrotelueschen
--

ALTER TABLE ONLY taggings ALTER COLUMN id SET DEFAULT nextval('taggings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sethgrotelueschen
--

ALTER TABLE ONLY tags ALTER COLUMN id SET DEFAULT nextval('tags_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sethgrotelueschen
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: nodes; Type: TABLE DATA; Schema: public; Owner: sethgrotelueschen
--

COPY nodes (id, user_id, title, content, parent_node, children_nodes, terminal, created_at, updated_at, parent_path) FROM stdin;
2	3	The Vanishing Girl	 There's something about the Vanishing Girl. \r\n I watch her from the Presto Portraits booth of the county fair. A man in a cowboy hat is painting my portrait with punchy, animated strokes; if he's not finished in six minutes, the portrait's free. He tells me to angle my head left, and that's when I see her. The Vanishing Girl, her sign proclaims her. I allow myself to stare. After all, I'm posing for a picture; I can't look away. \r\n The girl leans drearily forward, sucking on a strand of muddy red hair. Give me something of yours, her sign reads, and I'll make it vanish before your eyes! No tricks, just magic. Only two dollars. But one look into her flat hazel eyes and I have a hard time imagining her mustering the energy to paint the bright red letters of that sign. \r\n As I watch, a customer approaches, corralling her young son beside her. "Oh look, Patrick, magic! This should be fun. What should we give the lady?" \r\n The boy shrugs up to his ears. \r\n "Well, let's see..." the woman reaches into her purse and pulls out a pair of blue-handled scissors. "I can get these back at the end, right dear?" \r\n The Vanishing Girl's eyes widen slightly, as though she doesn't understand the question. "No," she breathes. "I can only vanish." \r\n The woman seems to consider arguing but then sighs and produces two dollars. "Well, here we go then. Patrick, can you see?" She bends down to pick up her son just as the girl reaches out her left hand and touches the scissors. \r\n They disappear. \r\n   	0	{}	\N	2013-09-13 03:38:32.387045	2013-09-13 03:38:32.394848	{}
3	4	The Velveteen Rabbit Says Goodbye	 There once was a rabbit who had been made of velveteen. For many years now he'd been Real--not just Real in the eyes of the Boy who loved him, but real to the world of grown-ups and rabbits with twitching noses and springy hind legs. \r\n The Rabbit's hind legs weren't as springy as they'd once been. They ached in the wintertime, and he hopped more slowly. He liked nothing better than to lie in a sunny patch by the thicket of overgrown raspberry canes and dream of the days when the Boy had held him close and warm beneath soft blankets. \r\n He was drowsing like this when he felt someone stroke the fur between his ears. He opened his eyes to see a dainty figure in a dress of pearls and dewdrops. Her face would have been quite the loveliest thing the Rabbit had ever seen, if it weren't all wet with tears. \r\n "I know you," said the Rabbit. "You made me Real." \r\n \r\n "I gave you flesh and fur, long ago," said the Nursery Magic Fairy. "Your Boy made you Real." \r\n "But you're crying! Whatever is wrong, dear Fairy?" \r\n A new tear trickled down her dainty nose. "Do you remember your Boy?" \r\n "Of course! He got tall and strong, and went off to a place called War." \r\n "War isn't a place, little Rabbit. It's a terrible thing that grown-ups do when they forget that others are Real." \r\n "And my Boy is there?" \r\n "He calls for you in his sleep." \r\n 	0	{}	\N	2013-09-13 03:39:52.327308	2013-09-13 03:39:52.334238	{}
1	3	The Witch's Cat	 We knew the witch was dead when her cat showed up on our doorstep. Mom found him sitting patiently beside the morning's milk delivery, like he was waiting for his share of the cream. She only called to Dad, but the tone of her voice got us both up from the breakfast table until we all stood in the entryway to stare at the cat. \r\n "You poor thing," Mom said, wrapping both the cat and his former mistress up in one expression of pity. "Won't you come in?" The cat took the invitation and stepped over the threshold of our house, weaving between Mom's ankles in a figure eight of appreciation. My father leaned down to pet him, and I heard the murmur of his voice as he spoke to the cat. Whatever he said seemed to satisfy the cat, who then made his way to me. I reached down and ran my hand along his back, which struck up a low, deep purr from his chest. Mom gathered up the milk bottles, Dad closed the front door, and the two of them shared a look. \r\n "Your mother and I are going to have to make some calls," said Dad. "Can you keep yourself busy? Out of the house?" \r\n \r\n I had made plans to spend the rest of the day watching cartoons and eating cereal straight from the box, but Dad's expression let me know there was little room for negotiation. "Okay," I said. \r\n "And take the cat with you." \r\n   \r\n 	0	{14}	\N	2013-09-13 03:37:38.373699	2013-09-13 04:09:52.666964	{}
4	4	The Remnant	 We expected them to be better at it. The aliens. You've only got to go to the movies to know that we expected explosions, telepathy, ray guns. We thought it would be something drawn-out and gruesome, or maybe quick and painless. But either way--big. \r\n The invasion looked bad in the beginning. On the first night, we saw weird damn flashes in the sky over the gulch, and the sound of the ships made lightning crawl across my shoulders. Earth's cities took some damage, but it didn't make much sense. They went for bridges and highway overpasses. \r\n And out here in the middle of nowhere, it was all bark, no bam. \r\n The stuff that ended it was pink. And it made everyone's nostrils burn for an hour like we'd just snorted soda up the wrong set of pipes, but it did the job. \r\n I don't know where it came from, but Earth's governments shot it into the atmosphere a couple of days after the invasion started. Within hours, all that was left was the cleanup. Pale gray ships drifting through the clouds like ghostly stingrays. Millions and millions of bodies, mostly theirs. 	0	{}	\N	2013-09-13 03:40:36.11476	2013-09-13 03:40:36.176018	{}
7	6	Self and Self	 Jane woke Kim. \r\n "You were dreaming," Jane whispered from the top bunk. "Twitching." \r\n Kim scrunched her face as if searching the corners of her mind with a flashlight. The look of uncertainty upset Jane. Kim's face was her face, too. They were twins. Whatever Kim felt, Jane felt obliged to feel. \r\n "Was I?" Kim asked. \r\n "Tell me," Jane said. \r\n "I can't. I don't remember the dream." \r\n Jane glared at her. "You take watch now." \r\n Kim huffed as if Jane had woken her because she couldn't keep her eyes open. \r\n "You swore," Jane said. \r\n Kim fingered her palm's scab and nodded. \r\n "If I twitch," Jane said, "wake me. Don't let me dream like them." \r\n "I won't." \r\n "Pick at the scab," Jane said. "It'll keep you awake." She showed Kim her bloody palm, then climbed down and traded bunks. \r\n She didn't know how she had expected an alien invasion to go, but this wasn't it. No spaceships, no soldiers, no violence. The enemy remained light-years away, until suddenly you dreamed their dreams for them and they dreamed yours. Then, the switch: you were in their bodies and they were in yours. \r\n The morning alarm woke Jane. Kim peered down at her bleary-eyed, gave a weak smile. They headed downstairs. \r\n   	0	{}	\N	2013-09-13 03:49:45.496686	2013-09-13 03:49:45.510342	{}
8	6	Visiting Planet Earth	 visit your planet from time to time, but it really is too painful. \r\n My race is immortal now, and our client races are immortal, too, or have transcended bodily form and exist in virtual realms, which is immortality by another route. \r\n But you humans are the only sentient beings we have discovered whose lifespans are finite. \r\n It pains me to visit planet Earth. \r\n Let me tell you about my last landfall. 	0	{}	\N	2013-09-13 03:50:17.288573	2013-09-13 03:50:17.337639	{}
20	2	Grocery Store	 We made our way to the grocery store where I found a few tins of cat food. When we reached the checkout, Sampson jumped up on the counter so the lady running the register could scratch under his chin and whisper into his ear. I tried to pay for the cat food, but the lady waved away my money and called for her shift supervisor, who called for the store manager, who went and got the butcher. The butcher hardly caught sight of Sampson before he ran back to his department and returned with steaks and fresh ground meat. Sampson purred as he tore into the meat, and the butcher watched him closely as he ate. When he leaned in to say what he had to say, I was already standing close enough to listen in without being noticed. \r\n "Your witch saved our little boy," the butcher said. "We won't forget that, and we won't forget her." \r\n When the butcher stepped away, another person stepped up to say something, and soon we had the whole store around us. It seemed like everyone had something to say to Sampson, and I realized that I probably ought to make sure everyone got their chance. 	19	{22}	\N	2013-09-13 04:21:24.3023	2013-09-13 04:23:52.002554	{5,19}
21	2	Uh - oh	 I spent the rest of the day taking Sampson around town. Wherever we went, there were people who recognized him and had to say something to him. By lunchtime, Sampson had started lagging behind me as we walked, so I started carrying him to make it easier on the little creature. We stopped so that I could feed him a tin of the cat food and that seemed to do him some good. \r\n We made it to the courthouse, the school, the pharmacy, and anywhere else that had a door for me to open. Once we were through with the old folks home, it seemed like Sampson was worn out for the day. He fell asleep as I carried him between places and only stirred himself when he heard a new voice nearby. \r\n "Let's go home," I said to Sampson. "We'll get you some rest and maybe tomorrow--" \r\n Sampson did not let me finish, instead he dug every claw he owned into my skin so that I knew exactly how he felt about my suggestion. \r\n "Fine," I said. "I'll keep going as long as you will." \r\n After that, we went to the post office and the florists. People pressed their mouths to the cat's ears and I held him still so they could have their turn before we moved on. Sampson mewled up at me, like a kitten might, and I took a moment to sit on the curb and comfort him before we headed on our way. \r\n "One last place," I told him. "You know where it is." \r\n I walked up the only hill in town to where the witch had lived. Her home was a small cottage that had been built by the town, with a set of flowerbeds beneath the front windows that was tended by a local bridge club. To my surprise, I was not alone. Dozens of people milled around the house, waiting near what looked like a huge pile of kindling. Sampson cuddled against my neck as I walked up to the scene. \r\n "What's happening?" I asked the question to no one in particular. There was a wave of motion in the crowd and I saw my mother push her way towards me. \r\n "You're just in time," she said. When she saw my blank face, she continued, "We're all here to honor our witch, and we each brought something special to give to her as thanks. Think of this as a tribute to her life." \r\n   	5	{27,32}	\N	2013-09-13 04:22:16.1354	2013-09-13 04:37:12.553931	{5}
13	1	Chapter 2	 She smiled with my teeth again. It wasn't as unnerving this time. \r\n I ventured, "How old are you now?" I corrected myself, "I mean, I know how old you are, but how close are you to being, uhm, an adult? You'd be old enough to vote now, if you were human--" The word choked in my throat. I didn't mean to make it sound like she wasn't my child. Like I thought she was some stranger. \r\n She didn't seem to notice. "I'm old enough to breed, but I haven't chosen a mate." She smirked, "I have a whole colony to choose from." \r\n I nodded that I understood. \r\n Her father had explained. How his species explored and colonized star systems far from their home world. They incorporated worthy qualities found in other species into those colonies. They were interested in experimenting with the male/female dichotomy. I was the model they used to build the new, female aspect of their species. The ability to recombine their forms would allow the mate the first female selected to accommodate her reproductive biology. \r\n Why then? I had asked. Why do you need me at all? Just have one of your underlings turn into a woman and leave me alone. But there was something that they needed. Some inscrutable quality that couldn't be faked with transmogrification and cellular plasticity. \r\n I felt the old conflict playing across my face. My gaze wandered to her hands again, resting on the table between us. She had the human number of joints, even if she had too many fingers. I wondered what other qualities of mine lurked beneath the surface. 	9	{}	\N	2013-09-13 04:08:49.121373	2013-09-13 04:08:49.312327	{9}
10	7	Inflection	 Beth was breaking down book boxes in the backroom on the day he left. She ran her box cutter down taped seams, split the tape with slashing strokes that ran into the cardboard, ran through the corrugation, frayed bits of brown into fringe. \r\n She had thought she would not see him again. Thought he would return to his home a billion miles away and never say goodbye. Leave her to her own decisions. \r\n But there he stood at the door, the metal door that never locked properly, the one that had to be yanked into submission. \r\n "This is it," he said, and, "It is it." \r\n It aggravated her that even here at the end he couldn't fill in his pronouns. His language didn't, and so he wasn't used to it; he was used to a verbal sea of its and hims modified by gesture, scent, touch. "I am he," he had said when they met, and upon the word "he" had touched his shoulder with one brittle, blue-tinged hand. That meant his name. \r\n Hand, Beth thought. Him. And she ripped the knife through the lines between the flaps, sharp and fast straight into the box. What right had he to possess something that looked like a hand, to identify with he? Alien should mean alien. Incongruous. \r\n Incompatible. \r\n   	0	{}	\N	2013-09-13 03:53:54.327551	2013-09-13 03:53:54.334633	{}
11	1	Epistemology of Disagreement	   \r\n The epistemological puzzle of disagreement can be summed up as follows: How can S  justifiably believe P when her peer believes ~P on the same evidence? Where S is an epistemic agent and P is a proposition with a truth value. Clearly there is a question here which demands our attention. If S and her peer are epistemic peers aware of all the same relevant evidence, then how can they both be justified in believing opposite claims about the truth value of P? Many papers have been written in an attempt to answer this question, but exploring those answers is not the purpose of this paper. The purpose of this paper is to make the answers unnecessary.  	0	{}	\N	2013-09-13 03:57:07.559528	2013-09-13 03:57:07.618782	{}
12	1	Inclusivism	 If I had to choose one of these terms to describe my stance towards various religious beliefs apart from my own I would say I am an inclusivist. Inclusivists believe that while one religion holds an absolutely true set of beliefs, there are other religions who incorporate at least some of these truths. Inclusivism appears to be in part a type of pluralism. Pluralism is the belief that one’s religion is not the sole source of truth. While I believe my religion to contain all truths, other religions declare the same truths and are therefore co-sources of said truth.  \r\n   \r\n I choose these descriptors for myself because I am a Christian, and believe that all truths are displayed for us in the Bible. However, many other religions share the same truths and are therefore sources of it, making me a pluralist. Such as ethical beliefs like abstaining from murder and adultery. There are truths, though, found only in Christianity, like Christ being the son of God and dying for our sins. I believe Christianity to be the only religion in which all truths are in one place, while other religions only have parts of the truth. This belief would lead me to being defined as an inclusivist.  	0	{}	\N	2013-09-13 03:57:54.042916	2013-09-13 03:57:54.051304	{}
5	5	I Heard You Got a Cat, I Heard You Named Him Charles	 heard you got a cat. I heard you named him Charles. I guess you didn't know that I do cats too? \r\n I played all those games you wanted, all those black-blond-red-brown-bald-headed strangers. But you never said you wanted a cat. I could have done that too. \r\n I told you that you'd never have to replace me, and I meant exactly what I said. I told you I could be anything you wanted--or even what you didn't know you wanted. In how many bars did I buy you drinks, wearing how many different skins? Through how many eyes and mouths did I pick you up? With how many hands did I touch you? \r\n All those different men--all me. That hint of danger and thrill of confusion you always wanted, that only I could give you. \r\n I heard you don't go to bars anymore. I heard you're afraid I still do. But that was never what I wanted. That was always just for you. \r\n I was a fox once, before I met you. For three whole months, I was--except, now and then, when I was half of one instead. That wasn't what I wanted either, but I did it because I could. I was the only one who could. \r\n   \r\n And I can do cats too. 	0	{18,19,21}	\N	2013-09-13 03:42:01.926744	2013-09-13 04:22:16.142846	{}
22	2	Nothing	 "I don't have anything," I said. I stepped closer to the pile of kindling and saw that it was made up of hundreds of little trinkets: jewelry, flowers, sealed envelopes, pictures and news clippings, and all the charms that the witch had made over the years. The charms wore out after a while, once they were no longer needed, but people kept them anyways. My Mom had one of her own that had been made for me when I was born too early. I imagined it now, lost in the rest of the offerings meant to show gratitude to the witch. \r\n "You did your part by letting everyone know," Mom said. "Your father and I are so proud." \r\n "What about Sampson?" I asked and gripped him tight. \r\n "Oh, sweetheart, he's just a cat. He can watch if he wants," she said. I nodded and stepped away so we could have a clear view while Mom went back into the crowd. I moved Sampson so that I cradled him like a baby, to make sure he could see everything that went on. His eyes didn't seem to focus on anything now and his breath had grown quick and shallow. By the time I looked up from him to ask for help, someone had lit the bonfire. \r\n I was struck by the beauty of the fire, as its flames had more colors than any fire could make on its own. I didn't know the witch well, but as I watched the fire burn, I remembered her for when she broke the fever of my friend Beverly and how she ran to haul Joseph Meyer out of the frozen lake when he had gone out across the thin ice on a dare. We all stood so close to the fire that I felt like we might burn up with it, but the heat was warm, comforting. The tributes broke down as they burned and soon became one mass of white-hot ash. \r\n My thoughts splintered when Sampson jumped out of my arms and into the fire. I screamed, and the people around me could hardly keep me from trying to follow him in a rescue attempt. He shouldn't have had the strength left to make the leap but he had pushed against my chest like a springboard and burst out of my grip. A gasp rippled through the crowd as Sampson dove into the ashes, the force of his impact sending a spray of sparks into the sky as he disappeared. We heard no howl of pain, we saw no attempt to escape. He was just gone. \r\n After that, it took both of my parents to haul me back home and a doctor to convince me to fall asleep. 	20	{23,40,41,42}	\N	2013-09-13 04:23:51.99575	2013-09-13 05:44:51.946082	{5,19,20}
9	7	Sapience and Maternal Instincts	 She had my teeth. I hadn't expected to recognize myself in her, but when she greeted me, her maroon lips parting into a crescent, there they were. My teeth. White, flat, and surprisingly human. \r\n I forced myself to look into her too large eyes as her warm, seven-fingered hand wrapped around mine. Black with purple specks, like a neon vision of the night sky, the almond-shaped organs took up the greater part of her face and were irrevocably her father's. \r\n "I was afraid you wouldn't make it," she breathed, her voice sing-song like the rest of her species. \r\n "Got lost after the second exit on ninety-five," I lied. I didn't want her to know that I'd spent half an hour with my face over the toilet, retching with nerves at the prospect of finally meeting her. My daughter. \r\n "Shall we sit?" She gestured with elongated limbs toward the cushiony, ornate table and chairs of the meeting room. \r\n Silence. \r\n I tried not to stare at her taut maroon skin, her too long fingers, her high cheek bones. She watched me fiddle with my wedding rings. \r\n "You don't have to stay." Her voice was reluctant as she continued, "If this is making you uncomfortable, I mean." \r\n With threadbare resolve I looked into her eyes, "No, I'm glad to see you..." I cleared my throat. "Your father told me that it wouldn't be possible to see you after the birth. I thought I'd never know what became of you." I added, "I'm glad to see you well." I surprised myself at the sincerity. 	0	{13}	\N	2013-09-13 03:52:51.931083	2013-09-13 04:08:49.13185	{}
14	1	Sampson	 The cat's name was Sampson. He was small with the black, velvety fur that you'd hope a witch's cat would have. I knew his name because everybody in town knew Sampson; he was always at the witch's side when she made house visits and was her herald when she ran errands at the library or hardware store. He would perch on her shoulder like a parrot or curl himself up in the basket of vegetables she bought at the farmer's market, cramming himself between the carrots and bundles of fresh herbs like he was meant to be there. Even if you were new in town you'd know his name because the witch had embroidered it onto his collar. I didn't think that a creature owned by a witch should tolerate wearing a collar, but he never seemed to mind the jingle of the metal tags that proved he had all his shots. \r\n I wandered around the neighborhood and tried to think of how to spend the day. Sampson was happy to walk along with me, occasionally darting into a yard to terrorize the local squirrel population before trotting back to my side. It occurred to me that he probably hadn't been fed yet and must be hungry, so I decided to head down to the grocery store. Once we got away from the houses and closer to Main Street, Sampson walked in front of me with his tail held high, like the drum major of his own one-cat, one-kid parade. We started to run into other people who caught sight of the cat before they noticed me. \r\n "Isn't that the witch's cat?" They'd ask. \r\n "Was," I'd answer. Then whoever asked would kneel down to give Sampson a pat and say something to him that I couldn't catch before they excused themselves and rushed off. Sampson took the attention in stride, even to where he'd let people snatch him up in their arms and give him a tight hug. \r\n   	1	{}	\N	2013-09-13 04:09:52.660953	2013-09-13 04:09:52.675252	{1}
15	2	Autumn	 A couple of autumn leaves blow onto the table, and Nelli brushes them off impatiently. Shading her eyes against the slanting sunlight, she looks expectantly at Kate. \r\n Kate's appalled. "You're going to marry Quentin? Omigod, Nelli, he's not even human! And you've been dating all these months? You never said!" \r\n "What do you mean, not human?" Nelli drops her fork, looking offended. "Of course he's human." \r\n "Girl, humans don't have feathers." \r\n "Feathers? What are you talking about, feathers?" \r\n An arguing couple walks past their table, followed by two teenagers with ice-cream cones. Kate waits until they are out of earshot, and drops her voice anyway. \r\n "Quentin Coates has feathers!" \r\n "Have you seen any feathers?" asks Nelli, looking her in the eye. \r\n "You told me in April! When he first asked you out." \r\n "You're imagining it," Nelli says flatly. "Quentin doesn't have feathers. In fact, he waxes." \r\n She pushes her chair back, knocking her half-finished rice salad onto the ground. It spills damply from the plastic tub. \r\n "I was going to ask you to be a bridesmaid." She stands, picks up her bag. "But I changed my mind. See you back at work." \r\n Kate stares after her. A dove descends on the fallen food. 	6	{}	\N	2013-09-13 04:14:07.53719	2013-09-13 04:14:07.556148	{6}
29	2	Long Journey	 "It wouldn't work. Not among them," he said, and them was inflected with reverence, subordinance, personal shame. His hands left her face. \r\n There seemed nothing else to say, so she held out the Hemingway so her hands had something to do. It was a best-of collection; the cover art showed white hills in a brown landscape. Hills like white elephants, she thought, and suddenly held it out to him. "You'd better take it," she said. "I've already reported it missing, and you'll need something to read." \r\n "Long journey," he agreed, and touched her chin, whispering, "You." Then his oddly-jointed frame was by the door again, leaning out, ready to be gone. Out of her life, out of her atmosphere. "No record, right?" \r\n Beth crushed the box she held against her rounded belly, in a way that might have said, I hate you for leaving, if they spoke the same kind of language, if her physicality meant something to him. "No record," she said. 	28	{}	\N	2013-09-13 04:33:37.912387	2013-09-13 04:33:37.926381	{5,21,27,28}
6	5	Chick Lit	 "Feathers? What do you mean, feathers?" Kate asked her co-worker, taking a bite of her honey-ham sandwich. "Aren't you eating? We're due back in fifteen." \r\n The spring breeze blew Nelli's hair into her face, and she brushed it away impatiently. \r\n "Quentin has feathers," she said. "All over his chest and stuff. Instead of body hair, you know." \r\n "Weird. What color feathers?" \r\n At the next table, a kid threw pieces of bread for the birds. A dove landed briefly on the canvas market umbrella above him. Nelli pointed to it. \r\n "Sort of gray-brown, like that bird. But downy, like a chick. And a few shiny green ones." \r\n "Chicks are yellow," says Kate, pulling her soda toward herself and rattling the ice in the plastic cup. \r\n "I know that, Kate. You know what I mean. Downy but gray." \r\n "Like baby swan thingies, cygnets?" \r\n "Why is it important what it's like? I'm telling you Quentin has feathers!" \r\n   \r\n "All the way down?" asked Kate with interest. \r\n   \r\n "Well, yeah…." Nelli blushed. \r\n Kate laughed. Nelli stiffened, glaring at her. "What's so funny?" \r\n   \r\n \r\n "What, Quentin Coates has got feathers? You're not serious, are you?" said Kate, looking carefully at Nelli. \r\n "I am so serious. You don't even believe me. I wish I didn't even tell you." \r\n "Hey, okay, Nelli," Kate said in a placatory tone. "So what did you do?" \r\n "I didn't know what to do. I just sort of pretended. You know." Nelli took a forkful of risotto. \r\n "Pretended?" \r\n "Pretended like it was normal. Like he didn't have down under his arms and pinfeathers on his chest. Did you notice he always wears long sleeves in the office, even on Fridays?" \r\n "Bummer," said Kate. "And you were so into him and all." \r\n Nelli said nothing, concentrating on her food. \r\n 	0	{15}	\N	2013-09-13 03:42:47.000255	2013-09-13 04:14:07.546432	{}
16	2	Call of the Minaret	 Cragg seems to be a huge fan of the Call of the Minaret, but that is not the point. Perhaps he describes the call in such detail so as to warm us up to the subject. If he immediately describes what the Call means to Muslims we may fill our minds with preconceived notions. The Call of the Minaret is a resounding praise of God, saying there is no God but the one God. Unfortunately any saying involving Allah brings to my mind thoughts far from Godly. It is difficult to hear Allah and not be immediately reminded of the damage terrorists have done in His name.  \r\n Once I get past these immediate thoughts though I try to think about who Allah really is. Is He any different from the God I worship? Deep down I believe the answer is no. Both Christians and Muslims worship one God, creator of the universe. We believe He is not just a supreme deity, but the only deity.  \r\n   \r\n I also realized why Muslims would have a difficulty accepting the Christian idea of a trinity. Muhammad was fighting the Meccan idea of a god with many gods below him. The Christian belief in a Son of God would go against the Muslim belief in a single deity. This has most likely cause tension between the two religions.  	0	{}	\N	2013-09-13 04:15:49.55721	2013-09-13 04:15:49.727265	{}
17	2	The Best World	 Seventeenth century philosopher Gottfried Leibniz argued that given God’s traits, this world we are currently living in must be the best of all possible worlds. The argument is as follows: \r\n   \r\n   God is a morally perfect, all-knowing, and all-powerful being \r\n A morally perfect, all-knowing, all-powerful being always chooses the best of all possible alternatives. \r\n God chose to create <em>this</em> world. \r\n Therefore, this is the best of all possible worlds. (Lawhead, 262) \r\n     \r\n   \r\n The argument is comprised of two separate conditionals. The first conditional comes from a reworking of premise (2). If God is a morally perfect, all-knowing, all-powerful being, then He will choose the best of all possible alternatives. Premise (1) states that God is morally perfect, all-knowing, and all-powerful. From here we have an implicit conclusion that God chooses the best of all possible alternatives. From (1), (2), and the implicit conclusion above comes a new implicit conditional I will call (2.5); If God chose to create this world, then this is the best of all possible worlds. Premise (3) affirms that God did create this world. The conclusion then follows from premise (3) and the implicit conditional (2.5) that (4) this is the best of all possible worlds. The argument contains two conditional statements, with the conclusion of the first motivating the second. 	0	{}	\N	2013-09-13 04:16:41.786914	2013-09-13 04:16:41.793936	{}
23	2	Kitten	 A few weeks later, when the newspaper was done running stories about her, I went back to the witch's house. The place felt empty and lonely without her presence. For as long as I could remember there had always been at least a car or two parked out front or the smell of something cooking coming up from the chimney. I walked up to the house with the hope of finding Sampson's collar among what was left of the tribute's ashes. I wanted something to remember him by. \r\n I kicked around in the ashes, lifting up little else but clouds of dust. Everything that had gone into the pile of tributes had been burnt completely. Disappointed, I sat down on the edge of one of flowerbeds and put my head in my hands. I stayed like that for a while and let the afternoon sun soak into my skin. When I lifted my head again, I found that I was not alone. \r\n A cat, more a kitten, had sat itself down at my feet. My heart twisted as I expected to see a bundle of black fur, but this kitten had a coat that was gray like a rain cloud or the shade of wet cement. \r\n Or gray like the color of ashes. I offered the kitten my hand and it responded with a testing nip. I picked it up and, by the time I lifted it to my chest, it had worked itself into a purr. \r\n "I bet you're hungry," I said. The kitten mewled back at me, and I was not surprised to find that I recognized its voice. By the time I stood up, the little thing was already lulled asleep by the warmth of my hands. \r\n I figured the walk back home would give me enough time to think up a new name. \r\n   	22	{}	\N	2013-09-13 04:24:32.894429	2013-09-13 04:24:32.953179	{5,19,20,22}
26	2	Cheek	 I compose myself, make a conscious decision. I'll only do something small, something she's probably not used to: I smile. Genuine, unaffected. Nothing like a smile to coax out a smile. \r\n Instead, she reaches out her left hand and touches my cheek. \r\n   	25	{}	\N	2013-09-13 04:27:26.910826	2013-09-13 04:27:26.926132	{5,18,24,25}
24	2	Cowboy Hat	 The woman didn't see it. She thinks she was duped and complains loudly. The girl merely looks at her like she's a troll spouting toads instead of words. \r\n I saw it, though. \r\n I'm distracted by my cowboy-hat-guy telling me my portrait is done, and with twenty seconds to spare. I thank him, making pleased sounds about his work, and find a new vantage to watch the girl. \r\n \r\n She's already got two new customers. This time, they both see the plastic cup vanish, as though it never existed. But while they watch the cup, I watch the girl, noticing mostly a lack of things: no pride, no guile, not even boredom colors her face. Perhaps a trace of agitation. She's like a rabbit in a wolf's den, trying not to smell delicious. With her left hand, the apparently magical one, she vanishes pens and sticks and a sock too torn to mend. Her customers leave blinking, equally impressed and discomfited. With her right hand, she makes their money disappear as well. \r\n The girl glances my way, worry lines wrinkling her brow. I'm actually excited she notices me and think about giving her something to vanish myself. \r\n But a dog barks, making us both jump. A little Jack Russell, unleashed, vigorously wagging its tail at her feet. The girl jerks out her left hand and touches it. \r\n It disappears. \r\n 	18	{25}	\N	2013-09-13 04:26:16.48605	2013-09-13 04:26:47.589546	{5,18}
30	2	Teeth	 She had my teeth. I hadn't expected to recognize myself in her, but when she greeted me, her maroon lips parting into a crescent, there they were. My teeth. White, flat, and surprisingly human. \r\n I forced myself to look into her too large eyes as her warm, seven-fingered hand wrapped around mine. Black with purple specks, like a neon vision of the night sky, the almond-shaped organs took up the greater part of her face and were irrevocably her father's. \r\n "I was afraid you wouldn't make it," she breathed, her voice sing-song like the rest of her species. \r\n "Got lost after the second exit on ninety-five," I lied. I didn't want her to know that I'd spent half an hour with my face over the toilet, retching with nerves at the prospect of finally meeting her. My daughter. \r\n "Shall we sit?" She gestured with elongated limbs toward the cushiony, ornate table and chairs of the meeting room. \r\n Silence. \r\n I tried not to stare at her taut maroon skin, her too long fingers, her high cheek bones. She watched me fiddle with my wedding rings. \r\n "You don't have to stay." Her voice was reluctant as she continued, "If this is making you uncomfortable, I mean." \r\n With threadbare resolve I looked into her eyes, "No, I'm glad to see you..." I cleared my throat. "Your father told me that it wouldn't be possible to see you after the birth. I thought I'd never know what became of you." I added, "I'm glad to see you well." I surprised myself at the sincerity. \r\n She smiled with my teeth again. It wasn't as unnerving this time. 	18	{}	\N	2013-09-13 04:35:14.525991	2013-09-13 04:35:14.543815	{5,18}
18	2	The Day	 I wouldn't even need a litter box. I could feed and water myself. I'd never scratch your furniture either--at least not without a cause. \r\n During the day, when you're out and gone, I could change back to a man. I could wash your breakfast dishes, make your morning bed, dust and tidy up your rooms. I could leave chocolate and flowers on your fluffed-up pillows, and I could still be a cat when you returned. \r\n At night, I'd watch you drink your tea and read your books. I'd curl up on your lap. I'd never let you be alone. \r\n I could change at night too, of course, if you ever wanted that. \r\n Or I could stay a cat instead. If that's really all you want, I'd stay a cat for you. Or several cats, perhaps? A different cat every day--tabby, calico, Maltese, Kashmir, tortoiseshell. Whatever you want me to be, I'm not going to beg or threaten you, but I'll take what I can get. \r\n I told you that you'd never have to replace me, but I heard you got a cat. And even though you named him Charles, it's not too late to give him back. 	5	{24,30,31}	\N	2013-09-13 04:18:18.108485	2013-09-13 04:35:56.141934	{5}
25	2	Gape	 I gape. Where there was a dog a moment ago, now there's none. It happened so fast, I don't think anyone else noticed; its single bark still hangs in the air. The Vanishing Girl's eyes meet mine once more, then slide away. She settles back into her slouch, waiting for the next ordeal of the day. \r\n I stumble forward, not sure I believe what just happened. Her depthless eyes almost convince me--there couldn't possibly have been a dog there a moment ago. Who is this girl, who is so beleaguered that she must vanish the world around her, piece by piece? Did her hand inspire her attitude, or was her ability born of some deep-rooted trauma? I find I want to rescue her, and yet am not sure that she is capable of being rescued. \r\n "What?" \r\n I realize that her wraithlike voice is directed at me. I'm just another trial to her, and a particularly stubborn one at that. All illusions of helping this creature vanish, leaving only a craving to understand. \r\n "What do you want from me?" Her voice shudders as though she could cry. As though this is all too much to handle. Why won't I just give her two dollars and let her vanish something so I can go away? \r\n If she seemed to be lacking in expression before, the fear that she radiates now is decidedly human. What force on this Earth made you this way, I wonder. My heart is pounding, as though I've witnessed something intimate in her watery hazel eyes. I try to pull myself away, to end this unintentional torment that I am causing her, but first I need... something. A human connection, an assurance that she hasn't already jumped off the cliff, falling before my very eyes just waiting to hit bottom. 	24	{26,35,36,37}	\N	2013-09-13 04:26:47.581271	2013-09-13 05:29:05.520615	{5,18,24}
27	2	Beth	 Beth was breaking down book boxes in the backroom on the day he left. She ran her box cutter down taped seams, split the tape with slashing strokes that ran into the cardboard, ran through the corrugation, frayed bits of brown into fringe. \r\n She had thought she would not see him again. Thought he would return to his home a billion miles away and never say goodbye. Leave her to her own decisions. \r\n But there he stood at the door, the metal door that never locked properly, the one that had to be yanked into submission. \r\n "This is it," he said, and, "It is it." \r\n It aggravated her that even here at the end he couldn't fill in his pronouns. His language didn't, and so he wasn't used to it; he was used to a verbal sea of its and hims modified by gesture, scent, touch. "I am he," he had said when they met, and upon the word "he" had touched his shoulder with one brittle, blue-tinged hand. That meant his name. \r\n Hand, Beth thought. Him. And she ripped the knife through the lines between the flaps, sharp and fast straight into the box. What right had he to possess something that looked like a hand, to identify with he? Alien should mean alien. Incongruous. \r\n Incompatible. \r\n   	21	{28,33,34}	\N	2013-09-13 04:30:51.535024	2013-09-13 04:39:11.838068	{5,21}
28	2	Fligth	 He moved into the narrow workspace between the piles of empty boxes and the rack of returns of picture books that hadn't sold. The normal scent of him was sharp and alcoholic, like licorice, like anisette. "I'm going back there," he said, and lifted his sharp chin in a way that meant home. \r\n Beth said nothing, but unhooked her knife from the box and ran it through another seam. When she compressed the box, a cardboard flap fell out of the bottom, dumping out a book that she had missed while receiving. A Hemingway collection. She turned it over in her hands. \r\n "I just don't think there should be a record," he said, looking down at her. "That I was here." \r\n "I see." \r\n "And it can't possibly turn out. You know. Like it ought." A flex of his double jointed elbow, the released scent of sulphur--inflections that signified normal. \r\n "Normal, no," she said. Of course it couldn't be. "And that's bad?" \r\n "It's up to you, of course. But think of the difficulties it will have. Neither one thing or another. You see that, don't you?" \r\n Beth had told him her name but he never used it. His name for her was "you," with a light touch on her chin. He did it now as he spoke, and the anisette of him curled along her skin. She did not know how he would describe her when he returned home, how he would represent she when she was not around to have her jaw line stroked. \r\n Silent now, his brittle hands touched her hair, her neck, her jaw again. Without the spoken pronoun what did the touch on her chin mean to him? Half a language was an echo, perhaps, a whisper, voices dying in the distance. \r\n "I could come with you," Beth said suddenly. It had been lurking in the back of her mind for three weeks now, but she hadn't dared to say it, only express it in hand and eye and tongue. A billion miles away. Away from everybody. The decision would be easy then, when she was fast in his arms, in flight from this life. 	27	{29}	\N	2013-09-13 04:33:09.066969	2013-09-13 04:33:37.91919	{5,21,27}
31	2	Memories	 I ventured, "How old are you now?" I corrected myself, "I mean, I know how old you are, but how close are you to being, uhm, an adult? You'd be old enough to vote now, if you were human--" The word choked in my throat. I didn't mean to make it sound like she wasn't my child. Like I thought she was some stranger. \r\n She didn't seem to notice. "I'm old enough to breed, but I haven't chosen a mate." She smirked, "I have a whole colony to choose from." \r\n I nodded that I understood. \r\n Her father had explained. How his species explored and colonized star systems far from their home world. They incorporated worthy qualities found in other species into those colonies. They were interested in experimenting with the male/female dichotomy. I was the model they used to build the new, female aspect of their species. The ability to recombine their forms would allow the mate the first female selected to accommodate her reproductive biology. \r\n Why then? I had asked. Why do you need me at all? Just have one of your underlings turn into a woman and leave me alone. But there was something that they needed. Some inscrutable quality that couldn't be faked with transmogrification and cellular plasticity. \r\n I felt the old conflict playing across my face. My gaze wandered to her hands again, resting on the table between us. She had the human number of joints, even if she had too many fingers. I wondered what other qualities of mine lurked beneath the surface. \r\n I spoke from the depth of my brooding. "Did your father tell you how, uh, you came to be?" \r\n She nodded, but said nothing. \r\n I said, around the lump in my throat, "Please, try to understand. It's not that I didn't want you. It's not that I wouldn't have-- \r\n She interrupted. "I have your memories." 	18	{}	\N	2013-09-13 04:35:56.134213	2013-09-13 04:35:56.148253	{5,18}
32	2	Cryptic	 I came down in the countryside, well away from any towns or cities. I hid myself and observed. \r\n I remained in situ for perhaps a week. I took great delight in your clouds, watching them speed along, change shape, vanish. I watched what the wind did on your planet, watched its invisible force stir trees, scatter leaves, sigh. I watched the rainfall like liquid code, and I watched the sun appear and burn up all the moisture.... \r\n Then one day a young boy found me, before I could change and conceal myself. \r\n He was wide-eyed with wonder. \r\n "What are you doing there?" he asked. \r\n "Watching." \r\n "Watching what?" \r\n "Your world." \r\n He was silent for a time. I looked at him. I can bear to look upon the young of your race, for they do not trail. \r\n He was blond and thin, and so young to my eyes. \r\n "What are you?" he asked. \r\n "I am old," I said, and I wept as I looked upon him. I wept at his youth. I wept at what his youth contained, its own corruption and eventual demise. \r\n He screwed up his face, taking in my ugliness. "How old?" \r\n "Oh," I said, "I am older than all the life on your planet, I am older than your sun, I am older even than many of the old stars you see on a clear, bright night." \r\n He frowned even more at my cryptic reply. 	21	{}	\N	2013-09-13 04:37:12.546131	2013-09-13 04:37:12.560183	{5,21}
33	2	Seven	 "And how old are you?" I asked. \r\n He stood to attention, suddenly proud. "Seven!" he announced. \r\n I wept anew. Seven? Just seven. Why, that was no age at all. \r\n He said, "I'm gonna go get my grandpa, take a look at you..." \r\n And off he scurried, heedless of my shouted, heartfelt plea, "No! No." \r\n I am old and powerful, but also I am slow moving. I could not move fast enough to evade the approach of the old man, fifteen minutes later. \r\n So I changed my appearance and braced myself for the horror of the encounter. 	27	{}	\N	2013-09-13 04:38:33.119281	2013-09-13 04:38:33.132788	{5,21,27}
34	2	Downstairs	 Jane woke Kim. \r\n "You were dreaming," Jane whispered from the top bunk. "Twitching." \r\n Kim scrunched her face as if searching the corners of her mind with a flashlight. The look of uncertainty upset Jane. Kim's face was her face, too. They were twins. Whatever Kim felt, Jane felt obliged to feel. \r\n "Was I?" Kim asked. \r\n "Tell me," Jane said. \r\n "I can't. I don't remember the dream." \r\n Jane glared at her. "You take watch now." \r\n Kim huffed as if Jane had woken her because she couldn't keep her eyes open. \r\n "You swore," Jane said. \r\n Kim fingered her palm's scab and nodded. \r\n "If I twitch," Jane said, "wake me. Don't let me dream like them." \r\n "I won't." \r\n "Pick at the scab," Jane said. "It'll keep you awake." She showed Kim her bloody palm, then climbed down and traded bunks. \r\n She didn't know how she had expected an alien invasion to go, but this wasn't it. No spaceships, no soldiers, no violence. The enemy remained light-years away, until suddenly you dreamed their dreams for them and they dreamed yours. Then, the switch: you were in their bodies and they were in yours. \r\n The morning alarm woke Jane. Kim peered down at her bleary-eyed, gave a weak smile. They headed downstairs. 	27	{}	\N	2013-09-13 04:39:11.831059	2013-09-13 04:39:11.845693	{5,21,27}
41	2	.22	 I drain the last of my beer and thunk the bottle down on the bar. "In the truck." \r\n I keep my .22 behind the seats, because that's where my daddy kept his. "What's doin'?" \r\n "Roxy's got one of them," he says. "She's got one of them under her shed." \r\n I think of armadillos first. How some of the damn things burrow under wherever they like and even the dogs can't drag them out. But I know Tiny wouldn't be screaming about the wildlife. \r\n "How'd one of them get up under there?" \r\n "It's alive," Tiny says. \r\n Of course it must be, because he wouldn't need the gun otherwise, wouldn't need me. But a live one doesn't make any more sense than the armadillos. \r\n "My nieces play around that shed," says Tiny. "My nieces. Out in the backyard every day with one of them under there." \r\n I think about tossing him the keys to my pickup, but that's not what Tiny really wants. And the beer isn't as cold as usual. "I'm coming." \r\n Jim pulls a handgun I never knew he had from the cabinet behind the cash register and follows us out the door. 	22	{}	\N	2013-09-13 05:44:25.30351	2013-09-13 05:44:25.318459	{5,19,20,22}
35	2	Rabbit	 "Oh please, bring him back!" \r\n "I can't do that, little Rabbit. Fairies, especially nursery fairies, have no place in the middle of a war." \r\n "Then take me to him, please, so he won't be alone." \r\n "I can send you to him, but only the Boy will know that you're Real." \r\n "But I thought that that once you become Real it lasts for always," the Rabbit protested. \r\n "And so it does, but one of the dark magics of war is that it blinds people to Realness in others, even those who are right before their eyes." \r\n The rabbit shuddered. "I can't leave my Boy alone like that. Please, send me there." \r\n The fairy kissed him between the ears. The raspberry canes vanished. He was in a dark place that smelled of damp and mildew, surrounded by hard lumpy objects that jostled and poked him. \r\n Light poured in above him, the way it had when the Boy used to pull back the covers. And it was the Boy who looked at him now, although his face was a young man's, filthy and stubbled, and his eyes looked like he'd just woken from a nightmare. \r\n "Is this a joke?" The Boy reached down and lifted the rabbit gently. "Bunny? But you disappeared a long time ago." \r\n His hand stroked the rabbit's head where the fairy had kissed him. It felt different, and the rabbit realized that he was once again made of velveteen, all in one piece. He sighed a little for his strong hind legs and long twitching ears, but the Boy was holding him again, and that was all that really mattered. \r\n   	25	{}	\N	2013-09-13 05:26:54.785127	2013-09-13 05:26:54.802211	{5,18,24,25}
36	2	Metal	 The rabbit tried to snuggle up under the Boy's chin the way he used to, but he'd forgotten how to wear his old velveteen body. The Boy smiled anyway. \r\n "It must be the gas. I'm seeing things. But I don't care. I'm glad you're here, old buddy." \r\n The rabbit wasn't glad to be in that place. Even stuffed down in the knapsack, he heard cries like a rabbit being caught by a fox, and the air smelled sharp and rusty. But his Boy was smiling. That was what mattered. \r\n   \r\n The Boy kept him out of sight in the knapsack most of the time. "You don't want to see what's out there, Bunny," he said, his young face looking pained and old. But sometimes the rabbit saw, through a hole in the canvas, glimpses of torn-up earth, and still bodies, and glints of light on metal. 	25	{}	\N	2013-09-13 05:27:24.017427	2013-09-13 05:27:24.024889	{5,18,24,25}
37	2	The Boy	 One day the Boy snuggled him under his jacket, for warmth, and the rabbit saw another face. Someone else's Boy, he thought. \r\n But the other young man looked at his Boy, and the rabbit realized that he wasn't seeing them at all. To that other Boy, they weren't Real. The other Boy raised a stick and pointed it at them. It flashed and thundered. Something tore through velveteen and stuffing, and into his Boy. The rabbit felt something warm and wet, like tears. \r\n   \r\n The other Boys made a great fuss when they found the rabbit. They sewed up the holes and washed away the blood. They called him Hero, and the Boys in the other beds all asked to hold him. They pinned shiny things on his spotted velveteen front, and touched the sewn-up place, and a bit of light came back into their too-old eyes. The rabbit was glad for that, because his Boy lay with his eyes closed, his skin burning with fever. He didn't speak or respond when anyone else spoke to him, but when they put the rabbit back in his arms, he held tight and wouldn't let go. \r\n The rabbit lay close against his Boy's chest and trembled. In his sawdust heart, he called out for the Nursery Magic Fairy, but she didn't come. All around him, Boys-grown-old moaned with pain, or cried out in the long, lonely hours of the night. \r\n Toys don't sleep, or dream. The rabbit no longer slept, but he lay throughout the night on his Boy's thin pillow, dreaming of the day when his Boy should be well again, and take him home to the old dear house. How he wanted to see the house again, and the bright cheerful gardens, and the late afternoon sunlight slanting golden through the trees. \r\n   	25	{}	\N	2013-09-13 05:29:05.505248	2013-09-13 05:29:05.512556	{5,18,24,25}
38	2	Boot-button Eyes	 "You see it too, don't you, old buddy?" said the Boy. \r\n The rabbit startled, for although the Boy had talked to him many times, he'd never really waited for an answer. Now he sat on the edge of the bed, looking faintly shimmery at the edges, with everything around him washed in shadow, so that the rabbit could only see his pale, wistful face. \r\n "You're well again!" the rabbit cried, and snuggled fiercely up against him. "Now we can go home, and have picnics in the raspberries, and play hide-and-seek in the woods...." \r\n The boy chuckled. He picked up the rabbit and stroked him. "You sound just like I imagined, Bunny. I always wished you could talk." \r\n "I'll talk all you'd like," said the rabbit, quite breathless with excitement. "Maybe... maybe I'll even learn to sing!" \r\n The Boy laughed out loud, but none of the sleepers around them stirred. "Oh, Bunny, I wish we could go home and play in the garden. But people are different from toys. You can't just patch 'em up with a bit of fabric. We've got blood and bones and things, and sometimes nobody can fix them." \r\n The rabbit remembered running, and a glimpse of sharp teeth. "Like when a fox catches a rabbit?" he said in a very small voice. \r\n The Boy looked startled, and held him even closer. "The fox got me, little friend. I have to go." \r\n "I want to come with you!" \r\n "I don't think toys can go on this trip," said his Boy. \r\n "I'm not a toy! I'm Real!" \r\n Once again, the Boy looked startled. He looked into the rabbit's boot-button eyes, and nodded. 	19	{}	\N	2013-09-13 05:32:35.80902	2013-09-13 05:32:35.819074	{5,19}
39	2	Real	 "You are, aren't you, Bunny?" \r\n "Yes!" \r\n "Would you do something for me?" \r\n "Yes!" \r\n "Look around. See all those other fellows, sleeping? They're hurting. They're scared. They need a friend. Would you be their friend?" \r\n "But... but you're my Boy." \r\n "Now you'll have dozens. Aw, don't look so droopy. It's not like I could ever forget you, you know. Perk up those whiskers. There you go." \r\n "But..." \r\n "But you're not just a toy, remember. This isn't make-believe. This is real." \r\n "And Real is for always," said the rabbit. "Only War makes people forget." \r\n The Boy touched the rabbit's velvet nose. "You're a very wise little Bunny, you know that? Will you help them remember?" \r\n "I promise. And I won't forget, either." \r\n "That's my Bunny!" His Boy smiled: a real, bright, joyful smile, and was gone. \r\n The rabbit never forgot that smile, or his Boy, or any of the others. And many of the boys who did go home never forgot the velveteen rabbit who reminded them, in a corner of their hearts, that they were all Real. 	19	{}	\N	2013-09-13 05:33:35.333125	2013-09-13 05:33:35.348618	{5,19}
19	2	Litter Box	 I wouldn't even need a litter box. I could feed and water myself. I'd never scratch your furniture either--at least not without a cause. \r\n During the day, when you're out and gone, I could change back to a man. I could wash your breakfast dishes, make your morning bed, dust and tidy up your rooms. I could leave chocolate and flowers on your fluffed-up pillows, and I could still be a cat when you returned. \r\n At night, I'd watch you drink your tea and read your books. I'd curl up on your lap. I'd never let you be alone. \r\n I could change at night too, of course, if you ever wanted that. \r\n Or I could stay a cat instead. If that's really all you want, I'd stay a cat for you. Or several cats, perhaps? A different cat every day--tabby, calico, Maltese, Kashmir, tortoiseshell. Whatever you want me to be, I'm not going to beg or threaten you, but I'll take what I can get. \r\n I told you that you'd never have to replace me, but I heard you got a cat. And even though you named him Charles, it's not too late to give him back. 	5	{20,38,39}	\N	2013-09-13 04:20:48.682498	2013-09-13 05:33:35.356349	{5}
40	2	A Weapon	 No little green men for us. I saw footage of bog mummies on an educational special once, and the bodies are kind of like that. Thin and shiny and dark, with a crumpled look to them. Taller than humans, but frail. Easy to drag. \r\n Around here, we haul them out to the Big Empty and burn them. Don't want the buzzards getting into them. We douse the aliens in gasoline even though they don't really need it, and they take to the fire like paper. \r\n Some of the kids cheer, some of the adults cheer, like I hear they used to do at hangings. \r\n We cleared the town in the first week, and maybe it should have stopped there, but the corpses didn't seem to be rotting. Spreading the cleanup out into the Big Empty made sense. It's ours as much as it is anybody else's. The government isn't really going to get around to it. It's something to do that feels like helping. \r\n The smoke scours my nose and eyes and reminds me of the pink stuff. \r\n Jim brought free beer to the first couple of burnings and passed it around, but things go back to normal fast. Now you've got to go to the bar if you need a cold one afterward, and you've got to pay. \r\n I'm on my third, staring at the muted news on the screen over the bar, when Tiny, who isn't, busts through the door like he has the Devil after him. \r\n "I need a gun!" he hollers. His gut shakes independently of the rest of him, as if it has its own special panic inside of it. "Somebody give me a gun." \r\n "What the hell, Tiny?" says Jim. "That's a new door." \r\n Tiny's eyes roll around the room until they find me. "Berto," he says, stumbling towards me. "Berto, you've got a gun? I need a gun. I need a weapon." 	22	{}	\N	2013-09-13 05:43:49.120878	2013-09-13 05:43:49.15588	{5,19,20,22}
43	2	Berto	 This makes me pause. I'd shut myself in that first night. Spent the hours between the strange lights in the sky and dawn holding a sawed-off in one hand and a steak knife in the other. Nothing had come to my door, and there wasn't much to see when the sun rose. \r\n On the second night, I'd had to shoot at a dark shape outside the kitchen window. I knew I'd hit it, but there was no body in the morning. There were never bodies in the morning. Not before the pink stuff. \r\n "Sure," I tell Jim. "I shot one." \r\n "Good," he says. He stops shaking his gun. "Good to know." \r\n When we get out at Roxy's I can smell smoke from the bonfire that's still smoldering miles away. \r\n   \r\n \r\n It's not a rabbit hole. \r\n It's obviously not a rabbit hole, and that means Jim is back in the truck with his pistol pointed out the passenger side window. He's shaking so much that I hope he forgot to load it. The opening is big enough for a man to crawl through with inches to spare, and it smells strange. Like camphor. Something's moving deep under the shed, making the dirt around the edge of the hole shift. \r\n Roxy must have been bad strung out not to notice this in her backyard, and Tiny's going to have to start keeping the girls for his sister again. The littlest is crying in an awful way, screaming and snotting all over Tiny's sleeve while he hauls her back to the porch. \r\n I hear, "Don't hurt it! Don't hurt it! He's my friend." \r\n And "Shit, Berto. Be careful. Be careful, all right?" \r\n And "Roxy, get it together. Have you heard back from the police?" \r\n But that's wishful thinking, because anything that even felt like law enforcement out here got called in to help more important places keep order days ago. \r\n A flashlight rests in the dirt next to the metal wall of the shed, and a large, half-empty bag of cat food is propped beside it. \r\n So maybe the alien is hurt. Maybe it's too sick to go after Tiny's niece when she feeds it kitty kibble. It could be dying down there right now, and all of this upset is for nothing. \r\n "How?" Jim calls, his voice warbling. "How?" \r\n \r\n   	42	{}	\N	2013-09-13 05:45:36.844399	2013-09-13 05:45:36.85912	{5,19,20,22,42}
42	2	Catholic	 Sally, who was not quite my wife, left me a long time ago because she didn't like my work. Not the odd jobs, but killing animals. It wasn't very decent of her after ten years of almost-marriage, but that's how things fell out. I sent her a Christmas card right after she left, before I was sure that the leaving was for good, and she sent a goat in my name to some tiny Asian village I'd never heard of before. A nanny goat that would provide "healthful milk and hope" to a family in need. \r\n I was pretty sure after that. \r\n I don't even kill them when I can help it. Traps work fine for most. But sometimes things need to be taken care of quickly. \r\n I deal with it all. Packs that come out of the Big Empty and bother the livestock. Rabid dogs. The feral cats that overrun the public dumpsters every spring. And people call me a lot for the armadillos too, because of the leprosy scare. I even take care of snakes, though most around here don't have a problem putting a half dozen of their own bullets into something that slithers. \r\n Sally had a problem with it. She was sweet, and I guess I'm not. \r\n Tiny isn't sweet, but he is scared. For all that he ran into the bar yelling for a gun, we all knew he'd really wanted me. I'm the kind of man who's good for messes. \r\n I follow his truck back to Roxy's place. It's way out past the edge of town, with no neighbors. Jim vibrates in the passenger seat next to me, slapping his pistol against his thigh and muttering something that sounds a lot like Hail Mary, except if Jim was religious I'm pretty sure he wouldn't be Catholic. \r\n "I think Tiny's full of it," he says as we pass the gas station. It's still missing a few windows. The sun is setting behind it, and it's rimmed in red. "Roxy's probably got a rabbit hole. They're all dead or we'd have heard otherwise." \r\n "Yeah." It's not that I think Jim is right, just that I don't feel much like having an opinion until I see what's what. \r\n "Yeah," says Jim. "You ever hear of anyone shooting one, Berto? Before they got sprayed, I mean?" 	22	{43,44}	\N	2013-09-13 05:44:51.938437	2013-09-13 05:46:16.691207	{5,19,20,22}
45	2	Fate	 You've got to wonder about last things. Coming face to face with one you've got to wonder. \r\n Fate? Luck? Or is it divine punishment? \r\n "You're not supposed to be here," I say. \r\n It's against the back wall of the burrow. Squatting, spine curved, one three-fingered hand cradling a wound in its abdomen. I wouldn't have thought that those hands could dig something like this out of our hard earth. \r\n It doesn't press away from me in fear, doesn't bare too-narrow jaws in warning. It watches, and something wet slides across the eyes in what I take for a blink. \r\n "Looks like someone got you with a shotgun," I say. \r\n My rifle's aimed well enough. Toward it, away from me. Not much room to miss. I'm not sure what I'm waiting on, exactly. I reckon I've shot one before, figure I've probably shot this one before, but I'm not pulling the trigger. \r\n I would if it were an animal. I'm pretty sure I would if it were a dangerous man. But I'd like to know for sure if it's one way or the other or somewhere in between. You owe something of yourself to the things you kill, and I want to know what my debts are. \r\n Cat food crunches under my boots as I shuffle forward a step. "Good of you not to hurt the little girl," I say. \r\n I'd like for it to tell me why. Before the pink stuff they never communicated, and now this one doesn't seem inclined to try. I wonder if it can even understand me. \r\n They're still yelling above ground. I hear the pitch turning frantic as the seconds tick past without me replying, and I know I have to do something. \r\n "You're probably the last one left on the planet." My brain picks at that, trying to turn it into some kind of justification, but I'm pretty sure lasts aren't any less eager for their next breath than the rest of us. \r\n "I'm sure you wouldn't want to be found by the government," I say. 	44	{}	\N	2013-09-13 05:46:47.942986	2013-09-13 05:46:47.957445	{5,19,20,22,42,44}
46	2	Tiny	 And that's better. I can work with that. My finger tightens around the trigger. My vision narrows, and I see the smooth pate of the head, the slanting panes of the chest, the hand clutching at the stomach. That's it. I'll take one shot, just to finish what I started. \r\n The rifle is impossibly loud. \r\n It jerks backwards into the wall, folds in on itself, doesn't cry out. It looks down at the new hole in its abdomen beside the old wound. Something black and thick oozes slowly down its body, and I step back. It's not dead, but I promised myself one shot. I'm not sure what the right thing to do was. I'm pretty sure that this halfway finished job wasn't it. \r\n "You aren't what we were expecting," I tell it. I can feel the sweat now, running under my arms and down the creases beside my nose. Can hear Tiny asking me if I got it. \r\n It looks at me. Blinks. And for the first time I really think I understand it. \r\n We aren't what it was expecting either. 	44	{}	\N	2013-09-13 05:47:27.209474	2013-09-13 05:47:27.223858	{5,19,20,22,42,44}
47	2	"Smelled"	 In the kitchen, mom ran her hands over the honey-oak cabinets. Her lips parted with wonder as she opened one. The coffeepot bubbled and beeped, startling her. \r\n "Mom?" Jane asked. Mom had always been spacey. \r\n Still wearing her nightgown, she faced Jane and Kim with a hundred-yard stare. \r\n "You're my daughters," she said, her words mushy. \r\n Dreaming readied the aliens for human bodies, but tongues remained tricky for them. \r\n Jane exchanged a concerned look with Kim. Kim switched on the radio. They packed lunches. Mom watched. \r\n A newscast said it was patriotic to act as if nothing had changed. \r\n "That's stupid," Jane said. "Like going down with a sinking ship." \r\n Kim shrugged. \r\n They went to school. \r\n Jane faked a stomachache to get out of class. The nurse only stared at her, dumbly holding eye contact. Jane reported to the principal. He was gone, too. When she returned to class Mr. Luffler had taken it upon himself to prepare his students for "the inevitable transition" by recounting his wrong-dreams. He wriggled his arms in pantomime. The alien's were squid-type creatures who could clamber about on land. They communicated telepathically. Their planet had seasons, too. Their snow was more delightful than Earth snow. The way it evaporated when touched tickled. It even "smelled" better. \r\n Jane met Kim after school and corroborated the list of those who had switched. \r\n "Mickey, too," Kim said, her tone solemn. She had liked Mickey. \r\n "He's barely fourteen," Jane said. \r\n "His parents went early," Kim said, as if that explained things. 	44	{}	\N	2013-09-13 05:49:22.576192	2013-09-13 05:49:22.596669	{5,19,20,22,42,44}
44	2	The Hole	 I'm pretty sure he means to ask how the situation looks, or maybe he's trying to check on me. "It's fine," I say. "Let's get Roxy and the kids in the truck. You can drive them back into town, and I'll keep watch on it with Tiny." \r\n I'm thinking that we can do this in shifts, me and Tiny and Jim and some of the others. Just watch and wait and shoot if we have to. I'll get Melinda from the grocery store to come help because she can pip Coke cans off a fence all day long, and she knows most of the good dirty jokes. \r\n I'm thinking that it's going to work out, easy as any other job, but then Tiny's back beside me, wide-eyed and wheezing, and he's still got the little one stuffed under his arm like an angry football. "I can't find Emma," he says. "I can't find her in the house. Roxy doesn't know where..." \r\n Of course, I think. Of course this is how it goes. \r\n The hole is dark, and the smell is sickening, and the angle is wrong for getting my rifle through. But I manage. \r\n I manage before I even remember that Emma is the red-haired one who sang the national anthem in front of the county courthouse last Fourth of July. She had the banner being star-sprinkled instead of spangled, and she sounded terrible. \r\n I come out into a burrow that's tall enough for a crouch. It seems like forever before I can see anything, but the flashlight follows me with a clatter and some light does make it down from above. I'm stretching my eyes so wide that it feels like the top of my head wants to come off. \r\n I don't see any sign of Emma, alive or dead. "She's not here," I call. "She's not in here, Tiny." \r\n He's yelling, I assume at Roxy. But I can't spare much thought for that, because Emma may not be down here with me, but the alien is. 	42	{45,46,47,48}	\N	2013-09-13 05:46:16.683229	2013-09-13 05:49:53.504283	{5,19,20,22,42}
48	2	Gone	 They rode the bus home. Mom had moved from the kitchen to the pantry. \r\n During Jane's night watch, mom entered their bedroom with a steaming pot of oatmeal, corn, raisins, and noodles. \r\n "You have to eat," mom said. \r\n "It's three a.m.," Jane said. \r\n Mom looked confused, then left. \r\n "There goes the pantry," Kim said. \r\n Jane nodded pensively. "We'll get by." \r\n Mom had left the house by the time Jane led Kim downstairs in the morning. The pantry was ransacked. School had been cancelled. Too many bus drivers had switched overnight. \r\n Jane made coffee. She didn't like it, didn't understand why adults liked it, but drank it anyway. \r\n "Think the neighbors have eggs?" Kim asked. \r\n Jane pressed their buzzer. No one answered, but the door was unlocked. \r\n "We have to think about the future," Jane said, packing groceries into Kim's backpack. \r\n Kim slouched under the increasing weight. \r\n Donuts staled. Dishes piled up. Batteries died. Jane learned to drive. The aliens walked everywhere. Jane drove Kim to their new home near a grocery. \r\n During her night watches, Jane scratched her palm until it wept puss. She consulted diagnosis charts and swiped antibiotics from a pharmacy. The pills knocked her out. When she woke, Kim lay beside her, sleeping, twitching. Jane woke her. \r\n "I'm sorry," Kim said, turning her palm up. It had healed. "I was afraid of infection." \r\n "Did you dream?" \r\n "Yes," Kim said. \r\n "Tell me." \r\n "The snow tickled." Kim's face scrunched with apology. \r\n Jane searched Kim's face, waiting to feel something. \r\n She left a week of food for Kim, how long it usually took. A week later, Jane pulled her car alongside Kim on the sidewalk. Kim goggled at her. "You're my sister." \r\n Jane left town. \r\n   	44	{}	\N	2013-09-13 05:49:53.496745	2013-09-13 05:49:53.510876	{5,19,20,22,42,44}
\.


--
-- Name: nodes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sethgrotelueschen
--

SELECT pg_catalog.setval('nodes_id_seq', 48, true);


--
-- Data for Name: nodes_stories; Type: TABLE DATA; Schema: public; Owner: sethgrotelueschen
--

COPY nodes_stories (id, node_id, story_id) FROM stdin;
\.


--
-- Name: nodes_stories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sethgrotelueschen
--

SELECT pg_catalog.setval('nodes_stories_id_seq', 1, false);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: sethgrotelueschen
--

COPY schema_migrations (version) FROM stdin;
20130905193706
20130905230249
20130905230929
20130906000523
20130906015122
20130906071826
20130907021248
20130907021608
20130908021149
20130908022418
20130908023045
20130908030635
20130908232809
20130910175325
20130910175333
20130910175738
20130911225057
\.


--
-- Data for Name: stars; Type: TABLE DATA; Schema: public; Owner: sethgrotelueschen
--

COPY stars (id, story_id, user_id, created_at, updated_at) FROM stdin;
1	1	1	2013-09-13 04:07:09.303815	2013-09-13 04:07:09.303815
2	9	1	2013-09-13 04:07:25.635623	2013-09-13 04:07:25.635623
3	11	2	2013-09-13 04:13:08.176401	2013-09-13 04:13:08.176401
4	5	2	2013-09-13 04:17:42.947167	2013-09-13 04:17:42.947167
\.


--
-- Name: stars_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sethgrotelueschen
--

SELECT pg_catalog.setval('stars_id_seq', 4, true);


--
-- Data for Name: stories; Type: TABLE DATA; Schema: public; Owner: sethgrotelueschen
--

COPY stories (id, title, user_id, node_id) FROM stdin;
1	The Witch's Cat	3	1
2	The Vanishing Girl	3	2
3	The Velveteen Rabbit Says Goodbye	4	3
4	The Remnant	4	4
5	I Heard You Got a Cat, I Heard You Named Him Charles	5	5
6	Chick Lit	5	6
7	Self and Self	6	7
8	Visiting Planet Earth	6	8
9	Sapience and Maternal Instincts	7	9
10	Inflection	7	10
11	Epistemology of Disagreement	1	11
12	Inclusivism	1	12
13	Chapter 2	1	13
14	Sampson	1	14
15	Autumn	2	15
16	Call of the Minaret	2	16
17	The Best World	2	17
18	The Day	2	18
19	Litter Box	2	19
20	Grocery Store	2	20
21	Uh - oh	2	21
22	Nothing	2	22
23	Kitten	2	23
24	Cowboy Hat	2	24
25	Gape	2	25
26	Cheek	2	26
27	Beth	2	27
28	Fligth	2	28
29	Long Journey	2	29
30	Teeth	2	30
31	Memories	2	31
32	Cryptic	2	32
33	Seven	2	33
34	Downstairs	2	34
35	Rabbit	2	35
36	Metal	2	36
37	The Boy	2	37
38	Boot-button Eyes	2	38
39	Real	2	39
40	A Weapon	2	40
41	.22	2	41
42	Catholic	2	42
43	Berto	2	43
44	The Hole	2	44
45	Fate	2	45
46	Tiny	2	46
47	"Smelled"	2	47
48	Gone	2	48
\.


--
-- Name: stories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sethgrotelueschen
--

SELECT pg_catalog.setval('stories_id_seq', 48, true);


--
-- Data for Name: taggings; Type: TABLE DATA; Schema: public; Owner: sethgrotelueschen
--

COPY taggings (id, tag_id, taggable_id, taggable_type, tagger_id, tagger_type, context, created_at) FROM stdin;
1	1	1	Story	\N	\N	tags	2013-09-13 03:37:38.966921
2	2	2	Story	\N	\N	tags	2013-09-13 03:38:32.405526
3	3	3	Story	\N	\N	tags	2013-09-13 03:39:52.347456
4	4	4	Story	\N	\N	tags	2013-09-13 03:40:36.191209
5	1	5	Story	\N	\N	tags	2013-09-13 03:42:01.946271
6	5	6	Story	\N	\N	tags	2013-09-13 03:42:47.022164
7	6	7	Story	\N	\N	tags	2013-09-13 03:49:45.530148
8	4	8	Story	\N	\N	tags	2013-09-13 03:50:17.347255
9	7	9	Story	\N	\N	tags	2013-09-13 03:52:51.953271
10	2	10	Story	\N	\N	tags	2013-09-13 03:53:54.344612
11	8	11	Story	\N	\N	tags	2013-09-13 03:57:07.632485
12	9	12	Story	\N	\N	tags	2013-09-13 03:57:54.06545
13	10	13	Story	\N	\N	tags	2013-09-13 04:08:49.425259
14	1	14	Story	\N	\N	tags	2013-09-13 04:09:52.687265
15	11	16	Story	\N	\N	tags	2013-09-13 04:15:49.829656
16	8	17	Story	\N	\N	tags	2013-09-13 04:16:41.805747
\.


--
-- Name: taggings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sethgrotelueschen
--

SELECT pg_catalog.setval('taggings_id_seq', 16, true);


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: sethgrotelueschen
--

COPY tags (id, name) FROM stdin;
1	cats
2	sci-fi
3	rabbit
4	aliens
5	bird
6	duality
7	parents
8	philosophy
9	religion
10	teeth
11	god
\.


--
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sethgrotelueschen
--

SELECT pg_catalog.setval('tags_id_seq', 11, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: sethgrotelueschen
--

COPY users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, confirmation_token, confirmed_at, confirmation_sent_at, provider, uid, name, created_at, updated_at, image_url) FROM stdin;
3	user1@example.com	$2a$10$ycB/BeiVW7Us4qbg1uasHOvNMkRMbJpCSaJqQCwfgx9dCilM3AKHK	\N	\N	\N	1	2013-09-13 03:36:50.453464	2013-09-13 03:36:50.453464	127.0.0.1	127.0.0.1	\N	\N	\N	\N	\N	 Kalisa Ann Lessnau	2013-09-13 03:36:50.438287	2013-09-13 03:36:50.455878	\N
4	user2@example.com	$2a$10$XK76AWvfussUymeTpPIhcumJLgsYvqm395HqwFw/9H/EWjBBti86y	\N	\N	\N	1	2013-09-13 03:39:16.967254	2013-09-13 03:39:16.967254	127.0.0.1	127.0.0.1	\N	\N	\N	\N	\N	Melissa Mead	2013-09-13 03:39:16.963212	2013-09-13 03:39:16.968015	\N
5	user3@example.com	$2a$10$KlUYvLtk.G3L4surQXzHvujqJKBI01etkfAtgq0hW4ZitOApoqAHS	\N	\N	\N	1	2013-09-13 03:41:28.809718	2013-09-13 03:41:28.809718	127.0.0.1	127.0.0.1	\N	\N	\N	\N	\N	M. Bennardo	2013-09-13 03:41:28.806229	2013-09-13 03:41:28.810536	\N
6	user4@example.com	$2a$10$Cv/UdjOdsgCMU6oQJegk2.O5ewVrNHDFl0GDxX/tOpW6nhNvEwtbq	\N	\N	\N	1	2013-09-13 03:43:32.29155	2013-09-13 03:43:32.29155	127.0.0.1	127.0.0.1	\N	\N	\N	\N	\N	Jacob A. Boyd	2013-09-13 03:43:32.288135	2013-09-13 03:43:32.292337	\N
7	user5@example.com	$2a$10$EUYFnwLD/kpI9YO31DohzOWFjeXNn/HyvHb5vwJDRMu1HnkXPpCVa	\N	\N	\N	1	2013-09-13 03:52:00.766577	2013-09-13 03:52:00.766577	127.0.0.1	127.0.0.1	\N	\N	\N	\N	\N	Krystal Claxton	2013-09-13 03:52:00.76149	2013-09-13 03:52:00.76791	\N
1	sgrotelueschen@westmont.edu	$2a$10$uhiLpE6LC5nn0epL2hafgeXgqv/AJ5EccdE6DdGBddJrb1N79jIgy	\N	\N	\N	2	2013-09-13 03:55:04.210511	2013-09-13 01:56:46.49873	127.0.0.1	127.0.0.1	\N	\N	\N	\N	\N	Seth G	2013-09-13 01:56:46.483785	2013-09-13 03:55:04.211922	\N
2	twitter-559783189@storyward.com	$2a$10$2dtfQIiCkWsi93CQlrqMZ.nZCQRkVqVSBRtRQ0CxdKwGLUuUbacl2	\N	\N	\N	6	2013-09-13 05:23:22.817002	2013-09-13 05:12:41.094408	127.0.0.1	127.0.0.1	\N	\N	\N	twitter	559783189	Seth Grotelueschen	2013-09-13 02:37:11.453247	2013-09-13 05:23:22.818609	http://a0.twimg.com/profile_images/2154064757/562537_10150767818676427_590791426_11865393_2533311_n.jpg
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sethgrotelueschen
--

SELECT pg_catalog.setval('users_id_seq', 7, true);


--
-- Name: nodes_pkey; Type: CONSTRAINT; Schema: public; Owner: sethgrotelueschen; Tablespace: 
--

ALTER TABLE ONLY nodes
    ADD CONSTRAINT nodes_pkey PRIMARY KEY (id);


--
-- Name: nodes_stories_pkey; Type: CONSTRAINT; Schema: public; Owner: sethgrotelueschen; Tablespace: 
--

ALTER TABLE ONLY nodes_stories
    ADD CONSTRAINT nodes_stories_pkey PRIMARY KEY (id);


--
-- Name: stars_pkey; Type: CONSTRAINT; Schema: public; Owner: sethgrotelueschen; Tablespace: 
--

ALTER TABLE ONLY stars
    ADD CONSTRAINT stars_pkey PRIMARY KEY (id);


--
-- Name: stories_pkey; Type: CONSTRAINT; Schema: public; Owner: sethgrotelueschen; Tablespace: 
--

ALTER TABLE ONLY stories
    ADD CONSTRAINT stories_pkey PRIMARY KEY (id);


--
-- Name: taggings_pkey; Type: CONSTRAINT; Schema: public; Owner: sethgrotelueschen; Tablespace: 
--

ALTER TABLE ONLY taggings
    ADD CONSTRAINT taggings_pkey PRIMARY KEY (id);


--
-- Name: tags_pkey; Type: CONSTRAINT; Schema: public; Owner: sethgrotelueschen; Tablespace: 
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: sethgrotelueschen; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_taggings_on_tag_id; Type: INDEX; Schema: public; Owner: sethgrotelueschen; Tablespace: 
--

CREATE INDEX index_taggings_on_tag_id ON taggings USING btree (tag_id);


--
-- Name: index_taggings_on_taggable_id_and_taggable_type_and_context; Type: INDEX; Schema: public; Owner: sethgrotelueschen; Tablespace: 
--

CREATE INDEX index_taggings_on_taggable_id_and_taggable_type_and_context ON taggings USING btree (taggable_id, taggable_type, context);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: sethgrotelueschen; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON users USING btree (confirmation_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: sethgrotelueschen; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: sethgrotelueschen; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: sethgrotelueschen; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: public; Type: ACL; Schema: -; Owner: sethgrotelueschen
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM sethgrotelueschen;
GRANT ALL ON SCHEMA public TO sethgrotelueschen;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--


-- Drop table

-- DROP TABLE chat_rooms;

CREATE TABLE IF NOT EXISTS chat_rooms (
	id serial4 NOT NULL,
	room_name varchar(255) NULL,
	is_group bool DEFAULT false NOT NULL,
	created_at timestamp DEFAULT now() NOT NULL,
	CONSTRAINT chat_rooms_pkey PRIMARY KEY (id)
);


-- public.users definition

-- Drop table

-- DROP TABLE users;

CREATE TABLE IF NOT EXISTS users (
	id serial4 NOT NULL,
	username varchar(255) NOT NULL,
	"password" varchar(255) NOT NULL,
	"role" varchar(50) NOT NULL,
	created_at timestamp DEFAULT now() NOT NULL,
	last_login_at timestamp NULL,
	CONSTRAINT users_pkey PRIMARY KEY (id),
	CONSTRAINT users_username_key UNIQUE (username)
);


-- public.chat_room_users definition

-- Drop table

-- DROP TABLE chat_room_users;

CREATE TABLE IF NOT EXISTS chat_room_users (
	id serial4 NOT NULL,
	room_id int4 NOT NULL,
	user_id int4 NOT NULL,
	joined_at timestamp DEFAULT now() NOT NULL,
	CONSTRAINT chat_room_users_pkey PRIMARY KEY (id),
	CONSTRAINT uk_room_user UNIQUE (room_id, user_id),
	CONSTRAINT fk_cru_room FOREIGN KEY (room_id) REFERENCES chat_rooms(id) ON DELETE CASCADE,
	CONSTRAINT fk_cru_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);


-- public.messages definition

-- Drop table

-- DROP TABLE messages;

CREATE TABLE IF NOT EXISTS messages (
	id serial4 NOT NULL,
	room_id int4 NOT NULL,
	sender_id int4 NOT NULL,
	"content" text NOT NULL,
	created_at timestamp DEFAULT now() NOT NULL,
	is_read bool DEFAULT false NOT NULL,
	CONSTRAINT messages_pkey PRIMARY KEY (id),
	CONSTRAINT fk_msg_room FOREIGN KEY (room_id) REFERENCES chat_rooms(id) ON DELETE CASCADE,
	CONSTRAINT fk_msg_sender FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE
);


-- public.message_reads definition

-- Drop table

-- DROP TABLE message_reads;

CREATE TABLE IF NOT EXISTS message_reads (
	id serial4 NOT NULL,
	message_id int4 NOT NULL,
	user_id int4 NOT NULL,
	read_at timestamp DEFAULT now() NOT NULL,
	CONSTRAINT message_reads_pkey PRIMARY KEY (id),
	CONSTRAINT uk_message_user UNIQUE (message_id, user_id),
	CONSTRAINT fk_mr_message FOREIGN KEY (message_id) REFERENCES messages(id) ON DELETE CASCADE,
	CONSTRAINT fk_mr_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
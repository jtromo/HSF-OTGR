drop table if exists contact;

CREATE TABLE contact(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	firstName TEXT not null,
	lastName TEXT not null,
	emailAddress REAL not null,
	cellPhoneNumber REAL not null,
	contactType INTEGER,
	creationDate INTEGER not null default 0,
	modifiedDate INTEGER not null default 0,
	isDeleted INTEGER not null default 0,



checkbox fields

);
drop table if exists contact;

CREATE TABLE contact(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	firstName TEXT not null,
	lastName TEXT not null,
	emailAddress REAL not null,
	cellPhoneNumber TEXT not null,
	contactType TEXT not null,
	isApplication INTEGER not null default 0,
	isNewsletters INTEGER not null default 0,
	isResources INTEGER not null default 0,
	isVolunteering INTEGER not null default 0,
	isInternships INTEGER not null default 0,
	isSpeaking INTEGER not null default 0,
	isAmbassador INTEGER not null default 0,
	isDonating INTEGER not null default 0,
	isMentoring INTEGER not null default 0,
	isBeingMentored INTEGER not null default 0,
	other TEXT,
	creationDate INTEGER not null default 0,
	modifiedDate INTEGER not null default 0,
	isDeleted INTEGER not null default 0
);
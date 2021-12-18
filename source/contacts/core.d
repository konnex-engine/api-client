module konnexengine.contacts.core;

import std.uuid: UUID;

struct Name
{
	UUID id;
	string value;
}

struct Salutation
{
	UUID id;
	string value;
}

struct Suffix
{
	UUID id;
	string value;
}
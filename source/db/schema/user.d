module konnexengine.db.schema.user;

import std.typecons: Nullable;
import std.uuid: UUID;
import konnexengine.db.functions;


struct User
{
	Nullable!UUID id;
	Nullable!UUID[] email;
	Nullable!string username;
	Nullable!string displayName;
	Nullable!string password;
	Nullable!UUID realName;
	Nullable!UUID[] socials;
	Nullable!UUID[] phoneNumbers;
	Nullable!UUID[] addresses;
}

// User prepareUserData()
// {

// }

struct Name
{
	UUID id;
	string value;
}

struct NaturalPersonName
{
	Name firstName;
	Name[] middelNames;
	Name lastName;
}
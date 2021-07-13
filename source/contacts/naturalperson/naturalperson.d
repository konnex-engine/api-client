module konnexengine.contacts.naturalperson;

import std.uuid: UUID, sha1UUID;

/// NaturalPersonName - `struct`
struct NaturalPersonName
{
	UUID id;
	string salutation;
	string firstName;
	string[] middleNames;
	string lastName;
	string suffix;
}
///
unittest {
	import std.uuid: UUID, sha1UUID;
	
	auto name = NaturalPersonName
	(
		sha1UUID("test", sha1UUID("namespace")),
		"Ms.",
		"Luscious",
		["Lovely","Loveworthy"],
		"Lady",
		"Esq."
	);
	assert(is(typeof(name) == NaturalPersonName));
	assert(is(typeof(name.id) == UUID));
	assert(is(typeof(name.salutation) == string));
	assert(is(typeof(name.firstName) == string));
	assert(is(typeof(name.middleNames) == string[]));
	assert(is(typeof(name.lastName) == string));
	assert(is(typeof(name.suffix) == string));
	assert(name.id == sha1UUID("test", sha1UUID("namespace")));
	assert(name.salutation == "Ms.");
	assert(name.firstName == "Luscious");
	assert(name.middleNames == ["Lovely","Loveworthy"]);
	assert(name.lastName == "Lady");
	assert(name.suffix == "Esq.");
}
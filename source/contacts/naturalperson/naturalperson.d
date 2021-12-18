module konnexengine.contacts.naturalperson;

import std.uuid: UUID, sha1UUID;

import konnexengine.contacts.core: Name, Salutation, Suffix;

/// NaturalPersonName - `struct`
struct NaturalPersonName
{
	UUID id;
	Salutation salutation;
	Name firstName;
	Name[] middleNames;
	Name lastName;
	Suffix suffix;
}
// ///
// unittest {
// 	import std.uuid: UUID, sha1UUID;
	
// 	auto name = NaturalPersonName
// 	(
// 		sha1UUID("test", sha1UUID("namespace")),
// 		Salutation(sha1UUID("test", sha1UUID("namespace")),"Ms."),
// 		Name(sha1UUID("test", sha1UUID("namespace")),"Luscious"),
// 		[Name(sha1UUID("test", sha1UUID("namespace")),"Lovely"),Name(sha1UUID("test", sha1UUID("namespace")),"Loveworthy")],
// 		Name(sha1UUID("test", sha1UUID("namespace")),"Lady"),
// 		Name(sha1UUID("test", sha1UUID("namespace")),"Esq.")
// 	);
// 	assert(is(typeof(name) == NaturalPersonName));
// 	assert(is(typeof(name.id) == UUID));
// 	assert(is(typeof(name.salutation) == Salutation));
// 	assert(is(typeof(name.firstName) == Name));
// 	assert(is(typeof(name.middleNames) == Name[]));
// 	assert(is(typeof(name.lastName) == Name));
// 	assert(is(typeof(name.suffix) == Suffix));
// 	assert(name.id == sha1UUID("test", sha1UUID("namespace")));
// 	assert(name.salutation.value == "Ms.");
// 	assert(name.firstName.value == "Luscious");
// 	assert(name.middleNames[0].value == "Lovely");
// 	assert(name.middleNames[1].value == "Loveworthy");
// 	assert(name.lastName.value == "Lady");
// 	assert(name.suffix.value == "Esq.");
// }
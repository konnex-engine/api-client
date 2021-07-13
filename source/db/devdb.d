module konnexengine.db.devdb;

import std.uuid: UUID, sha1UUID;

/// DBEntry `struct`
struct DBEntry {
	UUID id;
	string email;
	string username;
	string password;
}
///
unittest {
	DBEntry entry = DBEntry(
		sha1UUID("user1@email.com", sha1UUID("konnex-engine.com")),
		"user1@email.com",
		"user1", 
		"password1");
	assert(is(typeof(entry) == DBEntry));
	assert(is(typeof(entry.id) == UUID));
	assert(is(typeof(entry.email) == string));
	assert(is(typeof(entry.username) == string));
	assert(is(typeof(entry.password) == string));
	assert(entry.id == sha1UUID("user1@email.com", sha1UUID("konnex-engine.com")));
	assert(entry.email == "user1@email.com");
	assert(entry.username == "user1");
	assert(entry.password == "password1");
}

/// DevDB `struct`
struct DevDB
{
	/// generateDevDB() `function`
	DBEntry[] generateUsers()
	{
		import std.conv: to;
		
		DBEntry[] devDB = [];
		
		for(uint i=0; i<10; i++)
		{
			devDB ~= DBEntry
			(
				sha1UUID("user"~i.to!string~"@email.com", sha1UUID("konnex-engine.com")),
				"user"~i.to!string~"@email.com",
				"user"~i.to!string,
				"password"~i.to!string
			);
		}
		return devDB;
	}
	///
	unittest {
		auto devDB = DevDB();
		auto db = devDB.generateUsers();
		assert(is(typeof(db) == DBEntry[]));
		assert(is(typeof(db[0].id) == UUID));
		assert(is(typeof(db[0].email) == string));
		assert(is(typeof(db[0].username) == string));
		assert(is(typeof(db[0].password) == string));
		assert(db[0].id == sha1UUID("user0@email.com", sha1UUID("konnex-engine.com")));
		assert(db[0].email == "user0@email.com");
		assert(db[0].username == "user0");
		assert(db[0].password == "password0");
	}

	/// flushToDisk() `function`
	void flushToDisk(){
		import std.file: write;


	}
	///
	unittest {
		// TODO: implement test
		auto dbutils = DevDB();
		auto devDB = dbutils.generateUsers();
		assert(is(typeof(devDB) == DBEntry[]));
	}
}


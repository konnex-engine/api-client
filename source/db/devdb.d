module konnexengine.db.devdb;

import std.uuid: UUID, sha1UUID;
import std.conv: to;
import std.typecons: Nullable, nullable;

import vibe.core.log: logInfo;
import konnexengine.db.functions;
import konnexengine.db.schema.user: User;

/// DevDB `struct`
struct DevDB
{
	/// generateDevDB() `function`
	User[] generateUsers()
	{
		import std.conv: to;
		
		User[] devDB = [];
		
		for(uint i=0; i<10; i++)
		{
			auto user = User(sha1UUID("user"~i.to!string~"@email.com", sha1UUID("konnex-engine.com")).nullable);
			user.email ~= sha1UUID("user"~i.to!string~"@email.com", sha1UUID("konnex-engine.com")).nullable;
			user.username = "user"~i.to!string~"@email.com";
			user.password = "password"~i.to!string;

			devDB ~= user;
			logInfo(user.to!string);
		}
		return devDB;
	}
	///
	unittest {
		import std.uuid: UUID, sha1UUID;
		import std.typecons: nullable;
		auto devDB = DB(DevDB());
		auto db = devDB.generateUsers();
		logInfo(db[0].id.to!string);
		assert(is(typeof(db) == User[]));
		assert(is(typeof(db[0].id) == Nullable!UUID));
		assert(is(typeof(db[0].email) == Nullable!UUID[]));
		assert(is(typeof(db[0].username) == Nullable!string));
		assert(is(typeof(db[0].password) == Nullable!string));
		auto a = sha1UUID("user0@email.com", sha1UUID("konnex-engine.com"));
		auto aa = a.nullable;
		assert(db[0].id == a);
		auto b = sha1UUID("user0@email.com", sha1UUID("konnex-engine.com")).nullable;
		assert(db[0].email == [b]);
		assert(db[0].username == "user0@email.com");
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
		assert(is(typeof(devDB) == User[]));
	}
}


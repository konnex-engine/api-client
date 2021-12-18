module konnexengine.db.redis.redis;

import vibe.db.redis.redis: connectRedis, RedisClient, RedisDatabase;
import vibe.db.redis.types;

/// struct RedisInstance
struct RedisInstance
{
	string url;
	long db;
	string password;
}

/// struct RedisHash
struct RedisHashEntry
{
	this(RedisDatabase d, string k, string f, RedisValue v)
	{
		this.db = d;
		this.key = k;
		this.field = f;
		this.entry.value = v;
	}

	RedisDatabase db;
	string key;
	string field;
	auto entry = RedisHash!string();
}

/**

 */
RedisClient connect(T)(T t)
{
	return connectRedis(t.url).getDatabase(t.db);
}
///
unittest
{

}


/**
	Template function - 
	```dlang
	 void persist(T)(T t)
	 ```
 */
void persist(T)(T t)
{
	t.db.hset(t.key, t.field, t.entry.value);
}
///
unittest
{
	// string key = "User";
	// string field = "email";
	// auto db = connectRedis("127.0.0.1").getDatabase(0);
	// auto entry = RedisHash!string(db, key);
	// entry.value = RedisValue(db, key);
	// auto rhe = RedisHashEntry(entry.key, field, entry.value);
	// assert(persist!RedisHashEntry(rhe));
}
module konnexengine.api.user;

import vibe.db.redis.redis: RedisDatabase;
import konnexengine.api.functions: createUserFrom;


string create(T)(T data, RedisDatabase* _user, RedisDatabase* _db)
{
	return createUserFrom!T(data, _user, _db);
}
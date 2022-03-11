module konnexengine.api.user;

import vibe.db.redis.redis: RedisDatabase;
import vibe.data.json;
import vibe.http.client: requestHTTP;
import vibe.http.common: HTTPMethod;
import vibe.stream.operations: readAllUTF8;
import vibe.core.log: logInfo, logWarn;


import konnexengine.api.functions: createUserFrom;


string create(T)(T data, RedisDatabase* _user, RedisDatabase* _db)
{
	return createUserFrom!T(data);
}

string attemptUserCreation(Json data)
{
	string url = "https://db.konnex-engine.com/v1/user";
	string result;
	bool created;
	requestHTTP(url, (scope req) {
		req.method = HTTPMethod.POST;
		req.writeJsonBody([
				"data": serializeToJson([
					"email": data["email"],
					"password": data["password"],
					"namespace": data["namespace"]
				])
			]);
	}, (scope res) {
		result = res.bodyReader.readAllUTF8();
		logWarn("\nUserService --- Response: %s\n", parseJsonString(result).toPrettyString());
		if (res.statusCode == 200)
		{
			auto r = result;
			try
			{
				created = true;
				
			}
			catch (Exception e)
			{
				created = false;
				throw new Error(e.msg);
			}
		}
		
	});
	return result;
}
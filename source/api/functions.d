module konnexengine.api.functions;

import vibe.http.common: HTTPMethod;
import vibe.http.client: requestHTTP;
import vibe.data.json: Json, serializeToJson, parseJsonString;
import vibe.core.log: logInfo, logWarn;
import vibe.stream.operations: readAllUTF8;
import vibe.db.redis.redis: RedisDatabase;


string result ="";

string createUserFrom(T)(T t, RedisDatabase* _user , RedisDatabase* _db)
{
	const string userApiUrl = "/user/create";
	const string url = "https://api.konnex-engine.com/v1" ~ userApiUrl;

	import konnexengine.user.api_request;

	auto data = UserRequest.Data(t.email,t.username,t.password,t.namespace);
	auto request = UserRequest(0, data);

	bool created = false;

	requestHTTP(url, (scope req) {
		req.method = HTTPMethod.POST;
		req.writeJsonBody([
				"fn": Json(request.fn),
				"data": serializeToJson([
					"email": Json(request.data.email),
					"username": Json(request.data.username),
					"password": Json(request.data.password),
					"namespace": Json(request.data.namespace)
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

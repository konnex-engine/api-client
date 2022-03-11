module konnexengine.api.functions;

import vibe.http.common : HTTPMethod;
import vibe.http.client : requestHTTP;
import vibe.data.json : Json, serializeToJson, parseJsonString;
import vibe.core.log : logInfo, logWarn;
import vibe.stream.operations : readAllUTF8;
import vibe.db.redis.redis : RedisDatabase;

string createUserFrom(T)(T t)
{
	const string url = "https://auth.konnex-engine.com/signup";

	import konnexengine.user.api_request;
	
	bool created = false;
	string result = "";

	requestHTTP(url, (scope req) {
		req.method = HTTPMethod.POST;
		req.writeJsonBody([
			"email": Json(t.email),
			"password": Json(t.password),
			"namespace": Json(t.namespace)
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

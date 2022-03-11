module konnexengine.crypto.utilities;

import std.conv : to;
import std.json;
import std.digest: toHexString;
import vibe.http.client : requestHTTP, HTTPMethod;
import vibe.data.json : Json, parseJsonString;
import vibe.stream.operations : readAllUTF8;
import vibe.core.log : logInfo, logWarn, logCritical;

import dauth: makeHash, toPassword, randomSalt, isSameHash, parseHash, Salt;
import dotenv : Env;

string hashPassword(string plaintext)
{
	char[] input = cast(char[]) plaintext;
	auto pass = toPassword(input);
	auto hash = makeHash(pass).toString();
	return hash;
}

bool checkPassword(string hashString, string password)
{
	char[] input = cast(char[]) password;
	auto p = toPassword(input);
	return isSameHash(p, parseHash(hashString));
}

string generateToken(string ns, string id, string name, string created)
{
	struct TokenRequest
	{

		this(string ns, string id, string name, string created)
		{
			this.namespace = ns;
			this.user_id = id;
			this.username = name;
			this.created_at = created;
		}

		string namespace;
		string user_id;
		string username;
		string created_at;
	}

	string token = "";
	// logInfo(ns);
	auto request = TokenRequest(ns, id, name, created);
	// logInfo(request.namespace);
	Env.load(".env", false);
	// string authUrl = Env["AUTH_SERVICE_URL"];
	string authUrl = "http://0.0.0.0:8099/login";

	logInfo("\nTrying URL: " ~ authUrl);

	requestHTTP(authUrl, (scope req) {

		req.method = HTTPMethod.POST;
		req.contentType = "application/json";

		req.writeJsonBody([
				"namespace": JSONValue(request.namespace.to!string),
				"user_id": JSONValue(request.user_id.to!string),
				"username": JSONValue(request.username.to!string),
				"created_at": JSONValue(request.created_at.to!string)
			]);

	}, (scope res) {

		token = res.bodyReader.readAllUTF8();
		// logWarn("\nAuthService --- Response: %s\n", parseJsonString(token).toPrettyString());

	});
	return token;
}

Json decodeToken(T)(T t)
{
	import fastjwt.jwt : decodeJWTToken, JWTAlgorithm;
	import stringbuffer : StringBuffer;

	string secret = "SuperStrongPassword";
	JWTAlgorithm algo = JWTAlgorithm.HS512;
	StringBuffer header;
	StringBuffer payload;

	const ulong rslt = decodeJWTToken(t["token"].get!string, secret, algo, header, payload);

	if (rslt > 0)
	{
		return Json(["message": Json("Your token was not OK")]);
	}

	return parseJsonString(payload.getData());
}

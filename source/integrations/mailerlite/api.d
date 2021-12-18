module konnexengine.integrations.mailerlite.api;

import std.conv : to;
import std.typecons: Nullable;

import vibe.core.log : logInfo, logWarn;
import vibe.data.json : Json, parseJsonString;
import vibe.stream.operations : readAllUTF8;
import vibe.http.common : HTTPMethod;
import vibe.http.client : requestHTTP;
import vibe.textfilter.urlencode : formEncode;

string BASE_URL = "https://api.mailerlite.com/api/v2/";

struct AuthInfo
{
	this(string apiKey)
	{
		this.apiKey = apiKey;
	}

	string apiKey;
	string authHeader = "X-MailerLite-ApiKey";
	string contentHeader = "Content-Type";
	string contentType = "application/json";
}

/// Subscriber Identifier
static struct CustomerDetails
{
	this(string email, string name, string lastname, string countryName)
	{
		this.email = email;
		this.name = name;
		this.lastname = lastname;
		this.countryName = countryName;
	}

	string email;
	string name;
	string lastname;
	string countryName;
}
///
unittest
{
	
}

/// Subscriber Identifier
static struct SubscriberIdentifier
{
	this(string identifier)
	{
		this.identifier = identifier;
	}

	string identifier;
}
///
unittest
{
	
}

Json createActiveSubscriberFrom(T)(T t, AuthInfo authInfo)
{
	string _url = BASE_URL ~ "subscribers";
	// auto authInfo = AuthInfo(t.apiKey);
	string response = "";
	Json reqBody = Json([
				"email": Json(t.email),
				"type": Json("active"),
				"name": Json(t.name),
				"fields": Json([
					"last_name": Json(t.lastname),
					"country": Json(t.countryName)
				])
				// "last_name": Json(t.lastName),
				// "country": Json(t.country)
			]);

	requestHTTP(_url,
			(scope req) {
		req.method = HTTPMethod.POST;
		req.headers[authInfo.authHeader] = authInfo.apiKey;
		req.headers[authInfo.contentHeader] = authInfo.contentType;
		req.writeJsonBody(reqBody);
	},
			(scope res) {
		response = res.bodyReader.readAllUTF8();
		logWarn("\nMailerLite Subscribers API --- Response: %s\n", response);
	});
	return parseJsonString(response);
}

Json updateActiveSubscriberFrom(T)(T t, AuthInfo authInfo)
{
	string _url = BASE_URL ~ "subscribers/" ~ t.email;
	// auto authInfo = AuthInfo(t.apiKey);
	string response = "";
	Json reqBody = Json([
				"type": Json("active"),
				"fields": Json([
					"last_name": Json(t.lastname),
					"country": Json(t.countryName)
				])
				// "last_name": Json(t.lastName),
				// "country": Json(t.country)
			]);
	logInfo(reqBody.toPrettyString());

	requestHTTP(_url,
			(scope req) {
		req.method = HTTPMethod.PUT;
		req.headers[authInfo.authHeader] = authInfo.apiKey;
		req.headers[authInfo.contentHeader] = authInfo.contentType;
		req.writeJsonBody(reqBody);
	},
			(scope res) {
		response = res.bodyReader.readAllUTF8();
		logWarn("\n1MailerLite Subscribers API --- Response: %s\n", response);
	});
	return parseJsonString(response);
}

Json getSubscriberBy(T)(T t, AuthInfo authInfo)
{
	string _url = BASE_URL ~ "subscribers/" ~t.identifier;
	// auto authInfo = AuthInfo(t.apiKey);
	string response = "";

	requestHTTP(_url,
			(scope req) {
		req.method = HTTPMethod.GET;
		req.headers[authInfo.authHeader] = authInfo.apiKey;
	},
			(scope res) {
		response = res.bodyReader.readAllUTF8();
		logWarn("\n2MailerLite Subscribers API --- Response: %s\n", response);
	});
	return parseJsonString(response);
}



static struct NewSubscriberToGroup
{
	this(string g, string e, string n, string ln) //, string ln, string c)
	{
		// this.apiKey = a;
		this.groupName = g;
		this.email = e;
		this.name = n;
		this.lastName = ln;
		// this.country = c;
	}

	// string apiKey;
	// string apiEndpoint;
	string groupName;
	string email;
	string name;
	string lastName;
	string country;
}

static class NewSubscriberToGroups
{
	this(string a, string[] g, string e, string n) //, string ln, string c)
	{
		this.apiKey = a;
		this.apiEndpoint = "groups/group_name/subscribers";
		this.groupNames = g;
		this.email = e;
		this.name = n;
		// this.lastName = ln;
		// this.country = c;
	}

	string apiKey;
	string apiEndpoint;
	string[] groupNames;
	string email;
	string name;
	string lastName;
	string country;
}

// Json prepareRequestBody(T)(T t) {
	
// }

Json addSubscriberToGroup(T)(T t, AuthInfo authInfo)
{
	string _url = BASE_URL ~ "groups/group_name/subscribers";
	// auto authInfo = AuthInfo(t.apiKey);
	string response = "";
	Json reqBody = Json([
				"group_name": Json(t.groupName),
				"email": Json(t.email),
				"name": Json(t.name)
				// "last_name": Json(t.lastName),
				// "country": Json(t.country)
			]);

	requestHTTP(_url,
			(scope req) {
		req.method = HTTPMethod.POST;
		req.headers[authInfo.authHeader] = authInfo.apiKey;
		req.headers[authInfo.contentHeader] = authInfo.contentType;
		req.writeJsonBody(reqBody);
	},
			(scope res) {
		response = res.bodyReader.readAllUTF8();
		logWarn("\nMailerLite Groups API --- Response: %s\n", response);
	});
	return parseJsonString(response);
}
///
unittest
{
	auto APICall = NewSubscriberToGroup("03450809c61a7f48416e6527320867c1", "Survey Started", "mirellakimsing@gmail.com", "Mirella", formEncode("Kim Sing"), "United Kingdom"); // @suppress(dscanner.style.long_line)

	auto result = addSubscriberToGroup!NewSubscriberToGroup(APICall);
	assert(is(typeof(result) == Json));
}

Json batchAddSubscriberToGroups(T)(T t) 
{
	string _url = BASE_URL ~ t.apiEndpoint;
	auto authInfo = AuthInfo(t.apiKey);
	string response = "";
	Json reqBody = Json([
				"requests": Json([
					Json([
						"method": "POST",
						"path": "/api/v2/groups/group_name/subscribers",
						"body": Json([
							"group_name": Json(t.groupName),
							"email": Json(t.email),
							"name": Json(t.name)
						]),
					])
				])
			]);

	requestHTTP(_url,
			(scope req) {
		req.method = HTTPMethod.POST;
		req.headers[authInfo.authHeader] = authInfo.apiKey;
		req.headers[authInfo.contentHeader] = authInfo.contentType;
		req.writeJsonBody(reqBody);
	},
			(scope res) {
		response = res.bodyReader.readAllUTF8();
		logWarn("\nMailerLite Groups API --- Response: %s\n", response);
	});
	return parseJsonString(response);
}

module konnexengine.ui.utilities;

import std.conv : to;
import std.uuid: UUID, parseUUID;

import vibe.db.redis.redis: RedisDatabase;
import vibe.data.json : Json, parseJsonString;
import vibe.http.server : HTTPServerRequest;
import konnexengine.app.data : AuthState, AppData;
import konnexengine.user.blueprint;

import dotenv;

T prepare(T)(T t, AppData appData, AuthState authState, Json videoData)
{
	t.ui.name = appData.name;
	t.ui.page = appData.page;
	t.ui.auth["signup"] = authState.signup;
	t.ui.auth["pass_reqd"] = authState.passwordRequired;
	t.ui.auth["success"] = authState.success;
	t.ui.auth["login"] = authState.login;
	t.ui.auth["valid"] = authState.valid;

	t.content.videos = videoData["items"];
	t.content.currentVideo = appData.currentVideo;

	t.user.accessToken = appData.accessToken;
	t.user.email = "";
	t.user.username = appData.username;

	return t;
}

void configure(AppData* appData, Json videoData)
{
	Env.load(".env", false);
	appData.page = "index";

	appData.name = "Konnex Accounts";
	// channel.name(videos[0]["snippet"]["channelTitle"].get!string);
	appData.currentVideo = videoData["items"][0];
	// logInfo(videoData.to!string);

	import std.file;

	if (!exists("videos.json"))
	{
		writeVideosToFile(videoData);
	}
}

void writeVideosToFile(Json videoData)
{
	string vids = videoData.toPrettyString();

	import std.file : write;

	write("videos.json", vids);
}

void cacheUser(string r, RedisDatabase* _user, RedisDatabase* _db)
{
	string id = parseJsonString(r)["user"]["user_id"].to!string;
	string email = parseJsonString(r)["user"]["email"].to!string;
	string username = parseJsonString(r)["user"]["username"].to!string;

	_user.set(email,id);
	_user.set(username, id);


	_user.hset("user: " ~ id, "id", id);
	_user.hset("user: " ~ id, "email", email);
	// foreach (eml; user.email())
	// {
	// 	_user.hset("user:" ~ id, "email", eml.get());
	// }
	_user.hset("user: " ~ id, "username", parseJsonString(r)["user"]["username"].to!string);
	_user.hset("user: " ~ id, "password", parseJsonString(r)["user"]["password"].to!string);

	_user.hgetAll("user:" ~ id);
}

void cacheUserTokens(string user, string accessToken, RedisDatabase* _user)
{
	string id = user;
	_user.set(id,accessToken);
}

void cacheUserPage(string user, string page, RedisDatabase* _page)
{
	string id = user;
	_page.set(id,page);
}

void cacheUserKomponent(string user, string komponent, RedisDatabase* _komponent)
{
	string id = user;
	_komponent.set(id,komponent);
}

// 

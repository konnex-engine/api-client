module konnexengine.app.data;

import konnexengine.modules.blueprint;
import vibe.data.json : Json;

struct UIData
{
	string name;
	string page;
	string komponent = "home";

	bool[string] auth;
}

struct ContentData
{
	Json videos;
	Json currentVideo;
}

struct UserData
{
	string _id;
	string accessToken;
	string username;
	string email;
}

struct Data
{
	auto ui = UIData();
	auto content = ContentData();
	auto user = UserData();
}

/// AppDataInterface `interface`
interface AppDataInterface
{

}

/// AppData `struct`
struct AppData
{
	string name = "";
	string namespace = "";
	string accessToken = "";
	string refreshToken = "";
	string page = "";
	string komponent = "home";
	string username = "";
	Json videos = Json("");
	Json currentVideo = Json("");
	string msg = "";
	string currentUser = "";
}
///
// unittest
// {
// 	import fastjwt.jwt;
// 	import vibe.data.json : Json;

// 	auto data = AppData("Test App", "Test Module", "token", "refreshToken",
// 			"crowdfunding", "user1", Json(""), Json(""));

// 	assert(is(typeof(data) == AppData));
// 	assert(is(typeof(data.name) == string));
// 	assert(is(typeof(data.namespace) == string));
// 	assert(is(typeof(data.accessToken) == string));
// 	assert(is(typeof(data.refreshToken) == string));
// 	assert(is(typeof(data.page) == string));
// 	assert(is(typeof(data.username) == string));
// 	assert(is(typeof(data.videos) == Json));
// 	assert(is(typeof(data.currentVideo) == Json));
// 	assert(data.name == "Test App");
// 	assert(data.namespace == "Test Module");
// 	assert(data.accessToken == "token");
// 	assert(data.refreshToken == "refreshToken");
// 	assert(data.page == "crowdfunding");
// 	assert(data.username == "user1");
// 	assert(data.videos == Json(""));
// 	// assert(data.currentVideo == "vky56f6uykty");

// }

/// AuthState `struct`
struct AuthState
{
	/// signuo - `bool`
	bool signup = false;
	/// passwordRequired - `bool`
	bool passwordRequired = false;
	/// login - `bool`
	bool login = false;
	/// success - `bool`
	bool success = false;
	/// valid - `bool`
	bool valid = false;
}
///
unittest
{
	auto state = AuthState();
	assert(is(typeof(state) == AuthState));
	assert(is(typeof(state.signup) == bool));
	assert(is(typeof(state.passwordRequired) == bool));
	assert(is(typeof(state.success) == bool));
	assert(is(typeof(state.login) == bool));
	assert(is(typeof(state.valid) == bool));
	assert(state.signup == false);
	assert(state.passwordRequired == false);
	assert(state.success == false);
	assert(state.login == false);
	assert(state.valid == false);
}

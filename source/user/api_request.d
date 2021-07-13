module konnexengine.user.api_request;

/// UserRequest `struct`
struct UserRequest
{
	this(uint fn, Data d)
	{
		this.fn = fn;
		this.data = d;
	}

	uint fn;
	Data data;

	struct Data
	{
		string email;
		string username;
		string password;
		string namespace;
	}
	///
	unittest {
		auto data = Data("","","","");
		assert(is(typeof(data) == Data));
		assert(is(typeof(data.email) == string));
		assert(is(typeof(data.username) == string));
		assert(is(typeof(data.password) == string));
		assert(is(typeof(data.namespace) == string));
		assert(data.email == "");
		assert(data.username == "");
		assert(data.password == "");
		assert(data.namespace == "");
	}
}///
unittest {
	auto request = UserRequest(0, UserRequest.Data("","","",""));
	assert(is(typeof(request) == UserRequest));
	assert(is(typeof(request.fn) == uint));
	assert(is(typeof(request.data) == UserRequest.Data));
	assert(request.fn == 0);
	assert(request.data == UserRequest.Data("","","",""));
}


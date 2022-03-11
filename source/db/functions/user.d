module konnexengine.db.functions.user;

Json create(T)(T t) {
	import vibe.http.client: requestHTTP;

	string url = Env["DB_SERVER_URL"];

	string result;

	requestHTTP(url, (scope req) {
		req.method = HTTPMethod.POST;
		req.writeJsonBody([
			"email": Json(t.email),
			"password": Json(t.password),
			"namespace": Json(t.namespace)
		]);
	}, (scope res) {
		result = res.json;
	});
	return result;
}
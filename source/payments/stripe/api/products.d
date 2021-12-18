module konnexengine.payments.stripe.api.products;

import vibe.http.common: HTTPMethod;
import vibe.http.client: requestHTTP;
import vibe.data.json: Json;
import vibe.stream.operations: readAllUTF8;
import vibe.core.log: logInfo;

import konnexengine.product.blueprint: Product;
import dotenv: Env;

/**
 * 
 */
Json create(T)(T t)
{
	Json product;

	Env.load(".env", false);
	string baseUrl = Env["STRIPE_API_URL"];
	logInfo(baseUrl);
	string url = baseUrl ~ "/products";
	logInfo(url);

	requestHTTP(url, (scope req)
	{
		req.method = HTTPMethod.POST;
		req.headers["Authorization"] = "Bearer " ~ Env["STRIPE_SECRET_KEY"];
		req.headers["Content-Type"] = "application/x-www-form-urlencoded";
		req.writeFormBody(["name": t.name]);
	}
	, (scope res)
	{
		product = res.bodyReader.readAllUTF8();
	});
	return product;
}
///
unittest
{
	import std.conv: to;
	import konnexengine.product.blueprint: Product;

	auto p = Product("Test Product 1");
	auto product = create!Product(p);

	logInfo(product.to!string);
}
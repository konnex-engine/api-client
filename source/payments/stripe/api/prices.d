module konnexengine.payments.stripe.api.prices;

import std.conv: to;
import vibe.http.common: HTTPMethod;
import vibe.http.client: requestHTTP;
import vibe.data.json: Json;
import vibe.stream.operations: readAllUTF8;
import vibe.core.log: logInfo;

import konnexengine.product.blueprint: Price;
import dotenv: Env;

/**
 * 
 */
Json create(T)(T t)
{
	Json price;

	Env.load(".env", false);
	string baseUrl = Env["STRIPE_API_URL"];
	logInfo(baseUrl);
	string url = baseUrl ~ "/prices";
	logInfo(url);

	requestHTTP(url, (scope req)
	{
		req.method = HTTPMethod.POST;
		req.headers["Authorization"] = "Bearer " ~ Env["STRIPE_SECRET_KEY"];
		req.headers["Content-Type"] = "application/x-www-form-urlencoded";
		req.writeFormBody(
			[
				"currency": t.currency,
				"unit_amount": t.amount.to!string,
				"product": t.product
			]);
	}
	, (scope res)
	{
		price = res.bodyReader.readAllUTF8();
	});
	return price;
}
///
unittest
{
	import std.conv: to;
	import konnexengine.product.blueprint: Price;

	auto p = Price("gbp", 99999, "prod_K7Cw4D36hz3OnZ");
	auto price = create!Price(p);

	logInfo(price.to!string);
}
module konnexengine.integrations.google.auth;

// import std.conv: to;
// import vibe.core.log: logInfo, logWarn;
// import vibe.data.json: Json, parseJsonString;
// import vibe.stream.operations: readAllUTF8;


// string authTokenTarget = "https://oauth2.googleapis.com/token";

// struct AuthScopes
// {
// 	string sheetsReadWrite = "https://www.googleapis.com/auth/spreadsheets";
// 	string sheetsReadOnly = "https://www.googleapis.com/auth/spreadsheets.readonly";
// }

// struct JWTClaim 
// {
// 	string serviceAccount;
// 	string authScope;
// 	string target;
// }


// string createJWTRequestObject(T)(T t)
// {
// 	Json header = Json(["alg": Json("RS256"), "type": Json("JWT")]);
	
// 	import std.datetime.systime: stdTimeToUnixTime, Clock;
// 	auto issuedAt = stdTimeToUnixTime(Clock.currStdTime());
// 	auto expiry = issuedAt + 3599;

// 	logInfo(issuedAt.to!string);
// 	logInfo(expiry.to!string);
	
// 	Json claimSet = Json([
// 		"iss": Json(t.serviceAccount),
// 		"scope": Json(t.authScope),
// 		"aud": Json(t.target),
// 		"exp": Json(expiry),
// 		"iat": Json(issuedAt)
// 	]);
// 	import std.base64: Base64URLNoPadding;
// 	import std.string: representation;
// 	string headerEnc = Base64URLNoPadding.encode(header.to!string.representation);
// 	string claimEnc = Base64URLNoPadding.encode(claimSet.to!string.representation);
// 	return headerEnc ~ "." ~ claimEnc;
// }
// /// 
// unittest
// {
// 	import fastjwt.jwt;
// 	import stringbuffer;

// 	string secret = "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC8rmOWgWUcTyQH\nZcJ1WKxjAqG4gkarkN0nqIuxkOPkLkWXWqjLdyKZ5xnAzZ9iq4pg3ZadzfeaMKgp\nAWI9RTMYqryMMUmXYu5KJpEH4860TqUuj5J2iZOgqC5GJKH2eau1ph3PSZFqBxzp\nABYPpaweLd2zr7b5ywwnuFLfvbNoiazYzJnRxpJgFzZgRBuWZz7pHaJBIvFNuCMt\n/PyVh8NGCYHpEROaSow5R86Vuo0dfjDLwpW4/WE5arc3GzRjIsXacsJUq0L+Bcad\nDWeWKPWJ4zWhn6rp/0t33yOv+p7GFJpqbWlHUeUZNQnf6cr8oU0JCX2cAP9ZicN9\n+MWtU+vHAgMBAAECggEAA1sAl2UetLWtmNoU7rxQeIRL9vmOIy/01uc28MX4X475\nGtt4ZAHu4hjLivO9MWaGk/ls28qVbC8QVoZZRmisI3Sp3L5lpiUSwsvTyXWiL++0\nHVNdUfFZaEKFbCbroHQCez0Ei7KtvNp6h6RCQC38lR7QsgjecqvLQAuVobgAcEv2\npOcasWOi8Xk3MMLjh8HJLFJ/3F4jigG0w9iQj/LSFwxTi/r5GFekQAVTSAqymbG3\n1rSGlK9T3J9O8uAmqf5xLHfiScbE9Zbz6xddxA7qnwEFri+OKkeaOJ0dQbpdx++a\no91CN5AaFi/niuMrPR7A2x4LD4FvMZQKrtvrrhv3ZQKBgQDzVDnFhZ3JDSwXoaBk\ne8MKgALnumFhM9Hbjp0+ahXKL/bRFeuznSw2Rit58zR1CvKlcHg5gu4uQuqK+VCX\nf7hVQzy4KL8s9QXkICf6B2FDvDcH/e6SopgqTVNbWbphuy3UsWYsk2y58qOQ1XCW\nUaxw/Mw1BkKcu8VXmWCii+zPgwKBgQDGganfD8skrGPj/m4OmhPpRGKfifDq5Mz1\n5ugqH7hAgC50kuUAX1vtQGkIAb7zonRdP1CqzIncwxDLqmK15XqoLm0ddyOa9Ard\niT5quAirx9IG74dI238uTDA3u7ONQfLWF/BEGaHQQzv6rdhlQaMLvWhnw6a6sUOm\nc3Pi/JRbbQKBgHhTdh4O7O+2687jxgTqjpBqrQUaTX1burLv2yI6I3xQK6VJSb0Q\nRASyvl0XvyEBwOu+qjUGYfHOdV0z3H6OUgEXtrb6r07z+23L2PjzHU35jN0O3SL1\n9Hk2s7nArUIW5Zr//p6caG+rZOcCJSKwUK2u1OyDo/0NfZDL79VxjDExAoGAa++H\nIW3iBH/kFM18pF3tI7J2ec80e1SLic3TQUxcEF5iZCqXcDtprbiPI7ZnUOxtn2JV\nB3oOIEbEtCliYQt1RUtxM0tbxd6apdkBYl/M/zK4peLKSbhoEBGHSla6i71nQDhm\nAXF6hdZ5H5Y1iuFEuZZ01a8R0oOeiDxQsASs2oUCgYEAofd5cqb/wijzxiizxCin\nMjCs6Gg7iYHOzKt6S46ME4hcII0zEnWGOp82OrmZ/9OZrB9QkF1eV+9L45GxM5jA\niwrJ5wjvp3gI84/vW8SPPictkXVnCgRRwVlvE+gC7ysMeX0SSt+/YawuNxaiazb0\nBAhROk01HsBKNj+tbvhBVR0=";
// 	JWTAlgorithm algo = JWTAlgorithm.HS256;
// 	StringBuffer buf;
// 	auto claim = JWTClaim("tbb-ml@the-beat-box-connector.iam.gserviceaccount.com", "https://www.googleapis.com/auth/spreadsheets.readonly", authTokenTarget);
// 	auto set = createJWTRequestObject!JWTClaim(claim);

// 	encodeJWTToken(buf, algo, secret, set);
// 	// res.writeBody();

	
// 	logInfo(buf.getData());
// }

// string requestAPIAccessToken(T)(T t)
// {
// 	import vibe.http.common: HTTPMethod;
// 	import vibe.http.client: requestHTTP;
// 	import vibe.textfilter.urlencode: formEncode;
	

// 	string url = authTokenTarget;
// 	string result = "";

// 	requestHTTP(url, (scope req) {
// 		req.method = HTTPMethod.POST;
// 		req.headers["Content-Type"] = "application/x-www-form-urlencoded"; 
// 		req.writeFormBody([
// 			"grant_type": "urn:ietf:params:oauth:grant-type:jwt-bearer",
// 			"assertion": t
// 		]);
// 	}, (scope res) {
// 		result = res.bodyReader.readAllUTF8();
// 		logWarn("\nGoogle OAuth2 Token Service --- Response: %s\n", parseJsonString(result).toPrettyString());
// 		// if (res.statusCode == 200)
// 		// {
// 		// 	auto r = result;
// 		// }
		
// 	});
// 	return result;
// }
// ///
// unittest
// {
// 	// import fastjwt.jwt;
// 	// import stringbuffer;

// 	string secret = "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC8rmOWgWUcTyQH\nZcJ1WKxjAqG4gkarkN0nqIuxkOPkLkWXWqjLdyKZ5xnAzZ9iq4pg3ZadzfeaMKgp\nAWI9RTMYqryMMUmXYu5KJpEH4860TqUuj5J2iZOgqC5GJKH2eau1ph3PSZFqBxzp\nABYPpaweLd2zr7b5ywwnuFLfvbNoiazYzJnRxpJgFzZgRBuWZz7pHaJBIvFNuCMt\n/PyVh8NGCYHpEROaSow5R86Vuo0dfjDLwpW4/WE5arc3GzRjIsXacsJUq0L+Bcad\nDWeWKPWJ4zWhn6rp/0t33yOv+p7GFJpqbWlHUeUZNQnf6cr8oU0JCX2cAP9ZicN9\n+MWtU+vHAgMBAAECggEAA1sAl2UetLWtmNoU7rxQeIRL9vmOIy/01uc28MX4X475\nGtt4ZAHu4hjLivO9MWaGk/ls28qVbC8QVoZZRmisI3Sp3L5lpiUSwsvTyXWiL++0\nHVNdUfFZaEKFbCbroHQCez0Ei7KtvNp6h6RCQC38lR7QsgjecqvLQAuVobgAcEv2\npOcasWOi8Xk3MMLjh8HJLFJ/3F4jigG0w9iQj/LSFwxTi/r5GFekQAVTSAqymbG3\n1rSGlK9T3J9O8uAmqf5xLHfiScbE9Zbz6xddxA7qnwEFri+OKkeaOJ0dQbpdx++a\no91CN5AaFi/niuMrPR7A2x4LD4FvMZQKrtvrrhv3ZQKBgQDzVDnFhZ3JDSwXoaBk\ne8MKgALnumFhM9Hbjp0+ahXKL/bRFeuznSw2Rit58zR1CvKlcHg5gu4uQuqK+VCX\nf7hVQzy4KL8s9QXkICf6B2FDvDcH/e6SopgqTVNbWbphuy3UsWYsk2y58qOQ1XCW\nUaxw/Mw1BkKcu8VXmWCii+zPgwKBgQDGganfD8skrGPj/m4OmhPpRGKfifDq5Mz1\n5ugqH7hAgC50kuUAX1vtQGkIAb7zonRdP1CqzIncwxDLqmK15XqoLm0ddyOa9Ard\niT5quAirx9IG74dI238uTDA3u7ONQfLWF/BEGaHQQzv6rdhlQaMLvWhnw6a6sUOm\nc3Pi/JRbbQKBgHhTdh4O7O+2687jxgTqjpBqrQUaTX1burLv2yI6I3xQK6VJSb0Q\nRASyvl0XvyEBwOu+qjUGYfHOdV0z3H6OUgEXtrb6r07z+23L2PjzHU35jN0O3SL1\n9Hk2s7nArUIW5Zr//p6caG+rZOcCJSKwUK2u1OyDo/0NfZDL79VxjDExAoGAa++H\nIW3iBH/kFM18pF3tI7J2ec80e1SLic3TQUxcEF5iZCqXcDtprbiPI7ZnUOxtn2JV\nB3oOIEbEtCliYQt1RUtxM0tbxd6apdkBYl/M/zK4peLKSbhoEBGHSla6i71nQDhm\nAXF6hdZ5H5Y1iuFEuZZ01a8R0oOeiDxQsASs2oUCgYEAofd5cqb/wijzxiizxCin\nMjCs6Gg7iYHOzKt6S46ME4hcII0zEnWGOp82OrmZ/9OZrB9QkF1eV+9L45GxM5jA\niwrJ5wjvp3gI84/vW8SPPictkXVnCgRRwVlvE+gC7ysMeX0SSt+/YawuNxaiazb0\nBAhROk01HsBKNj+tbvhBVR0=\n-----END PRIVATE KEY-----\n";
// 	// JWTAlgorithm algo = JWTAlgorithm.HS256;
// 	// StringBuffer buf;
// 	auto claim = JWTClaim("tbb-ml@the-beat-box-connector.iam.gserviceaccount.com", "https://www.googleapis.com/auth/spreadsheets.readonly", authTokenTarget);
// 	auto input = createJWTRequestObject!JWTClaim(claim);

// 	// encodeJWTToken(buf, algo, secret, set);
// 	// res.writeBody();

// 	string assertion = buf.getData();
// 	logInfo(buf.getData());

// 	string token = requestAPIAccessToken!string(assertion);

// 	logInfo(token);
// }
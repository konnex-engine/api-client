module konnexengine.payments.stripe.utilities;

import dotenv: Env;

string getStripePublishableKey() {
	Env.load(".env", false);
	return Env["STRIPE_PUBLISHABLE_KEY"];
}
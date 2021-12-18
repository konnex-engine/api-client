module konnexengine.integrations.soundee.webhooks;

import std.conv: to;
import std.string: capitalize;
import vibe.core.log: logInfo;
import vibe.data.json: Json;
import konnexengine.integrations.mailerlite.api;

void processSale(Json webhook, AuthInfo auth)
{
	string email = webhook["object"]["customer"]["email"].to!string;
	string name = capitalize(webhook["object"]["customer"]["firstName"].to!string);
	string lastname = capitalize(webhook["object"]["customer"]["lastName"].to!string);
	string country = webhook["object"]["country"]["countryName"].to!string;
	string licenseType = webhook["object"]["items"][0]["license"]["name"].to!string;
	
	// Check if customer is not already a subscriber
	auto i = SubscriberIdentifier(email);
	Json subscriber = getSubscriberBy!SubscriberIdentifier(i, auth);
	string type = subscriber["type"].to!string;
	scope(failure) 
	{
		// Add subscriber
		logInfo(i.identifier ~ " is not a subscriber.");
		logInfo("Adding: " ~ i.identifier ~ "...");
		auto c = CustomerDetails(email,name,lastname,country);
		auto s = createActiveSubscriberFrom!CustomerDetails(c, auth);
		logInfo("Added successfully.");
		logInfo("Setting " ~ i.identifier ~ " status to 'active'...");
		// Set Active
		logInfo(i.identifier ~ " is not a subscriber.");
		Json error = subscriber["error"];
		logInfo("2"~error.to!string);
	}
	scope(success)
	{
		if(type != "active") 
		{
			logInfo("Setting " ~ i.identifier ~ " status to 'active'...");
			// Set Active
			auto c = CustomerDetails(email,name,lastname,country);
			auto s = updateActiveSubscriberFrom!CustomerDetails(c, auth);
			logInfo(i.identifier ~ " is not a subscriber.");
		}
		// logInfo("1"~type);
	}
	scope(exit)
	{
		// Add to license group
		auto sl = NewSubscriberToGroup(licenseType, email, name, lastname);
		auto slg = addSubscriberToGroup!NewSubscriberToGroup(sl, auth);
		// Add to customer group
		auto s = NewSubscriberToGroup("Customer", email, name, lastname);
		auto sg = addSubscriberToGroup!NewSubscriberToGroup(s, auth);
		// Notify of sale
	}
}

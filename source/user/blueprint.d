module konnexengine.user.blueprint;

import std.uuid : UUID, sha1UUID;

import konnexengine.contacts.naturalperson : NaturalPersonName;
import konnexengine.app.data : AppData;

/// UserInterface: `interface`	 
interface UserInterface
{
	@property UUID id();
	@property EmailAddress[UUID] email();
	@property string username();
	@property DisplayName[UUID] displayName();
	@property NaturalPersonName realName();
	@property SocialAccount[UUID] socialAccounts();
	@property PhoneNumber[UUID] phoneNumbers();
	@property PostalAddress[UUID] addresses();
	@property User[UUID] list();
}

/// User - `class implements UserInterface`
class User : UserInterface
{
	this()
	{
	}
	// TODO: Normailse user object
	private
	{
		UUID u_id;
		EmailAddress[UUID] u_emails;
		string u_username;
		DisplayName[UUID] u_displayName;
		NaturalPersonName u_realName;
		SocialAccount[UUID] u_socials;
		PhoneNumber[UUID] u_numbers;
		PostalAddress[UUID] u_addresses;
		User[UUID] u_list;
	}

	/// id() - `UUID`
	@property UUID id()
	{
		return u_id;
	}

	/// id(UUID input) -`UUID`
	@property UUID id(UUID input)
	{
		return u_id = input;
	}

	@property EmailAddress[UUID] email()
	{
		return u_emails;
	}

	@property EmailAddress[UUID] email(EmailAddress input)
	{
		u_emails[input.id] = input;
		return u_emails;
	}

	@property string username()
	{
		return u_username;
	}

	@property string username(string input)
	{
		return u_username = "" ~ input;
	}

	@property DisplayName[UUID] displayName()
	{
		return u_displayName;
	}

	@property DisplayName[UUID] displayName(DisplayName input)
	{
		u_displayName[input.id] = input;
		return u_displayName;
	}

	@property NaturalPersonName realName()
	{
		return u_realName;
	}

	@property NaturalPersonName realName(NaturalPersonName input)
	{
		return u_realName = input;
	}

	@property SocialAccount[UUID] socialAccounts()
	{
		return u_socials;
	}

	@property SocialAccount[UUID] socialAccounts(SocialAccount input)
	{
		u_socials[input.id] = input;
		return u_socials;
	}

	@property PhoneNumber[UUID] phoneNumbers()
	{
		return u_numbers;
	}

	@property PhoneNumber[UUID] phoneNumbers(PhoneNumber input)
	{
		u_numbers[input.id] = input;
		return u_numbers;
	}

	@property PostalAddress[UUID] addresses()
	{
		return u_addresses;
	}

	@property PostalAddress[UUID] addresses(PostalAddress input)
	{
		u_addresses[input.id] = input;
		return u_addresses;
	}

	@property User[UUID] list()
	{
		return u_list;
	}

	@property User[UUID] list(User input)
	{
		u_list[input.id] = input;
		return u_list;
	}

	string deleteEntry(T)(T t)
	{
		logInfo("Delete function not implemented");
		auto message = "" ~ typeof(t) ~ ": " ~ t.id ~ " not deleted";
		return "";
	}
}
///
unittest
{
	import std.conv : to;

	User[UUID] users;
	for (ushort i = 1; i <= 10; i++)
	{
		auto user = new User();
		auto testID = sha1UUID("test" ~ i.to!string, sha1UUID("namespace"));
		user.id(testID);
		auto testemail = new EmailAddress("test" ~ i.to!string ~ "@email.com");
		user.email(testemail);
		user.username("test" ~ i.to!string);
		users[user.id] = user;
	}

	assert(is(typeof(users) == User[UUID]));

	auto user = users[users.keys()[0]];
	assert(is(typeof(user) == User));
	assert(is(typeof(user.id) == UUID));
	assert(is(typeof(user.email) == EmailAddress[UUID]));
	assert(is(typeof(user.username) == string));
	assert(user.id() == sha1UUID(user.username, sha1UUID("namespace")));
	assert(user.email() == user.email());
	assert(user.username() == user.username);

}

/// Email Address: `class`
class EmailAddress
{
	UUID id;
	import std.array : split;

	this(string email)
	{
		this.emailHandle = email.split("@")[0];
		this.emailDomain = email.split("@")[1];
		this.id = sha1UUID(emailHandle, sha1UUID(emailDomain));
		this.emailAddress = this.emailHandle ~ "@" ~ this.emailDomain;
	}

	private
	{

		string emailHandle;
		string emailDomain;
		string emailAddress;
	}

	@property string get()
	{
		return emailAddress;
	}

	@property string get(string input)
	{
		return emailAddress = "" ~ input;
	}

}
///
unittest
{
	auto address = new EmailAddress("test1@email.com");
	assert(is(typeof(address) == EmailAddress));
	assert(is(typeof(address.id) == UUID));
	assert(is(typeof(address.emailHandle) == string));
	assert(is(typeof(address.emailDomain) == string));
	assert(is(typeof(address.emailAddress) == string));
	assert(address.id == sha1UUID(address.emailHandle, sha1UUID(address.emailDomain)));
	assert(address.emailHandle == "test1");
	assert(address.emailDomain == "email.com");
	assert(address.emailAddress == "test1@email.com");
}

/// PhoneNumber: `struct`
struct PhoneNumber
{
	UUID id;
	string countryCode;
	string phoneNumber;
	string extension;
}
///
unittest
{
	auto number = PhoneNumber(sha1UUID("test", sha1UUID("namespace")), "44", "07999999999", "369");

	assert(is(typeof(number) == PhoneNumber));
	assert(is(typeof(number.id) == UUID));
	assert(is(typeof(number.countryCode) == string));
	assert(is(typeof(number.phoneNumber) == string));
	assert(is(typeof(number.extension) == string));
	assert(number.id == sha1UUID("test", sha1UUID("namespace")));
	assert(number.countryCode == "44");
	assert(number.phoneNumber == "07999999999");
	assert(number.extension == "369");
}

/// PostalAddress - `struct`
struct PostalAddress
{
	UUID id;
	string buildingNumber;
	string buildingName;
	string unitNumber;
	string[] streetAddress;
	string town;
	string city;
	string county;
	string country;
}

/// SocialAccount `struct`
struct SocialAccount
{
	UUID id;
	string platform;
	string handle;
	string homepage;
}
///
unittest
{
	import std.uuid : UUID, sha1UUID;

	auto account = SocialAccount(sha1UUID("test", sha1UUID("namespace")),
			"facebook", "konnex-engine", "konnex");
	assert(is(typeof(account) == SocialAccount));
	assert(is(typeof(account.id) == UUID));
	assert(is(typeof(account.platform) == string));
	assert(is(typeof(account.handle) == string));
	assert(is(typeof(account.homepage) == string));
	assert(account.id == sha1UUID("test", sha1UUID("namespace")));
	assert(account.platform == "facebook");
	assert(account.handle == "konnex-engine");
	assert(account.homepage == "konnex");

}

struct DisplayName
{
	UUID id;
	string prefix;
	string value;
	string suffix;

	DisplayName[] list = [];
}

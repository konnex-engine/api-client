module konnexengine.crowd.funding.blueprint;

import std.uuid : UUID, sha1UUID;
import std.conv : to;
import std.datetime : SysTime, Clock;

// TODO: Localise imports
import konnexengine.user.blueprint : User;
import konnexengine.social.engagement : Comment;
import money : currency;

/// CampaignInterface: `interface`
interface CampaignInterface
{
	/// id(): `UUID @property`
	@property UUID id();
	@property UUID ownerID();
	@property string title();
	@property string title(string input);
	@property string summary();
	@property string summary(string input);
	@property string overview();
	@property string overview(string input);
	@property Goal[UUID] goals();
	@property Goal[UUID] goals(Goal input);
	@property string raised();
	@property string raised(string input);
	@property User[UUID] supporters();
	@property User[UUID] supporters(User input);
	@property Donation[UUID] donations();
	@property Donation[UUID] donations(Donation input);
	@property Update[UUID] updates();
	@property Update[UUID] updates(Update input);
	@property Comment[UUID] comments();
	@property Comment[UUID] comments(Comment input);
	@property SysTime createdAt();
	@property SysTime launchedAt();
}

/// Campaign: `class implements CampaignInterface`
class Campaign : CampaignInterface
{
	/// constructor for a new campaign
	this(string title, UUID owner)
	{
		this.c_created_at = Clock.currTime();
		auto id = sha1UUID(title, sha1UUID(owner.to!string));
		this.c_id = id;
		this.c_owner = owner;
		this.c_title = title;
	}

	/// Constructor for an existing campaign
	this(UUID id)
	{
		this.c_id = id;
		// TODO: Pull in rest of existing campaign
	}

	private
	{
		UUID c_id;
		UUID c_owner;
		string c_title;
		string c_summary;
		string c_overview;
		Goal[UUID] c_goals;
		string c_raised;
		User[UUID] c_supporters;
		Donation[UUID] c_donations;
		Update[UUID] c_updates;
		Comment[UUID] c_comments;
		SysTime c_created_at;
		SysTime c_launched_at;
	}

	/// function id (): `returns UUID @property getter`
	@property UUID id()
	{
		return c_id;
	}

	/// @property ownerID (): `returns UUID @property getter`
	@property UUID ownerID()
	{
		return c_owner;
	}

	/// @property title (): `returns string @property getter`
	@property string title()
	{
		return c_title;
	}

	@property string title(string input)
	{
		return c_title = "" ~ input;
	}

	@property string summary()
	{
		return c_summary;
	}

	@property string summary(string input)
	{
		return c_summary = "" ~ input;
	}

	@property string overview()
	{
		return c_overview;
	}

	@property string overview(string input)
	{
		return c_overview = "" ~ input;
	}

	@property Goal[UUID] goals()
	{
		return c_goals;
	}

	@property Goal[UUID] goals(Goal input)
	{
		c_goals[input.id] = input;
		return c_goals;
	}

	@property string raised()
	{
		return c_raised;
	}

	@property string raised(string input)
	{
		return c_raised = "" ~ input;
	}

	@property User[UUID] supporters()
	{
		return c_supporters;
	}

	@property User[UUID] supporters(User input)
	{
		c_supporters[input.id] = input;
		return c_supporters;
	}

	@property Donation[UUID] donations()
	{
		return c_donations;
	}

	@property Donation[UUID] donations(Donation input)
	{
		c_donations[input.id] = input;
		return c_donations;
	}

	@property Update[UUID] updates()
	{
		return c_updates;
	}

	@property Update[UUID] updates(Update input)
	{
		c_updates[input.id] = input;
		return c_updates;
	}

	@property Comment[UUID] comments()
	{
		return c_comments;
	}

	@property Comment[UUID] comments(Comment input)
	{
		c_comments[input.id] = input;
		return c_comments;
	}

	@property SysTime createdAt()
	{
		return c_created_at;
	}

	@property SysTime launchedAt()
	{
		return c_launched_at;
	}
}
///
unittest
{
	auto owner = sha1UUID("owner", sha1UUID("namespace"));
	auto campaign = new Campaign("Amazing New Campaign", owner);
	assert(is(typeof(campaign.id()) == UUID));
	assert(is(typeof(campaign.ownerID()) == UUID));
	assert(is(typeof(campaign.title()) == string));
	assert(is(typeof(campaign.createdAt()) == SysTime));
}

class Goal
{

	this()
	{
		auto id = sha1UUID(amount ~ title, sha1UUID(amount ~ description));
	}

	private
	{
		UUID id;
		string amount;
		string title;
		string description;
		SysTime achieved;
	}

}

///
struct Donation
{
	UUID id;
	UUID donor;
	ulong amount;
}

///
struct Update
{
	UUID id;
	string title;
	string detail;
	Comment[] comments;
}

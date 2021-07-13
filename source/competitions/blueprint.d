module konnexengine.competitions.blueprint;

import std.uuid : UUID, sha1UUID;
import std.conv : to;
import std.datetime : SysTime, Clock;

// TODO: Localise imports
import konnexengine.user.blueprint : User;
import konnexengine.social.engagement : Comment;
import money : currency;

/// CompetitionInterface: `interface`
interface CompetitionInterface
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
	@property User[UUID] entrants();
	@property User[UUID] entrants(User input);
	@property Entry[UUID] entries();
	@property Entry[UUID] entries(Entry input);
	@property Update[UUID] updates();
	@property Update[UUID] updates(Update input);
	@property Comment[UUID] comments();
	@property Comment[UUID] comments(Comment input);
	@property SysTime createdAt();
	@property SysTime launchedAt();
}

/// Competition: `class implements CompetitionInterface`
class Competition : CompetitionInterface
{
	/// constructor for a new competition
	this(string title, UUID owner)
	{
		this.c_created_at = Clock.currTime();
		auto id = sha1UUID(title, sha1UUID(owner.to!string));
		this.c_id = id;
		this.c_owner = owner;
		this.c_title = title;
	}

	/// Constructor for an existing competition
	this(UUID id)
	{
		this.c_id = id;
		// TODO: Pull in rest of existing competition
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
		User[UUID] c_entrants;
		Entry[UUID] c_entries;
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

	@property User[UUID] entrants()
	{
		return c_entrants;
	}

	@property User[UUID] entrants(User input)
	{
		c_entrants[input.id] = input;
		return c_entrants;
	}

	@property Entry[UUID] entries()
	{
		return c_entries;
	}

	@property Entry[UUID] entries(Entry input)
	{
		c_entries[input.id] = input;
		return c_entries;
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
	auto competition = new Competition("Amazing New Competition", owner);
	assert(is(typeof(competition.id()) == UUID));
	assert(is(typeof(competition.ownerID()) == UUID));
	assert(is(typeof(competition.title()) == string));
	assert(is(typeof(competition.createdAt()) == SysTime));
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
struct Entry
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

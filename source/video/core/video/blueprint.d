module konnexengine.video.core.video.blueprint;

import std.uuid : UUID;

interface VideoInterface
{
	@property UUID id();
	@property string title();
	@property string description();
}

class Video : VideoInterface
{
	private
	{
		UUID v_id;
		string v_title;
		string v_description;
	}

	@property UUID id()
	{
		return v_id;
	}

	@property string title()
	{
		return v_title;
	}

	@property string description()
	{
		return v_description;
	}
}

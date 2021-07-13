module konnexengine.video.youtube.video.blueprint;

import std.uuid : UUID;
import vibe.inet.url : URL;
import konnexengine.video.core.video.blueprint : VideoInterface;

struct YoutubeVideos
{
	YoutubeVideo[] videos;
}

interface YoutubeVideoInterface
{
	@property string youtubeID();
	@property ResourceURL[] thumbnails();
}

class YoutubeVideo : VideoInterface
{
	private
	{
		UUID v_id;
		string v_youtube_id;
		string v_title;
		string v_description;
		ResourceURL[] v_thumbs;
	}

	@property UUID id()
	{
		return v_id;
	}

	@property UUID id(UUID input)
	{
		return v_id = input;
	}

	@property string youtubeID()
	{
		return v_youtube_id;
	}

	@property string title()
	{
		return v_title;
	}

	@property string description()
	{
		return v_description;
	}

	@property ResourceURL[] thumbnails()
	{
		return v_thumbs;
	}

}

interface ResourceURLInterface
{
	@property UUID id();
	@property string resourceType();
	@property URL resourceURL();
}

class ResourceURL : ResourceURLInterface
{
	private
	{
		UUID r_id;
		string r_type;
		URL r_url;
	}

	@property UUID id()
	{
		return r_id;
	}

	@property UUID id(UUID input)
	{
		return r_id = input;
	}

	@property string resourceType()
	{
		return r_type;
	}

	@property string resourceType(string input)
	{
		return r_type = "" ~ input;
	}

	@property URL resourceURL()
	{
		return r_url;
	}

	@property URL resourceURL(URL input)
	{
		return r_url = input;
	}
}

class ThumbnailURL : ResourceURL
{
}

module konnexengine.video.youtube.channel.blueprint;

import std.uuid : UUID, sha1UUID;
import konnexengine.video.core.video.blueprint : Video;

T generateStructfor(T)(T t)
{
	return t;
}

struct YoutubeChannelData
{
	this(string YoutubeID, string APIKey)
	{
		this.youtubeID = YoutubeID;
		this.apiKey = APIKey;
	}

	string youtubeID;
	string apiKey;
}

interface ChannelInterface
{
	@property UUID id();
	@property string youtubeID();
	@property string name();
	@property string apiKey();
	@property Video[] videos();
}

class Channel : ChannelInterface
{
	this()
	{
	}

	this(string youtubeID, string apiKey)
	{
		this.c_id = sha1UUID(youtubeID, sha1UUID(apiKey));
		this.c_youtube_id = youtubeID;
		this.c_api_key = apiKey;
	}

	private
	{
		UUID c_id;
		string c_youtube_id;
		string c_name;
		string c_api_key;
		Video[] c_videos;

		YoutubeChannelData generateChannelData()
		{

			auto cData = YoutubeChannelData(youtubeID(), apiKey());
			return cData;
		}
	}

	YoutubeChannelData returnChannelData()
	{
		return generateChannelData();
	}

	@property UUID id()
	{
		return c_id;
	}

	@property UUID id(UUID input)
	{
		return c_id = input;
	}

	@property string youtubeID()
	{
		return c_youtube_id;
	}

	@property string youtubeID(string input)
	{
		return c_youtube_id = "" ~ input;
	}

	@property string name()
	{
		return c_name;
	}

	@property string name(string input)
	{
		return c_name = "" ~ input;
	}

	@property string apiKey()
	{
		return c_api_key;
	}

	@property string apiKey(string input)
	{
		return c_api_key = "" ~ input;
	}

	@property Video[] videos()
	{
		return c_videos;
	}

	@property Video[] videos(Video input)
	{
		c_videos ~= input;
		return c_videos;
	}
}

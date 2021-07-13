module konnexengine.video.local.utilities;

import std.conv: to;

import vibe.data.json: Json;
import vibe.core.log: logInfo;


Json getVideosFromFile()
		{

			import std.file : read;

			auto vids = read("videos.json").to!string;

			if (is(typeof(vids)) == is(typeof("string")))
			{
				logInfo("SUCCESS: Video metadata loaded from file.");
				import vibe.data.json: parseJsonString;
				return parseJsonString(vids);
			}
			else
			{
				logInfo("ALERT: There was a problem loading video metadata from file.");
				throw new Error("Unable to load video from file.");
			}

		}

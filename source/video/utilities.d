module konnexengine.video.utilities;

import vibe.data.json : Json, parseJsonString;

Json getVideos()
{
	import std.file : exists;

	if (exists("videos.json"))
	{
		import vibe.core.log : logInfo;

		logInfo("Found videos.json file.\nLoading video metadata from file... ");
		import konnexengine.video.local.utilities : getVideosFromFile;

		return getVideosFromFile();
	}
	else
	{
		import konnexengine.video.youtube.config : getYoutubeVideos;

		return parseJsonString(getYoutubeVideos());
	}
}

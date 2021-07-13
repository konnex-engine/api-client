module konnexengine.video.youtube.config;

import konnexengine.video.youtube.channel.blueprint : generateStructfor,
	YoutubeChannelData, Channel;
import konnexengine.secret.environment : Credentials, returnCredentials;

string returnSearchApiUrlFrom(T)(T t)
{
	return "https://youtube.googleapis.com/youtube/v3/search?part=snippet&channelId="
		~ t.youtubeID ~ "&order=date&maxResults=50&key=" ~ t.apiKey;
}

string getYoutubeVideos()
{
	Credentials c = returnCredentials();
	auto id = c.youtubeChannelID;
	auto ak = c.youtubeAPIKey;
	auto channelData = YoutubeChannelData(id, ak);
	auto searchAPI = returnSearchApiUrlFrom!YoutubeChannelData(channelData);
	import konnexengine.video.youtube.utilities : getVideosFromYoutube;

	return getVideosFromYoutube(searchAPI);
}

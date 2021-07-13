module konnexengine.video.youtube.utilities;

import vibe.core.log: logInfo;
import vibe.http.client;
import vibe.stream.operations;

string getVideosFromYoutube(const string url)
{
	logInfo("INFO: Retrieving video metadata from Youtube API...");

	string videos;
	
	requestHTTP(url, (scope req) {
		req.method = HTTPMethod.GET;
	}, (scope res) {
		if (res.statusCode == 200)
		{
			logInfo("SUCCESS: %s", "Successfully retrieved video metadata from Youtube API.");
		}
		else
		{
			logInfo("ALERT: There was a problem retrieving video metadata from Youtube API.");
			// throw new Error("Unable to retrive video metadata from Youtube API.");
		}

		videos = res.bodyReader.readAllUTF8();

	});
	return videos;
}

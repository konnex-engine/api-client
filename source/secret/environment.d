module konnexengine.secret.environment;

/// Credtials struct
struct Credentials
{   
    string youtubeAPIKey;
    string youtubeChannelID;
}
///
unittest {
    auto c = Credentials("iamastring", "soami");
    assert(is(typeof(c) == Credentials));
    assert(is(typeof(c.youtubeAPIKey) == string));
    assert(is(typeof(c.youtubeChannelID) == string));
    assert(c.youtubeAPIKey == "iamastring");
    assert(c.youtubeChannelID == "soami");
}

/**
    Function - returnCredentials()

    Returns - struct Credentials
 */
Credentials returnCredentials()
{
    import std.process : environment;

    return Credentials(environment.get("YOUTUBE_API_KEY"), environment.get("YOUTUBE_CHANNEL_ID"));
}
///
unittest
{
    import std.process: environment;
    assert(is(typeof(returnCredentials()) == Credentials));
    assert(is(typeof(returnCredentials().youtubeAPIKey) == string));
    assert(is(typeof(returnCredentials().youtubeChannelID) == string));
    assert(returnCredentials().youtubeAPIKey == environment.get("YOUTUBE_API_KEY"));
    assert(returnCredentials().youtubeChannelID == environment.get("YOUTUBE_CHANNEL_ID"));
}

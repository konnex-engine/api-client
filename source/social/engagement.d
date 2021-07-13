module konnexengine.social.engagement;

import std.uuid: UUID;

struct Comment
{
	UUID id;
	UUID commenter;
	string detail;
	string timestamp;
}
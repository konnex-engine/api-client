module konnexengine.auth.roles;

interface RoleInfoInterface
{
	bool isAdmin();
	bool isSubscriber();
	bool isMember();
	bool isPremiumUser();
}

@safe
static class RoleInfo: RoleInfoInterface
{
	this(string ID)
	{
		this.userID = ID;
	}

	@safe
	{
		string userID;

		bool isAdmin()
		{
			return true;
		}

		bool isSubscriber()
		{
			return true;
		}

		bool isMember()
		{
			return true;
		}

		bool isPremiumUser()
		{
			return true;
		}

		bool isHost()
		{
			return true;
		}

		bool isRenter()
		{
			return true;
		}
	}
}


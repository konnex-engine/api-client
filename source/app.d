import std.stdio;

import konnexengine.app.data: AppData;

version(unittest) 
{
	// Do nothing here, dub takes care of that
}
else
{
	void main()
	{
		auto d = AppData("");
		writeln("Edit source/app.d to start your project.");
	}
}


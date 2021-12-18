module konnexengine.db.functions;


T DB(T)(T t)
{
	return t;
}

T DBEntry(T)(T t)
{
	return t;
}

T prepareEntry(T)(T t)
{
	return t;
}

T prepareField(T)(T t)
{
	return t;
}

UUID[] prepareArrayField(T)(T t)
{
	UUID[] result = [];

	foreach(value; t)
	{
		appendArrayField!(value, result);
	}

	return t;
}

void appendArrayField(T)(T t, UUID[] arr)
{
	arr ~= t;
}
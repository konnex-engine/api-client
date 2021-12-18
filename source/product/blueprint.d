module konnexengine.product.blueprint;

import std.uuid: UUID;

struct Product
{
	this(string name)
	{
		this.name = name;
	}

	string name;
	string description;
	string[UUID] images;
}

struct Price
{
	string currency;
	uint amount;
	string product;
	// string[string] recurring;
}


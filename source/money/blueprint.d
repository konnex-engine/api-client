module konnexengine.money.blueprint;

import std.conv: to;
import std.uuid: UUID, sha1UUID;
import std.datetime: SysTime, Clock, DateTime;
import std.format;

import money;

class Amount 
{
	import money;
	
	this(string symbol, double amount)
	{
		this.timestamp = Clock.currTime();
		auto payload = "" ~ symbol ~ amount.to!string;
		DateTime ts = cast(DateTime)timestamp;
		this.id = sha1UUID(payload, sha1UUID(payload ~ ts.toISOExtString()));
		this.symbol = symbol;
		this.amount = amount;
	}

	UUID id;
	string symbol;
	double amount;
	SysTime timestamp;
}

class Currency
{
	this (string symbol, string name, ubyte decimals) {
		this.id = sha1UUID(symbol, sha1UUID("name: " ~ name));
		this.symbol = symbol;
		this.name = name;
		this.decimals = decimals;
	}
	UUID id;
	string symbol;
	string name;
	ubyte decimals;
}

/// `createAmountIn(T)(T t, double amount)`: `template function returns Amount`
Amount createAmountIn(T)(T t, double amount) {
	return new Amount(t.symbol, amount);
}
///
unittest {
	auto GBP = new Currency("GBP", "Great British Pound", 2);
	auto amount = createAmountIn!Currency(GBP, 1000);
	auto ts = cast(DateTime) amount.timestamp;
	
	assert(is(typeof(GBP) == Currency));
	assert(is(typeof(amount) == Amount));
}

/** `createMoneyIn (T)(T t)` 
```d
template function returns currency
```
 */
// string createMoneyIn (T)(T t)
// {
// 	alias CUR = currency!(t.symbol);
// 	logInfo(format("%.2f", CUR(t.amount)));
// 	return format("%.2f", CUR(t.amount));
// }
///
unittest {
	alias GBP = currency!("GBP");
	// auto a = createAmountIn!Currency(GBP, 1000);
	// auto money = createMoneyIn!Amount(a);
	// assert(is(typeof(money) == currency));
	// assert(is(typeof(a) == Amount));
	// assert(is(typeof(GBP) == currency));
}
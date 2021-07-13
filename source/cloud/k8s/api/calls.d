module konnexengine.cloud.k8s.api.calls;

/// Request `static struct`
static struct Request
{
	/// method - `string`
	string method;
	/// namespace - `string`
	string namespace;
}
///
unittest
{
	auto r = Request("GET", "konnex-engine");
	assert(is(typeof(r) == Request));
	assert(is(typeof(r.method) == string));
	assert(is(typeof(r.namespace) == string));
	assert(r.method == "GET");
	assert(r.namespace == "konnex-engine");
}


/// k8sAPIServiceEndpointDiscovery T
T k8sAPIServiceEndpointDiscovery(T)(T t)
{
	import vibe.core.log : logInfo;

	version(unittest)
	{

	}
	else
	{
		logInfo("SERVICE ENDPOINT DISCOVERY: " ~ t.method ~ " - " ~ t.namespace);
	}
	
	return t;
}
///
unittest
{
	auto r = Request("GET", "konnex-engine");
	assert(is(typeof(r) == Request));
	assert(is(typeof(r.method) == string));
	assert(is(typeof(r.namespace) == string));
	assert(is(typeof(k8sAPIServiceEndpointDiscovery!Request(r).method) == string));
	assert(is(typeof(k8sAPIServiceEndpointDiscovery!Request(r).namespace) == string));
	assert(k8sAPIServiceEndpointDiscovery!Request(r).method == "GET");
	assert(k8sAPIServiceEndpointDiscovery!Request(r).namespace == "konnex-engine");
}


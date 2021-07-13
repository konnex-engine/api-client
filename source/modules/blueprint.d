module konnexengine.modules.blueprint;

interface KonnexModuleInterface {
	@property string name();
	@property string name(string input);
	@property string navName();
	@property string navName(string input);
}

class KonnexModule: KonnexModuleInterface {
	private {
		string m_uuid;
		string m_name;
		string m_navName;
	}

	@property string name(){
		return m_name;
	}

	@property string name(string input){
		return m_name = "" ~ input;
	}

	@property string navName(){
		return m_navName;
	}

	@property string navName(string input){
		return m_navName = "" ~ input;
	}
}

interface KonnexModulesInterface {
	@property KonnexModule[] modules();
}

class KonnexModules: KonnexModulesInterface {
	private {
		KonnexModule[] konnex_modules;
	}

	@property KonnexModule[] modules(){
		return konnex_modules;
	}

	@property KonnexModule[] modules(KonnexModule input){
		return konnex_modules ~= input;
	}
}
use "stringext"
use "json"

class IVec2
	var x:I64 = 0
	var y:I64 = 0
	
	// Bindings for PonyJson
	new empty() =>
		None
	
	new fromJson(obj:JsonObject val)? =>
		x = obj.data("x")? as I64
		y = obj.data("y")? as I64
	
	new fromString(s:String val)? =>
		let parts = s.split(",")
		x = parts(0)?.i64()?
		y = parts(1)?.i64()?
	
	fun appendJson(json':String iso):String iso^ =>
		var json = consume json'
		json.append(StringExt.format("\"%s,%s\"", x, y))
	    consume json
		
	
	
	new create(x':I64, y':I64) =>
		x = x'
		y = y'
	
	fun ref string(): String val =>
		StringExt.format("%s,%s", x, y)
	
    fun eq(that: IVec2 box): Bool =>
		(x == that.x) and (y == that.y)
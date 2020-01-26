use "stringext"
use "json"
use "collections"

class VecN
	var values:Array[F64] = Array[F64](128)
	
	// Bindings for PonyJson
	new empty() =>
		None
	
	new fromJson(obj:JsonObject val)? =>
		error
	
	new fromString(s:String val)? =>
		let parts:Array[String] val = s.split(",")
		for v in parts.values() do
			push(v.f64()?)
		end
	
	fun appendJson(json':String iso):String iso^ =>
		var json = consume json'
		json.push('"')
		for v in values.values() do
			json.append(v.string())
			json.push(',')
		end
		if values.size() > 0 then
			try json.pop()? end
		end
		json.push('"')
	    consume json
		
	
	
	new create() =>
		None
	
	fun ref push(v:F64) =>
		values.push(v)
	
	fun ref pop():F64? =>
		values.pop()?
	
	fun ref get(i:USize):F64 =>
		try
			values(i)?
		else
			0
		end
	
	fun ref set(i:USize, v:F64) =>
		while values.size() <= i do
			values.push(0)
		end
		try values(i)? = v end
	
	fun ref string(): String val =>
		let s = recover trn String(128) end
		for v in values.values() do
			s.append(v.string())
			s.push(',')
		end
		try s.pop()? end
		consume s
	
    fun eq(that: VecN box): Bool =>
		if this is that then
			return true
		end
		if values.size() != that.values.size() then
			return false
		end
		
		for i in Range[USize](0, values.size()) do
			try
				if values(i)? != that.values(i)? then
					return false
				end
			else
				return false
			end
		end
		
		true
	
	
	fun length():F64 =>
		var t:F64 = 0
		for v in values.values() do
			t = t + (v * v)
		end
		t.f64().sqrt().round()
	
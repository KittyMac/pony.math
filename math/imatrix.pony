use "stringext"
use "json"
use "collections"

class IMatrix
	var values:Array[I64] = Array[I64]
	var width:USize = 0
	
	// Bindings for PonyJson
	new empty() =>
		None
	
	new fromJson(obj:JsonObject val)? =>
		None
		error
	
	new fromString(s:String val)? =>
		let parts:Array[String] val = s.split(",")
		var idx:USize = 0
		for v in parts.values() do
			if width == 0 then
				width = v.usize()?
				resize(width)
			else
				values(idx)? = v.i64()?
				idx = idx + 1
			end
		end
			
	fun appendJson(json':String iso):String iso^ =>
		var json = consume json'
		json.push('"')
		// first value is always the width
		json.append(width.string())
		json.push(',')		
		for v in values.values() do
			json.append(v.string())
			json.push(',')
		end
		try json.pop()? end
		json.push('"')
	    consume json
		
	
	
	new create(dimensions:USize) =>
		resize(dimensions)
	
	fun ref resize(dimensions:USize) =>
			
		// would be cooler to do this in place, but we'll leave that for another time
		let old_values = values
		let old_width = width
		
		width = dimensions
		values = Array[I64](width * width)
		values.undefined(width * width)
		
		for x in Range[USize](0, old_width) do
			for y in Range[USize](0, old_width) do
				try values((y * width) + x)? = old_values((y * old_width) + x)? end
			end
		end
		
		for x in Range[USize](old_width, width) do
			for y in Range[USize](old_width, width) do
				try values((y * width) + x)? = 0 end
			end
		end
		
		
	fun ref get(p:(USize,USize)):I64 =>
		try
			values((p._2 * width) + p._1)?
		else
			0
		end
	
	fun ref set(p:(USize,USize), v:I64) =>
		let m = p._1.max(p._2) + 1
		if m >= width then
			resize(m)
		end
		try values((p._2 * width) + p._1)? = v end
	
	fun ref string(): String val =>
		let s = recover trn String(128) end
		
		s.push('[')
		s.append(width.string())
		s.push('x')
		s.append(width.string())
		s.append("] =>\n")
		
		for y in Range[USize](0, width) do
			for x in Range[USize](0, width) do
				try
					let v = values((y * width) + x)?
					s.append(StringExt.format("%4s", v))
				end
			end
			s.push('\n')
		end

		consume s
	
    fun eq(that: IVecN box): Bool =>
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
		
use "stringext"
use "json"
use "collections"

class Matrix
	var values:Array[F64] = Array[F64]
	var cols:USize = 0
	var rows:USize = 0
	
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
			if rows == 0 then
				rows = v.usize()?
			elseif cols == 0 then
				cols = v.usize()?
				resize(rows,cols)
			else
				values(idx)? = v.f64()?
				idx = idx + 1
			end
		end
			
	fun appendJson(json':String iso):String iso^ =>
		var json = consume json'
		json.push('"')
		json.append(rows.string())
		json.push(',')
		json.append(cols.string())
		json.push(',')
		for v in values.values() do
			json.append(v.string())
			json.push(',')
		end
		try json.pop()? end
		json.push('"')
	    consume json
		
	
	
	new create(new_rows:USize, new_cols:USize) =>
		resize(new_rows, new_cols)
	
	fun ref resize(new_rows:USize, new_cols:USize) =>		
		// would be cooler to do this in place, but we'll leave that for another time
		let old_values = values
		let old_rows = rows
		let old_cols = cols
		
		rows = new_rows
		cols = new_cols
		
		values = Array[F64](rows * cols)
		values.undefined(rows * cols)
		
		for x in Range[USize](0, old_cols) do
			for y in Range[USize](0, old_rows) do
				try values((y * cols) + x)? = old_values((y * old_cols) + x)? end
			end
		end
		
		for x in Range[USize](old_cols, cols) do
			for y in Range[USize](old_rows, rows) do
				try values((y * cols) + x)? = 0 end
			end
		end
		
		
	fun ref get(p:(USize,USize)):F64 =>
		"""
		p is specified as (row,col)
		"""
		try
			values((p._1 * cols) + p._2)?
		else
			0
		end
	
	fun ref set(p:(USize,USize), v:F64) =>
		"""
		p is specified as (row,col)
		"""
		if (p._1 >= rows) or (p._2 >= cols) then
			resize((p._1+1).max(rows), (p._2+1).max(cols))
		end
		try values((p._1 * cols) + p._2)? = v end
	
	fun ref string(): String val =>
		let s = recover trn String(128) end
		
		s.push('[')
		s.append(rows.string())
		s.push('x')
		s.append(cols.string())
		s.append("] =>\n")
		
		for row in Range[USize](0, rows) do
			for col in Range[USize](0, cols) do
				s.append(StringExt.format("%4s", get((row, col))))
			end
			s.push('\n')
		end

		consume s
	
    fun eq(that: Matrix box): Bool =>
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
		
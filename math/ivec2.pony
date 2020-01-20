use "stringext"

class IVec2
	var x:I64 = 0
	var y:I64 = 0
	
	new create(x':I64, y':I64) =>
		x = x'
		y = y'
	
	fun ref string(): String val =>
		StringExt.format("%s,%s", x, y)

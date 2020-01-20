use "stringext"

class Vec2
	var x:F64 = 0
	var y:F64 = 0
	
	new create(x':F64, y':F64) =>
		x = x'
		y = y'
	
	fun ref string(): String val =>
		StringExt.format("%s,%s", x, y)
	
	fun length():F64 =>
		((x * x) + (y * y)).sqrt()
	
	fun distance(b:Vec2):F64 =>
		(((b.x - x) * (b.x - x)) + ((b.y - y) * (b.y - y))).sqrt()
	
	fun ref rotateBy(q:F64) =>
		let x' = x
		let y' = y
		x = (x' * q.cos()) - (y' * q.sin())
		y = (x' * q.sin()) + (y' * q.cos())

	fun angleSigned(b:Vec2):F64 =>
		let length_of_a = length()
		let ax = x / length_of_a
		let ay = y / length_of_a

		let length_of_b = b.length()
		let bx = b.x / length_of_b
		let by = b.y / length_of_b

		let dot = (ax * bx) + (ay * by)

		let angle = dot.atan2((ax * by) - (ay * bx))
		if angle.abs() < F64.epsilon() then return 0.0 end
		angle
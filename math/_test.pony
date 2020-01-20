use "ponytest"
use "files"

actor Main is TestList
	new create(env: Env) => PonyTest(env, this)
	new make() => None

	fun tag tests(test: PonyTest) =>
	test(_TestMathLength)
	test(_TestMathDistance)
	test(_TestMathRotateBy)
	test(_TestMathRotateAround)
		
	
 	fun @runtime_override_defaults(rto: RuntimeOptions) =>
		//rto.ponyanalysis = true
		rto.ponyminthreads = 2
		rto.ponynoblock = true
		rto.ponygcinitial = 0
		rto.ponygcfactor = 1.0


class iso _TestMathLength is UnitTest
	fun name(): String => "length"
	fun apply(h: TestHelper) =>
		h.complete( Vec2(100,0).length() == 100 )

class iso _TestMathDistance is UnitTest
	fun name(): String => "distance"
	fun apply(h: TestHelper) =>
		let a = Vec2(0,50)
		let b = Vec2(0,100)
		h.complete( a.distance(b) == 50 )

class iso _TestMathRotateBy is UnitTest
	fun name(): String => "rotateBy"
	fun apply(h: TestHelper) =>
		let a = Vec2(100,0)
		let b = Vec2(-100,0)
		a.rotateBy(F64.pi())
		h.complete( a == b )

class iso _TestMathRotateAround is UnitTest
	fun name(): String => "rotateAround"
	fun apply(h: TestHelper) =>
		let a = Vec2(150,50)
		let c = Vec2(50,50)
		let b = Vec2(-50,50)
		a.rotateAround(c, F64.pi())
		h.complete( a == b )


use "ponytest"
use "files"
use "collections"

actor Main is TestList
	new create(env: Env) => PonyTest(env, this)
	new make() => None

	fun tag tests(test: PonyTest) =>
	test(_TestMathLength)
	test(_TestMathDistance)
	test(_TestMathRotateBy)
	test(_TestMathRotateAround)
	
	test(_TestIVecN)
	test(_TestIMatrix)
		
	
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

class iso _TestIVecN is UnitTest
	fun name(): String => "ivecN"
	fun apply(h: TestHelper) =>
		let a = IVecN
		var passed = true
		
		a.set(5, 99)
		
		a.set(2, 13)
		
		if a.get(10) != 0 then
			passed = false
		end
		
		if a.string() != "0,0,13,0,0,99" then
			passed = false
		end		
		
		h.complete( passed )


class iso _TestIMatrix is UnitTest
	fun name(): String => "imatrix"
	fun apply(h: TestHelper) =>
		let m = IMatrix(3, 3)
		var passed = true

		for x in Range[USize](0, 11) do
			m.set((x,x), 1)
			m.set((10-x,x), 1)
			m.set((5,x), 1)
			m.set((x,5), 1)
		end
		
		//h.env.out.print(m.string())
		
		if m.string() != "[11x11] =>\n 1   0   0   0   0   1   0   0   0   0   1  \n 0   1   0   0   0   1   0   0   0   1   0  \n 0   0   1   0   0   1   0   0   1   0   0  \n 0   0   0   1   0   1   0   1   0   0   0  \n 0   0   0   0   1   1   1   0   0   0   0  \n 1   1   1   1   1   1   1   1   1   1   1  \n 0   0   0   0   1   1   1   0   0   0   0  \n 0   0   0   1   0   1   0   1   0   0   0  \n 0   0   1   0   0   1   0   0   1   0   0  \n 0   1   0   0   0   1   0   0   0   1   0  \n 1   0   0   0   0   1   0   0   0   0   1  \n" then
			passed = false
		end

		h.complete( passed )

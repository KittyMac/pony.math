all:
	stable env /Volumes/Development/Development/pony/ponyc/build/release/ponyc -o ./build/ ./math
	time ./build/math

test:
	stable env /Volumes/Development/Development/pony/ponyc/build/release/ponyc -V=0 -o ./build/ ./math
	./build/math
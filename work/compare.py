from PIL import Image
import math, operator, sys

p1 = Image.open(sys.argv[1]).histogram()
p2 = Image.open(sys.argv[2]).histogram()

if (len(sys.argv)==4):
	print "test includes two reference screenshots"
	p3 = Image.open(sys.argv[3]).histogram()

rms = math.sqrt(reduce(operator.add, map(lambda a,b: (a-b)**2, p1, p2))/len(p1))
print "rms: "
print rms
if (len(sys.argv)==4):
	rms2 = math.sqrt(reduce(operator.add, map(lambda a,b: (a-b)**2, p3, p2))/len(p3))
	print rms2

if (rms==0):
	print "test passed"
	sys.exit(0)
else:
	if (len(sys.argv)==4):
		if (rms2==0):
			print "test passed"
			sys.exit(0)
	print "test failed"
	sys.exit(1)


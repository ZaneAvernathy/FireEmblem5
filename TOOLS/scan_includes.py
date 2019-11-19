#!/usr/bin/python3

import os
import sys

inc_types = [".include", ".binclude", ".binary"]

def scan(file, deps):
	"""Scan a file for possible includes.
	"""

	try:
		with open(file, "r") as i:
			f = i.readlines()
	except OSError:
		return deps

	dir = os.path.dirname(file)

	for line in f:
		c = line.find(";")
		for inc_type in inc_types:
			d = None
			if line.find(inc_type) != -1:
				if (c != -1) and (line.find(inc_type) > c):
					continue # Comments
				if line.find("'") != -1:
					d = line[line.find("'")+1:line.rfind("'")]
				elif line.find('"') != -1:
					d = line[line.find('"')+1:line.rfind('"')]
				if d is not None:
					deps.append(os.path.join(dir, d))
				if (inc_type != ".binary") and (d is not None):
					n = []
					deps.extend(scan(os.path.join(dir, d), n))
	return deps

def main():

	deps = []
	deps = scan(sys.argv[1], deps)
	print(" ".join(deps))


if __name__ == '__main__':
	main()

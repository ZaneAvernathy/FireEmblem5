#!/usr/bin/python3
import sys
import os
from glob import glob

# Quick script to convert all line endings of files
# in a directory and all subdirectories into Unix-style
# line endings.

def main():

	root = sys.argv[1]

	files = glob(os.path.join(root, "**/*.*"), recursive=True)


	for file in files:

		with open(file, "r", encoding="UTF-8", newline=None) as i:
			f = i.read()

		with open(file, "w", encoding="UTF-8", newline="\n") as o:
			o.write(f)

if __name__ == "__main__":
	main()

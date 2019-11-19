#!/usr/bin/python3
import sys, os
import csv

def process(csvname, outname):

	defs = ""
	table = ""

	with open(csvname, "r", encoding="utf-8") as c:

		tablename = os.path.splitext(os.path.split(outname)[1])[0]

		tablename = tablename.replace(" ", "")

		sheet = csv.reader(c)

		row1 = next(sheet)

		structname = row1[0].split()[0]
		i = int(row1[0].split()[1])

		params = row1[1:]

		rows = [row for row in sheet]

		spacing = (4+max([len(p) for p in params])+max([len(row[0]) for row in rows]))//4

		for row in rows:

			name = row[0]

			items = row[1:]

			defs += "\t" + name + "\t"*(spacing-(len(name)//4)) + "\t= " + str(i) + "\n"

			for n in range(len(items)):

				defs += "\t\t" + name + params[n] + "\t"*(spacing-((len(name)+4+len(params[n]))//4)) + "\t= " + items[n] + "\n"

			i += 1

			defs += "\n"

			table += name + tablename + "Entry .dstruct " + structname + ", " + ", ".join([name+param for param in params]) + "\n"

	with open(outname, "w", encoding="utf-8") as o:
		o.write(defs)
		o.write(table)

def main():

	inname = sys.argv[1]
	outname = sys.argv[2]

	process(inname, outname)


if __name__ == '__main__':
	main()



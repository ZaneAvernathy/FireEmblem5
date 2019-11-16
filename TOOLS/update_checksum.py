#!/usr/bin/python3

import os
import sys

def main():
	with open(sys.argv[1], "rb") as i:
		ROM = bytearray(i.read())

	oldsum = int.from_bytes(ROM[0x7FDE:0x7FE0], "little")

	sum = 0

	for i in range(len(ROM)):
		if i in (0x7FDC, 0x7FDD):
			sum += 0xFF
		elif i in (0x7FDE, 0x7FDF):
			sum += 0x00
		else:
			sum += ROM[i]

	complement = (sum ^ 0xFFFF) & 0xFFFF
	sum &= 0xFFFF

	if (sum != oldsum):

		ROM[0x7FDC:0x7FDE] = complement.to_bytes(2, "little")
		ROM[0x7FDE:0x7FE0] = sum.to_bytes(2, "little")

		with open(sys.argv[1], "wb") as o:
			o.write(ROM)

		print("New checksums for ROM {0}:".format(sys.argv[1]))
		print("Checksum:   0x{0:04X}".format(sum))
		print("Complement: 0x{0:04X}".format(complement))

if __name__ == "__main__":
	main()

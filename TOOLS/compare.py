#!/usr/bin/python3

import os
import sys

def format_bin(data):
  return "".join(["{0:02X}{1}".format(data[i], "\n" if ((i+1) % 16) == 0 else " ") for i in range(len(data))])

def main():
  with open(sys.argv[1], "rb") as i:
    f1 = i.read()

  with open(sys.argv[2], "rb") as i:
    f2 = i.read()

  if len(f1) != len(f2):
    print("File lengths do not match:")
    print(sys.argv[1]+": {0:06X}".format(len(f1)))
    print(sys.argv[2]+": {0:06X}".format(len(f2)))

  offset = 0
  maxsize = min(len(f1), len(f2))

  while offset+1 < maxsize:
    if f1[offset] != f2[offset]:
      diffsize = 1
      while (f1[offset+diffsize] != f2[offset+diffsize]):
        if offset+diffsize+1 > maxsize:
          break
        diffsize += 1
      print("Difference at {0:06X}".format(offset))
      print("{0}:".format(os.path.basename(sys.argv[1])))
      print(format_bin(f1[offset:offset+diffsize]))
      print("---")
      print("{0}:".format(os.path.basename(sys.argv[2])))
      print(format_bin(f2[offset:offset+diffsize]))
      offset += diffsize
    else:
      offset += 1

if __name__ == "__main__":
  main()

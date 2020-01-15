#!/usr/bin/python3

import os
import sys

# This is a simple script to fix 64tass'
# VICE symbol output to be usable with
# bsnes-plus

def main():

  with open(sys.argv[1], "r", encoding="utf-8") as i:
    lines = i.readlines()

  # We've got three goals:
  # Ensure addresses are 6 characters long
  # remove . at start of label names
  # change scope character from : to .

  fixed = []

  for line in lines:

    _, address, label = line.split()

    label = label.lstrip(".")
    label = label.replace(":", ".")

    fixed.append("al {0:06x} {1}\n".format(int(address, 16), label))

  with open(sys.argv[1], "w", encoding="utf-8") as o:
    o.writelines(fixed)

if __name__ == "__main__":
  main()

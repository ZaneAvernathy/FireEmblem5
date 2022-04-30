#!/usr/bin/python3

"""
Script to print 64tass sections in a pretty format.

Groups contiguous regions together.
"""

import sys
import re
from typing import NamedTuple


class Section(NamedTuple):
  """A single memory section."""

  start: int
  end: int
  size: int
  name: str


class Region(NamedTuple):
  """A contiguous memory region."""

  start: int
  end: int
  sections: list[Section]


section_pattern = r"Section:\s*" \
                  r"\$(?P<start>[0-9a-fA-F]+)" \
                  r"(?:-\$(?P<end>[0-9a-fA-F]+))?\s*" \
                  r"\$(?P<size>[0-9a-fA-F]+)\s*" \
                  r"(?P<name>.*)"


def main() -> None:
  """Organize and print log sections."""
  log = sys.argv[1]

  with open(log, "r") as i:
    lines = [line.strip() for line in i.readlines()]

  sections = []

  for line in lines:

    if (match := re.match(section_pattern, line)):
      p_start, p_size = [int(g, 16) for g in match.group("start", "size")]
      p_end = int(p_end, 16) if (p_end := match.group("end")) else p_start
      p_name = match.group("name")

      sections.append(Section(p_start, p_end, p_size, p_name))

  if not sections:
    sys.exit()

  sections = sorted(sections)
  first = sections[0]

  regions: list[Region] = [Region(first.start, first.end, [first])]

  def is_contiguous(prev: Section, this: Section) -> bool:
    if prev[0] != prev[1]:
      return prev[1] + 1 == this[0]
    else:
      return prev[0] == this[0]

  for j, section in enumerate(sections[1:], 1):
    if is_contiguous(sections[j - 1], section):
      prev = regions[-1]
      if section.end != section.start:
        regions[-1] = Region(prev.start, section.end, prev.sections)
      prev.sections.append(section)

    else:
      real_end = (
        section.end if (section.end != section.start) else section.start
      )
      regions.append(Region(section.start, real_end, [section]))

  def block_str(start: int, end: int) -> str:
    end_str = f"-${end:06X}" if (end != start) else " " * 8
    return f"${start:06X}{end_str}"

  for region in regions:

    start, end, sections = region
    size = sum([s.size for s in sections])

    print(f"Region: {block_str(start, end)} ${size:06X}")

    for section in sections:
      start, end, size, name = section
      print(f"  {block_str(start, end)} ${size:04X} {name}")

    print()


if __name__ == '__main__':
  main()

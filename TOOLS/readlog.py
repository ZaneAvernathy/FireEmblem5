#!/usr/bin/python3

"""Script to print 64tass memory map files."""

import sys
import re
from typing import NamedTuple, Optional


class Section(NamedTuple):
  """A single memory section, possily with a name."""

  start: int
  size: int
  end: Optional[int]
  name: Optional[str]


class Region(NamedTuple):
  """A contiguous memory region."""

  start: int
  end: int
  sections: list[Section]


section_pattern = r"(?:[^\:]+\:)?\s*(?P<size>[0-9]+)\s*" \
                  r"\$(?P<start>[0-9a-fA-F]+)" \
                  r"(?:-\$(?P<end>[0-9a-fA-F]+))?\s*" \
                  r"\$(?P<size_hex>[0-9a-fA-F]+)\s*" \
                  r"(?:(?P<name>.*))?"


def section_sorter(item: Section) -> int:
  """Key func to ensure zero-byte sections appear first."""
  return (item.start * 10) + (1 if item.end else 0)


def is_contiguous(prev: Section, this: Section) -> bool:
  """Check if two sections are contiguous."""
  return (prev.start + prev.size) == this.start


def block_formatter(start: int, end: Optional[int]) -> str:
  """Make a string for a region's span."""
  end_str = f"-${end:06X}" if end else " " * 8
  return f"${start:06X}{end_str}"


def main() -> int:
  """Organize and print map sections."""
  log = sys.argv[1]

  with open(log, "r") as i:
    lines = [line.strip() for line in i.readlines()]

  sections = []

  for line in lines:

    if (match := re.match(section_pattern, line)):
      p_start, p_size = [int(g, 16) for g in match.group("start", "size_hex")]
      p_end = int(p_end, 16) if (p_end := match.group("end")) else None
      p_name = p_name if (p_name := match.group("name")) else None

      # For now, we'll discard unnamed sections ecause 64tass is being weird.

      if p_name:
        sections.append(Section(p_start, p_size, p_end, p_name))

  if not sections:
    sys.exit(0)

  sections = sorted(sections, key=section_sorter)
  first = sections[0]
  f_end = first.end if first.end else first.start

  regions: list[Region] = [Region(first.start, f_end, [first])]

  for j, section in enumerate(sections[1:], 1):
    if is_contiguous(sections[j - 1], section):
      prev = regions[-1]
      if section.end and (section.start != section.end):
        regions[-1] = Region(prev.start, section.end, prev.sections)
      prev.sections.append(section)

    else:
      real_end = section.end if section.end else section.start
      regions.append(Region(section.start, real_end, [section]))

  for r in regions:
    region_size = sum([s.size for s in r.sections])
    print(f"Region: {block_formatter(r.start, r.end)} ${region_size:06X}")

    for s in r.sections:
      print(f"  {block_formatter(s.start, s.end)} ${s.size:04X} {s.name}")

    print()

  return 0


if __name__ == "__main__":
  sys.exit(main())

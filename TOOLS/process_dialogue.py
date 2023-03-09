#!/usr/bin/python3

import sys
import re


def create_font_pages(filename: str) -> dict:
  """Creates a dict {text:font page} from a font file."""
  pages = {}
  with open(filename, "r", encoding="UTF-8") as raw:
    for (line, line_text) in enumerate(raw):
      line_glyphs = line_text.strip("\n").split("\t")

      for (glyph, glyph_text) in enumerate(line_glyphs):
        page = (line * 8) // (256 - 16)
        pages[glyph_text] = page

  return pages


# Some regexes for matching special text
p_newline = re.compile(r"\\n")
p_bracketed = re.compile(r"\[.*?\]")
p_control = re.compile(r"\{(?P<text>.*?)\}")


def get_font_character(text: str, pos: int, pages: list) -> (str, int):
  """Reads a character or bracketed sequence and gets its font page."""

  # Either a single character or
  # a variable number of characters in
  # square brackets.

  if (m := p_bracketed.match(text, pos)):
    character = m.group()
  else:
    character = text[pos]

  # Fetch the font page that the character
  # is on. If the character isn't in the
  # font, exit with an error.

  try:
    page = pages[character]

  except KeyError:
    sys.exit(f"Unable to process text '{text}' on line {line}, column {column}.")

  return (character, page)


def main():

  if len(sys.argv) != 4:
    print("Usage: python process_dialogue.py dialoguetext.txt fonttext.txt output.txt")
    sys.exit(-1)

  _, textname, fontname, outname = sys.argv

  pages = create_font_pages(fontname)

  with open(textname, "r", encoding="UTF-8") as raw:

    page = 0
    processed = []
    for (line, line_text) in enumerate(raw):

      line_text = line_text.strip("\n")

      line_pos = 0
      processed_line = []

      in_string = False

      while line_pos < len(line_text):

        text = ""

        # Treat newlines as special to
        # emit the current line.
        if (m := p_newline.match(line_text, line_pos)):
          text += "\\n\"\n"
          line_pos += len(m.group())
          in_string = False

        # Control codes are wrapped in curly brackets
        # and are processed to appear on their own lines,
        # with the contents inside the brackets appearing
        # verbatim.
        elif (m := p_control.match(line_text, line_pos)):

          # First, see if we need to emit the end
          # of a quoted string.
          if in_string:
            text += "\"\n"

          text += m.group("text") + "\n"
          line_pos += len(m.group())
          in_string = False

        # Otherwise, it's a standard character or
        # bracketed sequence.
        else:

          character, newpage = get_font_character(line_text, line_pos, pages)

          # Emit possible page changes.
          if newpage != page:

            # Wrap up current quoted string.
            if in_string:
              text += "\"\n"

            text += f"DIALOGUE_FONT_{newpage:d}\n"

            page = newpage
            in_string = False

          # Begin a quoted string before any characters.
          if not in_string:
            text += ".text \""
            in_string = True

          text += character
          line_pos += len(character)

        processed_line.append(text)

      processed.append("".join(processed_line))

  with open(outname, "w", encoding="UTF-8") as o:
    o.writelines(processed)


if __name__ == "__main__":
  main()

import os
import json

if os.path.exists('table_btt.json'):  # possible bug avec VSCode qui ne detecte pas table.json avec son path normal
    path = 'table_btt.json'
else:
    path = './extract_text/table_btt.json'

with open(path, "r") as table_file:
    table = json.load(table_file)


def get_char(char_code) -> str:
    if char_code in table:
        return table[char_code]
    else:
        return "error"


def convert(braille_char) -> str:
    num = bool(braille_char[7])
    maj = bool(braille_char[6])
    char_code = ""
    for i in range(0, len(braille_char) - 2):
        char_code += str(braille_char[i])
    if maj:
        if char_code == "001100" or char_code == "001011":
            char_code = "M" + char_code
    if num:
        char_code = "N" + char_code
    char = get_char(char_code)




import json
import re

with open("table.json", "r") as table_file:
    table = json.load(table_file)


def capital(match_obj):
    if match_obj.group(0) is not None:
        return str("C" + match_obj.group(0).lower())


def number(match_obj):
    if match_obj.group(0) is not None:
        return str("N" + match_obj.group(0))


def format_text(text: str) -> list:
    words = []
    for word in text.split(" "):
        word = re.sub(r"[A-Z]", capital, word)
        word = re.sub(r"[0-9]", number, word)
        words.append(word)
    return words


def convert_word(word:str) -> list:
    binary = []
    for letter in word:
        binary.append(table[letter])
    print(binary)

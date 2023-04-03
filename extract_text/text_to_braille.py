import json
import re
import os

if os.path.exists('table.json'):  # possible bug avec VSCode qui ne detecte pas table.json avec son path normal
    path = 'table.json'
else:
    path = './extract_text/table.json'

with open(path, "r") as table_file:
    table = json.load(table_file)


def capital(match_obj):  # fonction qui sert a mettre la lettre majuscule en minuscule et a mettre C devant
    if match_obj.group(0) is not None:
        return str("C" + match_obj.group(0).lower())


def number(match_obj):
    if match_obj.group(0) is not None:
        return str("N" + match_obj.group(0))


def format_text(text: str) -> list:
    sentences = []
    words = []
    length = 0
    for word in text.split(" "):
        word = re.sub(r"[A-Z]", capital, word)
        word = re.sub(r"[0-9]", number, word)
        length += len(word) + 1 - ('\n' in word if 2 else 0)
        if length >= 20:
            length = 0
            sentences.append(words.copy())
            words.clear()
            if r"\n" in word: #si il y'a \n dans le mot alors on enlève \n
                length = 0
                raw_word = re.sub(r"\\n", "", word)
                words.append(raw_word)
                sentences.append(words.copy())
                words.clear()
            else:
                words.append(word)
        elif r"\n" in word: #si il y'a \n dans le mot alors on enlève \n
            length = 0
            raw_word = re.sub(r"\\n", "", word)
            words.append(raw_word)
            sentences.append(words.copy())
            words.clear()
        else: #si il n'y a pas de \n dans le mot on l'ajoute a words sans modification
            words.append(word)
    return sentences  # Retourne une Array avec Chaque mot dans des différentes 'Case' et dans un format compatible avec le table.json


def convert_word(word: str) -> list:  # on convertit le mot en une liste avec dans chaque 'Case' une de ses lettres
    binary = []
    for letter in word:
        if letter in table:
            binary.append(table[
                              letter])  # Pour chaque lettre on la convertit en matrice braille et on l'ajoute dans une nouvelle 'case' de binary
    return binary


def convert_sentence(sentence: list) -> list:
    new_sentence = []
    for word in sentence:
        new_sentence.append(convert_word(word))
    return new_sentence

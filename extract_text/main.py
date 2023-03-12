import utils
from text_manipulation import text

if __name__ == "__main__":
    formated = utils.format_text(str(text))
    for word in formated:
        utils.convert_word(word)

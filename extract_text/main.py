import utils

if __name__ == "__main__":
    formated = utils.format_text("Text6 32")
    for word in formated:
        utils.convert_word(word)

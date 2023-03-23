import time
import keyboard
import braille_to_text
#                  1, 2, 3, 4, 5, 6,cap,num
current_braille = [0, 0, 0, 0, 0, 0, 0, 0]


def invert(index: int):
    current_braille[index] = 1 - current_braille[index]


def clear():
    for i in range(0, len(current_braille)):
        current_braille[i] = 0


def update():
    time.sleep(0.1)
    key = keyboard.read_key()
    if key == "7":
        invert(0)
    elif key == "8":
        invert(1)
    elif key == "4":
        invert(2)
    elif key == "5":
        invert(3)
    elif key == "1":
        invert(4)
    elif key == "2":
        invert(5)
    elif key == "right shift":
        current_braille[7] = 1 - current_braille[7]
        current_braille[6] = 0
    elif key == "maj":
        current_braille[6] = 1 - current_braille[6]
        current_braille[7] = 0
    elif key == "space":
        print("\n" + str(current_braille))
        braille_to_text.convert(current_braille)
        clear()
    else:
        print(key)

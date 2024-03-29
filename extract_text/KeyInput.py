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
    match keyboard.read_key():
        case "7":
            invert(0)
        case "8":
            invert(1)
        case "4":
            invert(2)
        case "5":
            invert(3)
        case "1":
            invert(4)
        case "2":
            invert(5)
        case "right shift":
            current_braille[7] = 1 - current_braille[7]
            current_braille[6] = 0
        case "maj":
            current_braille[6] = 1 - current_braille[6]
            current_braille[7] = 0
        case "space":
            print("\n" + str(current_braille))
        case default:
            print(default)

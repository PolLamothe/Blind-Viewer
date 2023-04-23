import pytesseract
#import picamera2
import os
import time

pytesseract.pytesseract.tesseract_cmd = r'C:\\Program Files\\Tesseract-OCR\\tesseract.exe'

#camera = PiCamera()

#camera.resolution = (1920,1080)
#camera.capture('test.webp')
#camera.stop_preview()

path = r'../extract_text/test.webp' #path anormale car quand node js lance le fichier, python prend comme chemin actuel le chemin de server.js

text = pytesseract.image_to_string(path)
print(text)
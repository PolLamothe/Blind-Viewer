import pytesseract
import picamera2
import os
import time

pytesseract.pytesseract.tesseract_cmd = r'C:\\Program Files\\Tesseract-OCR\\tesseract.exe'

#camera = PiCamera()

camera.resolution = (1920,1080)
camera.capture('test.webp')
camera.stop_preview()

if(os.path.exists('test.webp')):
    path = r'test.webp'
else:
    path = r'extract_text/test.webp'

text = pytesseract.image_to_string(path)
input(text)
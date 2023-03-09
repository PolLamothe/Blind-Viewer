import pytesseract
import os

pytesseract.pytesseract.tesseract_cmd = r'C:\\Tesseract-OCR\\tesseract.exe'

if(os.path.exists('test.webp')):
    path = r'test.webp'
else:
    path = r'extract_text/test.webp'

text = pytesseract.image_to_string(path)
input(text)
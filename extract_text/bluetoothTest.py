import socket
PolPhoneMacAddress = '50:da:d6:db:17:7e'
port = 3
s = socket.socket(socket.AF_BLUETOOTH, socket.SOCK_STREAM, socket.BTPROTO_RFCOMM)
s.connect((PolPhoneMacAddress,port))
while True:
    text=input()
    if text == 'quit':
        break
    s.send(bytes(text,'UTF-8'))
s.close()
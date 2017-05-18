# Stimulator YAML Interface
import os
import yaml
import socket
import sys

#host, port = "localhost", 1234

# Create a socket (SOCK_STREAM means a TCP socket)
#sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

#import socket

input = raw_input('EOF
---
method: set
object: "V_TRAIN_ANALOG"
properties:
   objValue: 100
userData: Set analog speed to 100
...

---
method: set
object: "P71_DMI_V_NUM"
properties:
   objValue: 100
userData: Set digital speed to 100
...
EOF')


clientsocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
clientsocket.connect(('localhost', 1234))
clientsocket.send(input)

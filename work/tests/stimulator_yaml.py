# Stimulator YAML Interface
import os
import yaml
import socket
import sys

host, port = "localhost", 1234

# Create a socket (SOCK_STREAM means a TCP socket)
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

yamlObj = {'method':'set', 
     'object': 'V_TRAIN_ANALOG', 
     'properties': 
         {'objValue':'42'}}
         
yamlObj2 = {'method':'get', 
     'object': 'V_TRAIN_ANALOG'}
         
         
try:
    # Connect to server and send data
    sock.connect((host, port))
    #sock.sendall(yaml.dump(yamlObj, default_flow_style=False, explicit_start = True, explicit_end = True))
    sock.sendall(yaml.dump(yamlObj2, default_flow_style=False, explicit_start = True, explicit_end = True))

    # Receive data from the server and shut down
    sock.settimeout(1.0)          # 1 second timeout
    received = sock.recv(1024)    # receive up to 1024 byte
finally:
    sock.close()

print "Received:\n{}".format(received)

received_yaml = yaml.safe_load(received)

#print("yaml:", received_yaml)

print "Object Value:", received_yaml['properties']['objValue']


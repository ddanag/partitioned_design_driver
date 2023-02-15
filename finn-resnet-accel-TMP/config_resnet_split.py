from finn_examples import models
from vnx_utils import *
import numpy as np
import sys

# instantiate the accelerator
if sys.argv[2]=="True":
    load_weights=True
else:
    load_weights=False
accel = models.resnet50_w4a5_imagenet_split(None, sys.argv[1], load_weights)

# check link
print("Link interface 0 {}".format(accel.cmac_0.linkStatus()))

# Set up network layer
ip0_dev0 = '192.168.1.10'
ip0_dev1 = '192.168.1.20'
ip0_dev2 = '192.168.1.30'

port0_dev0 = '60100'
port1_dev0 = '60101'
port0_dev1 = '61100'
port1_dev1 = '61101'
port0_dev2 = '62100'
port1_dev2 = '62101'


if sys.argv[1] == "dev0.xclbin":
    if_status_ip0_dev0 = accel.networklayer_0.updateIPAddress(ip0_dev0, debug=True)
    accel.networklayer_0.sockets[0] = (ip0_dev1, port1_dev1, port0_dev0, True)
    accel.networklayer_0.sockets[1] = (ip0_dev2, port0_dev2, port1_dev0, True)
    accel.networklayer_0.populateSocketTable(debug=True)
    accel.networklayer_0.arpDiscovery()

    print("Dev0 ARP Table:")
    print(accel.networklayer_0.readARPTable())    

elif sys.argv[1] == "dev1.xclbin":
    if_status_ip0_dev1 = accel.networklayer_0.updateIPAddress(ip0_dev1, debug=True)
    accel.networklayer_0.sockets[0] = (ip0_dev2, port1_dev2, port0_dev1, True)
    accel.networklayer_0.sockets[1] = (ip0_dev0, port0_dev0, port1_dev1, True)
    accel.networklayer_0.populateSocketTable(debug=True)
    accel.networklayer_0.arpDiscovery()

    print("Dev1 ARP Table:")
    print(accel.networklayer_0.readARPTable())

elif sys.argv[1] == "dev2.xclbin": 
    if_status_ip0_dev2 = accel.networklayer_0.updateIPAddress(ip0_dev2, debug=True)
    accel.networklayer_0.sockets[0] = (ip0_dev0, port1_dev0, port0_dev2, True)
    accel.networklayer_0.sockets[1] = (ip0_dev1, port0_dev1, port1_dev2, True)
    accel.networklayer_0.populateSocketTable(debug=True)
    accel.networklayer_0.arpDiscovery()
    
    print("Dev2 ARP Table:")
    print(accel.networklayer_0.readARPTable())

#elif sys.argv[1] == "dev3.xclbin":
#    if_status_ip0_dev3 = accel.networklayer_0.updateIPAddress(ip0_dev3, debug=True)
#    accel.networklayer_0.sockets[0] = (ip0_dev0, port1_dev0, port0_dev3, True)
#    accel.networklayer_0.sockets[1] = (ip0_dev2, port0_dev2, port1_dev3, True)
#    accel.networklayer_0.populateSocketTable(debug=True)
#    accel.networklayer_0.arpDiscovery()

#    print("Dev3 ARP Table:")
#    print(accel.networklayer_0.readARPTable())


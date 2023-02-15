from finn_examples import models
from termcolor import colored
from vnx_utils import *
import numpy as np
import sys

if sys.argv[2]=="True":
    load_weights=True
else:
    load_weights=False

# instantiate the accelerator
accel = models.resnet50_w4a5_imagenet_split(None, sys.argv[1], load_weights)
data_in = np.load('./resnetw1a2/test_image.npy')
#data_in = data_in/128 - 1
#data_in = data_in.astype("uint8")
#print("load weights is ", load_weights)
#print("running accelerator")
#perform inference and get output
data_out = accel.execute(data_in)
print("Execute test result (split accel):")
print(colored(data_out, 'cyan'))
#if sys.argv[3] == "throughput":
#    res = accel.throughput_test_in()
#    print(res)
#    file = open("nw_metrics_split_rn0_dev0.txt", "w")
#    file.write(str(res))
#    file.close()
#print("Results written to nw_metrics_split.txt")
#accel = models.resnet50_w1a2_imagenet_split(None, sys.argv[1], load_weights, batch_size=1000)
#print("about to set batch size to 1000")
#accel.batch_size=1
#val = accel.validate()
#print("Validate test results:")
#print("Final top-1 accuracy - split accel: {}%".format(val))


    

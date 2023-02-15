from vnx_utils import *
import numpy as np
import sys
import pynq

# instantiate the accelerator
accel = pynq.Overlay("../FPGA0-TMP/dev0.xclbin")
print(accel.networklayer_0.getDebugProbes)
#print(accel.networklayer_1.getDebugProbes)
#print("cmac debug registers:")
#print(accel.cmac_0.getStats())
#print(accel.cmac_1.getStats())


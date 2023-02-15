if [ "$#" -lt 2 ]; then
	echo "Syntax: ./run_resnet_accel <host0> <host1> <host2> <host4>  <copy_files (optional)> <install deps (optional)>"
	exit 1
fi

COPY_FILES=$4
INSTALL_DEPS=$5
CONFIG_NETWORK=1 #$7
HOST0=$1
HOST1=$2
HOST2=$3
#HOST3=$4
USERNAME=danad
if [ $COPY_FILES == 1 ]; then
	#ssh -i ~/.ssh/cloudlab_openssh -t $USERNAME@$HOST0.cloudlab.umass.edu 'sudo su -c "mkdir /mydata/imagenet/; chmod 777 /mydata/imagenet/"'
	#scp -i ~/.ssh/cloudlab_openssh -r ./imagenet/val $USERNAME@$HOST0.cloudlab.umass.edu:/mydata/imagenet/
	#ssh -i ~/.ssh/cloudlab_openssh -t $USERNAME@$HOST1.cloudlab.umass.edu 'sudo su -c "mkdir /mydata/imagenet/; chmod 777 /mydata/imagenet/"'
        #scp -i ~/.ssh/cloudlab_openssh -r ./imagenet/val $USERNAME@$HOST1.cloudlab.umass.edu:/mydata/imagenet/
	scp -i ~/.ssh/cloudlab_openssh -r ./finn-resnet-accel-TMP ./FPGA0-TMP $USERNAME@$HOST0.cloudlab.umass.edu:~ #HOST0
	scp -i ~/.ssh/cloudlab_openssh -r ./finn-resnet-accel-TMP ./FPGA1-TMP $USERNAME@$HOST1.cloudlab.umass.edu:~ #HOST1
	scp -i ~/.ssh/cloudlab_openssh -r ./finn-resnet-accel-TMP ./FPGA2-TMP $USERNAME@$HOST2.cloudlab.umass.edu:~ #HOST2
	#scp -i ~/.ssh/cloudlab_openssh -r ./finn-resnet-accel-TMP ./FPGA3-TMP $USERNAME@$HOST3.cloudlab.umass.edu:~ #HOST3
fi
if [ $INSTALL_DEPS == 1 ]; then
	ssh -i ~/.ssh/cloudlab_openssh -t $USERNAME@$HOST0.cloudlab.umass.edu 'sudo su -c "cd /users/danad/finn-resnet-accel-TMP/; ./deps-install.sh; pip3 install termcolor"'
	#ssh -i ~/.ssh/cloudlab_openssh -t $USERNAME@$HOST0.cloudlab.umass.edu 'sudo su -c "apt-get install -y libjpeg-dev zlib1g-dev; pip3 install pillow; pip3 install torchvision"'
	ssh -i ~/.ssh/cloudlab_openssh -t $USERNAME@$HOST1.cloudlab.umass.edu 'sudo su -c "cd /users/danad/finn-resnet-accel-TMP/; ./deps-install.sh; pip3 install termcolor"'
	#ssh -i ~/.ssh/cloudlab_openssh -t $USERNAME@$HOST1.cloudlab.umass.edu 'sudo su -c "apt-get install -y libjpeg-dev zlib1g-dev; pip3 install pillow; pip3 install torchvision"'
	ssh -i ~/.ssh/cloudlab_openssh -t $USERNAME@$HOST2.cloudlab.umass.edu 'sudo su -c "cd /users/danad/finn-resnet-accel-TMP/; ./deps-install.sh; pip3 install termcolor"'
        #ssh -i ~/.ssh/cloudlab_openssh -t $USERNAME@$HOST2.cloudlab.umass.edu 'sudo su -c "apt-get install -y libjpeg-dev zlib1g-dev; pip3 install pillow; pip3 install torchvision"'
	#ssh -i ~/.ssh/cloudlab_openssh -t $USERNAME@$HOST3.cloudlab.umass.edu 'sudo su -c "cd /users/danad/finn-resnet-accel-TMP/; ./deps-install.sh; pip3 install termcolor"'
	#ssh -i ~/.ssh/cloudlab_openssh -t $USERNAME@$HOST3.cloudlab.umass.edu 'sudo su -c "apt-get install -y libjpeg-dev zlib1g-dev; pip3 install pillow; pip3 install torchvision"'


fi
if [ $CONFIG_NETWORK == 1 ]; then
#	ssh -i ~/.ssh/cloudlab_openssh -t $USERNAME@$HOST0.cloudlab.umass.edu "source /opt/xilinx/xrt/setup.sh; cd /users/danad/finn-resnet-accel-TMP/; python3.6 config_resnet_split.py dev0.xclbin False"
	ssh -i ~/.ssh/cloudlab_openssh -t $USERNAME@$HOST1.cloudlab.umass.edu "source /opt/xilinx/xrt/setup.sh; cd /users/danad/finn-resnet-accel-TMP/; python3.6 config_resnet_split.py dev1.xclbin False"
	ssh -i ~/.ssh/cloudlab_openssh -t $USERNAME@$HOST0.cloudlab.umass.edu "source /opt/xilinx/xrt/setup.sh; cd /users/danad/finn-resnet-accel-TMP/; python3.6 config_resnet_split.py dev0.xclbin False"
	ssh -i ~/.ssh/cloudlab_openssh -t $USERNAME@$HOST2.cloudlab.umass.edu "source /opt/xilinx/xrt/setup.sh; cd /users/danad/finn-resnet-accel-TMP/; python3.6 config_resnet_split.py dev2.xclbin False"
	ssh -i ~/.ssh/cloudlab_openssh -t $USERNAME@$HOST1.cloudlab.umass.edu "source /opt/xilinx/xrt/setup.sh; cd /users/danad/finn-resnet-accel-TMP/; python3.6 config_resnet_split.py dev1.xclbin False"
	#ssh -i ~/.ssh/cloudlab_openssh -t $USERNAME@$HOST3.cloudlab.umass.edu "source /opt/xilinx/xrt/setup.sh; cd /users/danad/finn-resnet-accel-TMP/; python3.6 config_resnet_split.py dev3.xclbin False"
	ssh -i ~/.ssh/cloudlab_openssh -t $USERNAME@$HOST2.cloudlab.umass.edu "source /opt/xilinx/xrt/setup.sh; cd /users/danad/finn-resnet-accel-TMP/; python3.6 config_resnet_split.py dev2.xclbin False"
	ssh -i ~/.ssh/cloudlab_openssh -t $USERNAME@$HOST0.cloudlab.umass.edu "source /opt/xilinx/xrt/setup.sh; cd /users/danad/finn-resnet-accel-TMP/; python3.6 config_resnet_split.py dev0.xclbin False"
	ssh -i ~/.ssh/cloudlab_openssh -t $USERNAME@$HOST1.cloudlab.umass.edu "source /opt/xilinx/xrt/setup.sh; cd /users/danad/finn-resnet-accel-TMP/; python3.6 config_resnet_split.py dev1.xclbin False"
	ssh -i ~/.ssh/cloudlab_openssh -t $USERNAME@$HOST2.cloudlab.umass.edu "source /opt/xilinx/xrt/setup.sh; cd /users/danad/finn-resnet-accel-TMP/; python3.6 config_resnet_split.py dev2.xclbin False"
	#ssh -i ~/.ssh/cloudlab_openssh -t $USERNAME@$HOST3.cloudlab.umass.edu "source /opt/xilinx/xrt/setup.sh; cd /users/danad/finn-resnet-accel-TMP/; python3.6 config_resnet_split.py dev3.xclbin False"
	ssh -i ~/.ssh/cloudlab_openssh -t $USERNAME@$HOST1.cloudlab.umass.edu "source /opt/xilinx/xrt/setup.sh; cd /users/danad/finn-resnet-accel-TMP/; python3.6 config_resnet_split.py dev1.xclbin False"
        ssh -i ~/.ssh/cloudlab_openssh -t $USERNAME@$HOST0.cloudlab.umass.edu "source /opt/xilinx/xrt/setup.sh; cd /users/danad/finn-resnet-accel-TMP/; python3.6 config_resnet_split.py dev0.xclbin False"
        ssh -i ~/.ssh/cloudlab_openssh -t $USERNAME@$HOST2.cloudlab.umass.edu "source /opt/xilinx/xrt/setup.sh; cd /users/danad/finn-resnet-accel-TMP/; python3.6 config_resnet_split.py dev2.xclbin False"
        ssh -i ~/.ssh/cloudlab_openssh -t $USERNAME@$HOST1.cloudlab.umass.edu "source /opt/xilinx/xrt/setup.sh; cd /users/danad/finn-resnet-accel-TMP/; python3.6 config_resnet_split.py dev1.xclbin False"
        #ssh -i ~/.ssh/cloudlab_openssh -t $USERNAME@$HOST3.cloudlab.umass.edu "source /opt/xilinx/xrt/setup.sh; cd /users/danad/finn-resnet-accel-TMP/; python3.6 config_resnet_split.py dev3.xclbin False"
        ssh -i ~/.ssh/cloudlab_openssh -t $USERNAME@$HOST2.cloudlab.umass.edu "source /opt/xilinx/xrt/setup.sh; cd /users/danad/finn-resnet-accel-TMP/; python3.6 config_resnet_split.py dev2.xclbin False"
        ssh -i ~/.ssh/cloudlab_openssh -t $USERNAME@$HOST0.cloudlab.umass.edu "source /opt/xilinx/xrt/setup.sh; cd /users/danad/finn-resnet-accel-TMP/; python3.6 config_resnet_split.py dev0.xclbin False"
        ssh -i ~/.ssh/cloudlab_openssh -t $USERNAME@$HOST1.cloudlab.umass.edu "source /opt/xilinx/xrt/setup.sh; cd /users/danad/finn-resnet-accel-TMP/; python3.6 config_resnet_split.py dev1.xclbin False"
        ssh -i ~/.ssh/cloudlab_openssh -t $USERNAME@$HOST2.cloudlab.umass.edu "source /opt/xilinx/xrt/setup.sh; cd /users/danad/finn-resnet-accel-TMP/; python3.6 config_resnet_split.py dev2.xclbin False"
        #ssh -i ~/.ssh/cloudlab_openssh -t $USERNAME@$HOST3.cloudlab.umass.edu "source /opt/xilinx/xrt/setup.sh; cd /users/danad/finn-resnet-accel-TMP/; python3.6 config_resnet_split.py dev3.xclbin False"

fi
## Load weights
#run split accelerator 0 from HOST2
#ssh -i ~/.ssh/cloudlab_openssh -t -t $USERNAME@$HOST2.cloudlab.umass.edu "source /opt/xilinx/xrt/setup.sh; cd /users/danad/finn-resnet-accel-TMP/; python3.6 run_split_accel0_dev2.py dev2.xclbin True" 

#run split accelerator 0 from HOST0
ssh -i ~/.ssh/cloudlab_openssh -t -t $USERNAME@$HOST0.cloudlab.umass.edu "source /opt/xilinx/xrt/setup.sh; cd /users/danad/finn-resnet-accel-TMP/; python3.6 run_split_accel0_dev0.py dev0.xclbin True" 


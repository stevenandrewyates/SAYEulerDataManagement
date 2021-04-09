##################################################
######            Details                   ######
##################################################

# author:   Steven Yates
# contact:  steven.yates@usys.ethz.ch
# Year:     2021
# Citation: TBA

##################################################
######            Description               ######
##################################################

# An sh script for downloading the SRAtoolkit on Euler
# please see below for more details

# https://github.com/ncbi/sra-tools

# this will download and unpack the SRAtoolkit in
# your $HOME directory


##################################################
######              Usage                   ######
##################################################

# sh 01 DownloadSRAtoolkit.sh

##################################################
######              Script                  ######
##################################################

echo "Changing directory to: $HOME";
cd $HOME

echo "Downloading sratoolkit";
wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.11.0/sratoolkit.2.11.0-centos_linux64.tar.gz

echo "unzipping sratoolkit";
gunzip sratoolkit.2.11.0-centos_linux64.tar.gz 
tar -vxf sratoolkit.2.11.0-centos_linux64.tar

echo "checking sratoolkit";
sratoolkit.2.11.0-centos_linux64/bin/fastq-dump -X 5 -Z SRR390728
echo "You should see some fastq data above ^^^ :)";


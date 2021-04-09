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

# A sh script for downloading Six Cassava samples
# each with a number reads.

# This will happen in your $SCRATCH folder. 
# In a folder you specify, in a subfolder FASTQ  

# you should already have installed the SRAtoolkit
# in your $HOME directory as done by:
# sh 01 DownloadSRAtoolkit.sh

##################################################
######              Usage                   ######
##################################################

# in this example it will download ten reads for 
# the six samples
# sh 02_DownloadCassavaSix.sh -f Cassava -n 10

# -f is the PATH
# -n is the number of reads per sample

##################################################
######              Script                  ######
##################################################

while getopts n:f: flag
do
    case "${flag}" in
        f) Example=${OPTARG};;
        n) Number=${OPTARG};;
    esac
done
echo "Path: $Example";

echo "Changing directory to: $SCRATCH";
cd $SCRATCH
echo "Making directory: $Example";
mkdir $Example
echo "Changing directory to: $Example";
cd $Example
echo "Making directory: FASTQ";
mkdir FASTQ
echo "Writing data:";
echo "getting $Number reads per sample";
for x in $(seq 1717931 1717936); do echo "$HOME/sratoolkit.2.11.0-centos_linux64/bin/fastq-dump -X $Number -Z SRR$x | paste - - - - - - - - | tee >(cut -f 1-4 | tr \"\\t\" \"\\n\" > FASTQ/SRR$x.1.fastq) | cut -f 5-8 | tr \"\\t\" \"\\n\" > FASTQ/SRR$x.2.fastq";done | bash
echo "Done :)";

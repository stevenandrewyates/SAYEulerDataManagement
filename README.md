# SAYEulerDataManagement
This guide will explain how to get your data onto the Euler computing system at ETH Zurich (http://scicomp.ethz.ch/wiki/Euler)

# Description

Sequencing Santa has delivered your data early, just in time for a conference, report or thesis. This guide will explain how to get your data onto the Euler computing system at ETH Zurich (http://scicomp.ethz.ch/wiki/Euler).
 
# Graphical user interface

An easy way to get data into Euler is using Filezilla. This is a graphical tool and can be used with Windows. Please see the guide on how to set this up

https://scicomp.ethz.ch/wiki/Getting_started_with_clusters.

This works great. But it can have problems especially with large files and when using a remote connection (VPN). 

# Secure copy

If you have access to Linux workstation the best way to transfer data is using secure copy `scp`. The example below will do this:

```
scp input.fastq.gz  username@euler.ethz.ch://cluster/scratch/username/Data
```

For this you need to make the destination folder first. So login to Euler then change directory `cd` to your scratch `$SCRATCH` folder

```
cd $SCRATCH
```

After make the directory `mkdir`, in this example `Data`

```
mkdir Data
```
 
you now have everything you need to transfer the data from a linux workstation to Euler

```
scp input.fastq.gz  username@euler.ethz.ch://cluster/scratch/username/Data
```

In the example above you have an input file `input.fastq.gz`, a path to the directory you will transfer to `://cluster/scratch/username/Data`. You will need a `username` (for example: Batman), this needs to be changed twice in the command 

```
scp input.fastq.gz  Batman@euler.ethz.ch://cluster/scratch/Batman/Data
```
After hitting enter you will then be asked for a password (for example: IronmanSucks)

# Direct from FGCZ

All the above works well, but why not get the data direct from the Functional Genomics Center Zurich (FGCZ, https://fgcz.ch/). Below is a fake example

```
wget --ask-password --user Batman https://fgcz-gstore.uzh.ch/projects/pXXXX/Your_DataDelivery/sample1.fastq.gz
```

This uses web get `wget`, 
with a user name `--user Batman`,
the path to your data `https://fgcz-gstore.uzh.ch/projects/pXXXX/Your_DataDelivery/sample1.fastq.gz`,
and will ask for a password `--ask-password` after hitting enter. 

Please note the example above will download the data to your current directory!

# Short read archive

If you want to use publically available data you can download this using the sra-toolkit. Please read this guide https://ncbi.github.io/sra-tools/fastq-dump.html.

First download a pre-built binary of the sratoolkit, using wget

```
wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.11.0/sratoolkit.2.11.0-centos_linux64.tar.gz
```

then unpack it

```
gunzip sratoolkit.2.11.0-centos_linux64.tar.gz 
tar -vxf sratoolkit.2.11.0-centos_linux64.tar 
```

next you need to activate it, hit

```
sratoolkit.2.11.0-centos_linux64/bin/vdb-config –interactiv
```

this will bring up a big blue screen. Hit ‘ctrl X’.

Now it should work, let’s try an example from there homepage

```
sratoolkit.2.11.0-centos_linux64/bin/fastq-dump -X 5 -Z SRR390728
```

this should print five fastq lines.

In the following example, six files will be downloaded using the batch submission (bsub)

```
for x in $(seq 1717931 1717936); do echo "bsub sratoolkit.2.11.0-centos_linux64/bin/fastq-dump  --split-files SRR$x";done | sh
```

the first part `for x in $(seq 1717931 1717936)` generates the numbers to download and puts them in a for loop. The next part `do echo "bsub sratoolkit.2.11.0-centos_linux64/bin/fastq-dump  --split-files SRR$x"` writes the command. This has the path to the fastq-dump program (you may need to get the whole path if you change folder). The name of the file is also created `SRR$x` and the data split into two fastq files `–split-files`. Finally this will also submit each download as a separate job `bsub`. The `done` marks the end of the loop. The last part `| sh` takes the output from the loop add passes (pipes `|`) it to the shell `sh` terminal. If you omit the `| sh` it will print the commands to the terminal for you to check them (very useful).

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

for a more real and useful example we will download six samples from Cassava

first move to the scratch directory then make some folders

```
cd $SCRATCH
mkdir Example
cd Example
mkdir FASTQ
```

In the following example, six files will be downloaded 

```
for x in $(seq 1717931 1717936); do echo "$HOME/sratoolkit.2.11.0-centos_linux64/bin/fastq-dump --split-files -X 100000 -Z SRR$x | paste - - - - - - - - | tee >(cut -f 1-4 | tr \"\\t\" \"\\n\" > FASTQ/SRR$x.1.fastq) | cut -f 5-8 | tr \"\\t\" \"\\n\" > FASTQ/SRR$x.2.fastq";done | bash
```

the first part `for x in $(seq 1717931 1717936)` generates the numbers to download and puts them in a for loop. The next part `do "$HOME/sratoolkit.2.11.0-centos_linux64/bin/fastq-dump -X 100000 -Z SRR$x` writes the command. In this case it will write the first 100,000 spots. This has the path to the fastq-dump program in your `$HOME` directory. The name of the file is also created `SRR$x` and the data split into two fastq files using the `paste - - - - - - - -` and `tee`commands.  The `done` marks the end of the loop. The last part `| bash` takes the output from the loop add passes (pipes `|`) it to the shell `bash` terminal (it doesnt work with just `sh`. If you omit the `| bash` it will print the commands to the terminal for you to check them (very useful).

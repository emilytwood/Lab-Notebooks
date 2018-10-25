#!/bin/bash
#SBATCH --nodes 1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time 1-00:00:00
#SBATCH --job-name jupyter-notebook
#SBATCH --output jupyter-notebook-%J.log

# get tunneling info
XDG_RUNTIME_DIR=""
port=$(shuf -i8000-9999 -n1)
node=$(hostname -s)
user=$(whoami)

# print tunneling instructions jupyter-log
echo -e "
MacOS or linux terminal command to create your ssh tunnel:
ssh -v -N -L ${port}:${node}:${port} ${user}@cl.bmap.ucla.edu
   

Forwarded port:same as remote port
Remote server: ${node}
Remote port: ${port}
SSH server: cl.bmap.ucla.edu
SSH login: $user
SSH port: 22

Use a Browser on your local machine to go to:
localhost:${port}  (prefix w/ https:// if using password)
"

# load modules or conda environments here
# e.g. farnam:
#module load anaconda/3.6 

# DON'T USE ADDRESS BELOW. 
# DO USE TOKEN BELOW
jupyter-notebook --no-browser --port=${port} --ip=${node} --NotebookApp.password=''

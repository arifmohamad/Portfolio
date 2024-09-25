# VM setup for jupyter and foma  

requires access to: https://gitlab.in.gfk.com/dp/cc/coma/libs/foma_research.git

## download miniconda
```
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
bash ~/miniconda.sh -b -p ~/miniconda
```

**reopen the terminal/console and:**
`mkdir --parents ~/.config/pip`

**edit this file (vim/nano):**  
`vim ~/.config/pip/pip.conf`

**& paste this:**  
```
[global]
index = https://coma-svc:z1WLTjcnTUiuS2ELpzPMKzitg4JvjlRr@nexus.gfk.com/repository/pypi-coma-group/pypi
index-url = https://coma-svc:z1WLTjcnTUiuS2ELpzPMKzitg4JvjlRr@nexus.gfk.com/repository/pypi-coma-group/simpl
```

## Clone foma_research repo
```
git clone https://gitlab.in.gfk.com/dp/cc/coma/libs/foma_research.git
git config --global user.name <your_user.name>
git config --global user.email <your.mail@gfk.com>
```

**store credentials:**  
```
git config --global credential.helper store
git pull
```
enter username and personal gitlab token

## instal and initialize Miniconda, to create (base) environment [https://docs.anaconda.com/free/miniconda/index.html]:
```
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh

for windows:

curl https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe -o miniconda.exe
start /wait "" miniconda.exe /S
del miniconda.exe


Then enter:
~/miniconda3/bin/conda init bash
~/miniconda3/bin/conda init zsh

```

## Create foma environment (used for analysis and research)
```
cd foma_research/
vim environment.yml
```
Comment out the last pip requirement (we will install it manually later).  
Create the environment and install foma package:  
``` 
conda env create -f environment.yml`
conda activate foma
pip install -e .
python -m ipykernel install --user --name foma --display-name "Python (foma)"
```

## Create JupyterLab environment
```
cp /share/datascience/chris/environment_jl.yml ~/
conda activate base
conda env create -f ~/environment_jl.yml
conda activate jl~
jupyter lab --port=8888 --no-browser --ip $(hostname -f)
```

**Adjust config with path**
```
jupyter notebook --generate-config
vim /home/mohammed.arif/.jupyter/jupyter_notebook_config.py
```
Uncomment this line and change the parameter to "/"
`c.NotebookApp.notebook_dir = '/'`

## Scripts to start tmux session and JupyterLab
cp /share/datascience/chris/launchtmux.sh ~/

## Configure JupyterLab
**install extensions:**
- jupyterlab-git
- jupyterlab-code-formatter

**Adjust settings in JupyterLab:**
- git
- notebook
- keyboard shortcuts
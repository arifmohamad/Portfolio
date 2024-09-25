# pip.conf file
[global]
index = https://[mohammed.arif]:[Escalade2020_Yukon2020]@nexus.gfk.com/repository/pypi-coma-group/pypi
index-url = https://[username]:[password]@nexus.gfk.com/repository/pypi-coma-group/simple


# in case we want pip to install from pypi, change to this in the pip.conf file:
https://PIP_TOOLS_TOKEN:<your_token>@gitlab.in.gfk.com/api/v4/groups/230/-/packages/pypi/simple

export STASH_USER=mohammed.arif
export STASH_PASSWORD=Tahoe2020_Yukon2020

echo $STASH_USER
echo $STASH_PASSWORD

## SSH into a VM:
ssh -i .ssh/my_ssh_key mohammed.arif@dcex1280ds01.gfk.com

ssh -i .ssh/my_ssh_key mohammed.arif@dcex1280cpufox1.gfk.com

# JupyterLab:

conda activate jl
jupyter lab --port=8888 --no-browser --ip $(hostname -f)


#Listing the size of the files in the directory:
du -sh * | sort -rh

#Accessing the pip.conf file
~/config/pip/pip.conf

# listing the size of the environemts
cd ~/miniconda3/envs
du -sch .[!.]* * |sort -h

# to check for an installed package disk usage:
du -sh /home/match/miniconda3/envs/papermill-test/lib/python3.10/site-packages/openpyxl
# to find the packages with above 1 MG disk usage:
find /home/match/miniconda3/envs/papermill-test/lib/python3.10/site-packages/ -type f -size +1000k -exec du -h {} \;| sort -h
# listing directories size
sudo du -ch --apparent-size / share/datascience | sort  -h | tail -n 30

#========== conda env ===========

conda create -n myenv python=3.9


# To delete an environment created by Conda, you can use the following command:
conda env remove --name <environment_name>

# create environment
conda env create -f environment.yml


# to update environment
conda env update --file your_environment.yml

# Create Jupyter Kernel
python -m ipykernel install --user --name=myenv-kernel

# to revert to a previous state of the created environemt
# checking the versions
conda list --revisions
conda install --revision <revision_number>


# clean up
conda clean -a

# update environment
conda env update -f environment.yml
# install a package
conda install <package_name>=<version>
#ex:
conda install gfk-foma-goo==3.0.109
# to sort the biggest ubfolders in the directory
sudo du -sh /home/* | sort -h
# check the available space on /home with the command 
df -h

##############################################################  Git ##############

# Rebasing diverging branch on Master / other branch

git checkout <branch_nam>
git fetch origin
git rebase origin/master
git push origin <branch_name> --force

# to abort rebase
git rebase --abort

# deleting a branch
git branch -d branch-to-delete
# deleting a branch and all it's commits related
git branch -D branch-to-delete
# deleting untracked directories permenanatly:
git clean -df

# Git rebase branch on master
1- git checkout dev
2- git fetch origin
3- git rebase origin/master
4- git rebase --continue
5- git push origin dev --force  # Note: Force pushing will overwrite the history of the remote branch

# to force resetting the local branch same as remote branch:
git reset --hard origin/FOMA-17893-adding_3rd_scenario

# to keep the version from the head while resolving rebase:
git checkout --ours pyproject.toml
git add pyproject.toml
git rebase --continue

git pull
git push



## merging master into local dev:
git checkout your-dev-branch
git fetch origin
git merge origin/master
# Resolve any conflicts if needed
git add <file-with-conflicts>
git commit
git status
git push

# if you wan to force master to overwrite the conflict on your local
git checkout dev_branch
git fetch origin
git reset --hard origin/master












# convert .ipynb notebook to html
jupyter nbconvert --to html your_notebook.ipynb

conda activate the environment_name
pip list 
# to save the packages in a text file for later refernece for pip.
pip freeze > packages.txt 

# to export the instaled packages in the activated environment:
conda env export --no-builds > /path/to/environment.yaml

#disk usage summary of a directory or file
du -sh <environment_path>






# ============================ Kernels and ver env ====================
 # create Jupyterlab ipykernel

python -m ipykernel install --user --name=foma_mqa_weekly --display-name "foma_mqa_weekly_test"
python -m ipykernel install --user --name=foma-test --display-name "foma-test"
# list kernels
jupyter kernelspec list

# to delete Kernel:
jupyter kernelspec uninstall my_kernel

# to upgrade outaded packages:
pip3 list --outdated --format=columns | grep -v '^\-e' | cut -d ' ' -f 1 | xargs -n1 pip3 install -U

# if there are issues with upgrading packages: 
https://stackoverflow.com/questions/68886239/cannot-uninstall-numpy-1-21-2-record-file-not-found


# ============================== Vevnv for windows ==========
# to activate the env created with python -m venv venv
.\venv\Scripts\activate.ps1





'pipdeptree --freeze | grep --only-matching --perl-regexp "^[\w\-]+" | grep --invert-match "\-e\|pkg" > requirements.in`


# to access the pip config file
~/.config/pip/pip.conf


[global]
index = https://coma-svc:z1WLTjcnTUiuS2ELpzPMKzitg4JvjlRr@nexus.gfk.com/repository/pypi-coma-group/pypi
index-url = https://coma-svc:z1WLTjcnTUiuS2ELpzPMKzitg4JvjlRr@nexus.gfk.com/repository/pypi-coma-group/simple


0 9 2 * * /home/match/miniconda3/envs/papermill/bin/python3 /home/match/foma/jobs/monthly_am_performance/job_master.py > /share/datascience/foma/jobs/monthly_am_performance/job_mast







rm -rf foma

df -h
du -sh *

##========== re-launching the Jupyert session with systemd ==================

mkdir -p  ~/.config/systemd/user/
nano ~/.config/systemd/user/jupyter-notebook.service

# Copy these lines into the file
```
[Unit]
Description=Jupyter Notebook Server

[Service]
ExecStart=/home/jshaus/miniconda3/envs/server/bin/jupyter notebook --port=8892 --ip=127.0.0.1 --no-browser

[Install]
WantedBy=default.target
```

# Replace this with your username
sudo loginctl enable-linger jshaus
systemctl --user enable jupyter-notebook.service
systemctl --user start jupyter-notebook.servic

============================================== Checking if you user is part of root / permissions issue to shares ===============
Access as root: Alternatively, you can switch to the root user using su or sudo -i and then navigate to the directory:
sudo -i
cd /usr/local/share/jupyter/
Check and Modify Permissions:
ls -ld /usr/local/share/jupyter/


Verify Group Membership
groups your_username
Add User to Root Group
usermod -aG root your_username
Check Permissions:
ls -ld /usr/local/share/jupyter/




Gh14KH9DFApHDEtKSbn



for Windows build_env.bat instead of build_env.sh:

::@echo off
setlocal enabledelayedexpansion

echo LOG - (Re)creating and activating repo environment

REM Create a virtual environment using Python
python -m venv foma-blacklist-service

REM Activate the virtual environment
call foma-blacklist-service\Scripts\activate

REM Install the required packages
pip install -r requirements\requirements-dev.txt

endlocal



Pycharm Pro creden:
pass: Tahoe2020_Durmax2020
username: hama_arif



Original caiman distribution including matlab compiled run time version of caimansaasexample.m

Get the caiman matlab runtime distribution from google drive using curl
curl -L "https://drive.google.com/open?id=10fNUbxrI66Ea5vIbH_p-no-_ly92qazE" > caiman-MATLAB_Runtime.tgz

Get the caiman mcr folder
curl -L "https://drive.google.com/open?id=1y3sVCf2Jb18I9rC4UIeXO9bBhLrKQvce" > caimanmcr.tgz
tar -zxvf caimanmcr.tgz

Caiman folder for downloading files from google drive manually
https://drive.google.com/open?id=1TlTMMpWbrLdca365YkpAtxqkQLOTOmRW

On the target computer, append the following to your LD_LIBRARY_PATH environment variable:  
/home/mike/tools/caiman_MATLAB_Runtime/v95/runtime/glnxa64:/home/mike/tools/caiman_MATLAB_Runtime/v95/bin/glnxa64:/home/mike/tools/caiman_MATLAB_Runtime/v95/sys/os/glnxa64:/home/mike/tools/caiman_MATLAB_Runtime/v95/extern/bin/glnxa64  


If MATLAB Runtime is to be used with MATLAB Production Server, you do not need to modify the above environment variable. 

Steps to install and set up
1. Install pyiome git clone https://github.com/mikeg64/pyiome
2. Edit .bashrc point to bin and lib folder in pyiome/tools/pyiome/old_iome/iogs
3. Down load the matlab distribution (see above)
4. Copy matlab distro files and extract in the caiman folder
5. edit .bashrc point to the matlab files (more detail needed here)
6. Edit .bashrc mv to tha caiman/caiman-rev folder flask and celery will be started from here this is the working directory exort the flask variables from here (see pyiome.py)
7. Start flask from /caiman/caiman-rev
8. Open anaother terminal and mv to the caiman/caiman-rev folder
9. Start celery celery celery -A tasks worker --loglevel=info

10. caiman server should now be working!



# Intelligent-AED
This code is for publication namely "Deep Feature Learning for Sudden Cardiac Arrest Detection in Automated External Defibrillators" on Scientific Report, 2018
Authors: Minh Tuan Nguyen, Binh Van Nguyen, and Kiseon Kim

1) Download vfdb and cudb database from following addresses and put them into separated folders to preprocess the ECG signal.
folder "processingVFDB" and "processingCUDB" include first ECG record of each database to temporarily test the codes
 http://www.physionet.org/physiobank/database/vfdb/
 http://www.physionet.org/physiobank/database/cudb/

2) Copy all the files and folders to a new folder namely "public_codes"

3) Go to following address to install VFDB toolbox for Matlab. The database needs additional functions to read the content of ECG records
https://physionet.org/physiotools/matlab/wfdb-app-matlab/

3) Run the file rhythms_RWCUDB.m and Rhythms_RWVFDB.m to get preprocessed ECG data, which is stored in ./public_codes/data

4) Run ECG_segmentation.m to divide ECG data into 8 second segment and compute Non-shockable signal and shockable signal from ECG segment using variational mode decomposition technique

5) Run separate_data.m to divide entire database into training and validated dataset

6) Run CNN_extractor_selection_f1.mat to select the CNNEs and run CNN_extractor_validation_feat_f1.mat to validate selected CNNEs

(foldes namely "CNNs_extractors" and "CNN_vailation_features" save the results for selection of CNNEs and validation performance using different Machine learning classifiers.
Folder "Full_CNNs" saves the results of selected full CNN and its validated performance).

7) LibSVM library is needed to be installed to excute the SVM simulation. Upgrading graphic card with GPU and larger memory is also necesarry to simulate deep learning with Matlab.

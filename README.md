# itpc
calculates inter-trial phase coherence for neural data

This script (tested on Matlab 2018a) uses the Fieldtrip toolbox (Oostenveld et al. 2011), Analysis pipeline adapted from Mike X Cohen book and Fieldtrip software.

# Installation
Step 1: Download Fieldtrip from https://www.fieldtriptoolbox.org/download/

Step 2: Load example_itpc_github.m in Matlab editor. This is an example script on how to calculate inter-trial phase coherence (ITPC) at your electrodes of choice.

Step 3: Load data and frequency bands.
```
load('data.mat') % Data. In fieldtrip format, already epoched.
load('freqranges.mat'); % frequency bands for hilbert transform

```
Step 4: Change Fieldtrip file path in example_code_pac.m
```
addpath /my fieldtrip software location here/fieldtrip folder name
```
Step 5: Change scripts file path in example_itpc_github.m
```
path(path,genpath('my itpc scripts here/my scripts folder name'));
```
Step 6: Change user defined inputs and run itpc func

```
config = [];
config.freqqq           = frequencyranges; % frequency bands for hilbert transform, according to Voytek et al. 2013.
config.choice_of_elec   = [1, 3, 5, 7]; % choose your choice of electrode numbers
config.ylim             = [5 20];
config.xlim             = [-.2 1];
```
# Data description
Electrocorticigraphy (ECoG) dataset with 29 bipolar derived electrodes (data.label). Data in Fieldtrip format.

Freqranges: Frequency bands for Hilbert transform according to Voytek et al. 2013.



%% load data
load('data.mat') % Data. In fieldtrip format, already epoched.
load('freqranges.mat'); % frequency bands for hilbert transform

%% add filetrip to path
restoredefaultpath
addpath /my fieldtrip software location here/fieldtrip folder name
ft_defaults
path(path,genpath('my itpc scripts here/my scripts folder name'));

%% run itpc func

%user defined inputs
config = [];
config.freqqq           = frequencyranges; % frequency bands for hilbert transform, according to Voytek et al. 2013.
config.choice_of_elec   = [1]; % choose your choice of electrode numbers
config.ylim             = [5 20];
config.xlim             = [-.2 1];

% run function
[itpc] = prepoc_itpc_func_github(config,data);


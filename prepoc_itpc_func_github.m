function [itc] = prepoc_itpc_func_github(config,data)

%% UNTITLED13 Summary of this function goes here
%% calculates itpc
% % input
% data = fieldtrip format data file. 
% config = with toi, left or right hemispshere, freq band of interest.

% % output
% instangs 
%% 
frequencyranges = config.freqqq;
elec = config.choice_of_elec;
ylimm = config.ylim;
xlimm = config.xlim;

%% channel selection (find channels that work for you. Otherwise select all. I have multiple selections here for my analysis)


%%
cfg = [] ;
% cfg.channel =  ft_channelselection('all', data_reref_WM_deleted_correct_50)
cfg.channel =  ft_channelselection(elec, data);
data_elec = ft_selectdata(cfg, data); 

%% calculate complex hilbert transform
[t_f_complex] = prepoc_hilbert_PAC_github(data_elec, frequencyranges, 'complex' );

%% calculate ITPC based on Mike X Cohen's method and Fieldtrip method

config =[];
config.xlim = xlimm;
config.ylim = ylimm;
config.freq = frequencyranges;
config.x_cohen = 0;
[itc] = prepoc_itpc_github(config, t_f_complex, 'itpc');



end


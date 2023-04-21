function [itc] = prepoc_itpc_github(config, t_f_A1notV1, AA)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

xlimitt = config.xlim;
ylimitt = config.ylim;

% colorax =  config.caxis;
% colorax_z =  config.caxis_z;

frequencyranges = config.freq;
n_trl = size(t_f_A1notV1.powspctrm, 1);
x_cohen = config.x_cohen;

%% using mike x cohen's method

for fi=1:size(frequencyranges, 1)
    
    % create wavelet and get its FFT
    as = (squeeze(t_f_A1notV1.powspctrm(:, :, fi, :)));
    if ndims(as) == 2
    as = permute(as,[2, 1]);
    
    % compute ITPC
    tf(fi,:)   = abs(mean(exp(1i*angle(as)), 2))';
    % raleigh correction
    tf_z(fi,:) = n_trl*((abs(mean(exp(1i*angle(as)), 2))).^2)';
    elseif ndims(as) == 3
        for chn =1:size(as,2)
             as2 = []; 
             as2 = squeeze(as(:, chn, :));
             as2 = permute(as2,[2, 1]);
    
            % compute ITPC
            tf_proxy(chn,:)   = abs(mean(exp(1i*angle(as2)), 2))';
            % raleigh correction
            tf_proxy_z(chn,:) = n_trl*((abs(mean(exp(1i*angle(as2)), 2))).^2)';
        end
        
        tf(fi, :) = mean(tf_proxy, 1);
        tf_z(fi, :) = mean(tf_proxy_z, 1);
    end
    

        
        
      
        
        
        
       

end


%
%% plot
% plot results
p = figure()
% subplot(2, 1, 1);
% contourf(t_f_A1notV1.time,t_f_A1notV1.freq  ,tf,40,'linecolor','none')
% title('ITPC')
% xlim(xlimitt)
% ylim(ylimitt)
% xlabel('time (s)');
% ylabel('frequency(Hz)');
% title(sprintf('%s %s: inter-trial phase coherence', AA, string(area_of_in)));colorbar
% caxis([0 colorax])
% colorbar

subplot(2, 1, 2);
contourf(t_f_A1notV1.time,t_f_A1notV1.freq  ,tf_z,40,'linecolor','none')
title('ITPC_z')
xlim(xlimitt)
ylim(ylimitt)
xlabel('time (s)');
ylabel('frequency(Hz)');
title(sprintf('Cohen %s: Railegh corrected inter-trial phase coherence', AA));colorbar
% caxis(colorax_z)
colorbar

%% using fieldtrip method
%%
F = t_f_A1notV1.powspctrm;   % copy the Fourier spectrum
N = size(F,1);           % number of trials


itc           = [];
itc.label     = t_f_A1notV1.label;
itc.freq      = t_f_A1notV1.freq;
itc.time      = t_f_A1notV1.time;
itc.dimord    = 'chan_freq_time';

% compute inter-trial phase coherence (itpc)
itc.itpc      = F./abs(F);         % divide by amplitude
itc.itpc      = sum(itc.itpc,1);   % sum angles
itc.itpc      = abs(itc.itpc)/N;   % take the absolute value and normalize
itc.itpc      = squeeze(itc.itpc);% remove the first singleton dimension
itc.itpc_all_chans =  itc.itpc; % save the  individual channel data
if size(F,2) > 1
itc.itpc      = mean(itc.itpc, 1); % mean over channels
else
    itc.itpc2(1, :, :)      = itc.itpc;
    itc.itpc = []
    itc.itpc= itc.itpc2;
end
itc.itpc_Z     = N*((itc.itpc).^2);



% compute inter-trial linear coherence (itlc)
itc.itlc      = sum(F) ./ (sqrt(N*sum(abs(F).^2)));
itc.itlc      = abs(itc.itlc);     % take the absolute value, i.e. ignore phase
itc.itlc      = squeeze(itc.itlc); % remove the first singleton dimension
itc.xcohen_Z    = tf_z;
itc.xcohen    = tf;
itc.itlc_Z     = N*((itc.itlc).^2);
%% plot
subplot(2,1,1)
% imagesc(itc.time, itc.freq, squeeze(itc.itpc(1,:,:)));
% contourf(squeeze(itc.itpc(1,:,:)));

contourf(itc.time, itc.freq  ,squeeze(itc.itpc(1,:,:)),40,'linecolor','none')

% axis xy;
xlim(xlimitt)
ylim(ylimitt)
ylabel('frequency(Hz)');

title(sprintf('Fieldtrip %s: inter-trial phase coherence', AA));colorbar
end


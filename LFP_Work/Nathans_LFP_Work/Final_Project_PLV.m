%PLV attempt 1


wavenumber=6;
%.25 octave intervals from 1-256 Hz
oct_num=32;%max frequency 256=2^8

scale_struct=struct('s0',1/267, 'ds',.25,'nb',oct_num,'type','pow','pow',2);

%firstforsize=cwt(LFP_Hip_corr(:,trial),'amor','VoicesPerOctave',voices,'NumOctaves',oct_num,'ExtendSignal',false);
firstforsize=cwtft({squeeze(LFP_Hip_corr(:,1)),time_step},'scales',scale_struct,'wavelet','morl');
morlet_Hip_corr=zeros([size(firstforsize.cfs),trials_corr]);
morlet_PFC_corr=zeros([size(firstforsize.cfs),trials_corr]);
morlet_Hip_incorr=zeros([size(firstforsize.cfs),trials_corr]);
morlet_PFC_incorr=zeros([size(firstforsize.cfs),trials_corr]);

%frequency,time Morlet
for trial=1:trials_corr
    %morlet_Hpc(:,:,trial)=cwt(LFP_Hip_corr(:,trial),'amor','VoicesPerOctave',voices,'NumOctaves',oct_num,'ExtendSignal',false);
    %morlet_PFC(:,:,trial)=cwt(LFP_PFC_corr(:,trial),'amor','VoicesPerOctave',voices,'NumOctaves',oct_num,'ExtendSignal',false);
    morlet_PFC_struct=cwtft({LFP_PFC_corr(:,trial),time_step},'scales',scale_struct,'wavelet','morl');
    morlet_PFC_corr(:,:,trial)=morlet_PFC_struct.cfs;
    morlet_Hip_struct=cwtft({LFP_Hip_corr(:,trial),time_step},'scales',scale_struct,'wavelet','morl');
    morlet_Hip_corr(:,:,trial)=morlet_Hip_struct.cfs;
    
end
PLV_corr=abs(mean((exp(1i*(angle(morlet_Hip_corr)-angle(morlet_PFC_corr)))),3));


%incorrect trials
for trial=1:trials_incorr
    morlet_PFC_struct=cwtft({LFP_PFC_incorr(:,trial),time_step},'scales',scale_struct,'wavelet','morl');
    morlet_PFC_incorr(:,:,trial)=morlet_PFC_struct.cfs;
    morlet_Hip_struct=cwtft({LFP_Hip_incorr(:,trial),time_step},'scales',scale_struct,'wavelet','morl');
    morlet_Hip_incorr(:,:,trial)=morlet_Hip_struct.cfs;    
end

PLV_incorr=abs(mean((exp(1i*(angle(morlet_Hip_incorr)-angle(morlet_PFC_incorr)))),3));


figure;
imagesc(PLV_corr-PLV_incorr);
L = get(gca,'YLim');
set(gca,'YTick',linspace(L(1),L(2),length(firstforsize.frequencies)));
set(gca,'YTickLabel',firstforsize.frequencies);
%set(gca,'XTickLabel',0:time_step:2-time_step));
xlabel('ms');
ylabel('Hz')
colorbar;
colormap(gray);
%save('PLV_indexes_3_3.mat','PLV_incorr','PLV_corr','morlet_Hip_incorr','morlet_PFC_incorr','morlet_Hip_corr','morlet_PFC_corr','firstforsize.frequencies')
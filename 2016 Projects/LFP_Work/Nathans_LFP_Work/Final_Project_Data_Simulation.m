clearvars;
close all;

%simulated_data
time_step=.001;
time_axis=0:time_step:2;
trials_corr=500;
trials_incorr=500;
LFP_Hip_corr=zeros(length(time_axis),trials_corr);
LFP_PFC_corr=zeros(length(time_axis),trials_corr);
LFP_Hip_incorr=zeros(length(time_axis),trials_incorr);
LFP_PFC_incorr=zeros(length(time_axis),trials_incorr);

%alpha
alpha=7;
alpha_phase=rand*pi;
alpha_phase_init=rand*pi;
%beta
beta=14;
beta_phase=rand*pi;
beta_phase_init=rand*pi;
%theta
theta=4;
theta_phase=rand*pi;
theta_phase_init=rand*pi;
%gamma
gamma=30;
gamma_phase=rand*pi;
gamma_phase_init=rand*pi;

 phase_random_walk=zeros(1,length(time_axis));
%correct trials
for trial=1:trials_corr
    for i=1:length(time_axis)-1
        phase_random_walk(i+1)=phase_random_walk(i)+5*rand*pi*time_step;
    end
    %alpha
    %alpha_phase_init=rand*pi;
    alpha_phase_incorr=rand*pi;
    %beta
    %beta_phase_init=rand*pi;
    beta_phase_incorr=rand*pi;
    %theta
    %theta_phase_init=rand*pi;
    theta_phase_incorr=rand*pi;
    %gamma
    %gamma_phase_init=rand*pi;
    gamma_phase_incorr=rand*pi;
    
    alphaHip=sin(2*pi*alpha*time_axis+alpha_phase_init);
    betaHip=sin(2*pi*beta*time_axis+beta_phase_init);
    thetaHip=sin(2*pi*theta*time_axis+theta_phase_init);
    GammaHip=sin(2*pi*gamma*time_axis+gamma_phase_init);
    alphaPFC=sin(2*pi*alpha*time_axis+alpha_phase_init+alpha_phase);
    betaPFC=sin(2*pi*beta*time_axis+beta_phase_init+beta_phase);
    thetaPFC=sin(2*pi*theta*time_axis+theta_phase_incorr+theta_phase+phase_random_walk);
    GammaPFC=sin(2*pi*gamma*time_axis+gamma_phase_incorr+gamma_phase+phase_random_walk);
    
    LFP_Hip_corr(:,trial)=alphaHip+betaHip+thetaHip+GammaHip+.25*rand(size(time_axis));
    LFP_PFC_corr(:,trial)=alphaPFC+betaPFC+thetaPFC+GammaPFC+.25*rand(size(time_axis));
end

%incorrect trials
for trial=1:trials_incorr
    %random walk phase
    for i=1:length(time_axis)-1
        phase_random_walk(i+1)=phase_random_walk(i)+5*rand*pi*time_step;
    end  
    
    %alpha
    %alpha_phase_init=rand*pi;
    alpha_phase_incorr=rand*pi;
    %beta
    %beta_phase_init=rand*pi;
    beta_phase_incorr=rand*pi;
    %theta
    %theta_phase_init=rand*pi;
    theta_phase_incorr=rand*pi;
    %gamma
    %gamma_phase_init=rand*pi;
    gamma_phase_incorr=rand*pi;
    
    alphaHip=sin(2*pi*alpha*time_axis+alpha_phase_init);
    betaHip=sin(2*pi*beta*time_axis+beta_phase_init);
    thetaHip=sin(2*pi*theta*time_axis+theta_phase_init);
    GammaHip=sin(2*pi*gamma*time_axis+gamma_phase_init);
    alphaPFC=sin(2*pi*alpha*time_axis+alpha_phase_incorr+alpha_phase+phase_random_walk);
    betaPFC=sin(2*pi*beta*time_axis+beta_phase_incorr+beta_phase+phase_random_walk);
    thetaPFC=sin(2*pi*theta*time_axis+theta_phase_init+theta_phase);
    GammaPFC=sin(2*pi*gamma*time_axis+gamma_phase_incorr+gamma_phase+phase_random_walk);    

    LFP_Hip_incorr(:,trial)=alphaHip+betaHip+thetaHip+GammaHip+.25*rand(size(time_axis));
    LFP_PFC_incorr(:,trial)=alphaPFC+betaPFC+thetaPFC+GammaPFC+.25*rand(size(time_axis));    
end

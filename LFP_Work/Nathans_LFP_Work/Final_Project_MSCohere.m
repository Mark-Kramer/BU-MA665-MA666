%Final Project MSCohere manual implementation
clear x y xf yf Sxx Sxy Syy Syx
trial=500; %default setting
x=LFP_Hip_incorr';
y=LFP_PFC_incorr';
trials=trials_incorr;

%x=LFP_Hip_corr';
%y=LFP_PFC_corr';
%trials=trials_corr;

t=time_axis(2:end);


dt = t(2)-t(1);	
T  = size(x,2)*time_step; %Define the total time.

fNQ=1/dt/2;
df=1/T;
faxis = [(0:df:fNQ), (-fNQ+df:df:-df)];

xf=zeros(length(faxis),500);
yf=zeros(length(faxis),500);

for i=1:trials
    xf(:,i)=fft(x(i,2:end));
    yf(:,i)=fft(y(i,2:end));
end


Sxx=zeros(length(faxis),500);
Syy=zeros(length(faxis),500);
Sxy=zeros(length(faxis),500);
Syx=zeros(length(faxis),500);
MSCohere=zeros(length(faxis),500);

for i=1:trials
%Sxx = 2*dt^2/T * (mean(xf,2).*conj(mean(xf,2)));    %Compute the power spectrum.
Sxx(:,i) = 2*dt^2/T * (xf(:,i).*conj(xf(:,i)));  
figure(2); hold on;
plot(faxis,Sxx(:,i));

%Syy = 2*dt^2/T * (mean(yf,2).*conj(mean(yf,2)));    %Compute the power spectrum.
Syy(:,i) = 2*dt^2/T * (yf(:,i).*conj(yf(:,i)));  
%figure(3); hold on;
%plot(faxis,real(Syy(:,i)));

%Sxy= 2*dt^2/T * (mean(xf,2).*conj(mean(yf,2))); 
Sxy(:,i) = 2*dt^2/T * (xf(:,i).*conj(yf(:,i))); 
%figure(4); hold on;
%plot(faxis,real(Sxy(:,i)));

%Sxy= 2*dt^2/T * (mean(xf,2).*conj(mean(yf,2))); 
Syx(:,i) = 2*dt^2/T * (yf(:,i).*conj(xf(:,i))); 
%figure(5); hold on;
%plot(faxis,real(Syx));


%figure(6); hold on;
%plot(faxis,real(MSCohere));
end
MSCohere(:,i)=abs(squeeze(mean(Sxy,2))).^2./(squeeze(mean(Sxx(:,i))).*squeeze(mean(Syy(:,i))));
figure(7);
plot(faxis,mean(abs(Sxy),2))
figure(8);
plot(faxis,mean(MSCohere,2))
xlabel('Frequency')
ylabel('Magnitude Squared Coherence')
title('Incorrect Condition')
xlim([0 45])
drawnow

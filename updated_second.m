%% Program for Optimal Policy for RF energy Harvesting Rate
%%% Network model: Time Switching Architecture
% That is, either the information receiver or the RF energy harvester is connected
% to the antenna at a given time.


%%  Commnets By : BATMAN 
%  Check the program with the valid data  
%  Please Remove the comments  

%% Variable description
% tau     : portion of time to harvest energy
% beta    : RF to DC power conversion efficiency
% Ps      : transmit power of RF transmitter k
% gamma   : path loss exponent
% hk      : channel power gain
% theta   : rate parameter
% delta   : shape parameter
% dk      : distance between transmit antenna of an RF transmitter to the
%           reciever antenna of RF powered device
% xk      : coordinates of k-th Rf transmitter referential to rf Device
% mu      : a constant
% max     : maximum value for Ps
% P_H     : RF energy harvesting rate(in watts) by the device from Rf
%           transmitter k
% P_HT    : Aggregated RF energy harvesting rate by the device equipped with
%           time switching architecture

% F,F_bar : Used to define thermal noise and noise in channel
%% Initialization
T     = 10;
K     = 5;
delta = 1; %so that 'hk' can be equal to 'exp(theta)'
MAX   = 10;
mu    = 3; %must be grater than 0
c     = zeros(K,1);
dk    = zeros(K,1);
e     = 0.5;
gamma = 5;
%% Input data 
% All data that needed to be entered by the user
tau   = input('Portion of time to harvest energy: ');
beta  = input('RF to DC power conversion efficiency');
Ps    = randi([0,MAX],[K,T]); %power value changes from '0' to 'max' with 'K'(no of transmitter)by 'T' (instances of time)
theta = input('Rate parameter: '); %theta must be positive, for all transmitters(1 by k)

xk    = input('Enter coordinates: '); %put array of coordinates for K no of transmitters,'(K,3)'
%% Defining different functions to be used further
hk = exp(theta);
F = exp(mu);
u = mu*( -mu + 1 ); %%%%%% expression needs to be verified   
% f = (1/u)*exp(-u);
syms x
Ei = double(-( int((1/(mu*(x+1)))*exp(-mu*(x+1)),x,mu,inf, 'PrincipalValue',true))); % Calculate value of the integral in the paper mailed page no 9 and conver the result into double 
F_bar = (1/(-mu*exp(mu)*Ei))

for i=1:K
   c(i) = ((((xk(i,1))^2)+((xk(i,2))^2)+((xk(i,3))^2))^0.5);
   dk(i) = e+c(i);
end

%% Calculating Energy Harvesting rate
%%% RF energy harvesting rate
P_H = [];
for i=1:K
P_H(i) = ((tau*beta)*Ps(i)*hk(i))/((dk(i))^gamma);
end

%%% Aggregate RF energy harvesting rate
s = sum(P_H);
P_HT= ((F_bar)/(1+F))*s;  % for the expression before 's' we can have some other expression to show noise

%% Results and plots
% to plot the results of harvesting rate vs density of ambient RF transmitter 
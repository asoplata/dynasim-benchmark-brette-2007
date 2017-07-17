function [T,E_v,E_iNaBM_m,E_iNaBM_h,E_iKBM_n,I_v,I_iNaBM_m,I_iNaBM_h,I_iKBM_n]=solve_ode
% ------------------------------------------------------------
% Parameters:
% ------------------------------------------------------------
params = load('params.mat','p');
p = params.p;
downsample_factor=p.downsample_factor;
dt=p.dt;
T=(p.tspan(1):dt:p.tspan(2))';
ntime=length(T);
nsamp=length(1:downsample_factor:ntime);
% ------------------------------------------------------------
% Initial conditions:
% ------------------------------------------------------------
% seed the random number generator
rng(p.random_seed);
t=0; k=1;

% STATE_VARIABLES:
E_v = zeros(nsamp,p.E_Npop);
  E_v(1,:) = zeros(1,p.E_Npop);
E_iNaBM_m = zeros(nsamp,p.E_Npop);
  E_iNaBM_m(1,:) = p.E_iNaBM_m_IC+p.E_iNaBM_IC_noise*rand(1,p.E_Npop);
E_iNaBM_h = zeros(nsamp,p.E_Npop);
  E_iNaBM_h(1,:) = p.E_iNaBM_h_IC+p.E_iNaBM_IC_noise*rand(1,p.E_Npop);
E_iKBM_n = zeros(nsamp,p.E_Npop);
  E_iKBM_n(1,:) = p.E_iKBM_n_IC+p.E_iKBM_IC_noise*rand(1,p.E_Npop);
I_v = zeros(nsamp,p.I_Npop);
  I_v(1,:) = zeros(1,p.I_Npop);
I_iNaBM_m = zeros(nsamp,p.I_Npop);
  I_iNaBM_m(1,:) = p.I_iNaBM_m_IC+p.I_iNaBM_IC_noise*rand(1,p.I_Npop);
I_iNaBM_h = zeros(nsamp,p.I_Npop);
  I_iNaBM_h(1,:) = p.I_iNaBM_h_IC+p.I_iNaBM_IC_noise*rand(1,p.I_Npop);
I_iKBM_n = zeros(nsamp,p.I_Npop);
  I_iKBM_n(1,:) = p.I_iKBM_n_IC+p.I_iKBM_IC_noise*rand(1,p.I_Npop);
% ###########################################################
% Numerical integration:
% ###########################################################
n=2;
for k=2:ntime
  t=T(k-1);
  E_v_k1=p.E_Iapp+((-(( p.E_iNaBM_gNa.*E_iNaBM_m(n-1,:).^3.*E_iNaBM_h(n-1,:).*(E_v(n-1,:)-p.E_iNaBM_ENa))))+((-(( p.E_iKBM_gK.*E_iKBM_n(n-1,:).^4.*(E_v(n-1,:)-p.E_iKBM_EK))))+((-(( p.E_iLeakBM_gLeak*(E_v(n-1,:)-p.E_iLeakBM_ELeak)))))));
  E_iNaBM_m_k1= (( 0.32*(13-E_v(n-1,:)+p.E_iNaBM_vT)./(exp((13-E_v(n-1,:)+p.E_iNaBM_vT)/4)-1))).*(1-E_iNaBM_m(n-1,:))-(( 0.28*(E_v(n-1,:)-p.E_iNaBM_vT-40)./(exp((E_v(n-1,:)-p.E_iNaBM_vT-40)/5)-1))).*E_iNaBM_m(n-1,:);
  E_iNaBM_h_k1= (( 0.128*exp((17-E_v(n-1,:)+p.E_iNaBM_vT)/18))).*(1-E_iNaBM_h(n-1,:))-(( 4./(1+exp((40-E_v(n-1,:)+p.E_iNaBM_vT)/5)))).*E_iNaBM_h(n-1,:);
  E_iKBM_n_k1= (( 0.032*(15-E_v(n-1,:)+p.E_iKBM_vT)./(exp((15-E_v(n-1,:)+p.E_iKBM_vT)/5)-1))).*(1-E_iKBM_n(n-1,:))-(( 0.5*exp((10-E_v(n-1,:)+p.E_iKBM_vT)/40))).*E_iKBM_n(n-1,:);
  I_v_k1=p.I_Iapp+((-(( p.I_iNaBM_gNa.*I_iNaBM_m(n-1,:).^3.*I_iNaBM_h(n-1,:).*(I_v(n-1,:)-p.I_iNaBM_ENa))))+((-(( p.I_iKBM_gK.*I_iKBM_n(n-1,:).^4.*(I_v(n-1,:)-p.I_iKBM_EK))))+((-(( p.I_iLeakBM_gLeak*(I_v(n-1,:)-p.I_iLeakBM_ELeak)))))));
  I_iNaBM_m_k1= (( 0.32*(13-I_v(n-1,:)+p.I_iNaBM_vT)./(exp((13-I_v(n-1,:)+p.I_iNaBM_vT)/4)-1))).*(1-I_iNaBM_m(n-1,:))-(( 0.28*(I_v(n-1,:)-p.I_iNaBM_vT-40)./(exp((I_v(n-1,:)-p.I_iNaBM_vT-40)/5)-1))).*I_iNaBM_m(n-1,:);
  I_iNaBM_h_k1= (( 0.128*exp((17-I_v(n-1,:)+p.I_iNaBM_vT)/18))).*(1-I_iNaBM_h(n-1,:))-(( 4./(1+exp((40-I_v(n-1,:)+p.I_iNaBM_vT)/5)))).*I_iNaBM_h(n-1,:);
  I_iKBM_n_k1= (( 0.032*(15-I_v(n-1,:)+p.I_iKBM_vT)./(exp((15-I_v(n-1,:)+p.I_iKBM_vT)/5)-1))).*(1-I_iKBM_n(n-1,:))-(( 0.5*exp((10-I_v(n-1,:)+p.I_iKBM_vT)/40))).*I_iKBM_n(n-1,:);
  % ------------------------------------------------------------
  % Update state variables:
  % ------------------------------------------------------------
  E_v(n,:)=E_v(n-1,:)+dt*E_v_k1;
  E_iNaBM_m(n,:)=E_iNaBM_m(n-1,:)+dt*E_iNaBM_m_k1;
  E_iNaBM_h(n,:)=E_iNaBM_h(n-1,:)+dt*E_iNaBM_h_k1;
  E_iKBM_n(n,:)=E_iKBM_n(n-1,:)+dt*E_iKBM_n_k1;
  I_v(n,:)=I_v(n-1,:)+dt*I_v_k1;
  I_iNaBM_m(n,:)=I_iNaBM_m(n-1,:)+dt*I_iNaBM_m_k1;
  I_iNaBM_h(n,:)=I_iNaBM_h(n-1,:)+dt*I_iNaBM_h_k1;
  I_iKBM_n(n,:)=I_iKBM_n(n-1,:)+dt*I_iKBM_n_k1;
  n=n+1;
end
T=T(1:downsample_factor:ntime);

end


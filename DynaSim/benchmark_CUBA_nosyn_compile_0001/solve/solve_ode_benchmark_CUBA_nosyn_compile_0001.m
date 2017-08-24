function [T,E_v]=solve_ode
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
% ###########################################################
% Numerical integration:
% ###########################################################
n=2;
for k=2:ntime
  t=T(k-1);
  E_v_k1=-p.E_gLeak*(E_v(n-1)-p.E_ELeak)./p.E_taum;
  % ------------------------------------------------------------
  % Update state variables:
  % ------------------------------------------------------------
  E_v(n)=E_v(n-1)+dt*E_v_k1;
  % ------------------------------------------------------------
  % Conditional actions:
  % ------------------------------------------------------------
  conditional_test=(E_v(n)>-50);
  if any(conditional_test), E_v(n,conditional_test)=-60; end
  n=n+1;
end
T=T(1:downsample_factor:ntime);

end


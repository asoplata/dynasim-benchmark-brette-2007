from brian2 import *
# from matplotlib import *

# set_device('cpp_standalone')

# Parameters
timelength =1000*ms
defaultclock.dt = 0.01*ms
# uncompiled: est. time 66s
# cells = 100

# uncompiled: est. time 1h 33m
# cells = 1000

cells = 500


area = 20000*umetre**2
Cm = (1*ufarad*cmetre**-2) * area
gl = (5e-5*siemens*cmetre**-2) * area

El = -60*mV
EK = -90*mV
ENa = 50*mV
g_na = (100*msiemens*cmetre**-2) * area
g_kd = (30*msiemens*cmetre**-2) * area
VT = -63*mV
# Time constants
taue = 5*ms
taui = 10*ms
# Reversal potentials
Ee = 0*mV
Ei = -80*mV
we = 6*nS  # excitatory synaptic weight
wi = 67*nS  # inhibitory synaptic weight

# tanh syns
gAMPA = (0.1*msiemens*cmetre**-2)* area
gGABAA = (0.06*msiemens*cmetre**-2)* area

EGABAA = -80*mV
tauGABAA = 5

EAMPA = 1*mV
tauAMPA = 2

# The model
eqs = Equations('''
dv/dt = (gl*(El-v)+
         -gAMPA/cells*sAMPAtotal*(v-EAMPA)+
         -gGABAA/cells*sGABAAtotal*(v-EGABAA)+
         -g_na*(m*m*m)*h*(v-ENa)+
         -g_kd*(n*n*n*n)*(v-EK))/Cm : volt
dm/dt = alpha_m*(1-m)-beta_m*m : 1
dn/dt = alpha_n*(1-n)-beta_n*n : 1
dh/dt = alpha_h*(1-h)-beta_h*h : 1
dge/dt = -ge*(1./taue) : siemens
dgi/dt = -gi*(1./taui) : siemens
alpha_m = 0.32*(mV**-1)*(13*mV-v+VT)/
         (exp((13*mV-v+VT)/(4*mV))-1.)/ms : Hz
beta_m = 0.28*(mV**-1)*(v-VT-40*mV)/
        (exp((v-VT-40*mV)/(5*mV))-1)/ms : Hz
alpha_h = 0.128*exp((17*mV-v+VT)/(18*mV))/ms : Hz
beta_h = 4./(1+exp((40*mV-v+VT)/(5*mV)))/ms : Hz
alpha_n = 0.032*(mV**-1)*(15*mV-v+VT)/
         (exp((15*mV-v+VT)/(5*mV))-1.)/ms : Hz
beta_n = 0.5*exp((10*mV-v+VT)/(40*mV))/ms : Hz
sAMPAtotal : 1
sGABAAtotal : 1
''')

# -gGABAA/cells*sGABAAtotal*(v-EGABAA)+
# sGABAAtotal : 1

# P = NeuronGroup(4000, model=eqs, threshold='v>-20*mV', refractory=3*ms,
#                 method='euler')

P = NeuronGroup(cells, model=eqs, method='euler')

proportion = int(0.8*cells)
Pe = P[:proportion]
Pi = P[proportion:]
# Ce = Synapses(Pe, P, on_pre='ge+=we')
# Ci = Synapses(Pi, P, on_pre='gi+=wi')
# Ce.connect(p=0.98)
# Ci.connect(p=0.98)
# AES 20170620 this is where the magic happens
sAMPA=Synapses(Pe,P,
               model='''ds/dt=1000.*5.*(1 + tanh(v_pre/(4.*mV)))*(1-s)/ms - (s)/(2*ms) : 1 (event-driven)
                        sAMPAtotal_post = s : 1 (summed)
                     ''')
#                model='''ds/dt=1000.*5.*(1 + tanh(v_pre/(4.*mV)))*(1-s)/ms - (s)/(2*ms) : 1 (clock-driven)
# model='''ds/dt=1000.*5.*(1 + tanh(v_pre/(4.*mV)))*(1-s) - (s)/(2) : 1 (clock-driven)
sAMPA.connect(p=0.98)

sGABAA_RETC=Synapses(Pi,P,
                     model='''ds/dt=1000.*2.*(1 + tanh(v_pre/(4.*mV)))*(1-s)/ms - s/(5*ms) : 1 (event-driven)
                              sGABAAtotal_post = s : 1  (summed)
                           ''')
#                      model='''ds/dt=1000.*2.*(1 + tanh(v_pre/(4.*mV)))*(1-s)/ms - s/(5*ms) : 1 (clock-driven)
sGABAA_RETC.connect(p=0.98)

# Initialization
P.v = 'El + (randn() * 5 - 5)*mV'
# P.ge = '(randn() * 1.5 + 4) * 10.*nS'
# P.gi = '(randn() * 12 + 20) * 10.*nS'

# Record a few traces
trace = StateMonitor(P, 'v', record=[1, 10, 100, 400])
totaldata = StateMonitor(P, 'v', record=True)
syndata = StateMonitor(P, 'sAMPAtotal', record=True)
# mdata = StateMonitor(P,'m',record=True)
# hdata = StateMonitor(P,'h',record=True)
# ndata = StateMonitor(P,'n',record=True)
# gedata = StateMonitor(P,'ge',record=True)
# giata = StateMonitor(P,'gi',record=True)


# prefs.codegen.cpp.compiler = '/usr/bin/gcc'
# prefs.codegen.cpp.extra_compile_args_gcc = ['-w', '-O3', '-ffast-math', '-march=native']
prefs.codegen.cpp.extra_compile_args_gcc = ['-w', '-O3', '-ffast-math', '-march=native','-llapack', '-lblas']

device.build(directory='output', compile=True, run=True, debug=False)
run(timelength, report='text')

# plot(trace.t/ms, trace[1].v/mV)
# plot(trace.t/ms, trace[10].v/mV)
# plot(trace.t/ms, trace[100].v/mV)
# plot(trace.t/ms, trace[400].v/mV)
# xlabel('t (ms)')
# ylabel('v (mV)')
# show()
# 
# print("Saving TC cell voltages!")
# numpy.savetxt("foo_totaldata.csv", totaldata.v/mV, delimiter=",")

plot(trace.t/ms, syndata[1].sAMPAtotal)
plot(trace.t/ms, syndata[10].sAMPAtotal)
plot(trace.t/ms, syndata[100].sAMPAtotal)
plot(trace.t/ms, syndata[400].sAMPAtotal)
xlabel('t (ms)')
ylabel('sAMPA')
show()


print("Saving syns!")
numpy.savetxt("foo_syndata.csv", syndata.sAMPAtotal, delimiter=",")

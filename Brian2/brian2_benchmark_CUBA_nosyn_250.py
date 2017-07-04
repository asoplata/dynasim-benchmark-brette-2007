"""
# Notes:

- This simulation seeks to emulate the CUBA benchmark simulations of (Brette
  et al. 2007) using the Brian2 simulator for speed benchmark comparison to
  DynaSim. However, this simulation does NOT include synapses, for better
  comparison to Figure 5 of (Goodman and Brette, 2008).

- The time taken to simulate will be indicated in the stdout log file
'~/batchdirs/brian_benchmark_CUBA_nosyn_250/pbsout/brian_benchmark_CUBA_nosyn_250.out'

- Note that this code has been slightly modified from the original (Brette et
  al. 2007) benchmarking code, available here on ModelDB:
  https://senselab.med.yale.edu/modeldb/showModel.cshtml?model=83319
  in order to work with version 2 of the Brian simulator (aka Brian2), and also
  modified to change the model being benchmarked, etc.

# References:

- Brette R, Rudolph M, Carnevale T, Hines M, Beeman D, Bower JM, et al.
Simulation of networks of spiking neurons: A review of tools and strategies.
Journal of Computational Neuroscience 2007;23:349–98.
doi:10.1007/s10827-007-0038-6.

- Goodman D, Brette R. Brian: a simulator for spiking neural networks in Python.
Frontiers in Neuroinformatics 2008;2. doi:10.3389/neuro.11.005.2008.
"""

from brian2 import *

# Parameters
cells = 250

defaultclock.dt = 0.01*ms

taum=20*ms
Vt = -50*mV
Vr = -60*mV
El = -49*mV

# The model
eqs = Equations('''
dv/dt = ((v-El))/taum : volt
''')

P = NeuronGroup(cells, model=eqs,threshold="v>Vt",reset="v=Vr",refractory=5*ms,
        method='euler')
proportion=int(0.8*cells)
Pe = P[:proportion]
Pi = P[proportion:]

# Initialization
P.v = Vr

# Record a few traces
trace = StateMonitor(P, 'v', record=[1, 10, 100])
totaldata = StateMonitor(P, 'v', record=True)


run(0.5 * second, report='text')

# plot(trace.t/ms, trace[1].v/mV)
# plot(trace.t/ms, trace[10].v/mV)
# plot(trace.t/ms, trace[100].v/mV)
# xlabel('t (ms)')
# ylabel('v (mV)')
# show()

# print("Saving TC cell voltages!")
# numpy.savetxt("foo_totaldata.csv", totaldata.v/mV, delimiter=",")

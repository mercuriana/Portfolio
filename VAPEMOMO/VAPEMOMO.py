# -*- coding: utf-8 -*-
"""
Created on Fri Apr 17 09:21:50 2020

@author: Noah Jaeggi
"""
import pandas as pd
import numpy as np
from inputfct import get_temp, buffer, get_data, get_ref
from outputfct import write_vapress, plot_vapress

# %%
'''
create the dataframe 'td' from thermodynamic data found in thermodata/data.txt
'''
td = get_data('thermodata', 'data')
comp = get_data('composition', 'composition')
comp['activity'] = comp['wt%']*comp['a_coeff']
# %%

'''
asks user for a minimum and maximum temperature. Number of steps is set
to 101 (each temperature step is an integer)
'''
temprange, tmin, tmax = get_temp()

# %%
'''
get ln(fO2) from a buffer - so far only IW buffer is incorporated
'''

lnfO2 = (pd.DataFrame(data=buffer(temprange))).T
lnfO2.columns = ["".join(item) for item in temprange.astype(str)]

fO2 = np.exp(lnfO2)
# %%

'''
create new dataframe for -(G-H)/RT and G/RT given a temperature range

Note: -(G-H)/RT = A + BT+CT^2+DT^3+ET^4, and dfH298 is in kK
'''
g_h = pd.DataFrame(data=td['Species'], index=td.index)
for tempnames in ["".join(item) for item in temprange.astype(str)]:
    g_h[tempnames] = ""
g = pd.DataFrame(data=td['Species'], index=td.index)
for T in temprange:
    g_h[str(T)] = td['A'] + 1E-03 * \
                  td['B'] * int(T) + 1E-06 * \
                  td['C'] * int(T)**2 + 1E-09 * \
                  td['D'] * int(T)**3 + 1E-12 * \
                  td['E'] * int(T)**4
    g[str(T)] = -g_h[str(T)] + td['dfH298']*1000/T

# %%

'''
calculate dG/RT and K8I) for the different species. Keep in mind, that
each species relates to O2, O and it's metal oxide in liquid form (see
Lamoreaux papers)
'''
# dG/RT
# for T in temprange:
#   = G(O) - d*G(MO)/RT - e*G(O2)/RT
gO = g.loc[g['Species'] == 'O']
gO2 = g.loc[g['Species'] == 'O2']

'''
get species name reference
TODO: Add O2 and O to the plots
'''

ref = get_ref(td)
# dropping O and O2 for now
ref = ref[1:]


dG = pd.DataFrame({'key': []})
# Ki = pd.DataFrame(data=td['Species'], index=td.index)
for tempnames in ["".join(item) for item in temprange.astype(str)]:
    dG[tempnames] = ""
# Ki['key'] = td['Species']
# Ki.set_index('Species', inplace=True, drop=True)
for element in ref:
    for specname in element:
        d = td['d'][0:].loc[td['Species'] == specname][0]
        e = td['e'][0:].loc[td['Species'] == specname][0]
#        print(element[0])
#        print(specname)
#        print('d = ' + str(d))
#        print('e = ' + str(e))
        df0 = g.loc[g['Species'] == specname].drop(columns=['Species'])
        df1 = d * g.loc[g['Species'] == element[0]].drop(columns=['Species'])
        df2 = e * gO2.drop(columns=['Species'])
        temp = pd.DataFrame(data=(df0.loc[specname]
                                  - df1.loc[element[0]]
                                  - df2.loc['O2']), columns=[specname]).T
        temp['key'] = specname
#        print('check')
        dG = dG.append(temp, sort=True)
dG = dG.drop(columns=['key'])
# %%

'''
calculate K(i) = exp(-dG/RT)
'''

Ki = dG.copy()


for T in temprange:
    Ki[str(T)] = Ki[str(T)].astype(float)
    Ki[str(T)] = np.exp(Ki[str(T)]*-1)

# %%
'''
calculate vapor pressure p(i) = K(i)*a(MO)^d*p[O2]^e
'''
pi = Ki.copy()
for element in ref:
    for specname in element:
        d = td['d'][0:].loc[td['Species'] == specname][0]
        e = td['e'][0:].loc[td['Species'] == specname][0]
        activity = comp['activity'].loc[comp['Species'] == element[0]][0]
#        print('specname =' + str(specname))
#        print('d =' + str(d))
#        print('e =' + str(e))
#        print('activity =' + str(activity))
        pi.loc[specname] = pi.loc[specname] * activity ** d
        pi.loc[specname] = pi.loc[specname] * fO2.loc[0] ** e

# %%
"""
write Vapor Pressures into txt file
"""
write_vapress(pi)

"""
plot Vapor Pressures
"""
plot_vapress(pi, ref, plot_all=False)

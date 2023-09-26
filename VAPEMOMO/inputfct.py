# -*- coding: utf-8 -*-
"""
Created on Fri Apr 17 09:33:15 2020

@author: Noah Jaeggi
"""
import numpy as np
import pandas as pd

# %%
"""
ask user for temperature range
"""


def get_temp():
    while True:
        tmininput = input("Lower temperature boundary >= 1500: ")

        try:
            tmin = int(tmininput)
            if tmin < 1500:
                print("------------------------------------------------------")
                print("continuing with value outside viable temperature range")
                print("------------------------------------------------------")
        except ValueError:
            print("This is not a valid number.")
        else:
            break
    while True:
        tmaxinput = input("Upper temperature boundary <= 2500: ")

        try:
            tmax = int(tmaxinput)
            if tmax > 2500:
                print("------------------------------------------------------")
                print("continuing with value outside viable temperature range")
                print("------------------------------------------------------")
        except ValueError:
            print("This is not a valid number.")
        else:
            break
    '''
    create temperature range with 101 integer values
    '''
    temprange = np.arange(tmin, tmax+1, int((tmax-tmin)/100))
    return temprange, tmin, tmax


# %%
"""
import thermo data from tab delimited .txt file into pandas dataframe
"""


def get_data(location, name):

    dataframe = pd.read_csv(r'%s\%s.txt' % (location, name), delimiter="\t+",
                            engine='python')
    dataframe.set_index('Species', inplace=True, drop=False)
#    thermodat = thermodat.set_index('Species')
#    print(thermodat)
    return dataframe


# %%
"""
Iron-Wüstite buffer dG and log(O2)
"""


def buffer(temprange,
           name='IW'):
    lnfO2 = []
    if name == 'IW':
        for T in temprange:
            if T < 1042:
                dGT = (-605568+1366.42*T-182.795*T*np.log(T) /
                       +0.10359*T**2)
            elif T < 1184:
                dGT = (-519113+59.129*T+8.9276*T*np.log(T))
            else:
                dGT = (-550915+269.106*T-16.9484*T*np.log(T))
            lnfO2.append(dGT/(8.31441*T*np.log(10)))
    #        print(lnfO2T)
    #        print(lnfO2tmax)
        return lnfO2


# %%
"""
Get species names as multi array and append new array whernever the first
letter of the name changes
"""


def get_ref(df):
    ref = []
    element = 0
    ref.append([])
    for species in df['Species']:
        if ref != [[]]:
            if species[0] != ref[element][0][0]:
                element += 1
                ref.append([])
        ref[element].append(species)
    return ref

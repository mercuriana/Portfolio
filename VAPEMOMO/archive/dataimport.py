# -*- coding: utf-8 -*-
"""
Created on Thu Apr 16 14:50:38 2020

@author: Noah Jaeggi

"""
import pandas as pd

"""
import thermo data from tab delimited .txt file into pandas dataframe
"""
def thermoimport(path=[r'thermodata\data.txt']):
    #df = pd.read_excel (r'thermodata\data.xlsx')
    thermodat = pd.read_csv (path, delimiter="\t+")
    #df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list('ABCD'))
    
    thermodat = thermodat.set_index('Species')
    print (thermodat)
    return thermodat
# -*- coding: utf-8 -*-
"""
Created on Fri Apr 17 09:17:54 2020

@author: Noah Jaeggi
"""
import numpy as np
"""
ask user for temperature range
"""
def temperature_range():
    while True:
        tmininput = input("Lower temperature boundary >= 1500: ")
        
        try:
            tmin = int(tmininput)
            if tmin < 1500:
                print("---------------------------------------------------------")
                print("...continuing with value outside viable temperature range")
                print("---------------------------------------------------------")
        except ValueError:
            print("This is not a valid number.")
        else:
            break
    while True:   
        tmaxinput = input("Upper temperature boundary <= 2500: ")
    
        try:
            tmax = int(tmaxinput)
            if tmax > 2500:
                print("---------------------------------------------------------")
                print("...continuing with value outside viable temperature range")
                print("---------------------------------------------------------")
        except ValueError:
            print("This is not a valid number.")
        else:
            break
    '''
    create temperature range with 101 integer values
    '''
    temprange = np.arange(tmin,tmax+1, int((tmax-tmin)/100))
    return temprange
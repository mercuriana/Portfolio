# -*- coding: utf-8 -*-
"""
Created on Mon April 20 14:19 2020
@author: Diana Gamborino
"""
# import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

# %%
"""
write vapor pressure dataframe into a .txt file including its index
"""


def write_vapress(pi):
    pi.to_csv('./output/vapress_table.txt', sep='\t')


"""
plot vapor pressures by transposing pi and filtering out (l) species
"""


def plot_vapress(pi, ref, plot_all=True):
    trans_pi = pi.T
    # Filter only the column names that contain '(g)':
    index_gas_pi = trans_pi.filter(like='(g)').columns
    # Create new dataframe with only gas species:
    gas_pi = pd.DataFrame(trans_pi[index_gas_pi])
    # Plot vapor pressure of gas species:
    if plot_all is True:
        name = 'all'
        plot = gas_pi.plot()
        plt.yscale('log')
        fig = plot.get_figure()
        fig.savefig("./output/vapress_plot.pdf",
                    bbox_inches='tight',
                    format='pdf')
    # Plot vapor pressures of different species in seperate plots:
    else:
        for n in range(len(ref)):
            liquid = ref[n][0]
            # If the species name has only a one letter shortform:
            if liquid[1].isdigit() is True:
                name = liquid[0]
                index_group = gas_pi.filter(like=name).columns
                gas_pi_select = pd.DataFrame(trans_pi[index_group])
                plot = gas_pi_select.plot()

            # If the species has a two letter shortform:
            else:
                name = liquid[:2]
                index_group = gas_pi.filter(like=name).columns
                gas_pi_select = pd.DataFrame(trans_pi[index_group])
                plot = gas_pi_select.plot()

            plt.xlabel('T/K')
            plt.ylabel('p/bar')
            plt.yscale('log')
            fig = plot.get_figure()
            fig.savefig("./output/vapress_"+name+".pdf",
                        bbox_inches='tight',
                        format='pdf')

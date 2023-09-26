# Topos-Chronos for Active Regions and Quiet Sun
# Methodology explained in Sec. 2.2 in Gamborino et al. (2016)

import numpy as np
import matplotlib.pyplot as plt

# Load data from AAA2.npy and PFlare.npy (changed file extensions)
AAA2 = np.load('AAA2.npy')
PFlare = np.load('PFlare.npy')

nt = 47 # time steps

# Convert matrices A{i}'s into row vectors
d, d2 = AAA2.shape[1], PFlare.shape[1]
GM = AAA2.reshape(nt, -1)
GM2 = PFlare.reshape(nt, -1)

# Perform SVD in 3-D
U, S, VT = np.linalg.svd(GM, full_matrices=False)
U2, S2, VT2 = np.linalg.svd(GM2, full_matrices=False)

MO = [VT[i].reshape(d, d) for i in range(d * d)]
MO2 = [VT2[i].reshape(d2, d2) for i in range(d2 * d2)]

# Save data to TCflare.npy
np.savez('TCflare.npz', U=U, S=S, VT=VT, MO=MO, U2=U2, S2=S2, VT2=VT2, MO2=MO2)

# Matrices truncation
r = range(1, nt + 1)
MT = []
MT2 = []

for k in r:
    MT_k = np.dot(U[:, :k], np.dot(np.diag(S[:k]), VT[:k, :]))
    MT2_k = np.dot(U2[:, :k], np.dot(np.diag(S2[:k]), VT2[:k, :]))
    
    MT.append(MT_k)
    MT2.append(MT2_k)

# Save truncated matrices to TCflareqs.npz
np.savez('TCflareqs.npz', U=U, S=S, VT=VT, MO=MO, U2=U2, S2=S2, VT2=VT2, MO2=MO2, MT=MT, MT2=MT2)

# Plotting modes
isee = [0, 1, 2, 3, 19, 29, 39, 45]

fig, axes = plt.subplots(4, 4, figsize=(16, 16))
for j, i in enumerate(isee):
    axes[j // 2, 2 * (j % 2)].imshow(-S[i] * MO[i], cmap='viridis')
    axes[j // 2, 2 * (j % 2)].set_title(f'k={i}')
    axes[j // 2, 2 * (j % 2) + 1].plot(range(1, nt + 1), -U[:nt, i])
    axes[j // 2, 2 * (j % 2) + 1].set_ylim([-0.5, 0.5])
    axes[j // 2, 2 * (j % 2) + 1].set_xlim([1, nt])

plt.show()

# Compute energy contribution percentage
Sum1 = np.sum(S)
Sum2 = np.sum(S2)
PC1 = np.cumsum(S) / Sum1
PC2 = np.cumsum(S2) / Sum2

# Plot energy contribution percentage
plt.figure(figsize=(10, 6))
plt.plot(range(1, nt + 1), PC1 * 100, '-o', label='Solar Flare')
plt.plot(range(1, nt + 1), PC2 * 100, '-o', label='Quiet Sun')
plt.xlabel('Rank r')
plt.ylabel('%')
plt.legend()
plt.show()

# Plot singular values
plt.figure(figsize=(10, 6))
plt.semilogy(range(1, nt + 1), S, '-o', label='Solar Flare')
plt.semilogy(range(1, nt + 1), S2, '-o', label='Quiet Sun')
plt.xlabel('Rank (k)')
plt.ylabel('Singular Values sigma^i')
plt.legend()
plt.show()
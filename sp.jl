r = 0.018
K = 300_000
T = 30
p = K/T

# linear scenario
# Nominal cost of loan
G = r*sum(K-i*p for i in 1:T)

# Cost taking into account tax benefit
0.62*G3

# Discounted to today's money
f = 1.02 # Average inflation
G = r*sum((K-i*p)/(f^(i-1)) for i in 1:T)

# Inflation and discount
G = 0.62*r*sum((K-i*p)/(f^(i-1)) for i in 1:T)

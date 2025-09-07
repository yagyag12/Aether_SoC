#!/usr/bin/env python3

from sys import argv

binfile = argv[1]
nwords = int(argv[2])

with open(binfile, "rb") as f:
    bindata = f.read()

# Pad bindata with zeros if it's not a multiple of 4 bytes
while len(bindata) % 4 != 0:
    bindata += b'\x00'

assert len(bindata) <= 4 * nwords

for i in range(nwords):
    if i < len(bindata) // 4:
        w = bindata[4*i : 4*i+4]
        print("%02x%02x%02x%02x" % (w[3], w[2], w[1], w[0]))
    else:
        print("0")
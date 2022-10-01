### Network Address Calculation From Subnet

#### Question
193.16.20.35/29

What is the Network IP, number of hosts, range of IP addresses and broadcast IP from this subnet?

#### Solution
/29 means there are 29 network bits and 3 left as host bits
11111111.11111111.11111111.11111000
Convert to decimal:
11111111.11111111.11111111.11111000
 255 .      255.      255.    248

1. Network IP Address
To find the network IP address:
Perform a bit-wise AND operation (1+1=1, 1+0 or 0+1 =0, 0+0=0) on the host IP address and subnet mask. The result is the subnet address in which the host is situated.


|Given IP    |193.   |16.   |20.   |35.   |
|------------|-------|------|------|------|
|Given IP binary   |11000001.   |00100000.   |00010100.   |00100011   |
|Subnet   |255.   |255.   |255.   |248   |
|Subnet binary   |11111111.   |11111111.   |11111111.   |11111111.   |
|------------|-------|------|------|------|
|Network IP binary   |11000001.   |00100000.   |00010100.   |00100000   |
|Network IP   |193.   |16.   |20.   |32   |

Network IP Address = 193.16.20.32

2. Number of Hosts

Number of host bits in the net mask = 3

Number of hosts = 2^Number of host bits - 2

                = 2^3 - 2

                = 8 - 2

                = 6

3. Range of IP Addresses

Subnet

11000001		00100000		00010100		00100|000

193			    16			    20			    32       


First Host

11000001	    00100000	    00010100	    00100 | 001

193			    16			    20			    33


Last Host

11000001		00100000		00010100		00100 | 110

193			    16			    20			    38


Broadcast Host

11000001		00100000		00010100		00100 | 111

193			    16			    20			    39


Next subnet

11000001		00100000		00010100		00101 | 000

193			    16			    20			    40


Range of IP Addresses = 193.16.20.33 - 193.16.20.38

Broadcast IP Address = 193.16.20.39
# Packet-Encoder
A MIPS program that encodes a domain name into a packet. The packet is then stored in memory.
This program runs on QtSpim.

The program prompts the user for the length of the domain name (the total number of characters). 
The program then prompts the user to enter the domain name.

The header of the packet is stored in memory in big-endian format from lines 40 to 88.

The domain name is encoded by separating the segments, storing the ascii codes for the characters after the length of the segment. The byte 0x00 is added to the end of the packet to indicate the end of the domain name.
For example, www.web.ac.uk  will be encoded as follows: 03777777 03776562 026163 02756B. 03, 03, 02 and 02 represent the length of the segments www, web, ac and uk.

The encoded domain name is added after the header

QType 0x0001 and QClass 0x0001 is then added to the packet.

The length of the packet, in bytes, is stored in register $v0 and printed to the console.
Register $a1 stores the memory address of the packet.
Register $a2 stores the transaction ID (0x1234).  The transaction ID is stored in the header.

# DDNS service for AWS route53 DNS

### This application requires a working aws cli,
### On start, the program reads the configuration file which includes:
  1. Hostzone id list
  2. Current machine's IP address
  3. IP check interval
It will do a quick check to see if the hostzones are reachable

### After Initialization, the program checks current machine's IP addresses periodically, triger action if the ip changes. 
### If the current machines' public IP changes, the program will do a scan on all provided hostzones and locate every record that contains the old IP address, then generate API requests for updating them.

### Program creates log files under /logs directory

# DDNS service for AWS route53
## Overview
The program runs on local linux machine which DNS services is provided by AWS Route53.

On start, the program reads the configuration file which includes:
  1. Hostzone id list
  2. Current machine's IP address
  3. IP check interval
  
and then do a quick check to see if the hostzones are reachable

After the initialization, the program checks current machine's IP addresses periodically (IP check interval), triger actions if detects ip changes: 
If the current machines' public IP changes, the program will do a scan on all provided hostzones and locate every record that contains the old IP address, then generate API requests for updating them.

## Key features
1. Hiccup handler. Allows temporary internet hiccups and retry query/request/sacn/etc. actions in a growing interval ( some actions up to 1 Day ) before exist.
2. Search all hostzones' record sets and change all matching old IPs
3. Complete log display/file generated for debugging.

One complete run demo here:
![6e9dceab3e7406c7b57f8a56cb12688](https://user-images.githubusercontent.com/49338791/205207687-3f9a8dc2-e9d2-4f88-86ce-f3b8fc4f4953.png)

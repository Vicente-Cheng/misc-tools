# compute node block stat analysis

import libvirt
from xml.etree import ElementTree

node_stats_rbytes = 0
node_stats_wbytes = 0

#Function to return a list of block devices used.
def get_target_devices(dom):
   #Create a XML tree from the domain XML description.
   tree=ElementTree.fromstring(dom.XMLDesc(0))

   #The list of block device names.
   devices=[]

   #Iterate through all disk target elements of the domain.
   for target in tree.findall("devices/disk/target"):
       #Get the device name.
       dev=target.get("dev")

       #Check if we have already found the device name for this domain.
       if not dev in devices:
           devices.append(dev)

   #Completed device name list.
   return devices

if __name__=="__main__":
   #Connect to some hypervisor.
   conn=libvirt.open("qemu:///system")

   #Iterate through all available domains.
   for id in conn.listDomainsID():
       #Initialize the domain object.
       dom=conn.lookupByID(id)

       #Initialize our block stat counters.
       rreq=0
       rbytes=0
       wreq=0
       wbytes=0

       #Iterate through each device name used by this domain.
       for dev in get_target_devices(dom):
           #Retrieve the block stats for this device used by this domain.
           stats=dom.blockStats(dev)

           #Update the block stat counters
           rreq+=stats[0]
           rbytes+=stats[1]
           wreq+=stats[2]
           wbytes+=stats[3]

       #display the results for this domain.
       node_stats_rbytes += rbytes
       node_stats_wbytes += wbytes
       print "\n%s Block Stats"%(dom.UUIDString())
       print "Read Requests:  %s"%(rreq)
       print "Read Bytes:     %s"%(rbytes)
       print "Write Requests: %s"%(wreq)
       print "Written Bytes:  %s"%(wbytes)

   print "\nTotal Read Bytes:     %s"%(node_stats_rbytes)
   print "Total Written Bytes:  %s"%(node_stats_wbytes)

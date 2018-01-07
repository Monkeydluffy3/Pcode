
BEGIN {

    seqno = 0;    

    droppedPackets = 0; 

    receivedPackets = 0;
    
    tcps = 0;

    tcpr = 0;
    
    tcpd = 0;

    udps = 0;

    udpr = 0;

    udpd = 0;

    acks = 0;

    ackr = 0;

    ackd = 0; 

    count = 0;

}

{

#packet delivery ratio for all packets


#For couting total no of send (tcp,udp and ack)
    	
    if (($1 == "+") && (seqno < $12))
    	{
	seqno = $12;
    	}


#For couting total no of receive at destination node4 and node5 (tcp,udp and ack)
 


#For individual send, receive and ack
   if (($1 == "+") && ($5 == "cbr") && ($3 == "1"))
        {
		udps++;
	}
   else if (($1 == "+") && ($5 == "tcp") && ($3 == "0"))
        {
		tcps++;
	}
   else if (($1 == "+") && ($5 == "ack") && ($3 == "4"))
	{
		acks++;
	}
   else if (($1 == "r") && ($5 == "cbr") && ($4 == "5"))
	{
		udpr++;
	}
   else if (($1 == "r") && ($5 == "tcp") && ($4 == "4"))
        {
		tcpr++;
	}
   else if (($1 == "r") && ($5 == "ack") && ($4 == "0"))
	{
		ackr++;
	}
   else if (($1 == "d") && ($5 == "cbr"))
	{
		udpd++;
	}
   else if (($1 == "d") && ($5 == "tcp"))
	{
		tcpd++;
	}
   else if (($1 == "d") && ($5 == "ack"))
	{
		ackd++;
	}
  }
 
END {
    print "\n";

    print "Total no of GeneratedPackets            = " seqno;

    print "Total no of ReceivedPackets             = " udpr+tcpr+ackr;

    print "Total no of Dropped Packets = " tcpd+udpd+ackd;

    print "Total Packet Delivery Ratio      = " receivedPackets/(seqno+1)*100
"%";
    print "Total no of TCP send            = " tcps;

    print "Total no of UDP send            = " udps;

    print "Total no of ACK send            = " acks;
    
    print "Total no of TCP receive            = " tcpr;

    print "Total no of UDP receive            = " udpr;

    print "Total no of ACK receive            = " ackr;
    
    print "Total no of TCP drop            = " tcpd;

    print "Total no of UDP drop            = " udpd;

    print "Total no of ACK drop            = " ackd;

   # print "Average End-to-End Delay    = " n_to_n_delay" s";

    print "\n";

} 

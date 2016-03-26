# Toolbox_Scilab
Development of Scilab equivalent functions for MATLAB fumctions compand( ) and bersync( ).
#
I have implemented both functions as .sci files. Follow these steps to execute the code:<br />
Open scilab console.<br />
Open the directory where the file is present and hence open the file.<br />
Click on save and execute button.<br />
#
###compand( )
On the console enter the function in any one of the following format:<br />
out = compand(in,param,v) <br />
out = compand(in,Mu,v,'mu/compressor') <br />
out = compand(in,Mu,v,'mu/expander') <br />
out = compand(in,A,v,'A/compressor') <br />
out = compand(in,A,v,'A/expander') <br />
where 'in' is input vector,'Mu' is  µ-law parameter of the compander, 'v' is  maximum value of the signal 'in', 'A' is A-law parameter of the compander.

####Example:<br />
data = 2:2:12
#####μ-law compander
compressed = compand( data, 255, max(data), 'mu/compressor' )<br />
output:<br />
compressed = 8.1644     9.6394    10.5084    11.1268    11.6071    12.0000<br />
<br />
expanded = compand( compressed, 255, max(data), 'mu/expander' )<br />
output:<br />
expanded = 2.0000     4.0000     6.0000     8.0000    10.0000    12.0000<br />
<br />
data = 1:5
#####A-law compander
compressed = compand( data, 87.6, max(data), 'a/compressor' )<br />
output:<br />
compressed = 3.5296    4.1629    4.5333    4.7961    5.0000<br />
<br />
expanded = compand(compressed,87.6,max(data),'a/expander')<br />
output:<br />
expanded = 1.0000    2.0000    3.0000    4.0000    5.0000<br />

###bersync( )
On the console enter the function in any one of the following format:<br />
ber = bersync(EbNo,timerr,'timing') <br />
ber = bersync(EbNo,phaserr,'carrier')<br />
where 'EbNo' is the ratio of bit energy to noise power spectral density, in dB, 'timerr' is the standard deviation of the timing error, 'phaserr' is the standard deviation of the error in the reference carrier phase, in radians.

####Example:<br />
#####Timing
ber = bersync( 4, 0.2, 'timing')<br />
output:<br />
ber = 5.2073D-02
<br />
ber = bersync( 8, 0, 'timing')<br />
output:<br />
ber = 1.9091D-04
#####Carrier
ber = bersync( 4, 0.2, 'carrier')<br />
output:<br />
ber = 1.4178D-02
<br />
ber = bersync( 8, 0, 'carrier')<br />
output:<br />
ber = 1.9091D-04 



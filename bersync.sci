//Implementation of Matlab function bersync() in scilab
//
//Name: Rama Shanbhag
//Institute: National Institute of Technology Karnataka Surathkal
//Email: ramashanbhag31@gmail.com
//
//Function: bersync()
//out=bersync(EbNo,timerr,law)
//
//Input arguments:
//EbNo: the ratio of bit energy to noise power spectral density, in dB.
//timerr: the standard deviation of the timing error, normalized to the symbol interval. timerr must be between 0 and 0.5. 
//law: one of the two
//        timing
//        carrier
//
//Output arguments:
//out: the BER of uncoded coherent binary phase shift keying (BPSK) modulation over an additive white Gaussian noise (AWGN) channel with imperfect timing when timing is choosen.
//out: the BER of uncoded BPSK modulation over an AWGN channel with a noisy phase reference when carrier is choosen.

//source:
//  in.mathworks.com
//  help.scilab.org
//  stackoverflow.com


function [y]=f(x) 
    y=%e^(-x^2/2) 
endfunction

//function to change the variable of integration from x=(-inf,inf) to z=atan(x)with 1 argument
function[y]=Gmodified1(z)
    x=tan(z);
    y=f(x)/(cos(z))^2;
endfunction

// Function that evaluates integral of Gmodified form of f(x) over the limit atan(sqrt(2R)(1-2abs(e))) to atan(inf)
function [y]=g(sig,R,e)
     y=intg(atan(sqrt(2*R)*(1-2*abs(e))),atan(%inf),Gmodified1);
     y=%e^(-e^2/(2*sig*sig))*y;
endfunction

//function to change the variable of integration from x=(-inf,inf) to z=atan(x) with 3 argument for timing equation
function [y]=Gmodified2(z,R,timerr)
    x=tan(z);
    y=g(timerr,R,x)/(cos(z))^2;
endfunction

// Function that evaluates integral of Gmodified form of f(x) over the limit atan(sqrt(2R)(cos(e))) to atan(inf)
function [y]=h(sig,R,e)
     y=intg(atan(sqrt(2*R)*cos(e)),atan(%inf),Gmodified1);
     y=%e^(-e^2/(2*sig*sig))*y;
endfunction

//function to change the variable of integration from x=(-inf,inf) to z=atan(x) with 3 argument for carrier equation
function [y]=Gmodified3(z,R,phaserr)
    x=tan(z);
    y=h(phaserr,R,x)/(cos(z))^2;
endfunction

//bersync function
function[out]=bersync(EbNo,timerr,law)
    //convert EbNo from dB to a linear scale and store it in R
    R=10.^(EbNo/10);
    //if the value of timerr or phaserr is very small(here 0) then the bersync command produces the same result as berawgn(EbNo,'psk',2)
    if timerr==0 then
        //this is given by 1/sqrt(2pi) times integral of f(x) in Gmodified form over the limit atan(sqrt(2R)) to atan(inf)
       ans= 1/(sqrt(2*%pi))*intg(atan(sqrt(2*R)),atan(%inf),Gmodified1);
       out=ans;
    elseif law=='timing' then
        //When the last input is 'timing', the function computes the following 
        //here list is used as v need Gmodified function with 3 arguments
       ans=1/(4*%pi*timerr);
       ans=ans*intg(-atan(%inf),atan(%inf),list(Gmodified2,R,timerr));
       ans=ans+1/(2*sqrt(2*%pi))*intg(atan(sqrt(2*R)),atan(%inf),Gmodified1);
       out=ans
    elseif law=='carrier' then
       // When the last input is 'carrier', the function computes the following
       ////here list is used as v need Gmodified function with 3 arguments
       phaserr=timerr;
       ans=1/(%pi*phaserr);
       ans=ans*intg(atan(0),atan(%inf),list(Gmodified3,R,phaserr));
       out=ans 
     end  
    format('e',11);out
   
endfunction
 

//Implementation of Matlab function compand() in scilab
//
//Name: Rama Shanbhag
//Institute: National Institute of Technology Karnataka Surathkal
//Email: ramashanbhag31@gmail.com
//
//Function: compand()
//out=compand(in,Mu,v,law)
//
//Input arguments:
//in: input vector(signal)
//Mu: µ-law or A-law parameter of the compander
//      The prevailing parameters used in practice are µ= 255 and A = 87.6
//v: maximum value of the signal 'in'
//law: one of the four
//        mu/compressor
//        mu/expander
//        a/compressor
//        a/expander
//
//Output arguments:
//out: The output of the µ-law or A-law compressor or expander
//
//source:
//  in.mathworks.com
//  help.scilab.org

//Function when type of operation is specified
function[out]=compand(in,Mu,v,law)
    
    //calculates signum function value of the input signal 'in'
    if in<0 then z=-1
    elseif in==0 then z=0
    elseif in>0 then z=1
    else z=in./abs(in)
    end
    
    //evaluates the output depending on the type of option choosen
    if (law=='mu/compressor') then
        //evaluates 
        //out = Vlog(1+μ|in|/v)sgn(in)/log(1+μ)
        out=v*log(1+Mu*abs(in)/v)*z/log(1+Mu)
          
    elseif law=='mu/expander' then
        //evaluates
        //out = e^((inlog(1+μ)/V)-1)sgn(in)V/μ
        out=( %e^(abs(in)*log(1+Mu)/v)-1)*v*z/Mu
        
    elseif law=='a/compressor' then
        //evaluates
        //out = A|in|sgn(in)/(1+log(A)) for 0<=|in|<=V/A
        //out = V(1+log(A)|in|/V))sgn(in)/(1+log(A)) for V/A<=|in|<=V
        //A is considered as Mu
        if abs(in)<v/Mu then
            out=Mu*abs(in)*z/(1+log(Mu))
        else
            out=v*z*(1+log(Mu*abs(in)/v))/(1+log(Mu))
        end
        
        //evaluates
        //out = in(1+log(A))sgn(in)/A for 0<=|in|<=V/A
        //out = e^(1+log(A)|in|/V-1))sgn(in)V/A for V/A<=|in|<=V
        //A is considered as Mu
    elseif law=='a/expander' then
        if abs(in)<v/Mu
            out=abs(in)*(1+log(Mu))*z/Mu
        else
            out= %e^(abs(in)*(1+log(Mu))/v-1)*v*z/Mu
        end
    end  
endfunction

//Function when type of operation is not specified
function[out]=compand(in,Mu,v)
    if in<0 then z=-1
    elseif in==0 then z=0
    elseif in>0 then z=1
    else z=in./abs(in)
    end
    //evaluates 
     //out = Vlog(1+μ|in|/v)sgn(in)/log(1+μ)
    out=v*log(1+Mu*abs(in)/v)*z/log(1+Mu)
endfunction

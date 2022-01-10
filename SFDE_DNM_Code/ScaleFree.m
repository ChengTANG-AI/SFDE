% clc;
% clear all;
% close all;

% N = 100;
% M = 3;

function Ba=ScaleFree(N,M)

% Ba.Sec = [];
% Ba.D = [];

for i = 1 : M
   Ba( i ).Sec = [ 1 : i - 1 , i + 1 : M ];
   Ba( i ).Dd = M - 1;
end

T = M * ( M - 1 );

for i = M : N - 1
   for num = 1 : i
      P( num ) = Ba( num ).Dd / T;
   end
   r = rand;
   s = 0;
   for num = 1 : i
      s = s + P( num );
      if r < s
         break;
      end
   end
   Ba( num ).Sec = [ Ba( num ).Sec,i + 1 ];
   Ba( num ).Dd = Ba( num ).Dd + 1;
   Ba( i + 1 ).Sec = [ num ];
   Ba( i + 1 ).Dd = 1;
   T = T + 2;
end
end
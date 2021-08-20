function avg = MovAvgFilter(x)
  %modificada para trabalhar com matriz
  persistent prevAvg n xbuf
  persistent firstRun
  
  if isempty(firstRun)
    n = 10;
    xbuf = (x.*ones(1, n+1));%11x3
    
    k = 1;
    prevAvg = x;
    
    firstRun = 1;
  endif
  
  for m = 1:n
    xbuf(:,m) = xbuf(:,m+1);
    
  end
  
  xbuf(:,n+1) = x;
  avg = prevAvg + (x - xbuf(:,1)) /n;
  
  prevAvg = avg;
  
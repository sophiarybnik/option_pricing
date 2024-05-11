function [F,J] = myfun(x)
  F = f(x);
  if nargout>1
      J = jacob(x, F);
  end
end 
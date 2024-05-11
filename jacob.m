function J = jacob(x, F)
  % Compute Jacobian matrix of function F using the finite difference approximation

  % Output
  % J –  Jacobian of the function evaluated at x (input)

  nrow = length(F);
  ncol = length(x);
  J = zeros(nrow,ncol);

  dx = 0.01; % define space step
  e = eye(ncol);
  
  for k=1:ncol
      ek= e(:,k)';
      fwd = f(x+ dx * ek);
      bkwd = f(x- dx * ek);
      % apply central difference 
      dk = (fwd - bkwd)/(2*dx);
      J(:,k) = dk;
  end
  
end
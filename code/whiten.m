function [white_X] = whiten(X)
  % whiten the matrix X as ICA preprocessing step:
  % by sphering the data the optimization can be restricted to
  % independent rotations
  %
  % Note: assumes X is formed s.t. each row is a component and the columns
  % are observations

  % whiten by singular value decomposition of covariance
  % (scale by inverse square root)
  [U, S, V] = svd(cov(X'));
  M_whiten = V*S^(-0.5)*U';
  white_X = M_whiten*X;
end

% *****************************************************************
% Copyright (c) Erik G. Learned-Miller, 2003.
% *****************************************************************
% RADICAL_2D   Solve the two-dimensional ICA problem.
%
%    Version 1.1. Includes major bug fix and faster entropy estimator.
% 
%    Apr.1, 2004. Major bug fix. Whitening matrix was wrong. Thanks
%      to Sergey Astakhov for spotting this one.
%
%    Mar.28, 2004. Sped up inner loop by about 20% with a better
%      entropy estimator.
%
%    Version 1.0. First release.
%    [Yopt,Wopt] = RADICAL_2D(X) takes a single argument, X,
%    the matrix of mixed components, with one component per
%    row, and finds the best "unmixing matrix" Wopt that it
%    can. Wopt applied to the mixed components X produces the
%    approximately independent components Yopt, with one component
%    per row.
%
%    Since this function solves the two-dimensional ICA problem,
%    both X and Yopt should have 2 rows, and Wopt will be a 
%    2x2 matrix.
%
%    ************************************************************* 
%
%    PARAMETERS: Set these parameters by hand in the next code block.
%
%    K:        The number of angles at which to evaluate the contrast
%              function. The ICA contrast function will be evaluated
%              at K evenly spaced rotations from -Pi/4 to Pi/4. For
%              small data sets (less than a few hundred points), the
%              default value of 150 should work well. For larger data
%              sets, very small benefits may be realized by
%              increasing the value of K, but keep in mind that the
%              algorithm is linear in K.
%
%    AUG_FLAG: This flag is set to 1 by default, which indicates
%              that the data set will be "augmented" as discussed
%              in the paper. If this flag is set to 0, then the
%              data will not be augmented, and the next two 
%              arguments are meaningless. For large data
%              sets with more than 10000 points, this flag should
%              usually be set to 0, as there is usually no need to
%              augment the data in these cases.
%
%    reps:     This is the number of replicated points for each  
%              original point. The default value is 30. The larger
%              the number of points in the data set, the smaller
%              this value can be. For data sets of 10,000 points or
%              more, point replication should be de-activated by setting
%              AUG_FLAG to 0 (see above).               
%
%    stdev:    This is the standard deviation of the replicated points. I
%              can't give too much guidance as to how to set this
%              parameter, but values much larger or smaller than
%              the default don't seem to work very well in the
%              experiments I've done. 

function [Yopt,Wopt]=RADICAL_2D(X)

% The recommended default parameter values are:
% K=150;
% AUG_FLAG=1;
% reps=30;
% stdev=0.175;

% ************************************************************
% User should change parameter values here:
K=150;
AUG_FLAG=1;
reps=30;
stdev=0.175;
% ************************************************************

[D,N]=size(X);
m=floor(sqrt(N));

% ****************
% Whiten the data. Store the whitening operation to combine with
% rotation matrix for total solution.

[u,s,v]=svd(cov(X'));
Whitening_mat=v*s^(-.5)*u';
X_white=Whitening_mat*X;

% If AUG_FLAG is on, we augment the points with reps near copies of each point.

if reps==1 | AUG_FLAG==0
  xAug=X_white;
else
  xAug=randn(D,N*reps)*stdev+repmat(X_white,[1,reps]);
end

% Then we rotate this data to various angles, evaluate the sum of 
% the marginals, and take the min.
for i=1:K
  % Map theta from -pi/4 to pi/4.
  theta= -(i-1)/(K-1)*pi/2-pi/4;
  rot=[cos(theta) -sin(theta); sin(theta) cos(theta)];
  rotPts=rot*xAug;

  for j=1:D
    marginalAtTheta(j)=vasicekm(rotPts(j,:),m);
  end
  ent(i)=sum(marginalAtTheta);
end

[val,ind]=sort(ent);
thetaStar= -(ind(1)-1)/(K-1)*pi/2-pi/4;
rotStar=[cos(thetaStar) -sin(thetaStar); sin(thetaStar) cos(thetaStar)];

Wopt=rotStar*Whitening_mat;
Yopt=Wopt*X;





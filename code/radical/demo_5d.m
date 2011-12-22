% *****************************************************************
% Copyright (c) Erik G. Learned-Miller, 2003.
% ********************************************************
% demo_5d
% ********************************************************
% 
% This code illustrates the use of RADICAL.m
% In the examples directory, you will find the following files:
%
% data_5d_ind   - samples from a 5-d distribution with independent
%                 components. 
% data_5d_mixed - the same samples after they have undergone a
%                 linear transformation, which mixes the components
%                 so that they are no longer independent.
% A_5d          - the mixing matrix.
%
% ********************************************************
% The program plots two-dimensional marginals of the original 
% independent samples, the two-dimensional marginals of the mixed
% samples, and RADICAL_2D's attempt at unmixing the samples.

load examples/data_5d_ind -ASCII
load examples/data_5d_mixed -ASCII
load examples/A_5d -ASCII

[Yopt,Wopt]=RADICAL(data_5d_mixed);
data_5d_unmixed=Yopt;

figure(1);
clf;
for i=1:4
  for j=i+1:5
    subplot(4,4,(j-2)*4+i);
    plot(data_5d_ind(i,:),data_5d_ind(j,:),'.');
    axis tight;
    axis square;
    t=sprintf('dim %d vs. %d',i,j);
    title(t);
  end
end
subplot(4,4,3);
axis off;
title('Original independent components.');

figure(2);
clf;
for i=1:4
  for j=i+1:5
    subplot(4,4,(j-2)*4+i);
    plot(data_5d_mixed(i,:),data_5d_mixed(j,:),'.');
    axis tight;
    axis square;
    t=sprintf('dim %d vs. %d',i,j);
    title(t);
  end
end
subplot(4,4,3);
axis off;
title('Mixed components.');

figure(3);
clf;
for i=1:4
  for j=i+1:5
    subplot(4,4,(j-2)*4+i);
    plot(data_5d_unmixed(i,:),data_5d_unmixed(j,:),'.');
    axis tight;
    axis square;
    t=sprintf('dim %d vs. %d',i,j);
    title(t);
  end
end
subplot(4,4,3);
axis off;
title('Unmixed components.');



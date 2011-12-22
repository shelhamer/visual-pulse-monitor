% *****************************************************************
% Copyright (c) Erik G. Learned-Miller, 2003.
% ********************************************************
% demo_2d
% ********************************************************
% 
% This code illustrates the use of RADICAL_2D.m
% In the examples directory, you will find the following files:
%
% data_2d_ind   - samples from a 2-d distribution with independent
%                 components. 
% data_2d_mixed - the same samples after they have undergone a
%                 linear transformation, which mixes the components
%                 so that they are no longer independent.
% A_2d          - the mixing matrix.
%
% ********************************************************
% The program plots the original independent samples, the mixed
% samples, and RADICAL_2D's attempt at unmixing the samples.

load examples/data_2d_ind -ASCII
load examples/data_2d_mixed -ASCII
load examples/A_2d -ASCII

[Yopt,Wopt]=RADICAL_2D(data_2d_mixed);

figure(1);
clf;
subplot(1,3,1);
plot(data_2d_ind(1,:),data_2d_ind(2,:),'.');
axis tight;
axis square;
title('Original independent components.');
 
subplot(1,3,2);
plot(data_2d_mixed(1,:),data_2d_mixed(2,:),'.');
axis tight;
axis square;
title('Mixed components.');

data_2d_unmixed=Yopt;
subplot(1,3,3);
plot(data_2d_unmixed(1,:),data_2d_unmixed(2,:),'.');
axis tight;
axis square;
title('Unmixed components.');

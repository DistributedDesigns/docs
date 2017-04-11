% We'll use a chi^2 goodness of fit test to verify that the distribution of
% delays from the quote server indeed derives from an exponential
% distribution.
%
% REQUIRES: Statistics and Machine Learning Toolbox

times = importdata('times.csv', ',');

% Remove the network delay to isolate distribution of quoteserver delays
times = floor(times);

% Delays are 0, 1, ..., 4 so use five buckets
hexp = histfit(times, 5, 'exponential');
hexp(1).FaceColor = [.8 .8 1];

expdist = fitdist(times, 'exponential');
disp(sprintf('Using distribution with mu = %0.4f', expdist.mu));

% Check for goodness of fit.
% Want p > 0.05, `chi2stat` small
[~, p, stats] = chi2gof(times, 'CDF', expdist);
disp(sprintf('Found p = %e, chi2stat = %0.4f', p, stats.chi2stat));

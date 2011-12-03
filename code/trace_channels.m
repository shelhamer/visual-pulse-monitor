function [traces] = trace_channels(I)
  % Makes single color measurement for each channel in every every frame,
  % yielding a trace over time of each color channel

  % average pixel values in each channel in every frame
  I_avg = mean(mean(I,1), 2);

  % remove singleton dimensions
  traces = squeeze(I_avg);
end

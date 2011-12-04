function [pass_pows pass_freq] = bandlimit(pows, freq, low, high)
  % select a certain frequency range from the power spectrum of a signal
  low_limit = min(find(freq > low));
  high_limit = max(find(freq < high));

  pass = low_limit:high_limit;
  pass_pows = pows(pass);
  pass_freq = freq(pass);
end

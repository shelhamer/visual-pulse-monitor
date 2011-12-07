function [max_freq, max_pow] = max_power_freq(pows, freq)
  [max_pow idx] = max(pows);
  max_freq = freq(idx);
end
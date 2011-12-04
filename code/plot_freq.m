function plot_freq(FFT, freq)
  % plot one-sided (positive) spectrum without amplitude normalization

  N = length(FFT);
  center_idx = N/2 + 1;
  pos_fft = FFT(center_idx:end);
  pos_freq = freq(center_idx:end);

  plot(pos_freq, abs(pos_fft));
end

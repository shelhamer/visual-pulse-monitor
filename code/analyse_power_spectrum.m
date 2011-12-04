function [pows, freq] = analyse_power_spectrum(X, Fs)
  % calculate the FFT of the signal X, transform to power, and
  % generate frequency range according to the sampling rate Fs

  N = length(X);

  % take FFT and shift it for symmetry
  amp = fftshift(fft(X));

  % make frequency range
  fN = N - mod(N, 2);
  k = -fN/2 : fN/2 - 1;
  T = N / Fs;
  freq = k/T;

  % select the positive domain FFT and range
  zero_idx = N/2 + 1;
  amp = amp(zero_idx:end);
  freq = freq(zero_idx:end);

  % return power spectrum
  pows = abs(amp).^2;
end

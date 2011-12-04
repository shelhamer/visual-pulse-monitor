function [FFT, freq] = analyse_freq(X, Fs)
  % calculate the FFT of the signal X and generate frequency axis
  % according to the sampling rate Fs

  N = length(X);

  % take FFT and shift it for symmetry
  FFT = fftshift(fft(X));

  % make frequency axis
  fN = N - mod(N, 2);
  k = -fN/2 : fN/2 - 1;
  T = N / Fs;
  freq = k/T;
end

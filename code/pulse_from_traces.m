function [pulse] = pulse_from_traces(traces, win_size, overlap)
  % measure pulse from hand-picked frames
  % by signal normalization, independent components analysis,
  % fourier transform, and picking the maximum power frequency
  % within the operation healthy human pulse range [.75, 4] Hz or 45-240 bpm

  PULSE_MIN = .75;
  PULSE_MAX = 4;

  Fs = 15; % sampling rate; video captured at ~15 fps
  WINDOW_SIZE = 30;   % window size in seconds
  OVERLAP     = 29;   % overlap in moving window in seconds

  % default to 30 sec window with 96.7% overlap if no window args given
  if nargin == 1
    win_size = WINDOW_SIZE;
    overlap = OVERLAP;
  end

  % split channel traces into blocks by a moving window,
  % with the blocks normalized for zero mean and unit variance
  trace_blocks = extract_normalized_windows(traces, win_size*Fs, overlap*Fs);
  num_channels = size(traces, 1);
  num_blocks = size(trace_blocks, 3);

  % measure pulse for each time window in each channel
  pulse = zeros([num_channels num_blocks]);
  for idx=1:num_blocks
    this_block = trace_blocks(:,:,idx);
    % progress output
    this_sec = (idx-1)*(win_size - overlap);
    fprintf('Measuring pulse over seconds %d - %d\n', [this_sec+1 this_sec+win_size]);

    % detrend window
    this_block = detrend(this_block')';

    % find independent components by JADE
    B = jade(this_block);
    Y = B*this_block;

    % figure; % signal visualization
    for chn=1:num_channels
      % pick maximum power frequency in each independent component as pulse
      [pows, freq] = analyse_power_spectrum(Y(chn, :), Fs);
      [ppows, pfreq] = bandlimit(pows, freq, PULSE_MIN, PULSE_MAX);
      pulse(chn, idx) = max_power_freq(ppows, pfreq);

      % debugging output & signal visualization
      % fprintf('  BPM for component #%d: %f \n', [chn pulse(chn, idx)*60]);
      % plot_idx = (chn-1)*3 + 1;
      % subplot(3,3,plot_idx);
      % plot(1:length(this_block(chn,:)), this_block(chn,:))
      % subplot(3,3,plot_idx+1);
      % plot(1:length(Y), Y(2,:));
      % subplot(3,3,plot_idx+2);
      % plot_power_spectrum(ppows, pfreq);
    end
  end
end
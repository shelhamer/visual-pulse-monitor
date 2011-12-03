function [windows] = extract_windows(traces, window_len, overlap)
  % Extract moving window from traces according to window length
  % and the desired overlap (both in number of frames)
  %
  % Note: (number of traces - overlap) must be divisible by the window spacing
  % (window length - overlap) to avoid truncation of trailing data

  % FIXME implement as clever vectorization

  % roll out traces into a channels x frames x windows matrix
  num_channels = size(traces, 1);
  win_spacing = window_len - overlap;
  num_windows = floor((length(traces) - overlap) / win_spacing);
  windows = zeros([num_channels window_len num_windows]);
  for win=1:num_windows
    win_start = (win-1)*win_spacing + 1;
    win_end = win_start + window_len - 1;
    windows(:, :, win) = traces(:, win_start:win_end);
  end
end

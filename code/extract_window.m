function [win] = extract_window(traces, win_idx, window_len, overlap)
  % Extract moving window from traces according to window length
  % and the desired overlap (both in number of frames)
  %
  % Note: this extracts one window at a time, given the index of the
  % window to extract

  % roll out traces into a channels x frames x windows matrix
  num_channels = size(traces, 1);
  win_spacing = window_len - overlap;
  win_start = (win_idx-1)*win_spacing + 1;
  win_end = win_start + window_len - 1;
  win = traces(:, win_start:win_end);
end

function [windows] = extract_normalized_windows(traces, window_len, overlap)
  % Extract moving window from traces according to window length
  % and the desired overlap (both in number of frames),
  % then normalize each window to have zero mean and unit variance

  % FIXME implement as clever vectorization

  % roll out traces into a matrix of window rows
  num_channels = size(traces, 1);
  win_spacing = window_len - overlap;
  num_windows = floor((length(traces) - overlap) / win_spacing);
  trace_windows = zeros([window_len num_windows*num_channels]);
  for win=1:num_windows
    win_start = (win-1)*win_spacing + 1;
    win_end = win_start + window_len - 1;
    tr_win_idx = (win-1)*num_channels + 1;
    tr_win_end = tr_win_idx + num_channels - 1;
    trace_windows(:, tr_win_idx:tr_win_end) = traces(:, win_start:win_end)';
  end

  % normalize each trace window to have zero mean and unit variance
  trace_windows = trace_windows - repmat(mean(trace_windows), [window_len 1]);
  trace_windows = trace_windows ./ repmat(std(trace_windows), [window_len 1]);

  % create a channels x frames x windows matrix
  windows = reshape(trace_windows, [window_len num_channels num_windows]);
  windows = permute(windows, [2 1 3]);
end

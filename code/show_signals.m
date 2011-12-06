function show_signals(traces, ics, trace_spect, ic_spect, freq_range)
  % visualize traces, independent components, and indep. comp. power spectrum
  % (restrict display to frequency range)

  figure;
  num_channels = size(traces, 1);
  for chn=1:num_channels
    % show raw trace
    plot_idx = (chn-1)*4 + 1;
    subplot(3,4,plot_idx);
    plot(1:length(traces(chn,:)), traces(chn,:))

    % trace power spectrum
    subplot(3,4,plot_idx+1);
    trace_freqs = trace_spect(chn, 2, :);
    trace_min = min(find(trace_freqs > freq_range(1)));
    trace_max = max(find(trace_freqs < freq_range(2)));
    plot_power_spectrum(trace_spect(chn, 1, trace_min:trace_max), trace_freqs(trace_min:trace_max));

    % independent component
    subplot(3,4,plot_idx+2);
    plot(1:length(ics), ics(chn,:));

    % independent component power spectrum
    subplot(3,4,plot_idx+3);
    ic_freqs = ic_spect(chn, 2, :);
    ic_min = min(find(ic_freqs > freq_range(1)));
    ic_max = max(find(ic_freqs < freq_range(2)));
    plot_power_spectrum(ic_spect(chn, 1, ic_min:ic_max), ic_freqs(ic_min:ic_max));
  end
end

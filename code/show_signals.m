function show_signals(traces, ics, trace_spect, ic_spect)
  % visualize traces, independent components, and indep. comp. power spectrum

  figure;
  num_channels = size(traces, 1);
  for chn=1:num_channels
    % show raw trace
    plot_idx = (chn-1)*4 + 1;
    subplot(3,4,plot_idx);
    plot(1:length(traces(chn,:)), traces(chn,:))

    % trace power spectrum
    subplot(3,4,plot_idx+1);
    plot_power_spectrum(trace_spect(chn, 1, :), trace_spect(chn, 2, :));

    % independent component
    subplot(3,4,plot_idx+2);
    plot(1:length(ics), ics(chn,:));

    % independent component power spectrum
    subplot(3,4,plot_idx+3);
    plot_power_spectrum(ic_spect(chn, 1, :), ic_spect(chn, 2, :));
  end
end
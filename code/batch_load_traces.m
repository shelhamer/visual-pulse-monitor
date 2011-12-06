% extract traces from large video files by batch loading frames,
% deriving traces, and repeating
function [traces, Fs] = batch_load_traces(filename, num_seconds)
  BLOCK_LEN = 200;

  % open video file for frame extraction
  vid = VideoReader(filename);
  Fs = round(vid.FrameRate);

  num_traces = Fs*num_seconds;
  traces = zeros([3 num_traces]);

  fprintf('loading %d frames from %dx%d video recorded at %d fps\n', ...
          [num_traces vid.Width vid.Height Fs]);

  % process each block...
  num_blocks = ceil(Fs*num_seconds / BLOCK_LEN);
  frames = zeros([vid.Height vid.Width 3 BLOCK_LEN], 'uint8');
  for this_block=1:num_blocks
    % extract frames
    num_frames = min(BLOCK_LEN, num_traces - (this_block-1)*BLOCK_LEN);
    frame_start = (this_block-1)*BLOCK_LEN + 1;
    for idx=1:num_frames
      frames(:,:,:,idx) = read(vid, frame_start+idx-1);
    end

    fprintf('processing frames %d-%d\n', [frame_start frame_start+num_frames-1]);

    % extract traces
    traces(:, frame_start:frame_start+num_frames-1) = trace_roi_channels(frames(:,:,:,1:num_frames));
  end
end

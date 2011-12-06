% load frames from video file (simple convenience function)
function [frames] = load_frames(filename, frame_range)
  vid = VideoReader(filename);
  fprintf('loading frames from %dx%d video recorded at %f fps\n', [vid.Width vid.Height vid.FrameRate]);
  if nargin == 1
    frames = read(vid);
  else
    num_frames = frame_range(2)-frame_range(1)+1;
    frames = zeros([vid.Height vid.Width 3 num_frames], 'uint8');
    for idx=1:num_frames
      frames(:,:,:,idx) = read(vid, idx-1+frame_range(1));
    end
  end
end

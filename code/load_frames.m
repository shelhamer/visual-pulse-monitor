% load frames from video file (simple convenience function)
function [frames] = load_frames(filename)
  vid = VideoReader(filename);
  frames = read(vid);
end

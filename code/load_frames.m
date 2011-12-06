% load frames from video file (simple convenience function)
function [frames] = load_frames(filename)
  vid = VideoReader(filename);
  fprintf('loading frames from %dx%d video recorded at %f fps\n', [vid.Width vid.Height vid.FrameRate]);
  frames = read(vid);
end

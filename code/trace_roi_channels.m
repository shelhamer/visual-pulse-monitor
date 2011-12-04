function [traces] = trace_roi_channels(frames)
  % Select the face, the region of interest for pulse measurement, and
  % average each channel to yield a trace over time
  %
  % 1.Detect faces by OpenCV implementation of Viola-Jones classifier
  % 2.Select pixels in face bounding box
  % 3.Retain previous bounding box if no face detected
  % 4.Choose detection closest to previous bounding box if multiple
  %   faces are detected
  %
  % Note: remember to install the face detection mex!

  SCALE = .25; % scale factor for detector input for efficiency

  num_frames = size(frames, 4);

  traces = zeros([size(frames, 3) num_frames]);
  face = zeros([1 4]); % x, y, width, height

  for idx=1:num_frames
    % convert frame to double and greyscale for input to detector
    this_frame = double(imresize(frames(:,:,:,idx), SCALE));
    grey_frame = .3*this_frame(:,:,1) + .59*this_frame(:,:,2) ...
                 + .11*this_frame(:,:,3);

    % detect face region
    faces = FaceDetect('../bin/haarcascade_frontalface_alt2.xml', grey_frame);
    if size(faces, 1) == 1
      % single or no face detected
      if faces > 0
        % single face detected (no face indicated by vector of -1s)
        face = faces;
      end
    else
      % multiple faces detected: pick the closest to previous detection
      dists = sum((faces(:, 1:2) - repmat(face(1:2), [size(faces, 1) 1])).^2, 2);
      [v idx] = min(dists);
      face = faces(idx, :);
    end

    if face > 0
      % record trace for successful detection
      coords = face*(1/SCALE);
      roi = frames(coords(2):coords(2)+coords(4), ...
                   coords(1):coords(1)+coords(3), :, idx);
      traces(:, idx) = mean(mean(roi), 2);
    end
  end
end

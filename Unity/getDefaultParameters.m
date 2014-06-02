function param = getDefaultParameters(initialLocation)
  param.motionModel           = 'ConstantVelocity';
  param.initialLocation       = initialLocation;
  param.initialEstimateError  = 1E5 * ones(1, 2);
  param.motionNoise           = [125, 100];
  param.measurementNoise      = 5;
  param.segmentationThreshold = 0.05;
end

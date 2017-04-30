% Auto-generated by cameraCalibrator app on 29-Dec-2016
%-------------------------------------------------------


% Define images to process
imageFileNames = {'E:\MyResearch\Thesis\calibration\Thu Dec 29 20-42-19.bmp',...
    'E:\MyResearch\Thesis\calibration\Thu Dec 29 20-44-33.bmp',...
    'E:\MyResearch\Thesis\calibration\Thu Dec 29 20-49-24.bmp',...
    'E:\MyResearch\Thesis\calibration\Thu Dec 29 20-51-24.bmp',...
    'E:\MyResearch\Thesis\calibration\Thu Dec 29 20-53-05.bmp',...
    'E:\MyResearch\Thesis\calibration\Thu Dec 29 20-53-21.bmp',...
    'E:\MyResearch\Thesis\calibration\Thu Dec 29 20-53-28.bmp',...
    'E:\MyResearch\Thesis\calibration\Thu Dec 29 20-53-47.bmp',...
    'E:\MyResearch\Thesis\calibration\Thu Dec 29 20-54-48.bmp',...
    'E:\MyResearch\Thesis\calibration\Thu Dec 29 21-39-19.bmp',...
    'E:\MyResearch\Thesis\calibration\Thu Dec 29 21-40-45.bmp',...
    };

% Detect checkerboards in images
[imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints(imageFileNames);
imageFileNames = imageFileNames(imagesUsed);

% Generate world coordinates of the corners of the squares
squareSize = 2.150000e+01;  % in units of 'mm'
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

% Calibrate the camera
[cameraParams, imagesUsed, estimationErrors] = estimateCameraParameters(imagePoints, worldPoints, ...
    'EstimateSkew', true, 'EstimateTangentialDistortion', true, ...
    'NumRadialDistortionCoefficients', 2, 'WorldUnits', 'mm', ...
    'InitialIntrinsicMatrix', [], 'InitialRadialDistortion', []);

% View reprojection errors
h1=figure; showReprojectionErrors(cameraParams, 'PatternCentric');

% Visualize pattern locations
h2=figure; showExtrinsics(cameraParams, 'CameraCentric');

% Display parameter estimation errors
displayErrors(estimationErrors, cameraParams);

% For example, you can use the calibration data to remove effects of lens distortion.
originalImage = imread(imageFileNames{1});
undistortedImage = undistortImage(originalImage, cameraParams);

% See additional examples of how to use the calibration data.  At the prompt type:
% showdemo('MeasuringPlanarObjectsExample')
% showdemo('StructureFromMotionExample')

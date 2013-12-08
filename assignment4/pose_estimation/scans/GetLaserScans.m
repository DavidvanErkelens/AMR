function dist = GetLaserScans(N)


%   GetLaserScans()
%
%   Author: Xavier Perrin - xavier.perrin@mavt.ethz.ch
%   Based on the work of Davide Scaramuzza - davide.scaramuzza@ieee.org
%   ETH Zurich - Mai, 4, 2007

% -------------------------------------------------------------------------
% MOST IMPORTANT PARAMETERS
% -------------------------------------------------------------------------

alpha = 140;%         Radial distortion coefficient
height = 0.21;%     camera height in meters

%% ------Old values ------
%alpha = 112;%         Radial distortion coefficient:  Robot ASL2: 112, other: 107
%         (it depends on the lens used... !)
%height = 0.17;%       camera height in meters
%% ---------------------------

BWthreshold = 130; %   Threshold for segment the image into Black & white colors
angstep = 360/N;%         Angular step of the beam in degrees
axislimit = 0.8;%     Axis limit

%global vid
global center Rmax Rmin
center = [545; 402];
Rmin = 115;
Rmax = 170;

%file = ['../dataset/picture1', '.jpg'];
global file;
snapshottmp = imread(file);

snapshot = imflipud( snapshottmp );%   Flip the image Up-Down

[undistortedimg, theta] = imunwrap( snapshot , center, angstep, Rmax, Rmin);% Transform omnidirectional image into a rectangular image

BWimg = img2bw( undistortedimg , BWthreshold ); % Binarize rectangular image into Blak&White

rho = getpixeldistance( BWimg , Rmin ); %Get radial distance (this distance is still affected by radial distortion)

figure(3); imagesc(snapshot); hold on; drawlaserbeam( center, theta, rho ); %pause;

dist = undistort_dist_points( theta , rho , alpha , height );

% figure(2); draw_undisdtorted_beam( dist , theta , axislimit ); drawnow;

%  c = img2bw( grayimg , BWthreshold ); figure(3); imagesc(c); colormap(gray); drawnow;

% stop(vid);


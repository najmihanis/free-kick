function hit = ball_hits_defender(X, Y, Z, time)
% BALL_HITS_DEFENDER checks if a ball at a given position intersects with any of the defenders
%
% This function determines if a ball at the specified position (X, Y, Z) at a
% given time intersects with any of the defenders' ellipsoids. The defender
% ellipsoids can be adjusted for tolerance using the tolerance_factor.
%
% Inputs:
%   X: the X coordinate of the ball's position (meters)
%   Y: the Y coordinate of the ball's position (meters)
%   Z: the Z coordinate of the ball's position (meters)
%   time: the current time in the simulation (seconds)
%
% Output:
%   hit: a boolean value indicating whether the ball intersects any defender's ellipsoid
%        (true if it intersects, false otherwise)
%
% Usage:
%   hit = ball_hits_defender(X, Y, Z, time);
%
% Note: The function requires the 'defender' function to calculate the defenders'
% ellipsoids based on the given time.

hit = false;
tolerance_factor = 0.5; % Adjust this value to control the tolerance

for defender_num = 1:5
    [Dx, Dy, Dz] = defender(defender_num, time);

    % Get the ellipsoid parameters from the defender function
    XC = mean(Dx(:));
    YC = mean(Dy(:));
    ZC = mean(Dz(:));
    XR = (max(Dx(:)) - min(Dx(:))) / 2 * tolerance_factor;
    YR = (max(Dy(:)) - min(Dy(:))) / 2 * tolerance_factor;
    ZR = (max(Dz(:)) - min(Dz(:))) / 2 * tolerance_factor;

    % Check if the ball intersects the defender's ellipsoid
    if (((X - XC)^2 / XR^2) + ((Y - YC)^2 / YR^2) + ((Z - ZC)^2 / ZR^2)) <= 1
        hit = true;
        break;
    end
end
end


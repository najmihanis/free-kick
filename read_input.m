function [X0,Y0,Z0,Umag0,theta,phi,omgX,omgY,omgZ] = read_input(file_name,kID)
% READ_INPUT extracts input parameters for a soccer ball's initial conditions
% from a text file based on the provided kick ID.
%
% This function reads input parameters from a text file and returns the initial
% conditions for a soccer ball's trajectory based on the provided kick ID.
%
% Inputs:
%   file_name: the name of the text file containing the input parameters
%   kID: the kick ID, an integer identifying the specific set of parameters to extract
%
% Outputs:
%   X0, Y0, Z0: initial position of the ball (meters)
%   Umag0: initial speed of the ball (m/s)
%   theta: angle between the horizontal plane and the velocity vector in the X-Y plane (degrees)
%   phi: angle between the vertical plane and the velocity vector in the X-Z plane (degrees)
%   omgX, omgY, omgZ: initial angular velocities of the ball in the X, Y, and Z directions (rad/s)
%
% Usage:
%   [X0,Y0,Z0,Umag0,theta,phi,omgX,omgY,omgZ] = read_input(file_name, kID);
%
% Note: The text file should be formatted with one row per kick ID and columns
% for the kick ID, initial position (X0, Y0, Z0), initial speed (Umag0), angles
% (theta, phi), and initial angular velocities (omgX, omgY, omgZ).

param = importdata(file_name,' ',5);

if any(kID==param.data(:,1))
    X0=param.data(kID,2);
    Y0=param.data(kID,3);
    Z0=param.data(kID,4);
    Umag0=param.data(kID,5);
    theta=param.data(kID,6);
    phi=param.data(kID,7);
    omgX=param.data(kID,8);
    omgY=param.data(kID,9);
    omgZ=param.data(kID,10);
else
    disp('Error: Invalid Kick ID');
    X0=NaN;
    Y0=NaN;
    Z0=NaN;
    Umag0=NaN;
    theta=NaN;
    phi=NaN;
    omgX=NaN;
    omgY=NaN;
    omgZ=NaN;
end

end
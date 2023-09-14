function is_goal = ball_in_goal(X, Y, Z)
% BALL_IN_GOAL checks if a ball at a given position is inside the goal
%
% This function determines if a ball at the specified position (X, Y, Z) is
% inside the goal area defined in the 'goal.mat' file.
%
% Inputs:
%   X: the X coordinate of the ball's position (meters)
%   Y: the Y coordinate of the ball's position (meters)
%   Z: the Z coordinate of the ball's position (meters)
%
% Output:
%   is_goal: a boolean value indicating whether the ball is inside the goal area
%            (true if it is inside, false otherwise)
%
% Usage:
%   is_goal = ball_in_goal(X, Y, Z);
%
% Note: The function requires the 'goal.mat' file to define the goal area.

goal = load('goal.mat');

    if X > min(goal.goal.Xnet) && X < max(goal.goal.Xnet) && ...
       Y > min(goal.goal.Ynet) && Y < max(goal.goal.Ynet) && ...
       Z > min(goal.goal.Znet) && Z < max(goal.goal.Znet)
        is_goal = true;
    else
        is_goal = false;
    end
end
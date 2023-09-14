function [T,X,Y,Z,U,V,W] = soccer(X0,Y0,Z0,Umag0,theta,phi,omgX,omgY,omgZ)
% SOCCER calculates the trajectory of a soccer ball using the Euler-Cromer method.
%
% This function computes the trajectory of a soccer ball in 3D space using
% the given initial conditions and parameters. The calculations are based on
% the Euler-Cromer method for solving differential equations.
%
% Inputs:
%   X0, Y0, Z0: initial position of the ball (meters)
%   Umag0: initial speed of the ball (m/s)
%   theta: angle between the horizontal plane and the velocity vector in the X-Y plane (degrees)
%   phi: angle between the vertical plane and the velocity vector in the X-Z plane (degrees)
%   omgX, omgY, omgZ: initial angular velocities of the ball in the X, Y, and Z directions (rad/s)
%
% Outputs:
%   T: time vector (seconds)
%   X, Y, Z: position vectors of the ball in the X, Y, and Z directions (meters)
%   U, V, W: velocity vectors of the ball in the X, Y, and Z directions (m/s)
%
% Usage:
%   [T,X,Y,Z,U,V,W] = soccer(X0,Y0,Z0,Umag0,theta,phi,omgX,omgY,omgZ);
%
% Note: This function requires the 'field.mat', 'goal.mat' files, and the
% 'ball_hits_defender' function to be available in the MATLAB path.

field = load('field.mat');
goal = load('goal.mat');

g=9.81;
m=0.4;
r=0.11;
A=pi*r^2;
rho=1.2;
Cd=0.3;
Cm=0.6;
U0=Umag0*cosd(theta)*sind(phi);
V0=Umag0*sind(theta)*sind(phi);
W0=Umag0*cosd(phi);

n=1;
T(n)=0;
X(n)=X0;
Y(n)=Y0;
Z(n)=Z0;
U(n)=U0;
V(n)=V0;
W(n)=W0;
dt=1/100;
hit=false;

 while Z(n)>=0 && (X(n)>min(field.field.X) && X(n)<max(field.field.X) && Y(n)>min(field.field.Y) && Y(n)<max(field.field.Y)...
     || (X(n)>min(goal.goal.Xnet) && X(n)<max(goal.goal.Xnet)&& Y(n)>min(goal.goal.Ynet) && Y(n)<max(goal.goal.Ynet)...
     && Z(n)>min(goal.goal.Znet) && Z(n)<max(goal.goal.Znet))) ...
     && hit==false 
    
     hit = ball_hits_defender(X(n),Y(n),Z(n),T(n));
     
    Vmagn=sqrt(U(n)^2+V(n)^2+W(n)^2);
    Fun = 0.5*Cd*rho*(A/m)*U(n)*Vmagn - 0.5*Cm*rho*r*(A/m)*(omgY*W(n)-omgZ*V(n));
    Fvn = 0.5*Cd*rho*(A/m)*V(n)*Vmagn - 0.5*Cm*rho*r*(A/m)*(omgZ*U(n)-omgX*W(n));
    Fwn = 0.5*Cd*rho*(A/m)*W(n)*Vmagn - 0.5*Cm*rho*r*(A/m)*(omgX*V(n)-omgY*U(n))+g;

    U(n+1)=U(n)-Fun*dt;
    V(n+1)=V(n)-Fvn*dt;
    W(n+1)=W(n)-Fwn*dt;

    X(n+1)=X(n)+U(n+1)*dt;
    Y(n+1)=Y(n)+V(n+1)*dt;
    Z(n+1)=Z(n)+W(n+1)*dt;
    %disp(Z(n+1));
    T(n+1)=T(n)+dt;
    n=n+1;

    
end


U=U(1:n);
V=V(1:n);
W=W(1:n);
X=X(1:n);
Y=Y(1:n);
Z=Z(1:n);
T=T(1:n);



end
clear; close all; clc;

% Load geometry files
load('field.mat');
load('goal.mat');

figure('unit','in','position',[1 2 14 5]);  % create figure window with specific size
hold on;

defender_color = 'bgmcr';
time = 0;  % time to render the surface of the defenders

% Render defenders' surface
for nd = 1:5
    [Dx,Dy,Dz] = defender(nd,time);
    surf(Dx,Dy,Dz,'FaceColor',defender_color(nd), 'EdgeColor','none'); 
end

plot3(field.X,field.Y,field.Z,'go','MarkerSize',2); % plot field
plot3(goal.Xpost,goal.Ypost,goal.Zpost,'k-','LineWidth',3); % plot goal post
plot3(goal.Xnet,goal.Ynet,goal.Znet,'co','MarkerSize',2); % plot goal net

title('Simulation Layout');
view(-20,45);  % control 3D view 
box on; grid on;
axis([-50 50 0 70 0 10]);   % axis control
xlabel('x (m)'); ylabel('y (m)'); zlabel('z (m)');
set(gca,'Position',[0.1 0.12 0.85 .7]);
set(gca,'FontSize',14);

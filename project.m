clear all;
close all;
clc;
format long;

name = 'Najmi Mohammad Hanis';
hw_num = 'project';

%% data
g=9.81;
m=0.4;

%% TASK 1 (WORKS!)
result1 = cell(7,7);
for kID = 1:7
    [X0(kID),Y0(kID),Z0(kID),Umag0(kID),theta(kID),phi(kID),omgX(kID),omgY(kID),omgZ(kID)] = read_input('MohammadHanisNajmi_input_parameter.txt',kID);
    [T,X,Y,Z,U,V,W] = soccer(X0(kID),Y0(kID),Z0(kID),Umag0(kID),theta(kID),phi(kID),omgX(kID),omgY(kID),omgZ(kID));
    
    result1{1,kID}=T;
    result1{2,kID}=X;
    result1{3,kID}=Y;
    result1{4,kID}=Z;
    result1{5,kID}=U;
    result1{6,kID}=V;
    result1{7,kID}=W;

end

load('field.mat');
load('goal.mat');


figure('unit','in','position',[1 2 14 5]);  % create figure window with specific size
hold on;

defender_color = 'bgmcr';
time = result1{1,1}(end);

% Render defenders' surface
for nd = 1:5
    [Dx,Dy,Dz] = defender(nd,time);
    surf(Dx,Dy,Dz,'FaceColor',defender_color(nd), 'EdgeColor','none'); 
end

plot3(field.X,field.Y,field.Z,'go','MarkerSize',2); % plot field
plot3(goal.Xpost,goal.Ypost,goal.Zpost,'k-','LineWidth',3); % plot goal post
plot3(goal.Xnet,goal.Ynet,goal.Znet,'co','MarkerSize',2); % plot goal net

color = 'krgbcym';
for kID = 1:7

    plot3(result1{2,kID},result1{3,kID},result1{4,kID},color(kID),'LineWidth',2);
    hold on;
    plot3(result1{2,kID}(end),result1{3,kID}(end),result1{4,kID}(end),[color(kID) 's'],'MarkerSize',5,'MarkerFaceColor', color(kID),'LineWidth',2);

end




title('Task 1');
view(-20,45);  % control 3D view 
box on; grid on;
axis([-50 50 0 70 0 10]);   % axis control
xlabel('x (m)'); ylabel('y (m)'); zlabel('z (m)');
set(gca,'Position',[0.1 0.12 0.85 .7]);
set(gca,'FontSize',14);

%% TASK 2A (WORKS!)

hit_cases = false(1, 6);
result2 = cell(7,6);
KEPE = cell(2,6);
maxh = zeros(1,6);
traveld = zeros(1,6);

% Iterate through all 6 input cases
for kID = 8:13
    [X02,Y02,Z02,Umag02,theta2,phi2,omgX2,omgY2,omgZ2] = read_input('MohammadHanisNajmi_input_parameter.txt',kID);
    [T2,X2,Y2,Z2,U2,V2,W2] = soccer(X02,Y02,Z02,Umag02,theta2,phi2,omgX2,omgY2,omgZ2);
    Vmag=sqrt(U2.^2+V2.^2+W2.^2);

    result2{1,kID-7}=T2;
    result2{2,kID-7}=X2;
    result2{3,kID-7}=Y2;
    result2{4,kID-7}=Z2;
    result2{5,kID-7}=U2;
    result2{6,kID-7}=V2;
    result2{7,kID-7}=W2;

    KE=0.5*m*Vmag.^2;
    PE=m*g*Z2;

    KEPE{1,kID-7}=KE;
    KEPE{2,kID-7}=PE;

    maxh(1,kID-7) = max(result2{4,kID-7});

    % Compute the Euclidean distance between consecutive points
    distances = sqrt(diff(X2).^2 + diff(Y2).^2 + diff(Z2).^2);

    % Compute the total travel distance
    traveld(1,kID-7) = sum(distances);

    % Initialize a flag to indicate if the ball hits a defender for the current case
    hit = false;

    % Iterate through the time vector
    for i = 1:length(T2)
        % Get the ball position and time for the current time step
        time = T2(i);
        xpos = X2(i);
        ypos = Y2(i);
        zpos = Z2(i);

        % Call the ball_hits_defender function to check if the ball hits a defender
        if ball_hits_defender(xpos, ypos, zpos, time)
            hit = true;
            break; % Exit the inner loop as we found a time where the ball hits a defender for the current case
        end
    end

    % Store the result for the current case
    hit_cases(kID-7) = hit;

end

% Find the indices of cases where the ball hits a defender
hit_indices = find(hit_cases);

time2_def = result2{1,hit_indices};

figure('unit','in','position',[1 2 14 5]);  % create figure window with specific size
hold on;

defender_color = 'bgmcr';
time2 = time2_def(end);

% Render defenders' surface
for nd = 1:5
    [Dx,Dy,Dz] = defender(nd,time2);
    surf(Dx,Dy,Dz,'FaceColor',defender_color(nd), 'EdgeColor','none'); 
end

plot3(field.X,field.Y,field.Z,'go','MarkerSize',2); % plot field
plot3(goal.Xpost,goal.Ypost,goal.Zpost,'k-','LineWidth',3); % plot goal post
plot3(goal.Xnet,goal.Ynet,goal.Znet,'co','MarkerSize',2); % plot goal net

color2 = 'rbkcym';
for cases = 1:6

    plot3(result2{2,cases},result2{3,cases},result2{4,cases},color2(cases),'LineWidth',2);
    hold on;
    plot3(result2{2,cases}(end),result2{3,cases}(end),result2{4,cases}(end),[color2(cases) 's'],'MarkerSize',5,'MarkerFaceColor', color2(cases),'LineWidth',2);

end

title('Task 2A');
view(-20,45);  % control 3D view 
box on; grid on;
axis([-50 50 0 70 0 10]);   % axis control
xlabel('x (m)'); ylabel('y (m)'); zlabel('z (m)');
set(gca,'Position',[0.1 0.12 0.85 .7]);
set(gca,'FontSize',14);

%% TASK 2B - plot KEPE (WORKS!)

figure(3);
for kID = 1:6
    subplot(2,3,kID); hold on;
    plot(result2{1,kID},KEPE{1,kID},[color2(kID) '-'], 'LineWidth', 2);
    plot(result2{1,kID},KEPE{2,kID},[color2(kID) '--'], 'LineWidth', 2);

    xlabel('Time (s)');
    ylabel('Energy (J)');
    box on; grid on;
    set(gca,'FontSize',14);

    if kID == 2
        title('Kinetic and Potential Energy against Time');
    end

    if kID == 4
        legend('KE','PE','Location','southwest');
    end

end

%% TASK 2C (WORKS!)

maxh_idx = zeros(1,6);
maxh_pos = cell(1,6);
final_loc = cell(1,6);

for i=1:6
    maxh_idx(1,i)=find(result2{4,i}==maxh(i));
end

% making collection of max height coordinates & collection of final location coordinate
for i=1:6 
    maxh_pos{1,i}=[result2{2,i}(maxh_idx(i)),result2{3,i}(maxh_idx(i)),result2{4,i}(maxh_idx(i))] ;
    final_loc{1,i}=[result2{2,i}(end),result2{3,i}(end),result2{4,i}(end)];
end

for i=1:6
    sim_res(i).kick_ID=i+7;
    sim_res(i).final_time= result2{1,i}(end);
    sim_res(i).max_height_location= maxh_pos{1,i};
    sim_res(i).final_location= final_loc{1,i};
    sim_res(i).travel_distance=traveld(i);
end

%% TASK 2D (WORKS!)

fid = fopen('report.txt','w');
fprintf(fid,'Najmi Mohammad Hanis \nA17406147 \nkick_ID, final_time (s), travel_distance (m)\n');
for n=1:6
    fprintf(fid,'%d    %15.9e    %15.9e\n',n+7,sim_res(n).final_time,sim_res(n).travel_distance);
end
fclose(fid);

%% TASK 3

goal_case = 0;

stop_checking = false;

% Iterate through input cases 14 to 100
for case3_idx = 14:100
    [X03,Y03,Z03,Umag03,theta3,phi3,omgX3,omgY3,omgZ3] = read_input('MohammadHanisNajmi_input_parameter.txt',case3_idx);
    [T3,X3,Y3,Z3,U3,V3,W3] = soccer(X03,Y03,Z03,Umag03,theta3,phi3,omgX3,omgY3,omgZ3);

    % Iterate through the time vector
    for i = 1:length(T3)
        % Get the ball position for the current time step
        xpos = X3(i);
        ypos = Y3(i);
        zpos = Z3(i);

        % Call the ball_in_goal function to check if the ball is inside the goal
        if ball_in_goal(xpos, ypos, zpos)
            goal_case = case3_idx;
            stop_checking = true;
            break; % Exit the inner loop as we found a time where the ball scores a goal for the current case
        end
    end
    if stop_checking
        break;
    end
end



figure('unit','in','position',[1 2 14 5]);  % create figure window with specific size
hold on;

defender_color = 'bgmcr';
time = T3(end);  % time to render the surface of the defenders

% Render defenders' surface
for nd = 1:5
    [Dx,Dy,Dz] = defender(nd,time);
    surf(Dx,Dy,Dz,'FaceColor',defender_color(nd), 'EdgeColor','none'); 
end

plot3(field.X,field.Y,field.Z,'go','MarkerSize',2); % plot field
plot3(goal.Xpost,goal.Ypost,goal.Zpost,'k-','LineWidth',3); % plot goal post
plot3(goal.Xnet,goal.Ynet,goal.Znet,'co','MarkerSize',2); % plot goal net
plot3(X3,Y3,Z3,'b-','LineWidth',2);
plot3(X3(end), Y3(end), Z3(end), 'bs', 'MarkerSize', 8, 'MarkerFaceColor', 'b');

title('Kick ID',goal_case);
view(-20,45);  % control 3D view 
box on; grid on;
axis([-50 50 0 70 0 10]);   % axis control
xlabel('x (m)'); ylabel('y (m)'); zlabel('z (m)');
set(gca,'Position',[0.1 0.12 0.85 .7]);
set(gca,'FontSize',14); 

%%

p1a = evalc('help read_input');
p1b = evalc('help soccer');
p1c = 'See figure 1';
p2a = 'See figure 2';
p2b = 'See figure 3';
p2c = sim_res(1);
p2d = sim_res(2);
p2e = sim_res(3);
p2f = sim_res(4);
p2g = sim_res(5);
p2h = sim_res(6);
p2i = evalc('type report.txt');
p3a = 'See figure 4';


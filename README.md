# Simulation of Magnus Effect in a Soccer Game

## Introduction
This repository contains a MATLAB project that simulates the motion of a soccer ball during a free kick. The analysis focuses on the influence of gravitational, frictional drag, and Magnus forces on the ball's trajectory. The Magnus force, resulting from the spinning motion of the ball, causes its trajectory to bend. The primary objectives are to:

1. Analyze the ball's trajectories for different sets of forces and initial conditions.
2. Simulate numerous free kicks using the provided parameters.
3. Observe and analyze the ball's behavior when there are defenders and a goalkeeper on the field.
For a more in-depth understanding of the project's objective, equations, and methodology, users are advised to refer to the **project_description.pdf** attached in this repository.

## Approach
The project uses the Euler-Cromer method to derive algebraic equations that describe the ball's trajectory over time. Using these equations, various trajectories of the ball are obtained for different initial conditions.

## Key MATLAB Files:
1. **soccer.m**: Solves the derived equations to obtain the ball's trajectory for a given set of parameters.
2. **read_input.m**: Reads parameters stored in **MohammadHanisNajmi_input_parameter.txt**.
3. **project.m**: Executes the simulation and generates key outputs including figures and a report.
4. **ball_hits_defender.m**: A custom function that checks if a ball at a given position intersects with any of the defenders.
5. **ball_in_goal**: A custom function that checks if a ball at a given position is inside the goal.

## Tasks Performed:
- **Task 1**: Simulating kicks ID #1 through 7 and analyzing the effect of rotation ω<sub>z</sub> on the ball's trajectory.
- **Task 2**: Simulating kicks ID #8 through 13 and analyzing the ball's kinetic and potential energy over time. This task also involves generating a report (**report.txt**) that contains key simulation results.
- **Task 3**: Identifying a successful goal kick between ID #14 through 100.

The main script (**project.m**) contains specific evaluation commands at the end and follows the given homework solution template.

## Usage
1. Clone the repository.
2. Ensure all required files like **field.mat**, **goal.mat**, **defender.m**, and **MohammadHanisNajmi_input_parameter.txt** are present in the directory.
3. Run the **project.m** script in MATLAB.

% Distance between parallel plates 
d = 10e-2;

% Potential of plate
boundary_voltage_high = 100.0;

% Potential of grounded plate
ground = 0.0;

% Number of Points in consideration
num_of_points = 25;  

% Number of Random Walks for Monte Carlo simulation
num_random_walks = 400;  

function V = monte_carlo(X,Y,d,num_of_points,boundary_voltage_high,ground,num_random_walks)
	n = size(X)(2);
	dx = d/num_of_points
	V=[];
	for i = 1:n
		disp(i)
		pot = 0;
		for j = 1:num_random_walks
			x = X(i);
			y = Y(i);

			while true
				if x <= 0 || x>=d || y<=0 || y>=d
					break;
				end
				r = randi(4);
				if r == 1
					x+= dx;
				elseif r==2
					x-= dx;
				elseif r==3
					y+= dx;
				else
					y-= dx;
				end
			end
			v = ground;
			if x >= d
				v = boundary_voltage_high;
			end

			pot+= v / num_random_walks;
		end

		V = [V,pot];
	end

end

[X,Y] = meshgrid(linspace(0,d,num_of_points),linspace(0,d,num_of_points));

V = monte_carlo(reshape(X,1,[]),reshape(Y,1,[]),d,num_of_points,boundary_voltage_high,ground,num_random_walks);
V = reshape(V,[],num_of_points);

figure(1);
surf(X,Y,V);
colormap(jet);
xlabel('distance (m)')
ylabel('length (m)')
zlabel('Potential (V)')

figure(2);
E = gradient(V)
surf(X,Y,E);
colormap(jet);
xlabel('distance (m)')
ylabel('length (m)')
zlabel('Electric Field (V/m)')
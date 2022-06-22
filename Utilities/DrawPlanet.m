function planet = DrawPlanet(axes, obj, pos,isSaturn)
hold(axes,'on')
[I, map] = imread(obj.TextureFile);
[X, Y, Z] = sphere(1024);
r = obj.radius; % equatorial radius
r2 = obj.polarRadius; % polar radius
X = X * r + pos(1);
Y = Y * r + pos(2);
Z = Z * r2 + pos(3);
props.FaceColor = 'texture';
props.EdgeColor = 'none';
props.Cdata = flipud(I); 
planet = surface(axes, X, Y, Z, props);
colormap(axes, map);
lighting(axes, 'gouraud')
view(axes, 3);
axis(axes,'vis3d','equal')
% set(axes, 'XColor', 'none', 'YColor', 'none', 'ZColor', 'none', 'Color', '#01021a')
if isSaturn


    cdata_rings = imread('saturnrings.png');
    n = size(cdata_rings, 2);

    % preallocates array to store colors
    colors = zeros(n, 3);

    % extracts rgb values from image data
    for i = 1:n
        colors(i, :) = cdata_rings(1, i, :);
    end

    n_new = 200;
    colors = colors(1:round(n/n_new):n, :);

    % scales colors to between 0 and 1 (currently between 0 and 255)
    colors = colors / 255;

    % plots the rings
    theta = 0:0.001:2 * pi;
    for i = 1:n_new
        
        r = (obj.radius + 7000 + ((80000 - 7000) / n_new) * i);

        % x, y, and z coordinates of Saturns rings in equatorial plane
        x_ring = pos(1) + r * cos(theta);
        y_ring = pos(2) + r * sin(theta);
        z_ring = pos(3) * ones(size(theta));

        % plots the jth ring
        plot3(axes, x_ring, y_ring, z_ring, 'Color', colors(i, :));

    end
end

end
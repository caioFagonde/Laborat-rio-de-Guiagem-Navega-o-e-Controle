function Rx = Rx_Matrix(ang)
% Rotation matrix around x axis
Rx = [1, 0, 0;
    0, cos(ang), sin(ang);
    0, -sin(ang), cos(ang)];

end
function [Crys3D, lx, ly, lz, a, b, c, dz] = Mo001Crystal(na, nb, nc, ncu, sigma)
CrysPar.na = na;
CrysPar.nb = nb;
CrysPar.nc = nc;
a = 3.1470; 
b = 3.1470; 
c = 3.1470;
CrysPar.a = a;
CrysPar.b = b;
CrysPar.c = c;
CrysPar.nuLayer = 2;
% x y z Z sigma occupancy
CrysPar.uLayer(1).atoms = [42, 0.0, 0.0, 0.0, sigma, 1];
CrysPar.uLayer(2).atoms = [42, 0.5, 0.5, 0.5, sigma, 1];
Crys3D = get_crystal_by_layers(CrysPar);

dz = CrysPar.c/ncu;
lx = na*CrysPar.a; ly = nb*CrysPar.b; lz = nc*CrysPar.c;
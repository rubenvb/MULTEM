/*
 * This file is part of MULTEM.
 * Copyright 2015 Ivan Lobato <Ivanlh20@gmail.com>
 *
 * MULTEM is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * MULTEM is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with MULTEM. If not, see <http://www.gnu.org/licenses/>.
 */

#include "types.hpp"
#include "atom_data.hpp"
#include "crystal.hpp"

#include <mex.h>
#include "matlab2cpp.hpp"

using multem::m_matrix_r;

/*******************Matlab to layer unit cell*********************/
void read_input_data(const mxArray *mxCrystal, int &na, int &nb, int &nc, double &a, double &b, double &c, multem::Vector<multem::Atom_Data<double>, multem::e_Host> &uLayer)
{
	na = mx_get_scalar_field<int>(mxCrystal, "na"); 
	nb = mx_get_scalar_field<int>(mxCrystal, "nb");
	nc = mx_get_scalar_field<int>(mxCrystal, "nc"); 

	a = mx_get_scalar_field<double>(mxCrystal, "a");
	b = mx_get_scalar_field<double>(mxCrystal, "b"); 
	c = mx_get_scalar_field<double>(mxCrystal, "c");

	auto nuLayer = mx_get_scalar_field<int>(mxCrystal, "nuLayer");

	mxArray *mexuLayer; 
	mexuLayer = mxGetField(mxCrystal, 0, "uLayer");
	
	uLayer.resize(nuLayer);
	for(auto i=0; i < uLayer.size(); i++)
	{
		auto atoms = mx_get_matrix_field<m_matrix_r>(mexuLayer, i, "atoms");
		uLayer[i].set_Atoms(atoms.rows, atoms.real, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0);
	}
}

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
	int na, nb, nc;
	double a, b, c;
	multem::Vector<multem::Atom_Data<double>, multem::e_Host> uLayer;
	multem::Atom_Data<double> atoms;
	multem::Crystal<double> crystal;

	read_input_data(prhs[0], na, nb, nc, a, b, c, uLayer);

	crystal.Create3DCrystal(na, nb, nc, a, b, c, uLayer, atoms);

	auto atomsM = mx_create_matrix<m_matrix_r>(atoms.size(), 6, plhs[0]);

	for(auto i=0; i<atomsM.rows; i++)
	{		
		atomsM.real[0*atomsM.rows + i] = atoms.Z[i]; 		// Atomic number
		atomsM.real[1*atomsM.rows + i] = atoms.x[i]; 		// x-position
		atomsM.real[2*atomsM.rows + i] = atoms.y[i]; 		// y-position
		atomsM.real[3*atomsM.rows + i] = atoms.z[i]; 		// z-position
		atomsM.real[4*atomsM.rows + i] = atoms.sigma[i]; 	// Standard deviation
		atomsM.real[5*atomsM.rows + i] = atoms.occ[i]; 		// Occupancy
	}
}
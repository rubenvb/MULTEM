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

#include "host_functions.hpp"

#include <mex.h>
#include "matlab2cpp.hpp"

using multem::m_matrix_r;

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[ ]) 
{
	int shift;
	m_matrix_r fI, radius;
 
	fI = mx_get_matrix<m_matrix_r>(prhs[0]);
	shift = mx_get_scalar<int>(prhs[1]);

	radius = mx_create_scalar<m_matrix_r>(plhs[0]);

	*(radius.real) = multem::FFT_information_limit_2D(fI.rows, fI.cols, shift, fI.real);
}
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

#include <algorithm>
#include "types.hpp"
#include "quadrature.hpp"

#include <mex.h>
#include "matlab2cpp.hpp"
	
using multem::m_matrix_r;

void mexFunction(int nlhs,mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
	int q_type, nq;

	q_type = mx_get_scalar<int>(prhs[0]);
	nq = mx_get_scalar<int>(prhs[1]);

	/*****************************************************************************/
	multem::Q1<double, multem::e_Host> q;
	multem::Quadrature quadrature;
	quadrature.get(q_type, nq, q);

	m_matrix_r x = mx_create_matrix<m_matrix_r>(nq, 1, plhs[0]);
	m_matrix_r w = mx_create_matrix<m_matrix_r>(nq, 1, plhs[1]);

	std::copy(q.x.begin(), q.x.end(), x.real);
	std::copy(q.w.begin(), q.w.end(), w.real);
}
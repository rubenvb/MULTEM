clear all; clc;

input_multislice = multem_default_values();         % Load default values;

input_multislice.precision = 1;                     % eP_Float = 1, eP_double = 2
input_multislice.device = 2;                        % eD_CPU = 1, eD_GPU = 2
input_multislice.cpu_ncores = 1; 
input_multislice.cpu_nthread = 4; 
input_multislice.gpu_device = 0;
input_multislice.gpu_nstream = 8;

input_multislice.simulation_type = 32;              % eST_STEM=11, eST_ISTEM=12, eST_CBED=21, eST_CBEI=22, eST_ED=31, eST_HRTEM=32, eST_PED=41, eST_HCI=42, eST_EWFS=51, eST_EWRS=52, eST_EELS=61, eST_EFTEM=62	
input_multislice.phonon_model = 1;                  % ePM_Still_Atom = 1, ePM_Absorptive = 2, ePM_Frozen_Phonon = 3
input_multislice.interaction_model = 1;             % eESIM_Multislice = 1, eESIM_Phase_Object = 2, eESIM_Weak_Phase_Object = 3
input_multislice.potential_slicing = 1;             % ePS_Planes = 1, ePS_dz_Proj = 2, ePS_dz_Sub = 3, ePS_Auto = 4
input_multislice.potential_type = 6;                % ePT_Doyle_0_4 = 1, ePT_Peng_0_4 = 2, ePT_Peng_0_12 = 3, ePT_Kirkland_0_12 = 4, ePT_Weickenmeier_0_12 = 5, ePT_Lobato_0_12 = 6

input_multislice.fp_dim = 110; 
input_multislice.fp_seed = 1983; 
input_multislice.fp_nconf = 10;
input_multislice.fp_iconf = 0;

input_multislice.microscope_effect = 1;             % 1: Partial coherente mode, 2: transmission_fun cross coefficient
input_multislice.spatial_temporal_effect = 1;       % 1: Spatial and temporal, 2: Temporal, 3: Spatial

input_multislice.zero_defocus_type = 3;             % eZDT_First = 1, eZDT_Middle = 2, eZDT_Last = 3, eZDT_User = 4
input_multislice.zero_defocus_plane = 0;
input_multislice.input_wave_type = 1;               % eIWT_Automatic = 1, eIWT_User_Define = 2
input_multislice.psi_0 = 0;

input_multislice.bwl = 0;

input_multislice.E_0 = 300;                         % Acceleration Voltage (keV)
input_multislice.theta = 0.0;                       % Till ilumination (degrees)
input_multislice.phi = 0.0;                         % Till ilumination (degrees)

na = 8; nb = 8; nc = 10; ncu = 2; rms3d = 0.085;

[input_multislice.atoms, input_multislice.lx...
, input_multislice.ly, input_multislice.lz...
, a, b, c, input_multislice.dz] = Cu001Crystal(na, nb, nc, ncu, rms3d);

input_multislice.nx = 1024; 
input_multislice.ny = 1024;

input_multislice.lens_m = 0;       %mm
input_multislice.lens_f = 100;     %Angs
input_multislice.lens_Cs3 = 0.04;	%mm
input_multislice.lens_Cs5 = 0.00;	%mm
input_multislice.lens_mfa2 = 0.0; 
input_multislice.lens_afa2 = 0.0; %(Angs, degrees)
input_multislice.lens_mfa3 = 0.0; 
input_multislice.lens_afa3 = 0.0; %(Angs, degrees)
input_multislice.lens_aobjl = 0.0; 
input_multislice.lens_aobju = 0.0; %(mrad, mrad)
input_multislice.lens_sf = 32; 
input_multislice.lens_nsf = 64; % (Angs, number of steps)
input_multislice.lens_beta = 0.1; 
input_multislice.lens_nbeta = 10; %(mrad, half number of steps)

clear MULTEM;
tic;
[m2psi_tot] = MULTEM(input_multislice); 
toc;

figure(1);
imagesc(m2psi_tot);
title('Total intensity');
axis image;
colormap gray;
clear all; clc;

input_multislice = multem_default_values();         % Load default values;

input_multislice.precision = 1;                     % eP_Float = 1, eP_double = 2
input_multislice.device = 2;                        % eD_CPU = 1, eD_GPU = 2
input_multislice.cpu_ncores = 1; 
input_multislice.cpu_nthread = 4; 
input_multislice.gpu_device = 0;
input_multislice.gpu_nstream = 8;

input_multislice.simulation_type = 51;              % eST_STEM=11, eST_ISTEM=12, eST_CBED=21, eST_CBEI=22, eST_ED=31, eST_HRTEM=32, eST_PED=41, eST_HCI=42, eST_EWFS=51, eST_EWRS=52, eST_EELS=61, eST_EFTEM=62	
input_multislice.phonon_model = 1;                  % ePM_Still_Atom = 1, ePM_Absorptive = 2, ePM_Frozen_Phonon = 3
input_multislice.interaction_model = 1;             % eESIM_Multislice = 1, eESIM_Phase_Object = 2, eESIM_Weak_Phase_Object = 3
input_multislice.potential_slicing = 1;             % ePS_Planes = 1, ePS_dz_Proj = 2, ePS_dz_Sub = 3, ePS_Auto = 4
input_multislice.potential_type = 6;                % ePT_Doyle_0_4 = 1, ePT_Peng_0_4 = 2, ePT_Peng_0_12 = 3, ePT_Kirkland_0_12 = 4, ePT_Weickenmeier_0_12 = 5, ePT_Lobato_0_12 = 6

input_multislice.fp_dim = 110; 
input_multislice.fp_seed = 1983; 
input_multislice.fp_nconf = 20;
input_multislice.fp_iconf = 0;

input_multislice.zero_defocus_type = 3;             % eZDT_First = 1, eZDT_Middle = 2, eZDT_Last = 3, eZDT_User = 4
input_multislice.zero_defocus_plane = 0;
input_multislice.input_wave_type = 1;               % eIWT_Automatic = 1, eIWT_User_Define = 2
input_multislice.psi_0 = 0;

input_multislice.bwl = 1;

input_multislice.E_0 = 300;                          % Acceleration Voltage (keV)
input_multislice.theta = 2.0;                       % Till ilumination (degrees)
input_multislice.phi = 0;                         % Till ilumination (degrees)

%%%%%%%%%%%%%%%%%%%%%%%%% EW Fourier Space %%%%%%%%%%%%%%%%%%%%%%
input_multislice.ewfs_convergent_beam = 0;     % 1: true, 0:false
input_multislice.ewfs_x0 = 0.0;                % x position 
input_multislice.ewfs_y0 = 0.0;                % y position
%%%%%%%%%%%%%%%%%%%%%%%%%% EW Real Space %%%%%%%%%%%%%%%%%%%%%%%%
input_multislice.ewrs_convergent_beam = 0;     % 1: true, 0:false
input_multislice.ewrs_x0 = 0.0;                % x position 
input_multislice.ewrs_y0 = 0.0;                % y position

na = 8; nb = 8; nc = 20; ncu = 2; rms3d = 0.085;

[input_multislice.atoms, input_multislice.lx...
, input_multislice.ly, input_multislice.lz...
, a, b, c, input_multislice.dz] = SrTiO3001Crystal(na, nb, nc, ncu, rms3d);

input_multislice.nx = 1024; 
input_multislice.ny = 1024;

clear MULTEM;
tic;
[m2psi_tot, psi_coh] = MULTEM(input_multislice); 
toc;

m2psi_coh = abs(psi_coh).^2;

c = 1e5;
m2psi_tot = log(1+c*m2psi_tot/max(m2psi_tot(:)));
m2psi_coh = log(1+c*m2psi_coh/max(m2psi_coh(:)));

I_min = min([min(m2psi_tot(:)), min(m2psi_coh(:))]);
I_max = max([max(m2psi_tot(:)), max(m2psi_coh(:))]);

figure(1);
subplot(1, 2, 1);
imagesc(m2psi_tot, [I_min I_max]);

title('Total intensity');
axis image;
colormap gray;

subplot(1, 2, 2);
imagesc(m2psi_coh, [I_min I_max]);

title('Coherent intensity');
axis image;
colormap gray;
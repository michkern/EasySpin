function [err,data] = test(opt,olddata)
% Check that using stochtraj with anisotropic diffusion generates a
% proper distribution of orientations

Par.lambda = 2*(2*rand()-1);
Par.tcorr = 10*rand()*1e-9;
Par.dt = Par.tcorr/10;
Par.nSteps = ceil(100*Par.tcorr/Par.dt);
Par.nTraj = 800;
Par.theta = pi*(2*rand()-1);
Par.phi = 2*pi*(2*rand()-1);
Par.chi = 2*pi*(2*rand()-1);

nTraj = Par.nTraj;
nSteps = Par.nSteps;
c20 = Par.lambda;

nBins = 50;

[t, R] = stochtraj(Par);


VecTraj = squeeze(R(:, 3, :, :));

bins = linspace(0, pi, nBins)';
ThetaHist = zeros(nBins, nTraj);

for iTraj = 1:nTraj
  ThetaHist(:, iTraj) = hist(acos(VecTraj(3, :, iTraj)), bins);
end

ThetaHist = sum(ThetaHist, 2);
ThetaHist = ThetaHist/sum(ThetaHist);

BoltzDist = exp(c20*(1.5*cos(bins).^2 - 0.5));
BoltzInt = sum(BoltzDist.*sin(bins));
BoltzDist = BoltzDist.*sin(bins)./BoltzInt;

% ChiSquare = sum(((ThetaHist - BoltzDist).^2)./ThetaHist);
rmsd = sqrt(sum((ThetaHist - BoltzDist).^2)/nBins);

% This seems like a loose condition and should be investigated further
if rmsd > 1e-2
  err = 1;
  plot(bins, ThetaHist, bins, BoltzDist)
else  
  err = 0;
end

data = [];

end

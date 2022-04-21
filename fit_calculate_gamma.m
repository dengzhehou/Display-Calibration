ds = readtable('display_calibration_data.xlsx', 'sheet','data');

voltage = table2array(ds(:, 1));
luminance = table2array(ds(:, 5));
voltage = voltage / max(voltage);
luminance = luminance / max(luminance);

maxLevel = 255;
%Gamma function fitting
g = fittype('x^g');
fittedmodel = fit(voltage,luminance,g);
displayGamma = fittedmodel.g;
gammaTable1 = ((([0:3:maxLevel]'/maxLevel))).^(1/fittedmodel.g); %#ok<NBRAK>

plot(voltage, luminance, '.')
hold on
plot(voltage, voltage.^2.39)
% plot(voltage, voltage.^(1/2.39))
plot(voltage, luminance.^(1/2.39))
hold off
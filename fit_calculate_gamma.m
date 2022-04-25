opengl software

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


plot(voltage,luminance,'.b', voltage,voltage.^displayGamma,'g', voltage,luminance.^(1/displayGamma),'r')
xlabel('voltage')
ylabel('luminance')
legend('collected luminance','predicted luminance','corrected luminance', 'Location','northwest')

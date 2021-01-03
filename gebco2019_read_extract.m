% % GEBCO 2019 Global Grid 15 arc-sec
% % Lon (86400) (x) -179.9979:0.0042:179.9979
% % Lat (43200) (y) -89.9979:0.0042:89.9979
% % Elevation (86400,43200)
% % This script extracts bathymeric data from GEBCO Global DEM 2019.
% % Please change your area of interest with lonn and latn varibles.
% % Please also check whether the name of the file is true: GEBCO_2019.nc.

%% data loading

lon=ncread('GEBCO_2019.nc','lon');
lat=ncread('GEBCO_2019.nc','lat');
elevation=ncread('GEBCO_2019.nc','elevation');

%% extraction area definition by bounding box

lonn=[15.2;21.5];
latn=[33.1;38.8];

% finding nearest points
lon_ind=dsearchn(lon,lonn);
lat_ind=dsearchn(lat,latn);

%% Extracting values
dem_extract=elevation(lon_ind(1):lon_ind(2),lat_ind(1):lat_ind(2));
lon_extract=lon(lon_ind(1):lon_ind(2));
lat_extract=lat(lat_ind(1):lat_ind(2));

fileID=fopen('DEM_extracted.xyz','w');
for i=1:numel(lon_extract)
    for j=1:numel(lat_extract)
        if dem_extract(i,j)<=0 %% only bathymetry extraction
            fprintf(fileID,'%f ',lon_extract(i));
            fprintf(fileID,'%f ',lat_extract(j));
            fprintf(fileID,'%f\n',dem_extract(i,j));
        end
    end
end
fclose(fileID);

%% Plotting
data=importdata("DEM_extracted.xyz");
geoscatter(data(:,2),data(:,1),[],data(:,3),'filled')
colorbar

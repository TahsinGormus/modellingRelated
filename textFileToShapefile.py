"""
Create shapefile from a textfile
"""
import pandas as pd
import geopandas as gpd
from fiona.crs import from_epsg

# Reading the data
df = pd.read_csv('data.txt', delimiter = "\t")

# Creating the shapefile
gdf = gpd.GeoDataFrame(df, geometry=gpd.points_from_xy(df.LON, df.LAT))

# Set the GeoDataFrame's coordinate system to WGS84 (i.e. epsg code 4326)

gdf.crs = from_epsg(4326)

# Writing the shapefile
outfp = "data.shp"
gdf.to_file(outfp)


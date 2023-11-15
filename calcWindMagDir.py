#############################################################################
# Function for computing wind speed magnitude and direction relative to North
import numpy as np # necessary
def calcWindMagDir(u,v): # u and v should be 1-D arrays
    mag=np.sqrt(u**2+v**2)
    wind_dir=np.empty(np.size(u),dtype=np.float32)
    wind_dir[:]=np.NaN
    alpha=np.degrees(np.arctan(np.absolute(v/u)))
    u_sign=np.sign(u)
    v_sign=np.sign(v)
    
    for ts in np.arange(0,np.size(u_sign)):
        if u_sign[ts]==1 and v_sign[ts]==1:
            wind_dir[ts]=270-alpha[ts]
        elif u_sign[ts]==1 and v_sign[ts]==-1:
            wind_dir[ts]=270+alpha[ts]
        elif u_sign[ts]==-1 and v_sign[ts]==-1:
            wind_dir[ts]=90-alpha[ts]
        elif u_sign[ts]==-1 and v_sign[ts]==1:
            wind_dir[ts]=90+alpha[ts]

    return mag, wind_dir
#############################################################################

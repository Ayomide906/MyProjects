import json
import pickle
import numpy as np

__data_column = None
__locations = None
__model = None

def get_location_names():
    return __locations

def get_estimated_price(loc, total_sqft, bath, bhk, area):
    try:
        loc_index = __data_column.index(loc.lower())
    except:
        loc_index = -1

    try:
        area_index = __data_column.index(area.lower())
    except:
        area_index = -1

    x = np.zeros(len(__data_column))
    x[0] = bath
    x[1] = total_sqft
    x[2] = bhk

    if loc_index >= 0:
        x[loc_index] = 1
    if area_index >= 0:
        x[area_index] = 1

    return __model.predict([x])[0]

def load_saved_artifacts():
    print("Loading artifacts...")
    global __data_column, __locations, __model

    with open('artifacts/columns.json', 'r') as f:
        __data_column = json.load(f)['data_columns']
        __locations = __data_column[3:]

    with open('artifacts/banglore_home_prices_model.pickle', 'rb') as f:
        __model = pickle.load(f)

    print("Artifacts loaded.")

# Load ONCE
load_saved_artifacts()

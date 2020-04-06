import numpy as np
import pandas as pd

from pandas import Series, DataFrame

series_object = Series(np.arange(8), index=['row 1', 'row 2', 'row 3', 'row 4', 'row 5', 'row 6', 'row7', 'row 8'])
series_object['row 7']
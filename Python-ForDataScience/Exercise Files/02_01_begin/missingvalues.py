import numpy as np
import pandas as pd

from pandas import Series, DataFrame

missing = np.nan
series_obj = Series(['row 1', 'row 2', missing, 'row 4', 'row 5', 'row 6', missing, 'row 8'])
print(series_obj.isnull())

np.random.seed(25)
DF_obj = DataFrame(np.random.rand(36).reshape(6,6))
print(DF_obj)

DF_obj.loc[3:5, 0] = missing 
DF_obj.loc[1:4, 5] = missing
print(DF_obj)

filled_DF = DF_obj.fillna(0)
print(filled_DF)

filled_DF = DF_obj.fillna({0:0.1, 5:1.25})
print(filled_DF)

fill_DF = DF_obj.fillna(method='ffill')
print(fill_DF)

np.random.seed(25)
DF_obj = DataFrame(np.random.rand(36).reshape(6,6))
DF_obj.loc[3:5, 0] = missing
DF_obj.loc[1:4, 5] = missing
print(DF_obj)

print(DF_obj.isnull().sum())

DF_no_NaN = DF_obj.dropna()
print(DF_no_NaN)


DF_no_NaN = DF_obj.dropna(axis=1)
print(DF_no_NaN)
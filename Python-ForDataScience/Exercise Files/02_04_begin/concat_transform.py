import numpy as np
import pandas as pd

from pandas import Series, DataFrame

DF_obj = pd.DataFrame(np.arange(36).reshape(6,6))
print(DF_obj)

DF_obj_2 = pd.DataFrame(np.arange(15).reshape(5,3))
print(DF_obj_2)

print(pd.concat([DF_obj, DF_obj_2], axis=1 ))

print(pd.concat([DF_obj, DF_obj_2]))

print(DF_obj.drop([0,2]))

print(DF_obj.drop([0,2], axis=1))

seris_obj = Series(np.arange(6))
seris_obj.name = "added_variable"
print(seris_obj)
variable_added = DataFrame.join(DF_obj, seris_obj)
print(variable_added)

added_datatable = variable_added.append(variable_added, ignore_index=False)
print(added_datatable)


added_datatable = variable_added.append(variable_added, ignore_index=True)
print(added_datatable)

DF_sorted = DF_obj.sort_values(by=(5), ascending=[False])
print(DF_sorted)
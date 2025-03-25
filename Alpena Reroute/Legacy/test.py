import openpyxl as pyxl
from openpyxl.utils.dataframe import dataframe_to_rows
import pandas as pd 
import sqlite3
import os
if os.path.exists("test.db"):
    os.remove("test.db")
db = sqlite3.connect("test.db")
c = db.cursor()

D1 = pd.read_excel("Dummy1.xlsx", "Sheet1") 
D2 = pd.read_excel("Dummy2.xlsx", "Sheet1") 
defCols1 = [x + " TEXT" for x in D1.columns]
defCols2 = [x + " TEXT" for x in D2.columns]
queryCols1 = ["dummy1." + x for x in D1.columns]
queryCols2 = ["dummy2." + x for x in D2.columns]
c.execute(f'Create Table dummy1 ({defCols1[0] + "Primary Key,"} {" ,".join(defCols1[1:])})')
c.execute(f'Create Table dummy2 ({defCols2[0] + "Primary Key,"} {" ,".join(defCols2[1:])})')
D1.to_sql('dummy1', db, if_exists='append', index=False)
D2.to_sql('dummy2', db, if_exists='append', index=False)
quits = pd.read_sql(f'SELECT {" ,".join(queryCols2)} FROM dummy2 LEFT JOIN dummy1 ON dummy1.Cu_ID = dummy2.Cu_ID WHERE dummy1.Cu_ID IS NULL', db)
adds = pd.read_sql(f'SELECT {" ,".join(queryCols1)} FROM dummy1 LEFT JOIN dummy2 ON dummy1.Cu_ID = dummy2.Cu_ID WHERE dummy2.Cu_ID IS NULL', db)
changes = pd.read_sql(f'SELECT {" ,".join(queryCols1)} FROM dummy1 EXCEPT SELECT *FROM dummy2 sort order by Cu_ID desc', db)
quits['Cu_ID'] = quits['Cu_ID'].astype(str) + '-'
changes['Cu_ID'] = changes['Cu_ID'].astype(str) + '*'
# changes2 = changes[~changes.isin(adds)].dropna(how = 'all')
print("Quit accounts:")
print(quits)
print('Add accounts:')
print(adds)
print('Changed Rows:')
print(changes)
if os.path.exists("test.db"):
    os.remove("test.db")
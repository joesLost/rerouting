import openpyxl as pyxl
import pandas as pd 
wb = pyxl.load_workbook('Reroute Control File.xlsm') 
solution = pd.read_excel('Reroute Control File.xlsm', 'Solution Unique stops only').dropna(0, subset=['Cu_ID'])
rts = solution['New Rt'].unique().astype(int)
columnsToExport = ("Acct #", "Cust #", "Week #", "New Rt", "New Delivery Day", "New Stop", "Customer Name", "DisplayAddressFull", "X_Longitude", "Y_Latitude")
for rt in rts:
    mask = '`New Rt` == ' + str(rt)
    fileName = 'Solution ' + wb['Control'].cell(1,2).internal_value + '\\Map Data\\' 'Rt ' + str(rt) + '.tsv'
    solution.query(mask, False).to_csv(fileName,'\t', columns= columnsToExport, quoting= 1)
from textwrap import fill
import os
import tkinter as tk
# import openpyxl as pyxl
import pandas as pd
# from PyPDF2 import PdfFileMerger
from tkinter import simpledialog
from sqlalchemy import create_engine, text as sqltext

engine = create_engine('mssql+pyodbc://@clsalliant/Reroute?trusted_connection=yes&driver=odbc+Driver+17+for+SQL+Server')
current_iteration = pd.read_sql(sqltext('Select * from current_iteration'),engine.connect(),index_col='cu_id')
branch = pd.read_sql(sqltext('Select * from current_branch'),engine.connect()).at[0,'Branch']
iteration_name = pd.read_sql(sqltext("Select [Current Iteration] from control_parameters where Branch='"+ branch+ "'"),engine.connect()).at[0,'Current Iteration']

def createIteration():
    title = simpledialog.askstring(title="Name your " + branch + " Iteration", prompt="Enter the name for your new Iteration folder in " + branch + " Reroute")
    newIterationPath = os.getcwd() + '\\' + branch + ' Reroute\\Iteration ' + title
    neededFolders = ['\\Data Files', 
                     '\\Map Data', 
                    #  '\\Report Files\\Accounts by route', 
                    #  '\\Report Files\\All Days', 
                    #  '\\Report Files\\Five Days',
                    #  '\\Report Files\\Coming&Going',
                    #  '\\Report Files\\Retape By Day',
                    #  '\\Report Files\\Retape By RtDay'
                    ]
    for folder in neededFolders:
        path = newIterationPath + folder
        os.makedirs(path)
        print(path)

def exportMapData():
    # wb = pyxl.load_workbook('New Control File.xlsm') 
    # solution = pd.read_excel('Reroute Control File.xlsm', 'Solution Unique stops only').dropna(0, subset=['Cu_ID'])
    rts = current_iteration['New Route'].unique().astype(str)
    columnsToExport = ("Account", "Customer", "New Delivery Day", "Alliant Sequence", "Customer Name", "Address", "X_Longitude", "Y_Latitude")
    for rt in rts:
        mask = '`New Route` == "' + rt + '"'
        fileName = branch + ' Reroute\\' + 'Iteration ' + iteration_name + '\\Map Data\\' 'Rt ' + rt + '.tsv'
        current_iteration.query(mask, False).to_csv(fileName,'\t', columns= columnsToExport, quoting= 1)


# def mergePDF():
 
#     wb = pyxl.load_workbook('Reroute Control File.xlsm') 
#     solution = wb['Control'].cell(1,2).internal_value
#     solutionPath = '\\Solution '+ solution
#     neededFolders = [ '\\Report Files\\Accounts by route', '\\Report Files\\All Days', '\\Report Files\\Five Days','\\Report Files\\Coming&Going','\\Report Files\\Retape By Day','\\Report Files\\Retape By RtDay']
#     cwd = os.getcwd() 
#     # solution = cwd.rsplit('\\', 1)[1]

#     for folder in neededFolders:
#         merger = PdfFileMerger()
#         os.chdir(cwd + solutionPath + folder)
#         print(cwd)
#         pdfs = [a for a in os.listdir() if a.endswith(".pdf")]
#         for pdf in pdfs:
#             merger.append(open(pdf, 'rb'))
#         filename = "Solution " + solution + ' ' + folder.rsplit('\\', 1)[1] + '.pdf'
#         print(filename)
#         with open(filename, "wb") as fout:
#             merger.write(fout)
#         merger.close()

# def livoniaMergePDF():
 
#     wb = pyxl.load_workbook('Reroute Control File.xlsm') 
#     solution = wb['Control'].cell(1,2).internal_value
#     solutionPath = '\\Solution '+ solution
#     neededFolders = [ '\\Report Files\\West Side\\Accounts by route', '\\Report Files\\West Side\\All Days', '\\Report Files\\West Side\\Five Days','\\Report Files\\West Side\\Coming&Going',  '\\Report Files\\East Side\\Accounts by route', '\\Report Files\\East Side\\All Days', '\\Report Files\\East Side\\Five Days','\\Report Files\\East Side\\Coming&Going']
#     cwd = os.getcwd() 
#     # solution = cwd.rsplit('\\', 1)[1]

#     for folder in neededFolders:
#         merger = PdfFileMerger()
#         os.chdir(cwd + solutionPath + folder)
#         print(cwd)
#         pdfs = [a for a in os.listdir() if a.endswith(".pdf")]
#         for pdf in pdfs:
#             merger.append(open(pdf, 'rb'))
#         filename = folder.rsplit('\\', 2)[1] + ' Solution ' + solution + ' ' + folder.rsplit('\\', 1)[1] + '.pdf'
#         print(filename)
#         with open(filename, "wb") as fout:
#             merger.write(fout)
#         merger.close()

# def livoniaCreateSolution():
#     title = simpledialog.askstring(title="Name your Solution", prompt="Enter the Name for your new Solution folder")
#     newSolutionPath = os.getcwd() + '\\Solution ' + title
#     neededFolders = ['\\Data Files', '\\Map Data', '\\Report Files\\West Side\\Accounts by route', '\\Report Files\\West Side\\All Days', '\\Report Files\\West Side\\Five Days','\\Report Files\\West Side\\Coming&Going',  '\\Report Files\\East Side\\Accounts by route', '\\Report Files\\East Side\\All Days', '\\Report Files\\East Side\\Five Days','\\Report Files\\East Side\\Coming&Going']
#     for folder in neededFolders:
#         path = newSolutionPath + folder
#         os.makedirs(path)
#         print(path)
root = tk.Tk()
root.title("Reroute Helper")
root.geometry("500x200")
label1 = tk.Label(root, text="To change the branch or iteration, use either processing file")
label1.pack(pady=4)
label2 = tk.Label(root, text="Current Branch: " + branch)
label2.pack(pady=4)
label3 = tk.Label(root, text="Current Iteration: " + iteration_name)
label3.pack(pady=4)

button_text = "Create new Iteration folder"
tk.Button(text= button_text,command=createIteration).pack(anchor="center",pady=4)
button_text = "Create Map Data"
tk.Button(text=button_text,command=exportMapData).pack(anchor="center",pady=4)
# tk.Button(text="Create merged report files for active solution",command=mergePDF).pack(fill=tk.X)
# tk.Button(text="Create merged report files for active solution (Livonia)",command=livoniaMergePDF).pack(fill=tk.X)
# tk.Button(text="Create new Solution folder (Livonia)",command=livoniaCreateSolution).pack(fill=tk.X)

root.mainloop()

    
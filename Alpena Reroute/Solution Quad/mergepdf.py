import os
from PyPDF2 import PdfFileMerger
 
neededFolders = [ '\\Report Files\\Accounts by route', '\\Report Files\\All Days', '\\Report Files\\Five Days', '\\Report Files\\Fourth Week']
cwd = os.getcwd() 
solution = cwd.rsplit('\\', 1)[1]

for folder in neededFolders:
    merger = PdfFileMerger()
    os.chdir(cwd + folder)
    x = [a for a in os.listdir() if a.endswith(".pdf")]
    for pdf in x:
        merger.append(open(pdf, 'rb'))
    os.chdir(cwd)
    filename = solution + ' ' + folder.rsplit('\\', 1)[1] + '.pdf'
    with open(filename, "wb") as fout:
        merger.write(fout)
    merger.close()
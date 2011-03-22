import os
import re

str = '!_TAG_FILE_SORTED\t2\t/2=foldcase/'
for root, dirs, files in os.walk('d:/works/renren/'):
    folders = re.split(r'[/\\]', root)
    if '.svn' in folders:
        continue
    for file in files:
        str = str + '\n' + file + '\t' + os.path.join(root, file) + '\t1'

out = open('d:/works/renren/filenametags', 'w')
out.write(str)

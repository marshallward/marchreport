inpath = 'march2017.txt'
outpath = 'tmp.txt'

with open(inpath, 'r') as doc:
    tmpdoc = open(outpath, 'w')
    for line in doc:
        if line.startswith('.. include::'):
            incpath = line.replace('.. include::', '', 1).strip()
            with open(incpath, 'r') as inc:
                for line in inc:
                    tmpdoc.write(line)
        else:
            tmpdoc.write(line)
    tmpdoc.close()

import math, itertools, re

s = """\
|de|  | f|Cl|nf|ed|au| i|ti|  |ma|ha|or|nn|ou| S|on|nd|on|
|ry|  |is|th|is| b|eo|as|  |  |f |wh| o|ic| t|, |  |he|h |
|ab|  |la|pr|od|ge|ob| m|an|  |s |is|el|ti|ng|il|d |ua|c |
|he|  |ea|of|ho| m| t|et|ha|  | t|od|ds|e |ki| c|t |ng|br|
|wo|m,|to|yo|hi|ve|u | t|ob|  |pr|d |s |us| s|ul|le|ol|e |
| t|ca| t|wi| M|d |th|"A|ma|l |he| p|at|ap|it|he|ti|le|er|
|ry|d |un|Th|" |io|eo|n,|is|  |bl|f |pu|Co|ic| o|he|at|mm|
|hi|  |  |in|  |  | t|  |  |  |  |ye|  |ar|  |s |  |  |. |"""

def foldlines(cols):
    return [''.join(l) for l in zip(*cols)]

class Pdist(dict):
    def __init__(self):
        for line in open('count_1w.txt'):
            key,count = line.split('\t')
            self[key] = int(count)
        self.N = float(sum(self.itervalues()))
    def __call__(self, key): 
        if key in self: return self[key]/self.N  
        else: return 1./self.N
Pw = Pdist()

Words = re.compile('[a-z]+')
def Pline(line):
    score = -100 if '  ' in line else 0
    return score + sum([math.log(Pw(w)) for w in Words.findall(line)])

def Pcol(cols):
    return sum([Pline(line.lower()) for line in foldlines(cols)])

def segment(startelts, cols):
    if not cols: return []
    candidates = itertools.permutations(cols, min(4, len(cols)))
    start = list(max(candidates, key=lambda c: Pcol(startelts + list(c))))
    return start + segment(start, set(cols) - set(start))

if __name__ == '__main__':
    columns = zip(*[w.strip('|').split('|') for w in s.splitlines()])
    print '\n'.join(foldlines(segment([], columns)))  # -> 1948

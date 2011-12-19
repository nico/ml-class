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


def wordlist():
  return [s.strip() for s in open('/usr/share/dict/words').readlines()]
Wordlist = set(wordlist())


class Pdist(dict):
    "A probability distribution estimated from counts in datafile."
    def __init__(self, data=[], N=None, missingfn=None):
        for key,count in data:
            self[key] = self.get(key, 0) + int(count)
        self.N = float(N or sum(self.itervalues()))
        self.missingfn = missingfn or (lambda k, N: 1./N)
    def __call__(self, key): 
        if key in self: return self[key]/self.N  
        else: return self.missingfn(key, self.N)

def datafile(name, sep='\t'):
    "Read key,value pairs from file."
    for line in file(name):
        yield line.split(sep)

def avoid_long_words(key, N):
    "Estimate the probability of an unknown word."
    return 10./(N * 10**len(key))

N = 1024908267229 ## Number of tokens
Pw  = Pdist(datafile('count_2l.txt'), N, avoid_long_words)


def Pcol(cols):
    score = 0
    for a, b in zip(cols[:-1], cols[1:]):
        score += math.log(Pw(a[1] + b[0]))
    return score


def Pwords(words):
    "Probability of a sequence of words."
    return product(words, key=Pw)

def segment(startelts, cols):
    if not cols: return []
    maxp = -10000000
    start = []
    R = []
    for c in itertools.permutations(cols, min(4, len(cols))):
      c = list(c)
      score = Pcol(startelts + c)
      if score > maxp:
        maxp = score
        start = c[:]
        R = set(cols) - set(c)
    return start + segment(start, R)


def main():
    columns = zip(*[w.strip('|').split('|') for w in s.splitlines()])
    columns = segment([] * len(columns[0]), columns)
    lines = [''.join(l) for l in zip(*columns)]
    print '\n'.join(lines)  # -> 1948


if __name__ == '__main__':
    main()



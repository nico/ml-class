import math, operator, string

def wordlist():
  return [s.strip() for s in open('/usr/share/dict/words').readlines()]

def Pw(w, l):
  """Ghetto probability estimation, worse than word frequency."""
  if w.lower() in l: return 1
  return 0.1

def caesar(s, i):
  def ul(s): return s + s.upper()
  alphabet = "abcdefghijklmnopqrstuvwxyz"
  translated = alphabet[i:] + alphabet[:i]
  return string.translate(s, string.maketrans(ul(alphabet), ul(translated)))

def P(s, words):
    return sum([math.log(Pw(w, words)) for w in s.split()])

if __name__ == '__main__':
    s = "Esp qtcde nzyqpcpynp zy esp ezatn zq Lcetqtntlw Tyepwwtrpynp " + \
        "hld spwo le Olcexzfes Nzwwprp ty estd jplc."
    words = set(wordlist())
    strings = [(caesar(s, i), i) for i in range(26)]
    strings = [(P(s, words), i, s) for s, i in strings]
    for p, i, s in sorted(strings, reverse=True)[:1]:
        print p, i, s  # -> 1956

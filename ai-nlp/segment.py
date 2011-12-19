def splits(characters, longest=12):
    "Al ways to split characters into a first word and remainder."
    return [(characters[:i], characters[i:])
            for i in range(1, 1+min(longest, len(characters)))]

def Pwords(words):
    "Probability of a sequence of words."
    return product(words, key=Pw)

@memo
def segment(text):
    "Best segmentation of text into words, by probability."
    if text == "": return []
    candidates = [[first]+segment(rest) for first,rest in splits(text)]
    return max(candidates, key=Pwords)

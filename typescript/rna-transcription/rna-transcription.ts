
export function toRna(dna: string): string {
  const asArray = Array.from(dna)
  if (!isDna(asArray)) {
    throw new Error('Invalid input DNA.')
  }
  return toRnaStrict(asArray).join("");
}

function toRnaStrict(dna: DNA): RNA {
    return dna.map(dnaNucleotidetoRnaNucleotide);
}

function dnaNucleotidetoRnaNucleotide(dna: DNA_NUCLEOTIDE): RNA_NUCLEOTIDE {
  return RNA_NUCLEOTIDES[DNA_NUCLEOTIDES.indexOf(dna)];
}

const DNA_NUCLEOTIDES = ["A", "C", "G", "T"] as const;
const RNA_NUCLEOTIDES = ["U", "G", "C", "A"] as const;

type DNA_NUCLEOTIDE = typeof DNA_NUCLEOTIDES[number];
type DNA = DNA_NUCLEOTIDE[]
type RNA_NUCLEOTIDE = typeof RNA_NUCLEOTIDES[number];
type RNA = RNA_NUCLEOTIDE[]

function isDnaNucleotide(char: string): char is DNA_NUCLEOTIDE {
  return DNA_NUCLEOTIDES.includes(char as DNA_NUCLEOTIDE);
}

function isDna(val: string[]): val is DNA {
  return val.every(isDnaNucleotide);
}

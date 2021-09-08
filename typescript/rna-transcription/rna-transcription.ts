
export function toRna(dna: string): string {
  const asArray = [...dna];
  if (!isDna(asArray)) {
    throw new Error('Invalid input DNA.');
  }
  return toRnaStrict(asArray).join("");
}

function toRnaStrict(dna: DNA): RNA {
  return dna.map(dna => TRANSCRIPTION[dna]);
}

const TRANSCRIPTION = {
  "A": "U",
  "C": "G",
  "G": "C",
  "T": "A"
} as const;

type DNA_NUCLEOTIDE = keyof typeof TRANSCRIPTION;
type DNA = DNA_NUCLEOTIDE[];
type RNA_NUCLEOTIDE = typeof TRANSCRIPTION[DNA_NUCLEOTIDE];
type RNA = RNA_NUCLEOTIDE[];

function isDnaNucleotide(char: string): char is DNA_NUCLEOTIDE {
  return Object.keys(TRANSCRIPTION).includes(char as DNA_NUCLEOTIDE);
}

function isDna(val: string[]): val is DNA {
  return val.every(isDnaNucleotide);
}

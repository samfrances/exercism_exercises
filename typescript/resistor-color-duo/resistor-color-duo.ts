export function decodedValue([first, second, ..._rest]: [string, string, ...string[]]) {
  assertIsResistor(first);
  assertIsResistor(second);
  return resistorValue(first) * 10 + resistorValue(second);
}

function resistorValue(resistor: Resistor): number {
  return resistors.indexOf(resistor);
}

const resistors = [
  "black",
  "brown",
  "red",
  "orange",
  "yellow",
  "green",
  "blue",
  "violet",
  "grey",
  "white",
] as const;

type Resistor = typeof resistors[number];

function isResistor(val: string): val is Resistor {
  return resistors.includes(val as Resistor);
}

function assertIsResistor(val: string): asserts val is Resistor {
  if (!isResistor(val)) {
    throw new Error(`Not a resistor name: ${val}`);
  }
}
export function decodedValue([first, second, ..._rest]: [ResistorString, ResistorString, ...ResistorString[]]) {
  return resistorValue(
    Resistor[first],
    Resistor[second]
  )
}

function resistorValue(first: Resistor, second: Resistor): number {
  return resistorValues[first] * 10 + resistorValues[second]
}

enum Resistor {
  black = "black",
  brown = "brown",
  red = "red",
  orange = "orange",
  yellow = "yellow",
  green = "green",
  blue = "blue",
  violet = "violet",
  grey = "grey",
  white = "white",
}

type ResistorString = `${Resistor}`;

const resistorValues = {
  [Resistor.black]:  0,
  [Resistor.brown]:  1,
  [Resistor.red]:    2,
  [Resistor.orange]: 3,
  [Resistor.yellow]: 4,
  [Resistor.green]:  5,
  [Resistor.blue]:   6,
  [Resistor.violet]: 7,
  [Resistor.grey]:   8,
  [Resistor.white]:  9
} as const;

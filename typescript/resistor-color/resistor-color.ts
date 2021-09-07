export const colorCode = (name: ResistorString) => {
  return COLORS.indexOf(name);
}

export const COLORS = [
  "black",
  "brown",
  "red",
  "orange",
  "yellow",
  "green",
  "blue",
  "violet",
  "grey",
  "white"
] as const;

type ResistorString = typeof COLORS[number];

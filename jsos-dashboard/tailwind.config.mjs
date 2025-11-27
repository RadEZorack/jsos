/** @type {import('tailwindcss').Config} */
export const content = [
  "./app/**/*.{js,ts,jsx,tsx}",
];
export const theme = {
  extend: {
    colors: {
      sky98: {
        light: "#E5E5E5",
        dark: "#C0C0C0",
        border: "#7A7A7A",
        highlight: "#000080"
      }
    }
  },
};
export const plugins = [];
  
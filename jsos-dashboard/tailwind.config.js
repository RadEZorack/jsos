/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./app/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
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
  },
  plugins: [],
};

module.exports = function (api) {
  api.cache(true);
  return {
    presets: [
      ["babel-preset-expo", { jsxImportSource: "nativewind" }],
      "nativewind/babel",
    ],
    // No extra class-property plugins needed — babel-preset-expo already
    // includes them in the correct order (after the TypeScript transform).
  };
};

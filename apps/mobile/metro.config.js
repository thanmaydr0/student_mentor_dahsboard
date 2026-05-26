const { getDefaultConfig } = require("expo/metro-config");
const { withNativeWind } = require("nativewind/metro");
const path = require("path");

const projectRoot = __dirname;
const workspaceRoot = path.resolve(projectRoot, "../..");

const config = getDefaultConfig(projectRoot);

// 1. Watch all files in the monorepo so Metro can find shared packages
config.watchFolders = [workspaceRoot];

// 2. Resolve packages: mobile's own node_modules first, then root
config.resolver.nodeModulesPaths = [
  path.resolve(projectRoot, "node_modules"),
  path.resolve(workspaceRoot, "node_modules"),
];

// 3. Tell Metro where the project root actually is
config.projectRoot = projectRoot;

module.exports = withNativeWind(config, { input: "./app/global.css" });

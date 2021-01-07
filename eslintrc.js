module.exports = {
  env: {
    browser: true,
    commonjs: true,
    es6: true,
    node: true,
    "jest/globals": true
  },
  globals: {
    page: true,
    browser: true
  },
  extends: [
    "eslint:recommended",
    "plugin:react/recommended",
    "plugin:flowtype/recommended"
  ],
  parser: "babel-eslint",
  parserOptions: {
    sourceType: "module",
    codeFrame: false,
    ecmaFeatures: {
      experimentalObjectRestSpread: true,
      jsx: true
    }
  },
  plugins: ["react", "react-hooks", "flowtype", "jest", "import"],
  settings: {
    react: { version: "16.2" }
  },
  rules: {
    "react/no-find-dom-node": 0,
    "flowtype/require-valid-file-annotation": [
      2,
      "always",
      {
        annotationStyle: "line"
      }
    ],
    "react-hooks/rules-of-hooks": "error",
    "flowtype/newline-after-flow-annotation": [2, "always"],
    "react/prop-types": 0,
    "react/display-name": 0,
    "react/react-in-jsx-scope": 0,
    "no-console": 1,
    "no-unused-vars": 1,
    "prefer-const": "error",
    "linebreak-style": ["error", "unix"],
    quotes: ["error", "double"],
    semi: ["error", "never"],
    "import/named": 2,
    "import/exports-last": 0,
    "import/first": 2,
    "import/default": 2,
    "import/namespace": 2,
    "require-await": 2,
    "no-return-await": 2
  }
}

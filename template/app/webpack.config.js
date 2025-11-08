const webpack = require("@nativescript/webpack");

module.exports = (env) => {
    webpack.init(env);

    webpack.chainWebpack((config) => {
        // Custom webpack configuration
    });

    return webpack.resolveConfig();
};
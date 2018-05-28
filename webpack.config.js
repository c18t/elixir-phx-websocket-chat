const path = require('path')
const VueLoaderPlugin = require('vue-loader/lib/plugin')
const ExtractTextPlugin = require("extract-text-webpack-plugin")
const isProduction = process.env.NODE_ENV === 'production';

module.exports = {
  // // フロントエンドのルートディレクトリ(却って分かりづらいので指定しない)
  // context: path.resolve(__dirname, './lib/js'),
  // ソースマップのスタイル
  devtool: isProduction ? 'hidden-source-map' : 'cheap-eval-source-map',
  // // ビルドモード(for 4)
  // mode: isProduction ? 'production' : 'development',

  // メインとなるJavaScriptファイル（エントリーポイント）
  entry: {
    app: path.resolve(__dirname, './lib/js/main.ts'),
  },

  // ファイルの出力設定
  output: {
    //  出力ファイルのディレクトリ名
    path: path.resolve(__dirname, './priv/static/js'),
    // 出力ファイル名
    filename: '[name].js',
  },

  // Vueのビルドバージョンを明示的に指定
  resolve: {
    extensions: ['*', '.js', '.ts', '.vue', '.json'],
    alias: {
      'vue$': isProduction ? 'vue/dist/vue.runtime.esm.js' : 'vue/dist/vue.esm.js',
    },
  },

  // モジュール設定
  module: {
    rules: [
      {
        // TypeScriptファイルの設定
        test: /\.ts$/,
        exclude: /node_modules/,
        loader: 'ts-loader',
        options: {
          appendTsSuffixTo: [/\.vue$/],
        },
      },
      {
        // SFCの設定
        test: /\.vue$/,
        loader: 'vue-loader',
        options: {
          extractCSS: true,
        },
      },
      {
        // SFC展開後のstylusの設定
        test: /\.stylus$/,
        use: [
          'vue-style-loader',
          'css-loader',
          'stylus-loader',
        ],
      },
    ],
  },

  // プラグイン設定
  plugins: [
    new VueLoaderPlugin(),
    new ExtractTextPlugin(path.resolve(__dirname, './priv/static/css/style.css'))
  ]
};

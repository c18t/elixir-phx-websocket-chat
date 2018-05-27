module.exports = {

  mode: 'development',

  // メインとなるJavaScriptファイル（エントリーポイント）
  entry: `./lib/js/app.js`,
  
  // ファイルの出力設定
  output: {
    //  出力ファイルのディレクトリ名
    path: `${__dirname}/priv/static/js`,
    // 出力ファイル名
    filename: 'app.js'
  },
};

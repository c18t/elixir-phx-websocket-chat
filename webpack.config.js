module.exports = {

  mode: 'development',

  context: __dirname + "/lib/js", // rootにしたいパスを指定

  // メインとなるJavaScriptファイル（エントリーポイント）
  entry: `./app.js`,
  
  // ファイルの出力設定
  output: {
    //  出力ファイルのディレクトリ名
    path: `${__dirname}/priv/static/js`,
    // 出力ファイル名
    filename: 'app.js'
  },
};

const { environment } = require('@rails/webpacker')

// 不要な `node` 設定を削除します
environment.config.node = {
  // 必要に応じて以下の設定を有効にしますが、基本的には削除で問題解決する場合が多いです
  __dirname: true,
  __filename: true,
  global: true
}

const babelLoader = environment.loaders.get('babel')
babelLoader.use[0].options.presets = ['@babel/preset-env']


module.exports = environment

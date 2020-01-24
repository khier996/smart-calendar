const { environment } = require('@rails/webpacker')
const { VueLoaderPlugin } = require('vue-loader')
const vue = require('./loaders/vue')
const path = require('path')

const aliasConfig = {
  resolve: {
    // below are convenient shortcuts that we can use in javascript and css files in order to avoid relative paths
    // in js files we can use them like this: import something from 'Javascript/some/path/to/file.js'
    // in css files we need also to add "~" to the shortcut name: @import '~SomeVariable/some_file.js'
    alias: {
      Javascript: path.resolve(__dirname, '../../app/javascript/'),
      CommonStyles: path.resolve(__dirname, '../../app/javascript/common_styles'),
      Calendar: path.resolve(__dirname, '../../app/javascript/calendar'),
    }
  }
}

environment.config.merge(aliasConfig)
environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.prepend('vue', vue)
module.exports = environment

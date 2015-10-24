semantic_ui = (gulp, plugins) ->
  () ->
    gulp.src 'bower_components/semantic-ui/dist/themes/**'
      .pipe gulp.dest '../../public/assets/themes'

module.exports = semantic_ui

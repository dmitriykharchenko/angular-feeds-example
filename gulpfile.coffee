gulp = require 'gulp'
concat = require 'gulp-concat'
coffee = require 'gulp-coffee'
jade = require 'gulp-jade'
template_cache = require 'gulp-angular-templatecache'
angular_filesort = require 'gulp-angular-filesort'
stylus = require 'gulp-stylus'
es = require 'event-stream'


application_modules = ['app', 'instagram', 'flickr', 'feeds']

paths =
  lib: [
    'app/bower_components/angular/angular.js'
    'app/bower_components/angular-ui-router/release/angular-ui-router.js'
    'app/bower_components/angular-contenteditable/angular-contenteditable.js'
  ]
  styles_lib: [
    'app/bower_components/bootstrap/dist/css/bootstrap.css'
    'app/bower_components/bootstrap/dist/css/bootstrap-theme.css'
    'app/bower_components/fontawesome/css/font-awesome.css'
  ]
  fonts: [
    'app/bower_components/fontawesome/fonts/FontAwesome.otf'
    'app/bower_components/fontawesome/fonts/fontawesome-webfont.eot'
    'app/bower_components/fontawesome/fonts/fontawesome-webfont.svg'
    'app/bower_components/fontawesome/fonts/fontawesome-webfont.ttf'
    'app/bower_components/fontawesome/fonts/fontawesome-webfont.woff'
  ]
  app: 'app/coffee'
  styles: 'app/styles/**/**.styl'


gulp.task 'angular-app', ->

  lib_pipe = gulp.src paths.lib
  .pipe concat 'lib.js', {newLine: ';'}

  module_pipes = for module in application_modules

    templates = gulp.src "#{paths.app}/#{module}/templates/**/**.jade"
    .pipe jade()
    .pipe template_cache
      base: (file) ->
        path = file.path
        .replace("#{__dirname}/#{paths.app}/", '')
        .replace('templates', '')
        .replace('.html', '')
        path

      module: "#{module}"

    scripts = gulp.src "#{paths.app}/#{module}/**/**.coffee"
    .pipe coffee()

    es.concat(scripts, templates)
    .pipe angular_filesort()
    .pipe concat "#{module}.js", {newLine: ';'}

  application_pipe = es.concat.apply es, module_pipes
  .pipe angular_filesort()
  .pipe concat 'app.js', {newLine: ';'}
  .pipe gulp.dest 'public/javascripts'

  lib_pipe
  .pipe concat 'lib.js', {newLine: ';'}
  .pipe gulp.dest 'public/javascripts'


gulp.task 'styles', ->
  styles_lib = gulp.src paths.styles_lib
  application = gulp.src paths.styles
  .pipe stylus()

  es.concat styles_lib, application
  .pipe concat 'app.css'
  .pipe gulp.dest 'public/stylesheets/'


gulp.task 'copy', ->
  gulp.src paths.fonts
  .pipe gulp.dest 'public/fonts'


gulp.task 'watch', ->
  gulp.watch "#{paths.app}/**/**.coffee", ['angular-app']
  gulp.watch "#{paths.app}/**/**.jade", ['angular-app']
  gulp.watch paths.styles, ['styles']

gulp.task 'build', ['angular-app', 'styles', 'copy']

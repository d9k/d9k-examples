var gulp    = require('gulp'),
    coffee  = require('gulp-coffee'),
    babel   = require('gulp-babel'),
    gutil   = require('gulp-util');

config = {
    coffeePath: './src-coffee',
    es6Path : './src-es6',
    staticDir: './static'
};

gulp.task('coffee', function(){
    gulp.src(config.coffeePath + '/**/*.coffee')
    //gulp.src(config.coffeePath + '/*.coffee')
        // bare option: see http://coffeescript.org/#lexical-scope
        .pipe(coffee({bare: true}))//.on('error', gutil.log))
        .pipe(gulp.dest(config.es6Path));
});

gulp.task('es6', function () {
	gulp.src(
    config.es6Path + '/**/*.js'
  )
	.pipe(babel({
		presets: [
      // Without any configuration options, babel-preset-env behaves exactly the same as babel-preset-latest (or babel-preset-es2015, babel-preset-es2016, and babel-preset-es2017 together).
      'env'
    //'es2015', 'stage-0'//, 'react'
    //, 'es2016', 'es2017'
    ],
    // plugins: ['transform-runtime'],
		sourceRoot: 'src',
//    sourceRoot: src.babelSourceRoot,
		sourceMap: true
	}))
	.pipe(gulp.dest(config.staticDir + '/es5'));
});


gulp.task('default', ['coffee', 'es6']);

module.exports = function(grunt) {
    grunt.initConfig({
    
      //TODO: add banner, produce autogenerating files
    
      // The main task
      rig: {
        compile: {
          files: {
            'workframe.pd': ['src/workframe.pd']
          }
        }
      }
      
    })

    grunt.loadNpmTasks('grunt-rigger')
    
    grunt.registerTask('default', ['rig']);
}


module.exports = function(grunt) {
    grunt.initConfig({
    
      //TODO: add banner, produce autogenerating files
    
      // The main task
      rig: {
        compile: {
          files: {
            'workframe.pde': ['src/workframe.pde']
          }
        }
      }
      
    })

    grunt.loadNpmTasks('grunt-rigger')
    
    grunt.registerTask('default', ['rig']);
}


module.exports = function(grunt) {
    grunt.initConfig({
    
      // The main task
      rig: {
        compile: {
          options: {
            banner: 'Building WorkFrame...\n'
          },
          files: {
            'workframe.pd': ['src/workframe.pd']
          }
        }
      }
      
    })

    grunt.loadNpmTasks('grunt-rigger')
    
    grunt.registerTask('default', ['rig']);
}


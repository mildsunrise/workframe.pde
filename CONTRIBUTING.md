# How to contribute

## General

 1. Always **rebuild and test** before committing, by  
    running `grunt test`. Verify the tests are successful.

 2. If you modify the version in `package.json`, update  
    the one in `src/banner.pd`, and viceversa.

 3. Make code **readable and structured**. If you feel you're  
    adding too much code on a file, consider adding another.

 4. (Advanced) Never include full directories, instead  
    create a file with the same name as the directory (but  
    with the suffix `.pd`) and include the files there.

## Code

 1. Try to keep the code formatting (2-space indent, etc.).

 2. Methods and classes are always kept `public`, and  
    never declared `static`.


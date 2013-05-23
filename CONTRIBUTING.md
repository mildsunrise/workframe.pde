# How to contribute

## General

 1. Always **rebuild and test** before committing, by  
    running `grunt test`. Verify the tests are successful.

 2. If you modify the version in `package.json`, update  
    the one in `src/banner.pde`, and viceversa.

 3. Make code **readable and structured**. If you feel you're  
    adding too much code on a file, consider adding another.

 4. (Advanced) Never include full directories, instead  
    create a file with the same name as the directory (but  
    with the suffix `.pde`) and include the files there.

## Code

 1. Try to keep the code formatting (2-space indent, etc.).

 2. Methods and classes are always kept `public`, and  
    never declared `static`.

 3. The user isn't expected to construct an instance manually
    (i.e. `new StackLayer()`). He's should normally use the
    friendly shortcuts (i.e. `stack()`).

    Thus, constructors should *not* be overloaded, since they
    aren't user-facing. There should be one constructor, with
    all the arguments one would ever need to pass to it.

    Methods should also be written (the shortcuts), and
    overloaded accordingly, which call the constructor with
    the appropiate values.

 4. Whenever possible, we try to emulate a dynamically-typed language.

    For example, instead of implementing the interface `Stackable`
    just on `BlenderLayer` and `StackLayer` (as we would do in
    classical OOP), we implement it in `Layer`, with dummy methods
    that **always throw**. `BlenderLayer` overrides these methods
    as appropiate.

    That way, using i.e. a `GraphicsLayer` where a `Stackable` is
    expected won't result in a compile error, but will throw when run.

 5. For the same reason, we don't usually throw regular `Exception`s
    (that would require a `try`/`catch` block to compile). Instead we
    throw `RuntimeException`s.


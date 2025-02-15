## # HappyX
## 
##   ### Web framework written in Nim with ❤
## 
## 
## ## Why HappyX? 🤔
## HappyX is macro-oriented full-stack web framework that provides same syntax in both parts of framework (SPA and SSR).
## - SPA part compiles only on `JS` and provides these features:
##   - `components`;
##   - `event handlers`;
##   - `buildJs` macro;
##   - state management
## - SSR part compiles only on `C`/`Cpp`/`Obj-C` and provides these features:
##   - `CORS` registration;
##   - Request models;
## 
## SPA and SSR also provides both syntax for routing.
## You don't need to learn new syntax for new projects.
## 
## HappyX provides CLI tool for creating and serving your projects 🛠
## 
## Create new project ✨
## ```bash
## hpx create
## ```
## 
## Serve existing SPA project 🛠
## ```bash
## hpx dev
## ```
## 
## Help ❔
## ```bash
## hpx help [subcommand]
## ```
## 
## 
## ## Examples
## 
## ### SPA 🎴
## 
## SPA works only on JS backend
## 
## - `index.html`
## 
##   .. code-block::html
##      <html>
##        <head>
##          <meta charset="utf-8">
##          <title>Title</title>
##        </head>
##        <body>
##          <div id="app"></div>
##          <script src="main.js"></script>
##        </body>
##      </html>
## 
## - `components/hello_world.nim`
## 
##   .. code-block::nim
##      import happyx
##      
##      component HelloWorld:
##        `template`:
##          # Use HTML here
##          tDiv:
##            "Hello, world!"
##        `script`:
##          # Use real Nim code here
##          discard
##        `style`: """
##          /* Use pure CSS here */
##          div {
##            color: green;
##          }
##          """
## 
## - `main.nim`
## 
##   .. code-block::nim
##      import
##        happyx,
##        components/[hello_world]
##      
##      appRoutes "app":
##        "/":
##          component HelloWorld
## 
## 
## ### SSR 💻
## 
## SSR works only on C/Cpp/ObjC backends
## 
## - `main.nim`
## 
##   .. code-block::nim
##      import happyx
##      
##      serve "127.0.0.1", 5000:
##        # In this scope you can declare gc-safe vars/lets
##        var myVar = 0
##        
##        get "/":
##          # available only on GET method
##          # In this scope you can access to
##          # req: Request  - current request
##          # query: StringTableRef  - current queries
##          # path: string  - current path
##          myVar += 1
##          return "Hello, world! myVar is {myVar}"
##        
##        "/framework":
##          return "This method available from any method (POST, GET, PUT, etc.)"
##        
##        middleware:
##          echo "This will printed first"
##        
##        notfound:
##          return "Oops, not found!"
## 
## ### CLI Usage 🎈
## 
## #### SSR
## 
## At first we need to create project and choose SSR project type.
## ```bash
## hpx create
## ```
## 
## This creates directory with `.gitignore`, `README.md` and `main.nim` files
## 
## After creating you can work with project as you want
## 
## #### SPA
## 
## At first we need to create project and choose SPA project type.
## ```bash
## hpx create
## ```
## 
## This creates directory with `.gitignore`, `README.md`, `main.nim` and `components/hello_world.nim` files
## 
## After creating you can work with project as you want
## ```bash
## cd PROJECT_NAME
## hpx dev
## ```
## 
## `hpx dev` command will see all changes in your project and recompile `main.nim`
## 
## `hpx build` command will builds your project as standalone web application (HTML + JS files)
## 
## 
## ## Path Params 🛠
## 
## Routing provides powerful path params.
## 
## ### Example
## 
## .. code-block::nim
##    "/user{id:int}":
##      # In this scope you can use `id` as assigned immutable variable
##      ...
##    "/user{username}":
##      # In this scope you can use `username` as assigned immutable variable
##      ...
## 
## ### Validation ⚙
## 
## In path params you can describe every param if you need. Here is syntax overview.
## - Required param: `{arg:type}`, `$arg:type`, `{arg}`, `$arg`
## - Optional param: `{arg?:type}`, `$arg?:type`, `{arg?}`, `$arg?`
## - Mutable param: `{arg:type[m]}`, `$arg:type[m]`, `{arg[m]}`, `$arg[m]`
## - Mutable optional param: `{arg?:type[m]}`, `$arg?:type[m]`, `{arg?[m]}`, `$arg?[m]`
## - Optional param with default value: `{arg:type=val}`, `$arg:type=val`, `{arg=val}`, `$arg=val`
## - Mutable optional param with default value: `{arg?:type[m]=val}`, `$arg?:type[m]=val`, `{arg?[m]=val}`, `$arg?[m]=val`
## 
## ### Aliases 🎈
## 
## Path params can be used by default in curly brackets: `{arg}`
## But you can use syntax sugar (alias) also: `$arg`
## 
## ### Typing 👮‍♀️
## 
## Every path param keeps type (default is string)
## 
## List of types:
## - `bool`: can be `on`, `1`, `yes`, `true`, `y` for true and `off`, `0`, `n`, `no` and `false` for false
## - `string`: string that excludes `/` chars
## - `enum(EnumTypeName)`: matches enum value
## - `word`: like `string` but excludes any symbols
## - `int`: any integer
## - `float`: any float
## - `path`: like `string` but includes `/` chars.
## - regex pattern: any regex pattern translates in string. Usage: `/:patternHere:/`. Doesn't provides optional and default.
## 
## ### (Im)mutable ⚙
## 
## Every path param by default is immutable, but you can change it to mutable by add `[m]` after param type:
## 
## | Immutable            | Mutable                 | Immutable Via Alias     | Mutable Via Alias          |
## | :--:                 | :--:                    | :--:                    | :--:                       | 
## | `{arg}`              | `{arg[m]}`              | `$arg`                  | `$arg[m]`                  |
## | `{arg:type}`         | `{arg:type[m]}`         | `$arg:type`             | `$arg:type[m]`             |
## | `{arg:type=default}` | `{arg:type[m]=default}` | `$arg:type=default`     | `$arg:type[m]=default`     |
## | `{arg=default}`      | `{arg=default}`         | `$arg=default`          | `$arg[m]=default`          |
## | `{arg?:type}`        | `{arg?:type[m]}`        | `$arg?:type`            | `$arg?:type[m]`            |
## 
## ## Mounting 🔌
## 
## HappyX routing provides mounting also.
## 
## Here is example of mount declaration ✨
## 
## .. code-block:: nim
##    mount Settings:
##      "/":
##        ...
##    mount Profile:
##      mount "/settings" -> Settings
##      mount "/config" -> Settings
## 
## Here is example of mount usage 🎈
## 
## .. code-block:: nim
##    serve(...):  # or appRoutes 🍍
##      # /profile does not works
##      # /profile/settings does not works
##      # /profile/settings/ works!
##      mount "/profile" -> Profile
## 
## 
## # API Reference 📄
## 
## ## Automatic Import 🎈
## 
## ### Core 🔋
## 
## - [constants](happyx/core/constants.html) - describes all HappyX flags and consts.
## - [queries](happyx/core/queries.html) - provides some utils to work with query parameters.
## - [exceptions](happyx/core/exceptions.html) - describes all HappyX exceptions.
## - [secure](happyx/core/secure.html) - provides some secure features.
## 
## ### Single Page Application ✨
## 
## - [renderer](happyx/spa/renderer.html) provides SPA renderer.
## - [components](happyx/spa/components.html) provides working with components.
## - [translatable](happyx/spa/translatable.html) provides working with translatable strings.
## - [state](happyx/spa/state.html) provides reactivity.
## - [spa_utils](happyx/spa/spa_utils.html) provides JS sugar for SPA.
## - [tag](happyx/spa/tag.html) provides VDOM.
## 
## ### Server Side Rendering 🍍
## 
## - [cors](happyx/ssr/cors.html) provides CORS registration.
## - [server](happyx/ssr/server.html) provides routing and working with server.
## - [form data](happyx/ssr/form_data.html) provides routing and working with server.
## - [request models](happyx/ssr/request_models.html) provides routing and working with server.
## - [session](happyx/ssr/session.html) provides working with sessions.
## - [open api](happyx/ssr/docs/open_api.html) provides OpenAPI for HappyX.
## - [utils](happyx/ssr/utils.html) provides some utils to work with HTTPHeaders, JSON and etc.
## 
## ### Template Engine 🎴
## 
## - [engine](happyx/tmpl_engine/engine.html) provides templates for SSR.
## 
## ### Routing 🔌
## 
## - [routing](happyx/routing/routing.html) provides powerful routing and `pathParams` macro.
## - [mounting](happyx/routing/mounting.html) provides powerful mounting.
## - [decorators](happyx/routing/decorators.html) provides powerful decorators.
## 
## ### Syntax Sugar ✨
## 
## - [use](happyx/sugar/use.html) provides `use` macro.
## - [style](happyx/sugar/style.html) provides `buildStyle` macro.
## - [sgr](happyx/sugar/sgr.html) provides `->` macro.
## - [js](happyx/sugar/js.html) provides `buildJs` macro.
## 
## ### Language Binds ✌
## 
## #### Python 🐍
## - [python](happyx/bindings/python_types.html) main module for Python HappyX.
## - [python_types](happyx/bindings/python.html) Python types.
## 
when not defined(js):
  import
    happyx/ssr/server,
    happyx/ssr/request_models,
    happyx/ssr/form_data,
    happyx/ssr/cors,
    happyx/ssr/session,
    happyx/core/secure,
    std/sugar

  export
    server,
    request_models,
    form_data,
    cors,
    session,
    secure,
    sugar

import
  happyx/core/[exceptions, constants],
  happyx/sugar/[use, sgr, js, style],
  happyx/spa/[renderer, state, translatable, tag],
  happyx/routing/[mounting, decorators],
  happyx/ssr/utils

when enableTemplateEngine:
  import happyx/tmpl_engine/engine

when enableAppRouting:
  import happyx/routing/routing
  import happyx/core/queries
when enableDefaultComponents:
  import regex
  export regex
  import happyx/spa/components
  export components

when defined(js):
  import happyx/spa/spa_utils
  export spa_utils


when enableApiDoc and not defined(js) and not exportPython and not exportJvm:
  import happyx/ssr/docs/open_api
  export open_api

export
  exceptions,
  constants,
  use,
  renderer,
  state,
  decorators,
  translatable,
  style,
  tag,
  mounting,
  sgr,
  js,
  utils

when enableAppRouting:
  export routing, queries
when enableTemplateEngine:
  export engine


# Language bindings
when exportPython:
  import happyx/bindings/[python]
  export python


when exportJvm:
  import happyx/bindings/[java]
  export java

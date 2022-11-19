# First Project

## Run Project

```bash
yarn install
yarn serve
```

## Writing from Scratch

### Initialize Project

1. Install  `purescript`, `spago` and `vite`

   ```bash
   yarn add purescript spago vite
   ```

2. Initialize a `purescript` project

   ```bash
   spago init
   ```

3. Let us now create a directory dev, and inside of it a  `HTML` file and a `JavaScript` file to serve `halogen` with `vite`

   ```bash
   mkdir dev
   touch dev/index.html dev/styles.css dev/main.js
   ```

4. In `styles.css`, add:

   ```css
   .red-color {
       color: red;
   }
   ```

5. Add the following to `index.html`

   ```html
   <!DOCTYPE html>
   <html lang="en">
   <head>
       <meta charset="UTF-8" />
       <meta name="viewport" content="width=device-width, initial-scale=1.0" />
       <title>Halogen App</title>
   </head>
   <body>
   <script type="module" src="./main.js"></script>
   </body>
   </html>
   
   ```

6. Import `index.js`, the generated `JavaScript`  code by the `PureScript` compiler

   ```javascript
   import { main } from  '../output/Main'
   
   main()
   
   ```

7. Update `package.json`

   ```json
   {
     "dependencies": {
       "purescript": "^0.15.6",
       "spago": "^0.20.9",
       "vite": "^3.2.4"
     },
     scripts: {
       "build": "spago build",
       "dev": "spago run",
       "serve": "vite serve ./dev",
       "test":  "spago test"
     }
   }
   
   ```


### Adding Halogen

1. Install the package with `spago`

   ```bash
   spago install halogen
   ```

2. Let us now rewrite `src/Main.purs` to make the simplest possible application with Halogen:

   ```purescript
   module Main where
   
   import Prelude
   
   import Effect (Effect)
   import Halogen.Aff as HA
   import Halogen.VDom.Driver (runUI)
   import Halogen as H
   import Halogen.HTML (ClassName(..))
   import Halogen.HTML as HH
   import Halogen.HTML.Properties as HP
   
   main :: Effect Unit
   main = HA.runHalogenAff do
     body <- HA.awaitBody
     runUI component unit body
   
   data Action = Nothing
   
   component :: forall query input output m. H.Component query input output m
   component =
       H.mkComponent
           { initialState
           , render
           , eval: H.mkEval H.defaultEval { handleAction = handleAction }
           }
       where
       initialState _ = "Hello World"
   
       render state =
           HH.h1 [ HP.class_ $ ClassName "red-color" ] [ HH.text state ]
   
       handleAction = case _ of
           Nothing -> H.modify_ \state -> state
   ```

   
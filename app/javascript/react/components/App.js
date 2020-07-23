import React from 'react'
import { BrowserRouter, Switch, Route } from "react-router-dom"

import VideogamesContainer from "./Video_game_folder/VideogamesContainer"
import VideogameShowContainer from "./Video_game_folder/VideogameShowContainer"

export const App = (props) => {
  return (
    <div clasName="App">
      <BrowserRouter>
        <Switch>
          <Route exact path="/" component={VideogamesContainer} />
          <Route exact path="/videogames" component={VideogamesContainer} />
          <Route exact path="/videogames/:id" component={VideogameShowContainer} />
        </Switch>
      </BrowserRouter>
    </div>
  )
}

export default App

import React from 'react'
import { BrowserRouter, Switch, Route } from "react-router-dom"

import VideogamesContainer from "./Video_game_folder/VideogamesContainer"

export const App = (props) => {
  return (
    <BrowserRouter>
      <Switch>
        <Route exact path="/" component={VideogamesContainer} />
      </Switch>
    </BrowserRouter>
  )
}

export default App

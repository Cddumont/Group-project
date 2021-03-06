import React from "react";
import { BrowserRouter, Switch, Route } from "react-router-dom";

import VideogamesContainer from "./Video_game_folder/VideogamesContainer";
import VideogameFormContainer from "./Video_game_folder/VideogameFormContainer";
import VideogameShowContainer from "./Video_game_folder/VideogameShowContainer";

export const App = (props) => {
  return (
    <div className="App">
      <BrowserRouter>
        <Switch>
          <Route exact path="/" component={VideogamesContainer} />
          <Route exact path="/videogames" component={VideogamesContainer} />
          <Route exact path="/videogames/new" component={VideogameFormContainer} />
          <Route exact path="/videogames/:id" component={VideogameShowContainer} />
        </Switch>
      </BrowserRouter>
    </div>
  );
};

export default App;

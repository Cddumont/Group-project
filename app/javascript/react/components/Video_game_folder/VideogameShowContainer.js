import React, { useState, useEffect } from "react"

import VideogameShowTile from "./VideogameShowTile"

const VideogameShowContainer = (props) => {
  const [videogame, setVideogame] = useState({})
  let gameId = props.match.params.id

  useEffect(() => {
    fetch(`/api/v1/videogames/${gameId}`, {
      credentials: 'same-origin'
    })
      .then(response => {
        if (response.ok) {
          return response;
        } else {
          let errorMessage = `${response.status} (${response.statusText})`,
            error = new Error(errorMessage);
          throw (error);
        }
      })
      .then(response => response.json())
      .then(body => {
        setVideogame(body)
      })
      .catch(error => console.error(`Error in fetch: ${error.message}`))
  }, [])

  return (
    <VideogameShowTile videogame={videogame} />
  )
}

export default VideogameShowContainer
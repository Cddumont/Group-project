import React, { useState, useEffect } from "react"
import { Link } from "react-router-dom";

import Videogame from "./Videogame"

const VideogamesContainer = (props) => {
  const [videogamesData, setVideogamesData] = useState([])

  useEffect(() => {
    fetch("/api/v1/videogames", {
      credentials: "same-origin"
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
        setVideogamesData(body.videogames)
      })
      .catch(error => console.error(`Error in fetch: ${error.message}`))
  }, [])

  const videogamesComponents = videogamesData.map((videogame) => {
    return (
      <Videogame
        key={videogame.id}
        id={videogame.id}
        name={videogame.name}
        releaseYear={videogame.release_year}
        description={videogame.description}
        image={videogame.image}
      />
    )
  })

  return (
    <>
      <div className="grid-y">{videogamesComponents}
        <Link to="/videogames/new" id="add-new-videogame" className="text-center">Add New Videogame</Link>
      </div>
    </>
  )
}

export default VideogamesContainer
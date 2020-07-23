import React from 'react'

const VideogameShowTile = (props) => {
  return (
    <div>
      <h1>{props.videogame.name}</h1>
      <p>{props.videogame.release_year}</p>
      <p>{props.videogame.description}</p>
    </div>
  )
}

export default VideogameShowTile
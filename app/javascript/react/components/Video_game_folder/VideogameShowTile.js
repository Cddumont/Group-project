import React from 'react'

const VideogameShowTile = (props) => {
  return (
    <div className="grid-y show-page-infoblock">
      <div className="grid-x information-videogame-tab cell callout">
        <p className="cell show-page-name">{props.videogame.name}</p>
        <p className="cell">{props.videogame.release_year}</p>
      </div>
      <div className="cell callout show-page-description">
        <p>Description: </p>
        <p>{props.videogame.description}</p>
      </div>
    </div>
  )
}

export default VideogameShowTile

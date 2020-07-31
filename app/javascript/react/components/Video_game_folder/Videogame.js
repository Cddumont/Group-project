import React from "react"

import { Link } from "react-router-dom"

const Videogame = props => {
  
  return (
    <div className="videogames cell small-6" style={{
      backgroundImage: `url(${props.image})`,
      width: '100%',
      height: '100%',
      backgroundPosition: 'center'
    }}>
        <Link to={`/videogames/${props.id}`}>
          <p className="index-game text-center">{props.name}</p>
        </Link>
    </div>
  )
}

export default Videogame
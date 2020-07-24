import React from "react"

import { Link } from "react-router-dom"

const Videogame = props => {
  
  return (
    <div className="videogames">
        <Link to={`/videogames/${props.id}`}>
          <p>Title: {props.name}</p>
        </Link>
    </div>
  )
}

export default Videogame
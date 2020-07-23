import React from "react"

import { Link } from "react-router-dom"

const Videogame = props => {
  
  return (
    <div className="videogames">
      <ul>
        <Link to={`/videogames/${props.id}`}>
          <ul>Title: {props.name}</ul>
        </Link>
      </ul>
    </div>
  )
}

export default Videogame
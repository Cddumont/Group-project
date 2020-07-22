import React from "react"

const Videogame = props => {
  
  return (
    <div className="videogames">
      <ul>
        <ul>Title: {props.name}</ul>
      </ul>
    </div>
  )
}

export default Videogame
import React from "react"

const Videogame = props => {
  
  return (
    <div className="videogames">
      <p>Title: {props.name}</p>
    </div>
  )
}

export default Videogame
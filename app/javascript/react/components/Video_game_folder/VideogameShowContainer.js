import React, { useState, useEffect } from "react"
import { Redirect } from "react-router-dom";

import VideogameShowTile from "./VideogameShowTile"
import ReviewTile from "./ReviewTile"
import ReviewFormContainer from './ReviewFormContainer'

const VideogameShowContainer = (props) => {
  const [videogame, setVideogame] = useState({})
  const [reviews, setReviews] = useState([])
  const [errors, setErrors] = useState("")
  const [shouldRedirect, setShouldRedirect] = useState(false);
  
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
        setVideogame(body.videogame)
        setReviews(body.videogame.reviews)
      })
      .catch(error => console.error(`Error in fetch: ${error.message}`))
  }, [])

  const addNewReview = (newReview) => {
    setReviews([...reviews, newReview])
  }

  const updateReviews = (updatedReview) => {
    setReviews(updatedReview)
  }

  const deleteVideogame = (event) => {
    fetch(`/api/v1/videogames/${gameId}/`, {
      credentials: "same-origin",
      method: "DELETE",
      headers: {
        Accept: "application/json",
        "Content-Type": "application/json",
      },
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
      if (body.redirect) {
        setShouldRedirect(true)
      } else {
        setErrors(body.error)
      }
    })
    .catch(error => console.error(`Error in fetch: ${error.message}`))
  }

  const reviewsComponents = reviews.sort((a,b) => b.vote_count - a.vote_count).map((review) => {    
    return (
      <ReviewTile
        key={review.id}
        id={review.id}
        rating={review.rating}
        body={review.body}
        title={review.title}
        admin={videogame.admin_user}
        voteCount={review.vote_count}
        updateReviews={updateReviews}
      />
    )
  })

  let errorMsg = <></>
  if (errors !== "") {
    errorMsg = <p className="error-message">{errors}</p>
  }

  let deleteButton = <></>
  if (videogame.admin_user) {
    deleteButton = <div className="button cell" onClick={deleteVideogame}>Delete Videogame</div>
  }

  if (shouldRedirect) {
    return <Redirect to="/" />;
  }

  return (
    <div className="grid-container" style={{
      backgroundImage: `url(${videogame.image})`,
      width: '100%',
      height: '100%',
      backgroundPosition: 'center'
    }}>
      <VideogameShowTile videogame={videogame} />
      {reviewsComponents}
      <ReviewFormContainer
        gameId={gameId}
        addNewReview={addNewReview}
      />
      {errorMsg}
      {deleteButton}
    </div>
  )
}

export default VideogameShowContainer
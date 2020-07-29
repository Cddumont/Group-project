import React, { useState, useEffect } from "react"

import VideogameShowTile from "./VideogameShowTile"
import ReviewTile from "./ReviewTile"
import ReviewFormContainer from './ReviewFormContainer'

const VideogameShowContainer = (props) => {
  const [videogame, setVideogame] = useState({})
  const [reviews, setReviews] = useState([])
  
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

  const reviewsComponents = reviews.map((review) => {    
    return (
      <ReviewTile
        key={review.id}
        id={review.id}
        rating={review.rating}
        body={review.body}
        title={review.title}
        voteCount={review.vote_count}
        updateReviews={updateReviews}
      />
    )
  })

  return (
    <div className="grid-container">
      <VideogameShowTile videogame={videogame} />
      {reviewsComponents}
      <ReviewFormContainer
        gameId={gameId}
        addNewReview={addNewReview}
      />
    </div>
  )
}

export default VideogameShowContainer
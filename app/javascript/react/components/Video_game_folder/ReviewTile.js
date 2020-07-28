import React, { useState } from 'react'

const ReviewTile = props => {

  let title
  if (props.title) {
    title = <p>Title: {props.title}</p>
  } else {
    title = <></>
  }

  let body
  if (props.body) {
    body = <p>Review: {props.body}</p>
  } else {
    body = <></>
  }
  let rating

  switch (props.rating) {
    case 1:
      rating = "★☆☆☆☆"
      break
    case 2:
      rating = "★★☆☆☆"
      break
    case 3:
      rating = "★★★☆☆"
      break
    case 4:
      rating = "★★★★☆"
      break
    case 5:
      rating = "★★★★★"
      break
  }

  const upvoteClick = (event) => {
    event.preventDefault()
    fetch(`/api/v1/reviews/${props.id}/upvotes`, {
      credentials: "same-origin",
      method: "POST",
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
        if (body.review){
          props.updateReviews(body.review)
       }
      })
      .catch(error => console.error(`Error in fetch: ${error.message}`))
  }

  return(
    <div className="callout review-box">
      <p>Rating: {rating}</p>
      {title}
      {body}
      <div className="grid-x">
        <div className="button cell" onClick={upvoteClick}>Upvote</div>
        <p className="cell">Votes: {props.voteCount}</p>
      </div>
    </div>
  )
}
// onClick={upvoteClick}
export default ReviewTile
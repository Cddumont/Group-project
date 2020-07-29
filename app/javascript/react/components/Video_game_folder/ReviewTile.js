import React, { useState } from 'react'

const ReviewTile = props => {
  const [errors, setErrors] = useState("")

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
    setErrors("")
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
        if (body.reviews) {
          props.updateReviews(body.reviews)
        } else if (body.errors) {
          setErrors(body.errors)
        }
      })
      .catch(error => console.error(`Error in fetch: ${error.message}`))
  }

  const downvoteClick = (event) => {
    event.preventDefault()
    setErrors("")
    fetch(`/api/v1/reviews/${props.id}/downvotes`, {
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
        if (body.reviews) {
          props.updateReviews(body.reviews)
        } else if (body.errors) {
          setErrors(body.errors)
        }
      })
      .catch(error => console.error(`Error in fetch: ${error.message}`))

  }

  let errorMessages = <></>
  if (errors !== "") {
    if (errors === "Review has already been taken and User has already been taken") {
      errorMessages = <p className="error-message">You've already voted</p>
    } else {
      errorMessages = <p className="error-message">You must be signed in to vote</p>
    }
  }


  return (
    <div className="callout review-box">
      {errorMessages}
      <p>Rating: {rating}</p>
      {title}
      {body}
      <div className="grid-x">
        <div className="button cell" onClick={upvoteClick}>Upvote</div>
        <div className="button alert cell" onClick={downvoteClick}>Downvote</div>
        <p className="cell">Votes: {props.voteCount}</p>
      </div>
    </div>
  )
}

export default ReviewTile
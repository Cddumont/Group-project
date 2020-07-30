import React, { useState, useEffect } from 'react'

const ReviewTile = props => {
  const [errors, setErrors] = useState("")
  const [admin, setAdmin] = useState(false)

  useEffect(() => {
    fetch(`/api/v1/reviews/`, {
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
        if (body.admin) {
          setAdmin(true)
        }
      })
      .catch(error => console.error(`Error in fetch: ${error.message}`))
  }, [])

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

  const deleteReview = (event) => {
    fetch(`/api/v1/reviews/${props.id}/`, {
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
      if (body.reviews) {
        props.updateReviews(body.reviews)
      } else {
        setErrors(body.error)
      }
    })
    .catch(error => console.error(`Error in fetch: ${error.message}`))
  }

  let errorMessages = <></>
  if (errors !== "") {
    if (errors === "Review has already been taken and User has already been taken") {
      errorMessages = <p className="error-message">You've already voted</p>
    } else if (errors === "Only Admins May Delete Reviews") {
      errorMessages = <p className="error-message">Only admins may delete reviews</p>
    } else {
      errorMessages = <p className="error-message">You must be signed in to vote</p>
    }
  }

  let deleteButton = <></>

  if (admin) {
    deleteButton = <div className="button cell" onClick={deleteReview}>Delete</div>
  }

  return (
    <div className="callout review-box">
      {errorMessages}
      <p>Rating: {rating}</p>
      {title}
      {body}
      <div className="grid-x">
        <div className="button success cell" onClick={upvoteClick}>Upvote</div>
        <div className="button alert cell" onClick={downvoteClick}>Downvote</div>
        {deleteButton}
        <p className="cell">Votes: {props.voteCount}</p>
      </div>
    </div>
  )
}

export default ReviewTile
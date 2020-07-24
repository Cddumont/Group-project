import React from 'react'

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

  return(
    <div className="callout review-box">
      <p>Rating: {props.rating}</p>
      {title}
      {body}
    </div>
  )
}

export default ReviewTile
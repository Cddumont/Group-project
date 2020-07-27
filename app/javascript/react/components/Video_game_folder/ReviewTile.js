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

  return(
    <div className="callout review-box">
      <p>Rating: {rating}</p>
      {title}
      {body}
    </div>
  )
}

export default ReviewTile
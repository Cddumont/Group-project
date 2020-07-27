import React, { useState } from 'react'

const ReviewFormContainer = props => {
  const [getNewReview, setNewReview] = useState({
    rating: "",
    title: "",
    body: "",
    videogame_id: props.gameId
  });
  const [errors, setErrors] = useState("")

  const handleFieldChange = (event) =>{
    setNewReview({
      ...getNewReview,
      [event.currentTarget.id]: event.currentTarget.value,
    });
  }

  const handleSubmit = (event) => {
    event.preventDefault();
    addNewReview(getNewReview)
  }

  const clearForm = () => {
    setNewReview({
      rating: "",
      title: "",
      body: "",
      videogame_id: props.gameId
    })
  }

  const addNewReview = (formPayload) => {
    fetch("/api/v1/reviews", {
      credentials: "same-origin",
      method: "POST",
      body: JSON.stringify(formPayload),
      headers: {
        Accept: "application/json",
        "Content-Type": "application/json",
      },
    })
    .then((response) => {
      if (response.ok) {
        return response;
      } else {
        let errorMessage = `${response.status} (${response.statusText})`,
          error = new Error(errorMessage);
        throw error;
      }
    })
    .then((response) => response.json())
    .then((body) => {
      if (body.submitted) {
        props.addNewReview(body.review)
        clearForm()
        setErrors("")
      } else {
        setErrors("Please select a rating")
      }
    })
  }
  let errorMessage = <></>;

  if (errors !== "") {
    errorMessage = <p className="error-message">{errors}</p>
  }

  return(
    <div>
      <form onSubmit={handleSubmit} className="new-review-form callout">
      <h3>Add New Review:</h3>
      {errorMessage}
        <label>
          Rating:
          <select id="rating" value={getNewReview.rating} onChange={handleFieldChange}>
            <option value={null}>Select Rating</option>
            <option value="1">★☆☆☆☆</option>
            <option value="2">★★☆☆☆</option>
            <option value="3">★★★☆☆</option>
            <option value="4">★★★★☆</option>
            <option value="5">★★★★★</option>
          </select>
        </label>
        <label>
          Title (optional):
          <input
            name="title"
            id="title"
            type="text"
            value={getNewReview.title}
            onChange={handleFieldChange}
          />
        </label>
        <label>
          Review (optional):
          <input
            name="body"
            id="body"
            type="text"
            value={getNewReview.body}
            onChange={handleFieldChange}
          />
        </label>

        <div className="button-group">
          <input className="button" type="submit" value="Submit" />
        </div>
      </form>
    </div>
  )
}

export default ReviewFormContainer
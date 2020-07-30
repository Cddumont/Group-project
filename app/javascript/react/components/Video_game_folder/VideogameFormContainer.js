import React, { useState, useEffect } from "react";
import { Redirect } from "react-router-dom";

const VideogameFormContainer = (props) => {
  const [getNewVideogame, setNewVideogame] = useState({
    name: "",
    release_year: "",
    description: "",
  });
  const [shouldRedirect, setShouldRedirect] = useState(false);

  const [error, setError] = useState("");

  const handleFieldChange = (event) => {
    setNewVideogame({
      ...getNewVideogame,
      [event.currentTarget.id]: event.currentTarget.value,
    });
  };

  const addNewVideogame = (formInfo) => {
    fetch("/api/v1/videogames", {
      credentials: "same-origin",
      method: "POST",
      body: JSON.stringify(formInfo),
      headers: {
        Accept: "application/json",
        "Content-Type": "application/json",
      },
    })
    .then((response) => {
      if (response.ok) {
        return response;
      } else if (response.status===401) {
        setError("You must sign in before submitting a review!");
        let errorMessage = `${response.status} (${response.statusText})`,
        error = new Error(errorMessage)
        throw error;
      } else{ 
        let errorMessage = `${response.status} (${response.statusText})`,
        error = new Error(errorMessage);
        throw error;
      }})
      .then((response) => response.json())
      .then((body) => {
        if (body.submitted) {
          setShouldRedirect(true);
        } else setError(body.error);
      })
      .catch(error => console.error(`Error in fetch: ${error.message}`))
  };

  const handleSubmit = (event) => {
    event.preventDefault();
    addNewVideogame(getNewVideogame);
  };

  let errorMessage = <></>;

  if (error !== "") {
    errorMessage = <p className="error-message">{error}</p>;
  }

  if (shouldRedirect) {
    return <Redirect to="/" />;
  }

  return (
    <div>
      <form onSubmit={handleSubmit} className="new-videogame-form callout">
      {errorMessage}
        <label>
          Videogame Name:
          <input
            name="name"
            id="name"
            type="text"
            onChange={handleFieldChange}
          />
        </label>
        <label>
          Videogame Release Year:
          <input
            name="release_year"
            id="release_year"
            type="text"
            onChange={handleFieldChange}
          />
        </label>
        <label>
          Videogame Description:
          <input
            name="description"
            id="description"
            type="text"
            onChange={handleFieldChange}
          />
        </label>

        <div className="button-group">
          <input className="button" type="submit" value="Submit" />
        </div>
      </form>
    </div>
  );
};

export default VideogameFormContainer;

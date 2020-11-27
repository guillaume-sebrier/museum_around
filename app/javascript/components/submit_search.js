const submitSearch = () => {
  const form = document.querySelector(".search");
  // recuper l'element de la loupe queryS
  // ecouter le click .addEventListener
  // soumettre le formulaire form.submit
  const magnify = document.querySelector(".fa-search");
  if (magnify) {
    magnify.addEventListener("click", (event) => {
      form.submit()
    })
  }
}

export {submitSearch};


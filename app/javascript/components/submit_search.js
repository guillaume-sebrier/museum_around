const submitSearch = () => {
  console.log('');
  const form = document.querySelector(".search");
  console.log(form);
  // recuper l'element de la loupe queryS
  // ecouter le click .addEventListener
  // soumettre le formulaire form.submit
  const magnify = document.querySelector(".fa-search");
  console.log(magnify);
  magnify.addEventListener("click", (event) => {
    form.submit()
  })
}

export {submitSearch};


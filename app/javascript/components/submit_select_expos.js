const submitSelectExpos = () => {
  const form = document.querySelector(".form-map-expos");
  const select = document.querySelector(".select-button-expos");
  if (select) {
    select.addEventListener("click", (event) => {
      form.submit()
    })
  }
}

export { submitSelectExpos }

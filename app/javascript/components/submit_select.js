const submitSelect = () => {
  const form = document.querySelector(".form-map");
  const select = document.querySelector(".select-button");
  if (select) {
    select.addEventListener("change", (event) => {
      form.submit()
    })
  }
}

export {submitSelect}

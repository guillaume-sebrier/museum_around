const modalFilter = () => {
  const filter = document.querySelector("#filter");
  if (filter) {
    filter.addEventListener("click", (event) => {
      form.submit()
    })
  }
}

export { modalFilter }

const initCounterForVisits = () => {
  const minusButton = document.querySelector(".quantity-minus");
  const plusButton = document.querySelector(".quantity-plus");
  const visitsCount = document.querySelector("#booking_number_of_tickets");
  if (visitsCount) {
    minusButton.addEventListener("click", (event) => {

      if (visitsCount.value > 1) {
        visitsCount.value = parseInt(visitsCount.value) - 1;
      };
    });
    plusButton.addEventListener("click", (event) => {
      if (visitsCount.value < 40) {
        visitsCount.value = parseInt(visitsCount.value) + 1;
      };
    });
  };
};

export { initCounterForVisits }

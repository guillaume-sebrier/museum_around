import { French } from "flatpickr/dist/l10n/fr.js"

const initFlatpickr = () => {
  const startDateInput = document.getElementById('booking_date');
  if (startDateInput) {
    console.log("flatpickr");
    flatpickr(startDateInput, {
      minDate: "today",
      // enableTime: true,
      // time_24hr: true,
      locale: French,
      altInput: true,
      // inline: true,
      // minTime: "8:00",
      // maxTime: "20:00",
      altFormat: "Le j F Y",
      dateFormat: "d-m-Y",
    });
  };
};

export { initFlatpickr }

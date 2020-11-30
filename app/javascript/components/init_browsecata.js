

function initBrowsecata() {
  $('.banner-b i').on('click', function (e) {
    if (this.hash !== '') {
        e.preventDefault();

        const hash = this.hash;
console.log("initBrowsecata")
        $('html, body').animate({
                scrollTop: $(hash).offset().top - 100,
            },
            800
        );
    }
  });
}

export { initBrowsecata };

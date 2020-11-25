const initTabs = () => {
  const tabs = document.querySelectorAll('[data-tab-target]');
  // const tabContents = document.querySelectorAll

  tabs.forEach((tab) => {
    tab.addEventListener('click', () => {
      const tabContents = document.querySelectorAll('[data-tab-content]');
      tabContents.forEach((tabContent) => {
        tabContent.classList.remove('active');
      })
      tabs.forEach((tab) => {
        tab.classList.remove('active');
      })

      const target = document.querySelector(tab.dataset.tabTarget);
      tab.classList.add('active');
      target.classList.add('active');
    })
  })
}







export { initTabs };

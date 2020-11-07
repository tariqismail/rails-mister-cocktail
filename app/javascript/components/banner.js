import Typed from 'typed.js'

const loadDynamicBannerText = () => {
  new Typed('#banner-typed-text', {
    strings: ["Change your life", "Let's make super tasty mocktails!"],
    typeSpeed: 50,
    loop: true
  });
}

export { loadDynamicBannerText };

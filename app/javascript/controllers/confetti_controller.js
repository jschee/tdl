import { Controller } from "@hotwired/stimulus"
import JSConfetti from 'js-confetti'

export default class extends Controller {
  connect() {
    const jsConfetti = new JSConfetti()
    jsConfetti.addConfetti()

    setTimeout(function(){
      document.querySelector('canvas').remove();
    }, 2000)
  }
}

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    if (document.querySelectorAll('input').length > 0 ) {
      this.showSubmit()
    } else {
      this.hideSubmit()
    }
  }

  showSubmit() {
    let submit = document.querySelector("#submit-task")
    submit.classList.remove('hidden')
  }

  hideSubmit() {
    let submit = document.querySelector("#submit-task")
    submit.classList.remove('hidden')
  }
}

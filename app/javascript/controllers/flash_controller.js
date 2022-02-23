import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  close() {
    console.log('in close')
    this.element.remove();
  }
}

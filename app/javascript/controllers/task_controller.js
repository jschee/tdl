import { Controller } from "@hotwired/stimulus"
import { post } from '@rails/request.js'
import JSConfetti from 'js-confetti'

export default class extends Controller {
  static targets = [ "complete", "awesome" ]
  static values = { list: String,
                    task: String }

  async updateStatus() {
    let list = event.target.dataset.taskListValue
    let task = event.target.dataset.taskTaskValue
    let statusParams = this.completeTarget.checked ? "complete" : "incomplete"
    let incomplete_list = document.querySelector('#incomplete-tasks ul');
    let complete_list = document.querySelector('#complete-tasks ul');

    const response = await post(`/lists/${list}/tasks/${task}/status?status=${statusParams}`, { responseKind: "turbo-stream" })
    if (response.ok) {
      if (statusParams == "complete") {
        const jsConfetti = new JSConfetti()
        jsConfetti.addConfetti()
      }
    }

  }

  incompleteTasks() {
    let list = document.querySelector('#incomplete-tasks');
  }
}

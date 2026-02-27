import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  static values = { url: String, param: { type: String, default: "position" } }

  connect() {
    this.sortable = new Sortable(this.element, {
      animation: 150,
      ghostClass: "opacity-30",
      dragClass: "shadow-2xl",
      handle: "[data-sortable-handle]",
      onEnd: this.onEnd.bind(this)
    })
  }

  disconnect() {
    if (this.sortable) this.sortable.destroy()
  }

  onEnd(event) {
    if (event.oldIndex === event.newIndex) return

    const id = event.item.dataset.sortableId
    if (!id || !this.urlValue) return

    const url = this.urlValue.replace(":id", id)
    const csrfToken = document.querySelector("meta[name='csrf-token']")?.content

    fetch(url, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken,
        "Accept": "text/vnd.turbo-stream.html"
      },
      body: JSON.stringify({ [this.paramValue]: event.newIndex + 1 })
    })
  }
}

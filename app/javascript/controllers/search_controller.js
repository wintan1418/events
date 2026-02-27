import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results"]
  static values = { url: String }

  filter() {
    const query = this.inputTarget.value.toLowerCase()
    const rows = this.resultsTarget.querySelectorAll("[data-search-target='row']")

    rows.forEach(row => {
      const text = row.textContent.toLowerCase()
      row.style.display = text.includes(query) ? "" : "none"
    })
  }

  clear() {
    this.inputTarget.value = ""
    this.filter()
  }
}

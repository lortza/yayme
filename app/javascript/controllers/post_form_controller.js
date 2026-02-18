import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["postTypeSelect", "description"]

  connect() {
    if (!this.descriptionTarget.value) {
      this.fetchTemplate(this.postTypeSelectTarget.value)
    }
  }

  changePostType(event) {
    if (!this.descriptionTarget.value) {
      this.fetchTemplate(event.target.value)
    }
  }

  fetchTemplate(postTypeId) {
    fetch(`/post_types/${postTypeId}.json`)
      .then(response => response.json())
      .then(data => { this.descriptionTarget.value = data.description_template })
      .catch(err => console.error(err))
  }
}

import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="items"
export default class extends Controller {
  submit_charge(e) {
    const itemId = e.target.dataset.itemId
    const monthlyItemId = e.target.dataset.monthlyItemId
    const csrfToken = document.querySelector("[name='csrf-token']").content

    fetch(`/monthly_items/${monthlyItemId}/items/${itemId}`, {
      method: 'PUT',
      mode: 'cors',
      cache: 'no-cache',
      credentials: 'same-origin',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify( { applied: e.target.checked, item_id: itemId } )
    })
  }

}

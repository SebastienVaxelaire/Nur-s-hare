import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  connect() {
    console.log("Hello from notifications controller")
    this.channel = createConsumer().subscriptions.create("NotificationsChannel", {
      received: this.handleReceived.bind(this)
    });
  }

  disconnect() {
    this.channel.unsubscribe()
  }

  handleReceived(data) {
    this.showFlash(data.message);
  }

  showFlash(message) {
    const flashDiv = document.createElement("div");
    const successBabyUrlMetaTag = document.head.querySelector("[name='success-baby-url']");

    if (!successBabyUrlMetaTag) {
      console.error('La balise meta "success-baby-url" n\'a pas été trouvée.');
      return;
    }

    const successBabyUrl = successBabyUrlMetaTag.content;
    flashDiv.innerHTML = `<div class="alert alert-success alert-dismissible fade show m-1" role="alert">
                            <div class="d-flex justify-content-start align-items-center">
                              <div class="me-2">
                              <img src="${successBabyUrl}" height="70px">
                              </div>
                              <div class="">
                                ${message}
                              </div>
                            </div>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">
                            </button>
                          </div>`;

    // Ajoutez le message flash à la page
    document.body.appendChild(flashDiv);

  }
}

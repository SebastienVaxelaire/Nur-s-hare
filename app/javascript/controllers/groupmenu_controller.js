import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="groupmenu"
export default class extends Controller {
  connect() {
    console.log("hello from group controller")
    this.activeClass = 'active';
    document.querySelector('.first').classList.add('active');

  }

  toggleDiscussion(event) {
    this.resetActiveClass();
    event.currentTarget.classList.add(this.activeClass);
    document.querySelector('.calendar-active').classList.add('d-none');
    document.querySelector('.map-active').classList.add('d-none');
    document.querySelector('.chat-active').classList.remove('d-none');
    document.querySelector('.members-active').classList.add('d-none');
    document.querySelector('.events-active').classList.add('d-none');
  }

  toggleAgenda(event) {
    this.resetActiveClass();
    event.currentTarget.classList.add(this.activeClass);
    document.querySelector('.calendar-active').classList.remove('d-none');
    document.querySelector('.map-active').classList.add('d-none');
    document.querySelector('.chat-active').classList.add('d-none');
    document.querySelector('.members-active').classList.add('d-none');
    document.querySelector('.events-active').classList.add('d-none');
  }

  toggleMembers(event) {
    this.resetActiveClass();
    event.currentTarget.classList.add(this.activeClass);
    document.querySelector('.members-active').classList.remove('d-none');
    document.querySelector('.calendar-active').classList.add('d-none');
    document.querySelector('.map-active').classList.remove('d-none');
    document.querySelector('.chat-active').classList.add('d-none');
    document.querySelector('.events-active').classList.add('d-none');
  }

  toggleEvents(event) {
    this.resetActiveClass();
    event.currentTarget.classList.add(this.activeClass);
    document.querySelector('.events-active').classList.remove('d-none');
    document.querySelector('.members-active').classList.add('d-none');
    document.querySelector('.calendar-active').classList.add('d-none');
    document.querySelector('.map-active').classList.add('d-none');
    document.querySelector('.chat-active').classList.add('d-none');
  }

  resetActiveClass() {
    const menuItems = document.querySelectorAll('.menu');
    menuItems.forEach(item => {
      item.classList.remove(this.activeClass);
    });
  }
}

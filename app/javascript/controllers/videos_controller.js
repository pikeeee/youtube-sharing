import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["container", "notification"];
  connect() {
    this.newVideos = [];

    window.addEventListener("newVideo", (e) => {
      this.newVideos.push(e.detail);
      this.showNotification();
    });
  }
  disconnect() {
    window.removeEventListener("newVideo", this.showNotification);
  }
  showNotification() {
    this.newVideos.forEach((video) => {
      console.log("Video HTML string:", video);

      const parser = new DOMParser();
      const html = parser.parseFromString(video, "text/html");
      const videoNode = html.body.firstChild;

      const spans = videoNode.getElementsByTagName('span');

      const username = spans[0].innerText;

      const title = spans[1].innerText;

      this.containerTarget.prepend(videoNode);

      alert(`New video has been loaded!\nUsername: ${username}\nTitle: ${title}`);
    });
    this.newVideos = [];
    this.notificationTarget.style.display = "none";
  }
}

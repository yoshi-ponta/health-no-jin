import "@hotwired/turbo-rails"
import "./controllers"
import "./exercise_log_modal"
import { bindPasswordVisibility } from "./password_visibility";

document.addEventListener("turbo:load", () => {
  bindPasswordVisibility(document);
});
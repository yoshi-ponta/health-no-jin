export function bindPasswordVisibility(root = document) {
  root.querySelectorAll("[data-eye-toggle]").forEach((btn) => {
    const input = root.getElementById(btn.getAttribute("data-eye-target"));
    if (!input) return;

    btn.addEventListener("click", () => {
      const show = input.type === "password";
      input.type = show ? "text" : "password";

      btn.querySelectorAll("[data-eye-show]").forEach(el => el.classList.toggle("hidden", !show));
      btn.querySelectorAll("[data-eye-hide]").forEach(el => el.classList.toggle("hidden", show));
    });
  });
}

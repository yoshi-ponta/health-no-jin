(() => {
  let bound = false;

  function bind() {
    if (bound) return;
    bound = true;

    document.addEventListener("click", (e) => {
      const opener = e.target.closest("[data-modal-target]");
      if (opener) {
        const id  = opener.getAttribute("data-modal-target");
        const dlg = id && document.getElementById(id);
        if (dlg && typeof dlg.showModal === "function") {
          dlg.showModal();
          opener.setAttribute("aria-expanded", "true");

          const onOutside = (ev) => {
            const box = dlg.querySelector(".modal-box") || dlg.firstElementChild;
            if (box && !box.contains(ev.target)) dlg.close();
          };
          const onClose = () => {
            opener.setAttribute("aria-expanded", "false");
            dlg.removeEventListener("click", onOutside);
            dlg.removeEventListener("close", onClose);
            try { opener.focus(); } catch {}
          };

          dlg.addEventListener("click", onOutside);
          dlg.addEventListener("close", onClose);
        }
        return;
      }

      const closer = e.target.closest("[data-close-dialog]");
      if (closer) {
        const id  = closer.getAttribute("data-close-dialog");
        const dlg = (id && document.getElementById(id)) || closer.closest("dialog");
        if (dlg && typeof dlg.close === "function") dlg.close();
        return;
      }
    }, { capture: true });
  }

  document.addEventListener("turbo:load", bind);
  document.addEventListener("DOMContentLoaded", bind);
})();

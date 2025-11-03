document.addEventListener("DOMContentLoaded", () => {
  const SELECTED_CLASSES = ["border-primary", "ring-2", "ring-primary", "ring-offset-1"];
  const form = document.getElementById("exercise-log-form");

  function resetDialog(dialog) {
    if (!dialog) return;
    const prev = dialog.querySelector('[data-select-item][aria-pressed="true"]');
    if (prev) {
      SELECTED_CLASSES.forEach((c) => prev.classList.remove(c));
      prev.removeAttribute("aria-pressed");
    }
    const recordBtn = dialog.querySelector("[data-record-submit]");
    if (recordBtn) recordBtn.disabled = true;
  }

  function selectItem(button) {
    const dialog = button.closest("dialog");
    if (!dialog) return;

    const prev = dialog.querySelector('[data-select-item][aria-pressed="true"]');
    if (prev && prev !== button) {
      SELECTED_CLASSES.forEach((c) => prev.classList.remove(c));
      prev.removeAttribute("aria-pressed");
    }
    SELECTED_CLASSES.forEach((c) => button.classList.add(c));
    button.setAttribute("aria-pressed", "true");

    const recordBtn = dialog.querySelector("[data-record-submit]");
    if (recordBtn) recordBtn.disabled = false;
  }

  function submitSelection(button) {
    const dialog = button.closest("dialog");
    if (!dialog || !form) return;

    const selected = dialog.querySelector('[data-select-item][aria-pressed="true"]');
    const itemId = selected?.dataset.exerciseItemId;
    if (!itemId) return;

    const idInput = form.querySelector('input[name="exercise_log[exercise_item_id]"]');
    if (idInput) idInput.value = itemId;

    // performed_at が未設定なら今の時刻を入れる
    const tsInput = form.querySelector('input[name="exercise_log[performed_at]"]');
    if (tsInput && !tsInput.value) tsInput.value = new Date().toISOString();

    if (typeof form.requestSubmit === "function") form.requestSubmit();
    else form.submit();

    dialog.close();
  }

  document.addEventListener("click", (e) => {
    const opener = e.target.closest("[data-modal-target]");
    if (opener) {
      const raw = opener.getAttribute("data-modal-target") || "";
      const id = raw.replace(/^#/, "");
      const dlg = document.getElementById(id);
      if (dlg?.showModal) {
        resetDialog(dlg);
        dlg.showModal();
      }
      return;
    }

    const selectButton = e.target.closest("[data-select-item]");
    if (selectButton) {
      selectItem(selectButton);
      return;
    }

    const recordButton = e.target.closest("[data-record-submit]");
    if (recordButton) {
      submitSelection(recordButton);
      return;
    }

    const closer = e.target.closest("[data-close-dialog]");
    if (closer) {
      const raw = closer.getAttribute("data-close-dialog") || "";
      const id = raw.replace(/^#/, "");
      const dlg = id ? document.getElementById(id) : closer.closest("dialog");
      if (dlg) dlg.close();
      return;
    }
  });

  document.addEventListener("keydown", (e) => {
    if (e.key !== "Escape") return;
    const openDlg = document.querySelector("dialog[open]");
    if (openDlg) openDlg.close();
  });
}, { once: true });

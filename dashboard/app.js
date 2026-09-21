/* ----------------------------------------------------------
   MySQL-perso Dashboard v4.0
   Gestion locale des notes + hooks API (future v5.0)
---------------------------------------------------------- */

const notesContainer = document.getElementById("notes");
const statusBar = document.getElementById("status");

/* ----------------------------------------------------------
   UTILITAIRES
---------------------------------------------------------- */

function setStatus(msg) {
    statusBar.textContent = "Status : " + msg;
}

/* ----------------------------------------------------------
   AJOUTER UNE NOTE
---------------------------------------------------------- */

function addNote() {
    const title = document.getElementById("title").value.trim();
    const content = document.getElementById("content").value.trim();

    if (!title || !content) {
        setStatus("Erreur : champs vides");
        return;
    }

    const note = {
        id: Date.now(),
        title,
        content
    };

    saveNote(note);
    renderNote(note);

    document.getElementById("title").value = "";
    document.getElementById("content").value = "";

    setStatus("Note ajoutée");
}

/* ----------------------------------------------------------
   STOCKAGE LOCAL (v4.0)
---------------------------------------------------------- */

function saveNote(note) {
    const notes = JSON.parse(localStorage.getItem("notes") || "[]");
    notes.push(note);
    localStorage.setItem("notes", JSON.stringify(notes));
}

/* ----------------------------------------------------------
   AFFICHAGE DES NOTES
---------------------------------------------------------- */

function renderNote(note) {
    const div = document.createElement("div");
    div.className = "note-card";

    div.innerHTML = `
        <div class="note-title">${note.title}</div>
        <div class="note-content">${note.content}</div>
    `;

    notesContainer.appendChild(div);
}

function loadNotes() {
    const notes = JSON.parse(localStorage.getItem("notes") || "[]");
    notes.forEach(renderNote);
    setStatus("Notes chargées");
}

/* ----------------------------------------------------------
   INIT
---------------------------------------------------------- */

window.onload = () => {
    loadNotes();
};

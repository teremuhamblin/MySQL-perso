const API = 'http://localhost:3000/notes';

async function loadNotes() {
    const res = await fetch(API);
    const notes = await res.json();
    const container = document.getElementById('notes');
    container.innerHTML = '';

    notes.forEach(n => {
        container.innerHTML += `
            <div class="note">
                <h3>${n.title}</h3>
                <p>${n.content}</p>
                <button onclick="deleteNote(${n.id})">Supprimer</button>
            </div>
        `;
    });
}

async function addNote() {
    const title = document.getElementById('title').value;
    const content = document.getElementById('content').value;

    await fetch(API, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ title, content })
    });

    loadNotes();
}

async function deleteNote(id) {
    await fetch(`${API}/${id}`, { method: 'DELETE' });
    loadNotes();
}

loadNotes();

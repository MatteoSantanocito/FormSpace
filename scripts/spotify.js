let empty = './immagini/empty.png'
let fill = '/immagini/fill.png';

let p_empty = './immagini/p_empty.png';
let p_fill = './immagini/p_fill.png';

function jsonSpotify(json) {
    const container = document.getElementById('view');
    container.innerHTML = '';
    container.classList.remove('hidden');
    container.classList.add('new');
    console.log('JSON ricevuto');
    console.log(json);

    if(json.tracks.items.length >=  3){
        json.tracks.items.length = 1;
    }

    for (const track in json.tracks.items) {

        const all = document.createElement('div');
        all.classList.add('all');

        const card = document.createElement('div');
        card.dataset.id = json.tracks.items[track].id;
        card.classList.add('track');

        const img = document.createElement('img');
        img.classList.add('imgSpotify');
        img.src = json.tracks.items[track].album.images[0].url;

        const info = document.createElement('div');
        info.classList.add('info');

        const title = document.createElement('div');
        title.classList.add('titleSpotify');
        title.textContent = json.tracks.items[track].name;

        const author = document.createElement('div');
        author.classList.add('author');
        author.textContent = json.tracks.items[track].artists[0].name;

        const l = json.tracks.items[track].external_urls.spotify;
        const testo = 'Ascolta su spotify';
        const link = document.createElement('a');
        link.href = l;
        link.textContent = testo;
        link.classList.add('link');


        all.appendChild(card);
        all.appendChild(info);
        all.appendChild(link);
        card.appendChild(img);
        info.appendChild(title);
        info.appendChild(author);
        container.appendChild(all);
    }
}

function search(event)
{
    event.preventDefault();
    // Leggo il contenuto da cercare e mando tutto alla pagina PHP
    const element = document.querySelector('#text').value;
    const text = encodeURIComponent(element);
	console.log('Ricerca per : ' + text);

    // Mando le specifiche della richiesta alla pagina PHP, che prepara la richiesta e la inoltra
    fetch("curl.php?q=" + text).then(onResponse).then(jsonSpotify);
}

function onResponse(response)
{
    console.log('Response ricevuto');
    console.log(response);
    return response.json();
}

const elem = document.querySelector('.element');
elem.addEventListener('submit', search);

//---------

function onFocus()
{
  const text = document.getElementById('text');
  text.value = '';
}
const text = document.querySelector("input")
text.addEventListener("focus", onFocus);

//----------

/*function onClick(event){
    const img = document.querySelector('.love_pref .change_h');
    img = event.currentTarget;
    const container = document.getElementById('view');
    const elem = container.classList.add('new')
    if(elem){
        if(img.src === empty){
            img.src = fill;
        }else{
            img.src = empty
        }
    }
}

const container = document.getElementById('view');
const element = container.classList.add('new')
if(element){
    const img = document.querySelector('.love_pref .change_h');
    img.addEventListener('click', onClick);
}*/

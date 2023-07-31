// const resource = GetParentResourceName();
const blackscreen = $('#blackscreen');
const background = $('#background');
const characterContainer = document.getElementById('character-container');
const audio = $('#audio').get(0);

// const charData = [
//   {
//     charid: 1,
//     license: 'x',
//     firstname: 'John',
//     lastname: 'Doe',
//     gender: 'Male',
//     dateofbirth: '01/01/1990',
//     lastPlayed: '8:00 PM 07/25/2023'
//   },
//   {
//     charid: 2,
//     license: 'x',
//     firstname: 'Jane',
//     lastname: 'Doe',
//     gender: 'Female',
//     dateofbirth: '01/01/1990',
//     lastPlayed: '8:00 PM 07/25/2023'
//   }
// ];

let characterIDs = [];

function fadeInBackground() {
  window.requestAnimationFrame(() => {
    background.css({
      'opacity': '1.0',
      'transition': 'all 2.5s ease-in-out'
    });
  });
}

function fadeOutBackground() {
  window.requestAnimationFrame(() => {
    background.css({
      'opacity': '0.0',
      'transition': 'all 2.5s ease-in-out'
    });
  });
}

function fadeInBlackscreen() {
  window.requestAnimationFrame(() => {
    blackscreen.css({
      'opacity': '1.0',
      'transition': 'all 2.5s ease-in-out'
    });
  });
}

function fadeOutBlackscreen() {
  window.requestAnimationFrame(() => {
    blackscreen.css({
      'opacity': '0.0',
      'transition': 'all 2.5s ease-in-out'
    });
  });
}

function createNewCard() {
  let newDiv = document.createElement('new-card');
  newDiv.setAttribute('id', 'new-button');
  newDiv.classList.add('new-card');

  let newButton = document.createElement('newButton');
  newButton.textContent = 'CREATE';
  newButton.classList.add('new-button');

  newDiv.appendChild(newButton);
  characterContainer.append(newDiv);
}

function createExistingCards(charData) {
  charData.forEach((character) => {
    let characterDiv = document.createElement('div');
    let characterID = 'character-' + character.charid;
    characterDiv.classList.add('character-card');
    characterDiv.setAttribute('id', characterID);
    characterIDs.push(characterID);

    let charIDLabelElem = document.createElement('charIDLabel');
    charIDLabelElem.textContent = 'ID';
    charIDLabelElem.classList.add('char-id-label');

    let charIDElem = document.createElement('charID');
    charIDElem.textContent = character.charid;
    charIDElem.classList.add('char-id');

    let nameLabel = document.createElement('nameLabel');
    nameLabel.textContent = 'NAME';
    nameLabel.classList.add('name-label');

    let name = document.createElement('name');
    name.textContent = character.firstname + ' ' + character.lastname;
    name.classList.add('name');

    let genderLabel = document.createElement('genderLabel');
    genderLabel.textContent = 'GENDER';
    genderLabel.classList.add('gender-label');

    let gender = document.createElement('gender');
    gender.textContent = character.gender;
    gender.classList.add('gender');

    let dobLabel = document.createElement('dobLabel');
    dobLabel.textContent = 'DOB';
    dobLabel.classList.add('dob-label');

    let dob = document.createElement('dob');
    dob.textContent = character.dateofbirth;
    dob.classList.add('dob');

    let lastPlayedLabel = document.createElement('lastPlayedLabel');
    lastPlayedLabel.textContent = 'LAST PLAYED';
    lastPlayedLabel.classList.add('last-played-label');

    let lastPlayed = document.createElement('lastPlayed');
    lastPlayed.textContent = character.lastPlayed;
    lastPlayed.classList.add('last-played');

    let playDeleteContainer = document.createElement('playDeleteContainer');
    playDeleteContainer.classList.add('play-delete-container');

    let playButton = document.createElement('playButton');
    playButton.textContent = 'PLAY';
    playButton.classList.add('play-button');
    playButton.setAttribute('charid', character.charid);

    let deleteButton = document.createElement('deleteButton');
    deleteButton.textContent = 'DELETE';
    deleteButton.classList.add('delete-button');

    characterDiv.appendChild(charIDLabelElem);
    characterDiv.appendChild(charIDElem);
    characterDiv.appendChild(nameLabel);
    characterDiv.appendChild(name);
    characterDiv.appendChild(genderLabel);
    characterDiv.appendChild(gender);
    characterDiv.appendChild(dobLabel);
    characterDiv.appendChild(dob);
    characterDiv.appendChild(lastPlayedLabel);
    characterDiv.appendChild(lastPlayed);
    characterDiv.appendChild(playDeleteContainer);

    playDeleteContainer.appendChild(playButton);
    playDeleteContainer.appendChild(deleteButton);

    characterContainer.appendChild(characterDiv);
  });
}

// $(document).ready(() => {
//   fadeInBackground();
//   // createExistingCards(charData);
//   createNewCard();
// });

window.addEventListener('message', (event) => {
  switch(event.data.eventName) {
    case 'uridium_characters:start':
      fadeInBackground();
      break;
    case 'uridium_characters:new':
      createNewCard();
      break;
    case 'uridium_characters:existing':
      createExistingCards(event.data.charData);
      break;
    default:
      break;
  };
});
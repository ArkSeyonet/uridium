// @app
window.app = {}

const blkscrn = document.getElementById('blackscreen');
const container = document.getElementById('main-container');
const charCards = document.getElementById('character-cards');
const createCards = document.getElementById('create-cards');
const audio = $('#audio').get(0);
const numbers = /[0-9]/;
const symbols = /[`!@#$%^&*()_\-+=\[\]{};':'\\|,.<>\/?~ ]/;
const dateSymbols = /[`!@#$%^&*()_\-+=\[\]{};':'\\|,.<>\?~ ]/;
const regex = /[^\u000-\u00ff]/;
const genderMap = ['Male', 'Female', 'Non-Binary'];

let validCheck = { 'firstname': false, 'lastname': false, 'gender': 'Male', 'dateofbirth': false };

let charData = [
  { cid: 1, firstname: 'John', lastname: 'Doe', gender: 'Male', dateofbirth: '01/01/1990' },
  { cid: 2, firstname: 'James', lastname: 'Doe', gender: 'Non-Binary', dateofbirth: '01/01/1955' },
  { cid: 3, firstname: 'Jane', lastname: 'Doe', gender: 'Female', dateofbirth: '01/01/1990' }
];

async function generateCards(charData) {
  let count = 0;

  charData.forEach((character) => {
    count++;
    let value = count;

    let charCard = document.createElement('character-card');
    charCard.setAttribute('id', 'character-card-' + value);
    charCard.classList.add('character-card');

    let charCardInfo = document.createElement('character-card-info');
    charCardInfo.classList.add('character-card-info');

    let charCardNameLabel = document.createElement('character-card-label');
    charCardNameLabel.classList.add('character-card-label');
    charCardNameLabel.textContent = 'NAME';

    let charCardName = document.createElement('character-card-field');
    charCardName.setAttribute('id', 'character-card-' + value + '-name-field');
    charCardName.classList.add('character-card-field');
    charCardName.textContent = character.firstname + ' ' + character.lastname;

    let charCardGenderLabel = document.createElement('character-card-label');
    charCardGenderLabel.classList.add('character-card-label');
    charCardGenderLabel.textContent = 'GENDER';

    let charCardGender = document.createElement('character-card-field');
    charCardGender.setAttribute('id', 'character-card-' + value + '-gender-field');
    charCardGender.classList.add('character-card-field');
    charCardGender.textContent = character.gender;

    let charCardDOBLabel = document.createElement('character-card-label');
    charCardDOBLabel.classList.add('character-card-label');
    charCardDOBLabel.textContent = 'DATE OF BIRTH';

    let charCardDOB = document.createElement('character-card-field');
    charCardDOB.setAttribute('id', 'character-card-' + value + '-dob-field');
    charCardDOB.classList.add('character-card-field');
    charCardDOB.textContent = character.dateofbirth;

    charCardInfo.appendChild(charCardNameLabel);
    charCardInfo.appendChild(charCardName);
    charCardInfo.appendChild(charCardGenderLabel);
    charCardInfo.appendChild(charCardGender);
    charCardInfo.appendChild(charCardDOBLabel);
    charCardInfo.appendChild(charCardDOB);

    charCard.appendChild(charCardInfo);

    let charCardButtons = document.createElement('character-card-buttons');
    charCardButtons.classList.add('character-card-buttons');

    let playButton = document.createElement('play-button');
    playButton.setAttribute('id', 'play-button-' + value);
    playButton.classList.add('play-button');
    playButton.textContent = 'PLAY';

    let deleteButton = document.createElement('delete-button');
    deleteButton.setAttribute('id', 'delete-button-' + value);
    deleteButton.classList.add('delete-button');
    deleteButton.textContent = 'DELETE';

    charCardButtons.appendChild(playButton);
    charCardButtons.appendChild(deleteButton);

    charCard.appendChild(charCardButtons);

    charCards.appendChild(charCard);

    let createCard = document.createElement('create-card');
    createCard.setAttribute('id', 'create-card-' + value);
    createCard.classList.add('create-card');
  });

  if (count < 4) {
    count++;
    let value = count;

    let charCard = document.createElement('character-card');
    charCard.setAttribute('id', 'character-card-' + value);
    charCard.classList.add('character-card');

    let charCardNew = document.createElement('character-card-new');
    charCardNew.setAttribute('id', 'character-card-' + value + '-new');
    charCardNew.classList.add('character-card-new');
    charCardNew.textContent = 'CREATE';

    charCard.addEventListener('click', () => {
      window.app.showCreate(value);
    });

    charCard.appendChild(charCardNew);
    charCards.appendChild(charCard);

    let createCard = document.createElement('create-card');
    createCard.setAttribute('id', 'create-card-' + value);
    createCard.classList.add('create-card');

    let createCardForm = document.createElement('create-card-form');
    createCardForm.classList.add('create-card-form');

    let createCardFirstNameLabel = document.createElement('firstname-form-label');
    createCardFirstNameLabel.classList.add('form-label');
    createCardFirstNameLabel.textContent = 'FIRST NAME';

    let createCardFirstNameForm = document.createElement('input');
    createCardFirstNameForm.type = "text";
    createCardFirstNameForm.setAttribute('id', 'firstname-' + value);

    createCardFirstNameForm.addEventListener('change', () => {

    });

    let createCardLastNameLabel = document.createElement('lastname-form-label');
    createCardLastNameLabel.classList.add('form-label');
    createCardLastNameLabel.textContent = 'LAST NAME';

    let createCardLastNameForm = document.createElement('input');
    createCardLastNameForm.type = "text";
    createCardLastNameForm.setAttribute('id', 'lastname-' + value);

    createCardLastNameForm.addEventListener('change', () => {

    });

    let createCardGenderLabel = document.createElement('gender-form-label');
    createCardGenderLabel.classList.add('form-label');
    createCardGenderLabel.textContent = 'GENDER';


    let createCardGenderForm = document.createElement('select');
    createCardGenderForm.setAttribute('id', 'lastname-' + value);

    createCardGenderForm.addEventListener('change', () => {

    });


    let genderCount = 0;

    genderMap.forEach((gender) => {
      let option = document.createElement('option');
      option.value = genderMap[genderCount];
      option.textContent = genderMap[genderCount];
      createCardGenderForm.appendChild(option);
      genderCount++;
    });

    let createCardDOBLabel = document.createElement('dob-form-label');
    createCardDOBLabel.classList.add('form-label');
    createCardDOBLabel.textContent = 'DATE OF BIRTH';

    let createCardDOBForm = document.createElement('input');
    createCardDOBForm.type = "text";
    createCardDOBForm.setAttribute('id', 'dob-' + value);

    createCardDOBForm.addEventListener('change', () => {

    });

    createCardForm.appendChild(createCardFirstNameLabel);
    createCardForm.appendChild(createCardFirstNameForm);
    createCardForm.appendChild(createCardLastNameLabel);
    createCardForm.appendChild(createCardLastNameForm);
    createCardForm.appendChild(createCardGenderLabel);
    createCardForm.appendChild(createCardGenderForm);
    createCardForm.appendChild(createCardDOBLabel);
    createCardForm.appendChild(createCardDOBForm);

    createCard.appendChild(createCardForm);

    let createCardButtons = document.createElement('create-card-buttons');
    createCardButtons.classList.add('create-card-buttons');

    let createCardSubmit = document.createElement('create-card-submit');
    createCardSubmit.setAttribute('id', 'create-card-' + value + '-submit');
    createCardSubmit.classList.add('create-card-submit');
    createCardSubmit.textContent = 'SUBMIT';

    let createCardCancel = document.createElement('create-card-cancel');
    createCardCancel.setAttribute('id', 'create-card-' + value + '-cancel');
    createCardCancel.classList.add('create-card-cancel');
    createCardCancel.textContent = 'CANCEL';

    createCardCancel.addEventListener('click', () => {
      // for (let i = 1; i < 5; i++) {
      //   let element = document.getElementById('character-card-' + i);

      //   if (element) {
      //     charCards.removeChild(element);
      //   }
      // }

      window.app.cancel();
    });

    createCardButtons.appendChild(createCardSubmit);
    createCardButtons.appendChild(createCardCancel);

    createCard.appendChild(createCardButtons);

    createCards.appendChild(createCard);
  }
}

async function init() {
  await generateCards(charData);
}

window.app.showCreate = (id) => {
  if (!id) return;

  window.requestAnimationFrame(() => {
    charCards.style.opacity = `0`;

    setTimeout(() => {
      charCards.style.visibility = `hidden`;
      createCards.style.visibility = `visible`;
      createCards.style.opacity = `1`;
    }, 100);
  });
}

window.app.submit = () => {
  console.log('submit');
}

window.app.cancel = () => {
  window.requestAnimationFrame(() => {
    createCards.style.opacity = `0`;

    setTimeout(() => {
      createCards.style.visibility = `hidden`;
      charCards.style.visibility = `visible`;
      charCards.style.opacity = `1`;
    }, 100);
  });
}

window.app.check = (id) => {
  if (id === 'dob') {

  } else {
    console.log(id);
  }
}

$(document).ready(() => {
  init();
});
# Project Proposal

## Team

For the duration of this project our team members are:

- Trevor Stenson
- Tanner Muro


## Sections to add

- Who’s on your team? (done)
- What’s your project idea? (trevor, make more wordy somehow, pls give it a look)
- What API do you plan to use?
- What realtime behavior are you planning? (trevor, somehow expand ofc)
- What persistent state other than users will you be storing in a postgres DB?
- What “something neat” thing are you going to do?

For each experiment:

- What did you try?
- What was the result?
- What did you learn?
- What kinds of users do you expect to have use your app?
- For each kind of users, what is their most common workflow / user story?

## Project Idea

For this project, we wanted to create something that involved aerospace since we are both massive aviation nerds. ICAO codes are international airport identifiers that are used to identify global airports uniquely and are created by the International Civil Aviation Organization. The finished application we are proposing is one that serves as both a game and a learning system for users to learn about what ICAO/IATA codes reference what airports. The game component of the application would allow for users to guess what the ICAO code is for an airport given a photograph of the airport from either a region around the user's current location, or a randomly chosen airport from anywhere in the country. For each "round" of a game, a user is presented with an image that is programatically generated through the google maps API of some portion of an airport, and provided with 2-4 ICAO codes as choices. The user can click and guess any of the options, and will find out if they were correct or not before moving on to the next round. (THIS SENTENCE MAY NOT BE INCLUDED DEPENDING ON WHAT WE DO) Upon successfully guessing the ICAO code for an airport photo, a set of statistics about that airport will be displayed. Users will be able to compare their stastics with other users in both their local regions as well as with all users.

## Realtime Behavior

The realtime behavior for this application can be seen in a couple different ways. While a user is playing the game, websockets will be used to push updates to players regarding the outcome of a given round, as well as all new pertinent data for the next round after the current one is complete. There will also be a widget located on the site regardless of which page you're on that will display live updates globally to all users whenever someone gets a guess right.

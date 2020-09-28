# moVie-labs

[V-labs](https://v-labs.fr) onboarding project.

Highly inspired by the [Movie App design of Emre Secer](https://dribbble.com/shots/7158704-Movie-App/attachments/161831?mode=media)

### Todo:


- [ ] Change "vote count" from the MovieDetailView for a more useful data
- [ ] Use v-labs color scheme
- [ ] Add a "About this app" tab
- [ ] Create mocks for viewmodels and use them on  the preview
- [ ] Merge MoviesListView & MoviesListGenresView in a single view
- [ ] Implement state
- [ ] Keyboard scape from searchView
- [x] ~~Add popularity bar to the ActorView~~ (implemented but not used because unuseful to the user)
- [x] ~~Infinity scroll for MovieListGenresView~~
- [x] ~~Add three points ("...") to the truncated movie overview text at ActorView~~
- [x] ~~Home Screen: Fetch genres~~
- [x] ~~Home screen: the "view all" button gets the user to the selected list~~

**Problems to fix**


- [ ] DetailView Title text doesn't scale backwards if text is too long
- [ ] TabBar shadow color doesn't adapt in dark mode
- [ ] Ugly search text field isn't coherent with the UI
- [ ] Some movies doesn't show the rating correctly (see "The Crimes That Bind")
- [ ] Some ActorViews show a line between the gradiented image and the body of the view  (see "The SpongeBob Movie" > 3rd actor (Carolyn Lawrence)
- [ ] Some placeholders in the cast carousel (detail view) aren't shown (see "Santana", 7th item)
- [x] ~~Transitioning to a view briefly show the mock data~~
- [x] ~~Storyline section in detail view isn't correctly aligned (leading) if text is too short (see "Peninsula")~~ [View fix](https://crisrojas.com/notes/20200928121330.html)
- [x] ~~Titles of navbar are shown on top of content when scrolling. Using empty text solves this but there's an empty header space~~ [View fix](https://crisrojas.com/notes/20200928121330.html)

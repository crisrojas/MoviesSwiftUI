# moVie-labs

[V-labs](https://v-labs.fr) onboarding project.

UI adaptation of the [Movie App design by Emre Secer](https://dribbble.com/shots/7158704-Movie-App/attachments/161831?mode=media)

### toDo


- [ ] Change "vote count" from the MovieDetailView for a more useful data
- [ ] Use v-labs color scheme
- [ ] Add a "About this app" tab
- [ ] Implement state
- [ ] Keyboard scape from searchView
- [ ] Write unit tests
- [x] ~~[Kingfisher placeholders everywhere](https://github.com/onevcat/Kingfisher/wiki/SwiftUI-Support))~~
- [x] ~~Merge MoviesListView & MoviesListGenresView in a single view~~
- [x] ~~Add popularity bar to the ActorView~~ (implemented but not used because unuseful to the user)
- [x] ~~Infinity scroll for MovieListGenresView~~
- [x] ~~Add three points ("...") to the truncated movie overview text at ActorView~~
- [x] ~~Home Screen: Fetch genres~~
- [x] ~~Home screen: the "view all" button gets the user to the selected list~~
- [x] ~~Give a navbar title for each list when necessary for a better user experience~~
- [x] ~~Redondant model: DiscoverResponse is same as MovieResponse~~

### toFix


- [ ] Ugly search text field isn't coherent with the UI
- [ ] Some movies doesn't show the rating correctly (see "The Crimes That Bind")
- [ ] After updating xcode (v12) list background isn't cleared with  `appearance()` method (may be a simulator problem)
- [ ] Infinite scroll crashes after many page loads (probably last page)
- [ ] NavigationView pushes to back screen randomly when clicking in a navigation link (only observed from home screen)
- [ ] Random behaviour: slow back navigation from a list (usually when many movies have been loaded in infinite scroll)
- [x] ~~Now playing grid duplicates data when changing of screen and then returning back~~ (I was appending movies to the array instead of overwritting it)
- [x] ~~Transitioning to a view briefly show the mock data~~
- [x] ~~Storyline section in detail view isn't correctly aligned (leading) if text is too short (see "Peninsula")~~ [View fix](https://crisrojas.com/notes/20200928121330.html)
- [x] ~~Titles of navbar are shown on top of content when scrolling. Using empty text solves this but there's an empty header space~~ [View fix](https://crisrojas.com/notes/20200928121330.html)
- [x] ~~DetailView Title text doesn't scale backwards if text is too long~~ Fixed with `.fixedSize(horizontal: false, vertical: true)`
- [x] ~~TabBar shadow color doesn't match dark mode color scheme~~ (temporary fix: change the height of the shadow to make it softer and the difference between modes less evident)
- [x] ~~Inconsistent placement of movie title on "popular caroussel" (home vie)~

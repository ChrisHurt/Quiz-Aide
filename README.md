Demo: 

# Quiz Aide
> A Flexible Web Application for skill assessment

<!-- TABLE OF CONTENTS -->
## Table of Contents

* [About the Project](#about-the-project)
  * [Built With](#built-with)
  * [Deployed With](#deployed-with)
* [Application Demo](#application-demo)
* [Roadmap](#roadmap)
* [License](#license)
* [Contact](#contact)
* [Acknowledgements](#acknowledgements)

## About The Project

Too much time is spent marking student assessments which can easily be streamlined to reduce unnecessary workloads.

This web app is a CRUD app built for managing classes, teachers, assessment questions and automated grading.

### Built With
* [Ruby](https://www.ruby-lang.org/en/)
* [Sinatra](http://sinatrarb.com/)
* [PostgreSQL](https://www.postgresql.org/)
* [ActiveRecord](https://guides.rubyonrails.org/active_record_basics.html)
* [JavaScript](https://www.javascript.com/)
* [Bcrypt](https://rubygems.org/gems/bcrypt/)

## Deployed With

* [Heroku](https://www.heroku.com/about)

## Application Demo

[Link here](https://quiz-aide.herokuapp.com/login)

### Demo Student User
 - username: s7
 - password: s7

### Demo Student User
- username: t1
- password: t1

## Roadmap

### Sprint 1 -- Completed 31/07/19
* Build a login portal that differentiates between students, teachers and administrators
* Give teachers authorisation to:
  * CRUD Questions
  * READ Student answers & Student metrics
  * UPDATE student answer scores
* Give students authorisation to:
  * READ questions w/o the Answer Key
  * CREATE Answers to Questions & Self-score
  * READ Their own metrics
* Give administrators authorisation to:
  * CRUD all resources

### Sprint 2 -- Completed 01/10/19
* Selected a more semantic Heroku URL
* Completed a styling overhaul
* Added demo user accounts

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.


<!-- CONTACT -->
## Contact

Chris Hurt - chrishcoding@gmail.com

Project Link: [https://github.com/ChrisHurt/Quiz-Aide](https://github.com/ChrisHurt/Quiz-Aide)

<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements
* [README template - othnieldrew](https://github.com/othneildrew/Best-README-Template)
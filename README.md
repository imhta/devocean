# devocean
social network for remote developers and learners
## Installation ⚙
### Requirements
- Ruby 2.6
- Rails 6
- Postgres
- Webpacker
- Foreman (To run procfile.dev)
- ActionText
- ImageMagick(For ImageProcessing gem)
#### Useful links
- [Install imagemagick on debian ubuntu](https://www.tecmint.com/install-imagemagick-on-debian-ubuntu/)
### Clone
```bash
git clone https://github.com/imhta/devocean.git
cd devocean
```
Setup and Start Rails server
```bash
bundle
rails db:migrate
rails server
```
##### For Webpack server
In a new Terminal 
```bash
foreman start -f Procfile.dev
```
#### Test
```bash
bundle exec rspec
```
## Features :star: 
- WYSIWYG editor for post
- PWA
## ERD
<img src="docs/_Entity Relationship for DevOcean .png">

## Screenshots

#### Home page (before sign in)
<img src="docs/images/homepage.png">

#### Sign in page
<img src="docs/images/signin.png">

#### Sign up page
<img src="docs/images/signup.png">

#### feed page
<img src="docs/images/feed.PNG">

#### showpost page
<img src="docs/images/showpost.PNG">



## Author
- [@imhta](https://github.com/imhta)
- [@Abdusaid](https://github.com/Abdusaid10)

# Rent a World

This is a Ruby on Rails Air B'n'B application for renting fake fantasy worlds.
Why fantasy worlds? Well, I wanted to theme the app with something more fun than flats. That's it!

# Roadmap (more in the GitHub issues tab)

## Features

*   User authentication (sign up, sign in, sign out)
*   Create, Read, Update, and Delete worlds
*   Book worlds for a certain period - Cally calendar
*   Leave reviews for worlds
*   Real-time messaging between users using JS polling instead of websockets (why? because I wanted to try)
*   Basic search using PG gem

## Missing Features

*   Image uploads for worlds
*   Fake Payment processing for bookings
*   User profiles CRUD
*   Categorize worlds with tags, activities and amenities - (ongoing)
*   Extended Search and filtering functionality - (currently basic search against world titles and tags)
*   In-app notifications with Noticed gem v2
*   Admin dashboard for managing the platform
*   LLM chatbot using RubyLLM gem

## Technical Stack

*   **Ruby:** 3.3.5
*   **Rails:** 8.0.1
*   **Database:** PostgreSQL
*   **Web server:** Puma
*   **Frontend:**
    *   Importmap
    *   Hotwire (Turbo & Stimulus)
    *   Tailwind CSS
*   **Authentication:** Devise
*   **Deployment:** - To be determined

## Running the app

# Dowloading the repo

1.  **Prerequisites:**
    *   Ruby 3.3.5
    *   Bundler
    *   Node.js and Yarn
    *   PostgreSQL

2.  **Setup:**
    *   Clone the repository.
    *   Run the setup script: `bin/setup`

3.  **Running the development server:**
    *   Run `bin/dev` and run migrations (bin/rails db:create db:migrate db:seed) to start the Rails server and the Tailwind CSS watcher.
    *   The app will be available at `http://localhost:3000`.

4.  **Navigate the app and create a fake account (or use one from the seeds.rb file):**
    *   So that you can create bookings, worlds, chat with another user...

# Running the App with Docker

Get the app running locally using Docker.  
No local Ruby, Node, or PostgreSQL installation is required.
---

## 1. Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop) installed on your machine
---

## 2. Clone the Repository

```bash
git clone git@github.com:EmmanuelVernet/rent-a-world.git
cd rent-a-world
```
## 3. Setup Environment Variables
### Genereate a .env file. It needs:
```bash
POSTGRES_PASSWORD=postgres
RAILS_MASTER_KEY=dev_key_here
```
### You can generate new keys for your need, copy them and paste them into the .env file
```bash
docker-compose exec web bin/rails credentials:edit --environment development
docker-compose exec web bin/rails credentials:edit --environment test
```
## 4. Build and Start Docker Containers
```bash
docker-compose build web
docker-compose up -d
```
### Check that containers are running:
```bash
docker-compose ps
```
### Run migrations and seed the database:
```bash
docker-compose exec web bin/rails db:create db:migrate db:seed
```
## 5. Run the app
http://localhost:3000

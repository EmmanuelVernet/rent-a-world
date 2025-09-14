# Rent a World

This is a Ruby on Rails Air B'n'B application for renting fake fantasy worlds.
Why fantasy worlds? Well, I wanted to theme the app with something more fun than flats. That's it!

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

1.  **Prerequisites:**
    *   Ruby 3.3.5
    *   Bundler
    *   Node.js and Yarn
    *   PostgreSQL

2.  **Setup:**
    *   Clone the repository.
    *   Run the setup script: `bin/setup`

3.  **Running the development server:**
    *   Run `bin/dev` to start the Rails server and the Tailwind CSS watcher.
    *   The app will be available at `http://localhost:3000`.